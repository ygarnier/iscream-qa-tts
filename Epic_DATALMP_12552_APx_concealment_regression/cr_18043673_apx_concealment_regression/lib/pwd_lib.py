#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
==== PDF Generic Library version 4.2.45 ===="

Classes module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

from io import BytesIO
import sys
import os
import subprocess
import re
import base64
import platform
import getpass

# file types to clean
extension_types = ['.rex', '.log']

class Aim(object):
    """This class is used to manage interaction with Cyberark.
       To use the class' functions, it's mandatory to import in global.py file the ext_dependencies:

           sys.path.append(os.path.join(global_regression.TTS_RootDir, 'lib\ext_dependencies'))

        :Non-keyword arguments:
            - cyb_object -- CyberArk object (maps the LSS login)
            - global_regression -- TTS global regression object

        :Keyword_arguments:
            - appID -- basically a community of CyberArk users sharing the same LSS users e.g. QA-RES-TKT
            - appID_OS -- basically a community of CyberArk users sharing the same LSS users e.g. QA-RES-TKT. Use this appID to be authenticated by OS user
            - safe -- a container to store our LSS users (your organization path)
            - password -- the password value (better be a global variable defined in the TTS project properties, to avoid hardcoded value),
                                 that should be used INSTEAD of calling CyberArk.
                                 Also by convention, if you have already a global variable named PASSWORD,
                                 this is the same as expliciting here password =global_regression.PASSWORD
                                 Providing this parameter is useful if you have more than 1 CyberArk object in your test suite. 
            - folder -- an optional folder in the Safe container (default value is Root)

        You can add any other argument you fancy.

        :Examples:

        >>> CyberArk call using default parameters. Authentication by IP address using appID=NCE_LSS_CSS_QnT and authentication by OS user using appID_OS=NCE_LSS_CSS_QnT_OS
        >>> cyberark = generic_lib.pwd_lib.Aim('TESTVR', global_regression)

        >>> CyberArk call using authentication by IP address or OS user without default parameters
        >>> cyberark = generic_lib.pwd_lib.Aim('TESTVR', global_regression, appID='NCE_LSS_CSS_QnT', appID_OS="NCE_LSS_CSS_QnT_OS", safe='P_NCE_CSS_QnT', folder='Root')

        >>> request no CyberArk call (and trust passed password value)
        >>> cyberark = generic_lib.pwd_lib.Aim('TESTVR', global_regression, password=global_regression.MYGLOBALVARIABLE)
        >>> having a trusted password value in global variable PASSWORD is exactly the same as
        >>> cyberark = generic_lib.pwd_lib.Aim('TESTVR', global_regression, password=global_regression.PASSWORD)

    """

    response = None

    def __init__(self, *args, **kwargs):
        """Defines default attributes for Aim object."""
        if args != ():
            self.cyb_object = args[0]
            self.global_regression = args[1]
        else:
            raise ValueError("Error in CyberArk object creation: please check mandatory parameters")

        # Initiate default values for optional parameters
        # -----------------------------------------------

        # actually one of the 2 appIDs has to be there for the query to CyberArk
        self.appID = ""
        # actually one of the 2 appIDs has to be there for the query to CyberArk    
        self.appID_OS = ""
        # normally this one will be overriden by your own safe, if you are not in NCE_CSS_QnT organisation             
        self.safe = "P_NCE_CSS_QnT"
        # default = Root
        self.folder = "Root"
        # if you have a global variable PASSWORD, we take it here, but it can be overriden right after if you passed it explicitly in the list of arguments
        self.password = ""
        if hasattr(self.global_regression, 'PASSWORD'):
            self.password = self.global_regression.PASSWORD

        self.reason = "getpwd"

        # Initiate default values for optional parameters - End
        # -----------------------------------------------------


        # override above default values with specific values (maybe not all of them have been entered)
        if len(kwargs.items()) > 0:
            for arg, val in kwargs.items():
                setattr(self, arg, val)

        # ensure for coherence sake that we will always have the right values for safe = "P_NCE_CSS_QnT"
        if self.safe == "P_NCE_CSS_QnT":
            self.appID = 'NCE_LSS_CSS_QnT'
            self.appID_OS = 'NCE_LSS_CSS_QnT_OS'
            self.folder = "Root"

        # last coherence checks for optional parameters that are actually mandatory if we have to call CyberArk
        if self.password == "":
            # we need a safe value
            if self.safe == "":
                raise ValueError("Error in CyberArk object creation: no safe was provided")
            # we need at least 1 of the 2: appID or appID_OS
            if self.appID == "" and self.appID_OS == "":
                raise ValueError("Error in CyberArk object creation: no appID was provided")

    def get_password(self):
        """Get password from Cyberark.

            :Examples:

            >>> cyberark.get_password()
            PASSWORD
        """

        #TTS RD execution
        if '/remote/dspreg/' in self.global_regression.TTS_RootDir:
            raise ValueError("To use Cyberark on TTSRD you MUST use Amadeus Execution Engine")
        elif 'a2e_executor' in self.global_regression.TTS_RootDir:
            # A2E execution. check if A2E parameter is set
            if hasattr(self.global_regression, 'shooter_version'):
                print "Targeting A2E with TTS version " + self.global_regression.shooter_version
            else:
                raise ValueError("To use Cyberark on TTSRD you MUST pass an input parameter as shooter_version=18.0.1.14 (or an higher version)")
        else:
            #local execution
            sys.path.append(os.path.join(self.global_regression.TTS_RootDir, 'lib/ext_dependencies'))
                
        # initialize response (not found)
        self.response = None

        # create cc_dict on first activation to cache in it the list of (cyberArk object, password)
        if not hasattr(self.global_regression, 'cc_dict'):
            self.global_regression.cc_dict = dict()

        password_value_found = False
        # check cache first to avoid redundant CyberArk calls in the same execution
        for key in self.global_regression.cc_dict:
            if key == self.cyb_object:
                self.response =  self.global_regression.cc_dict[key]
                password_value_found = True
                break

        if not password_value_found:
            # first chance, you know the password and you have filled it in a global variable (PASSWORD is the default variable, or could result from passed parameter).
            # We will not call CyberArk in this case.
            if self.password != "":
                self.response = self.password
                # update cache to optimize next possible call with the same object
                self.global_regression.cc_dict.update( {self.cyb_object : self.response} )
                password_value_found = True
                
        if not password_value_found:
            # yet no password value found => now go for CyberArk call
            import pycurl
            import json
            import urllib
            import certifi
            
            windows = False

            # choose authentication type based on platform type
            os_type = platform.system()
            os_release = platform.release()

            # CyberArk authentication by OS user for Windows machines
            # Two cases:
            # 1) "Windows" in os_type --> for TTS2.10
            # 2) 'Microsoft' in os_release and 'Linux' in os_type --> for TT2.18
            if self.appID_OS != "" and ("Windows" in os_type or ('Microsoft' in os_release and 'Linux' in os_type)):
                URL = "https://pimapi.amadeus.com/aimwebservice/Win_Auth/AIM.asmx"
                
                cmd = "& {\
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; \
                $url = \"" + URL + "\" ; \
                $proxy = New-WebServiceProxy -Uri $url -UseDefaultCredential ; \
                $namespace = $proxy.getType().namespace ; \
                $request = New-Object ($namespace + \".passwordRequest\") ; \
                $request.AppID = \"" + self.appID_OS + "\" ; \
                $request.Query = \"Safe=" + self.safe + ";Folder=" + self.folder + ";Object=" + self.cyb_object + "\" ; \
                $response = $proxy.GetPassword($request) ; \
                $response | Convertto-Json }"
                
                windows = True
            elif self.appID != "" and ("Linux" in os_type and 'generic' in os_release):
                # CyberArk authentication by IP address for Linux machines
                
                params = {"Object" : self.cyb_object, "Folder" : self.folder, "Safe" : self.safe, "Reason" : self.reason, "AppID" : self.appID}
                URL = "https://pimapi.amadeus.com/AIMWebService/api/Accounts?"  + urllib.urlencode(params)
            else:
                raise ValueError("OS system (%s) and passed appID(s) do not match" % os_type)
            
            
            try:
                if windows:
                    response = str(subprocess.check_output(["powershell.exe" , "-Command" , cmd]))
                else:
                    buf = BytesIO()
                    curl = pycurl.Curl()
                    curl.setopt(pycurl.CAINFO, certifi.where())
                    curl.setopt(curl.URL, URL)
                    curl.setopt(curl.WRITEDATA, buf)
                    curl.perform()
                    curl.close()
        
                    body = buf.getvalue()
                    response = body.decode('iso-8859-1')


                response = json.loads(response)
                self.response = response['Content']

                # update cache to optimise next possible call with the same object
                self.global_regression.cc_dict.update( {self.cyb_object : self.response} )
            except:
                try:           
                    print response['ErrorCode'] + " - " + response['ErrorMsg']
                except TypeError:
                    # Exception caught in case default params (__APPID__) are used. 
                    # See CyberArk Technical Documentation https://rndwww.nce.amadeus.net/confluence/display/CSSQTPTSTMS/%5BCyberArk%5D+Technical+Documentation#id-[CyberArk]TechnicalDocumentation-1.1.1Setup 
                    pass
                finally:        
                    self.response = None

        # at this point we should have a password value in self.response (nominal case)
        if self.response != None:
            # store internally the password to clean in the list of passwords
            if not hasattr(self.global_regression, 'pwd_list'):
                self.global_regression.pwd_list = list()
            if self.response not in self.global_regression.pwd_list:
                self.global_regression.pwd_list.append(self.response)
    
            # store internally the script to clean in the list of scripts
            if not hasattr(self.global_regression, 'scripts_to_clean'):
                self.global_regression.scripts_to_clean = list()
            if hasattr(self.global_regression,"TTS_ScenarioPath"):
                if self.global_regression.TTS_ScenarioPath not in self.global_regression.scripts_to_clean:
                    self.global_regression.scripts_to_clean.append(self.global_regression.TTS_ScenarioPath)
            else:
                print " /!\ noTTS_ScenarioPath from here!"

        return str(self.response)


def hide_password(global_regression, pwd):
    """hide password in .rex and .log files for current TTS script (in global_regression.TTS_ScenarioPath)

    :Non-keyword arguments:
        - global regression -- for the full path and name of the current script to be cleaned
        - pwd -- value of the password to be hidden

    :Examples:

    >>> generic_lib.hide_password(context.global_regression,pwd)

    """

    for ext in extension_types:
        filename = global_regression.TTS_ScenarioPath + ext
        with open(filename, 'r') as script: filedata = script.read()
        # conceal
        filedata = conceal(filedata,pwd)         
        with open(filename, 'w') as script: script.write(filedata)
    

def clean_password(global_regression):
    """hide password in .rex and .log files at the end of the regression. Same usage of cleanpnr()

       Add in every script a finalize block with this code:
           global_regression.scripts_to_clean.append(global_regression.TTS_ScenarioPath)
       
       To use this function you have to declare two global variables in global.py file:
       
           -  variable "pwd_list":            global_regression.pwd_list = list()
           -  variable "scripts_to_clean":    global_regression.scripts_to_clean = list()
        
       Then you can fill this list with the password retrieved using Cyberark:
           global_regression.pwd_list.extend([pwd1, pwd2])
           

    :Non-keyword arguments:
        - global regression -- for the full path and name of the current script to be cleaned

    :Examples:

    >>> generic_lib.clean_password(global_regression)

    """

    # in case clean_password() is called without initialize the CyberArk class, list are initialized
    if not hasattr(global_regression, 'pwd_list'):
        global_regression.pwd_list = list()
    if not hasattr(global_regression, 'scripts_to_clean'):
        global_regression.scripts_to_clean = list()

    # remove duplicate values (especially when the same credentials are used all along the testing suite)
    pwd_list_nodup = list()
    for pwd in global_regression.pwd_list:
        if pwd not in pwd_list_nodup:
            pwd_list_nodup.append(pwd)

    # print "list of scripts (dupes): " +str(global_regression.scripts_to_clean)
    scripts_to_clean_nodup = list()
    for script in global_regression.scripts_to_clean:
        if script not in scripts_to_clean_nodup:
            scripts_to_clean_nodup.append(script)

    for file_path in scripts_to_clean_nodup:
        for ext in extension_types:
            filename = file_path + ext
            if not os.path.exists(filename):
                continue
            with open(filename, 'r') as script: filedata = script.read()
            # conceal each password in the list
            for pwd in pwd_list_nodup:
                #conceal this password value
                filedata = conceal(filedata,pwd)
                #consider possible upper and lower values, and b64encoded
                filedata = conceal(filedata,pwd.upper())
                filedata = conceal(filedata,pwd.lower())
                filedata = conceal(filedata,base64.standard_b64encode(pwd))
                filedata = conceal(filedata,base64.standard_b64encode(pwd.upper()))
                filedata = conceal(filedata,base64.standard_b64encode(pwd.lower()))
            with open(filename, 'w') as script: script.write(filedata)

def conceal(filedata, pwd, filename="no filename provided for debugging"):
    """given filedata, perform the transformations due to password concealment

       Note: this method is not public

    :Non-keyword arguments:
        - filedata -- the buffer of the file to be cleaned
        - pwd -- value of the password to be hidden
        - filename -- only used for debugging

    """

    # We need to keep the same string length to not destroy the .rex while it is still open

    # init for concealment in .rex
    pwd_rex1 = ""; concealedpwd1 = ""
    pwd_rex2 = ""; concealedpwd2 = ""

    # init for concealment in .log
    pwd_log = ""

    # dictionnary of special characters
    specials = {
            "&":{"replace1":"\&amp;", "replace2":"&amp;", "replace3":"\&"},
            "<":{"replace1":"&lt;", "replace2":"&lt;", "replace3":"<"},
            ">":{"replace1":"&gt;", "replace2":"&gt;", "replace3":">"},
            "'":{"replace1":"&apos;", "replace2":"&apos;", "replace3":"'"},
            '"':{"replace1":"&quot;", "replace2":"&quot;", "replace3":'"'}}

    # inspect each character of the password
    for character in pwd:

        # if special XML escaped character
        if character in specials:
            
            #append replacement to first pattern in  .rex
            pwd_rex1 = pwd_rex1 + specials[character]["replace1"]
            #append the exact same number of * in concealpwd1
            concealedpwd1 = concealedpwd1 + ("*" * len(specials[character]["replace1"]))

            #append replacement to second pattern in .rex
            pwd_rex2 = pwd_rex2 + specials[character]["replace2"]
            #append the exact same number of * in concealpwd2
            concealedpwd2 = concealedpwd2 + ("*" * len(specials[character]["replace2"]))

            #append replacement to first pattern in .log (length of concealment does not hurt here so we will use concealedpwd1)
            pwd_log = pwd_log + specials[character]["replace3"]

        # not an XML escaped character
        else:
            pwd_rex1 = pwd_rex1 + character
            pwd_rex2 = pwd_rex2 + character
            concealedpwd1 = concealedpwd1 + "*"
            concealedpwd2 = concealedpwd2 + "*"
            pwd_log = pwd_log + character

    pwd_rex1 = str(pwd_rex1)
    pwd_rex2 = str(pwd_rex2)
    pwd_log = str(pwd_log)
    pwd = str(pwd)

    if pwd_rex1 in filedata:
        filedata = filedata.replace(pwd_rex1, concealedpwd1)
    if pwd_rex2 in filedata:
        filedata = filedata.replace(pwd_rex2, concealedpwd2)
    if pwd_log in filedata:
        filedata = filedata.replace(pwd_log, concealedpwd1)
    if pwd in filedata:
        filedata = filedata.replace(pwd, concealedpwd1)

    return filedata
