"""

==== PDF Generic Library version 4.2.45 ===="

Python controller for ALFv3 webservices
Contribution from PNR-SCS Team - 2015
"""
import urllib
import time
import urllib2
import json
import base64
import logging
import socket
import ssl

MODE_PROD = 0
MODE_TEST = 1
HTTP_METHOD_GET = 0
HTTP_METHOD_POST = 1
HTTP_METHOD_DELETE = 2
DEFAULTS = {
    'types': ["SI_MSG", "BE", "FE"],
    'duration': "PT1M",
    'fileNamePattern': []
}


class AlfController(object):
    """
    The ALF Controller
    See example usage at bottom of the file
    Documentation of the webservices: https://rndwww.nce.amadeus.net/confluence/display/AIOLSI/How+to+use+the+ALF+API
    """

    def __init__(self, user, password, mode=MODE_TEST):
        """
        Instantiate the controller with credentials
        Use MODE_TEST (default) or MODE_PROD to target test or prod instance
        """
        self.logger = logging.getLogger(__name__)

        if mode == MODE_PROD:
            self._url = "https://loggingfacility.amadeus.com/v3/" #prod instance
        else:
            self._url = "http://ttsdashboard.nce.amadeus.net:8091/v3/" #test instance

        self.mode = mode
        self.user = user
        self.password = password
        self.topology = None
        self.searchid = ""
        self.login()

    def _auth_request(self, webservice, data, method=HTTP_METHOD_GET):
        """
        Helper for HTTP GET/POST authenticated request
        """
        # print ("Request %s (%s)" % (webservice, method))
        # self.logger.debug("Data sent: %s" % (data))
        
        # adding SSL context after PTR 16809325 [Medium]: HTTPS connection does not work in TTS2.18.1
        context = ssl._create_unverified_context()

        urlreq = self._url + webservice
        if method in [HTTP_METHOD_GET, HTTP_METHOD_DELETE]:
            urlreq = urlreq + '?' + urllib.urlencode(data)

        request = urllib2.Request(urlreq)
        auth = base64.b64encode('%s:%s' % (self.user, self.password))
        request.add_header("Authorization", "Basic %s" % auth)

        # Increase timeout
        socket.setdefaulttimeout(30)

        try:
            answer = None
            if method == HTTP_METHOD_GET:
                # ssl._create_unverified_context is present only in Python >= 2.7.9
                response = urllib2.urlopen(request, context=context)
                answer = response.read()

            elif method == HTTP_METHOD_DELETE:
                request.get_method = lambda: 'DELETE'
                # ssl._create_unverified_context is present only in Python >= 2.7.9
                response = urllib2.urlopen(request, context=context)
                answer = response.read()

            elif method == HTTP_METHOD_POST:
                request.add_header('content-type', "application/json")
                params = json.dumps(data)
                # ssl._create_unverified_context is present only in Python >= 2.7.9
                response = urllib2.urlopen(request, params, context=context)
                answer = response.read()

            json_answer = json.loads(answer)

        except urllib2.HTTPError as exception:
            self.logger.exception("Exception encountered: %s", exception)
            json_answer = None

        except ValueError as ex:
            self.logger.exception("ValueError encountered: %s", ex)
            json_answer = None

        # Reset to default
        socket.setdefaulttimeout(None)

        return json_answer

    def login(self):
        """
        Log into ALF
        """
        #print ("Try to log in")
        data = {
            'username': self.user,
            'password': self.password
        }
        result = self._auth_request("auth/isAuthenticated", data, HTTP_METHOD_GET)
        if not result['loggedIn']:
            #print ("Not logged in")
            result = self._auth_request("auth/login", data, HTTP_METHOD_POST)
        else:
            #print ("Already logged in")
            pass
        return result

    def get_application_full_name(self, application, phase, peak=None):
        """
        Rely on ALF topology service to compute the correct application name
        Example: AML peak 1 is "AML" while LOY peak 1 is "LOY_PK1"
        input parameter 'peak' must be in the form "PK1"
        """
        #print ("Get application full name for %s/%s", application, phase)
        application_list = []

        # Retrieve topology if not done yet
        if not self.topology:
            self.topology = self._auth_request("topology/obe", {}, HTTP_METHOD_GET)

        tentative_name = application.upper() + '_' + peak.upper() if peak is not None else ''
        if "phases" in self.topology.keys():
            # Get application list for given phase
            for current_phase_data in self.topology["phases"]:
                if current_phase_data.get("phase", "") == phase.upper():
                    application_list = current_phase_data.get("applications", [])
                    break

            # Check if the application is suffixed for this phase
            for app in application_list:
                if application.upper() in app.get("app", {}).get("id", ""):
                    if tentative_name == app.get("app", {}).get("id", ""):
                        return tentative_name

        return application.upper()

    def start_search(self, data):
        """
        Trigger a new search

        example:
            data = {
                'phase': 'PDT',
                'applications': ['CPL'],
                "startTime": '2015-05-18T08:20:33.900881Z',
                "pattern": 'CsxServerContext',
                "types": ["BE"],
                "fileNamePattern": "PXA_Retrieve",
                "patternIndex": "DcxId"
            }

        Documentation for API: https://rndwww.nce.amadeus.net/confluence/display/AIOLSI/How+to+use+the+ALF+API
        Documentation for duration and startTime keys:
            https://docs.oracle.com/javase/8/docs/api/java/time/Duration.html#parse-java.lang.CharSequence-
        """
        #print ("Start new search")

        # Presence is mandatory for these keys
        for mandatory_key in ['phase', 'applications', 'pattern', 'startTime']:
            if mandatory_key not in data.keys():
                if mandatory_key == "pattern":
                    # check if complexPattern is defined at least
                    if "complexPattern" in data.keys():
                        continue
                elif mandatory_key == "complexPattern":
                    # check if pattern is defined at least
                    if "pattern" in data.keys():
                        continue
                return None

        # These keys must not be None or Empty
        for valid_key in ['phase', 'startTime']:
            if valid_key is None or not data[valid_key]:
                return None

        # Special format for startTime - ALF needs a ending Z
        if data['startTime'][-1:] != 'Z':
            data['startTime'] += 'Z'

        # Fill optional keys with defaults
        for optional_key, _ in DEFAULTS.items():
            if optional_key not in data.keys():
                data[optional_key] = DEFAULTS[optional_key]

        result = self._auth_request("rest/search/start", data, HTTP_METHOD_POST)
        return result

    def get_search_status(self, searchid):
        """
        Get status of a search

        """
        data = {'searchId': searchid}
        status = self._auth_request("rest/info/status", data, HTTP_METHOD_GET)
        #print ("Current status is %s", status)
        return status

    def get_search_details(self, searchid):
        """
        Get full information about a search (details, tasks)
        """
        data = {'searchId': searchid}
        info = self._auth_request("rest/info/search", data, HTTP_METHOD_GET)
        tasks = self._auth_request("rest/info/tasks", data, HTTP_METHOD_GET)
        return {'info': info, 'tasks': tasks}

    def has_search_started(self, searchid):
        """
        Quick helper to check if a search has really started (true) or not (false)
        """
        status = self.get_search_status(searchid)
        if status:
            return status['taskScheduled'] > 0
        return False

    def has_search_finished(self, searchid):
        """
        Quick helper to check if a search has finished (true) or not (false)
        """
        details = self.get_search_status(searchid)
        if details:
            return details['percentage'] == 100
        return False

    def get_search_result(self, searchid):
        """
        Get the result of a search
        """
        data = {'searchId': searchid, 'limit': 999999, 'offset': 0}
        result = self._auth_request("rest/search/result", data, HTTP_METHOD_GET)
        return result

    def cancel_search(self, searchid):
        """
        Cancel the specified search
        """
        #print ("Cancel search: %s", searchid)
        data = {'searchId': searchid}
        result = None
        try:
            result = self._auth_request("rest/search/cancel", data, HTTP_METHOD_POST)
        except Exception as ex:
            self.logger.exception("Error while cancelling: %s", ex)
        return result

    def delete_search(self, searchid):
        """
        Delete the specified search
        """
        #print ("Delete search: %s", searchid)
        data = {'searchId': searchid}
        result = None
        try:
            result = self._auth_request("rest/search/delete", data, HTTP_METHOD_DELETE)
        except Exception as ex:
            self.logger.exception("Error while deleting: %s", ex)

        return result

    def get_alf_url(self, searchid):
        """
        Get the ALF url to check the result of a search
        """
        return self._url + '#/log-viewer/search-id/' + str(searchid)

    def start_search_and_get_results(self, data, poll_time=1, max_polls=15):
        """
        Trigger a search, wait for result, and returns the result
        "poll_time" argument permits to define the sleeping time (in seconds) between two status polls
        """
        trigger_result = self.start_search(data)
        #print ("Start search: %s", trigger_result)
        searchid = int(trigger_result['searchId']) if trigger_result is not None else None

        if searchid is not None:
            self.searchid = searchid

            # Waiting search to start
            poll_counter = 0
            while (not self.has_search_started(searchid)) and (poll_counter < max_polls):
                time.sleep(poll_time)
                poll_counter += 1

            if not self.has_search_started(searchid):
                print ("Search could not be started")
                return None

            # Waiting search to finish
            poll_counter = 0
            while (not self.has_search_finished(searchid)) and (poll_counter < max_polls):
                time.sleep(poll_time)
                poll_counter += 1

            if not self.has_search_finished(searchid):
                print ("Search could not finish")
                return None

        else:
            print ("Search could not be triggered")
            return None

        return self.get_search_result(searchid)

    def start_search_and_get_url(self, data, error_url=None):
        """
        Trigger a search, and returns the url to view it in ALF
        "poll_time" argument permits to define the sleeping time (in seconds) between two status polls
        "error_url" defines the url to return in case of error (default is ALF search page)
        """
        trigger_result = self.start_search(data)
        searchid = trigger_result['searchId'] if trigger_result is not None else None
        
        self.globalSearchId = searchid
        
        if searchid is not None:
            return self.get_alf_url(searchid)
        elif error_url is not None:
            return error_url
        else:
            self.get_alf_url("")
