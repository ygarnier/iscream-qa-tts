#!/usr/bin/env python
#-*- coding: UTF-8 -*-
"""
==== PDF Generic Library version 4.2.45 ===="

Miscellaneous functions module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

import re
import ttserverlib
import datetime
import time
#import socket
import os.path
import base64
import httplib
import urlparse
#import urllib
import urllib2
import shutil
import json
import xml.etree.ElementTree
from datetime import timedelta
#import suds.client
from ALFv3Ctrl import AlfController
import generic_lib


TRANSACTION_NB = 0
ALF_LOGS_DICT = {}


def format_float(list_of_floats, nb_of_decimals=2):
    """Sum up a list of floats and return the sum.

    :Non-keyword arguments:
        - list_of_floats -- the list conatining the floats to sum.
        - nb_of_decimals -- the number of decimal in the response (default: 2).

    :Example: 

    >>> generic_lib.format_float([12.3, 6.7])
    19.00

    """
    # Add floats contained in float list
    sum_of_floats = 0
    for float_ in list_of_floats:
        sum_of_floats += float(float_)

    # format to have the right number of decimals wanted
    nb_of_decimals_to_add = nb_of_decimals - len(str(sum_of_floats).split(".")[1])

    if nb_of_decimals_to_add < 0:
        formatted_float = str(sum_of_floats)[:nb_of_decimals_to_add]
        if formatted_float[-1] == ".":
            formatted_float = formatted_float[:-1]
    else:
        output_decimal_length = len(str(sum_of_floats)) + nb_of_decimals_to_add
        formatted_float = str(sum_of_floats).ljust(output_decimal_length, "0")

    return formatted_float


def compare(list_of_data):
    """Check if data provided as input are identical and return 0 if ok, 1 otherwise.

    :Non-keyword argument:
        - list_of_data -- data to be checked.

    :Examples: 

    >>> generic_lib.compare(["12345678", "00000000"])
    1

    >>> my_id = "12345678"
    >>> generic_lib.compare(["12345678", my_id, "12345678"])
    0

    """
    difference_found = 0
    ref_data = list_of_data.pop(0)
    for data in list_of_data:
        if data != ref_data:
            difference_found = 1
            break

    return difference_found


def parse_string(string_to_parse, reg_exp, group_number=0, is_found=False):
    '''
        This functions parse the string given in input using the regExp parameter as regular expression
    '''

    pattern = re.compile(reg_exp)
    match = pattern.search(string_to_parse)

    if is_found:
        #in this case is returned m (None in case of no match otherwise the location match).
        #It's use like a boolean return value
        return match
    else:
        if group_number == 'ALL':
            return match
        else:
            return match.group(group_number)


def get_script_duration(TTS_ScenarioPath, only_script_start_time=False):
    '''
        This method parse script logs to extract the script start date and duration
    '''
    script_name_path = TTS_ScenarioPath

    with open(script_name_path, 'r') as log_file:
        filedata = log_file.read()
        file_data_split = filedata.split('\n')

        for index, item in enumerate(file_data_split):
            if parse_string(item, "' Log report : (.*) - (.*)", 0, True) != None:
                script_start_time = parse_string(item, "' Log report : (.*) - (.*)", 1)

                if only_script_start_time:
                    break
            elif parse_string(item, r"' Total duration       : (\d+)h", 0, True) != None:
                hours = parse_string(item, r"' Total duration       : (\d+)h", 1)
                minutes = parse_string(item, r"' Total duration       : (\d+)h (\d+)min", 2)
                seconds = parse_string(item, r"' Total duration       : (\d+)h (\d+)min (\d+)s", 3)

    if only_script_start_time:
        current_time = datetime.datetime.now()
        current_time_str = current_time.strftime('%H:%M:%S.%f')
        current_time_datetime_object = datetime.datetime.strptime(current_time_str, '%H:%M:%S.%f')

        script_start_time_datetime_object = datetime.datetime.strptime(script_start_time, '%H:%M:%S.%f')
        script_duration_timedelta_object = current_time_datetime_object - script_start_time_datetime_object
        script_duration_timedelta_object = script_duration_timedelta_object + datetime.timedelta(seconds=10)

        script_duration_split = str(script_duration_timedelta_object).split(':')

        script_duration = script_duration_split[1]+ 'M'

        if script_duration == '00M':
            script_duration = script_duration_split[2] + 'S'
    else:
        unit_time = 'H'

        if hours == '0':
            unit_time = 'M'
            script_duration = minutes +  unit_time
            if minutes == '0':
                unit_time = 'S'
                script_duration = seconds +  unit_time
                if seconds == '0':
                    #less than 0s means ms so by default we set 1s
                    script_duration = '1' +  unit_time

    print 'Script duration: ' + script_duration
    print 'Script start time: ' + script_start_time

    return script_duration, script_start_time


def create_dict(dictionary, message_type):
    '''
        Method to create a dictionary as follow:
                                                {timestamp : payload}
                                                {timestamp : header}
    '''
    dictionary_payload_filtred = dict()
    dictionary_header_filtred = dict()

    for i in dictionary:
        #filter messages if message_type is specified
        if message_type != '':
            if i['meta']['logFormat'] != message_type:
                continue

        msg_timestamp = parse_string(i['header'], r"(\d{4})/(\d{2})/(\d{2}) (\d{2}):(\d{2}):(\d{2}).(\d{6})")


        dictionary_payload_filtred[msg_timestamp] = i['payload']
        dictionary_header_filtred[msg_timestamp] = i['header']

    return dictionary_payload_filtred, dictionary_header_filtred


def loop_or_abort(wait_t, max_of_replies):
    '''
        Method to break a loop if the number of replies is higher than the expected max number of replay

        :Non-keyword arguments:
            - wait_t -- wait time
            - max_of_replies -- max number of replies before to break the loop

        :Example:

            >>> generic_lib.loop_or_abort(1,5)
    '''
    if len(ttserverlib.TTServer.currentMessage.getRepliesList()) >= max_of_replies:
        ttserverlib.TTServer.currentClient.abortWithoutError()
        return ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE

    ttserverlib.TTServer.currentMessage.loop(wait_t, max_of_replies - 1, 0)
    return ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK

# def convert_parameter(parameter, conversion_system="Y_N"):
#     """Convert the value of a parameter into another format (used for cryptic entries).
#
#     :Non-keyword arguments:
#     parameter -- value to be converted.
#     conversion_system -- "YES_NO", "ON_OFF" or "EOS" (Default: Y_N)
#
#     :Examples:
#     >>> generic_lib.convert_parameter("YES", "ON_OFF")
#     ON
#
#     >>> generic_lib.convert_parameter("OFF", "EOS")
#     X
#
#     >>> generic_lib.convert_parameter("")
#     N
#
#     """
#     # Convert parameter
#     if conversion_system == "EOS":
#         if parameter in ["", " "]:
#             parameter = "X"
#     else:
#         if parameter.upper() in["", " ", "N", "NO", "OFF"]:
#             parameter = conversion_system.split("_")[1]
#         elif parameter.upper() in ["Y", "YES", "ON"]:
#             parameter = conversion_system.split("_")[0]
#
#     return parameter


def check_tty_messages(expected_replies_list, max_loop_nb=10):
    """Ensure all expected messages have been received, regardless of the order - typically used in TTS Match block.

    :Non-keyword arguments:
        - expected_replies_list -- list of replies number expected.
        - max_loop_nb -- maximum number of attempts to catch tty messages before exiting in error (default: 10).

    :Example:

    .. image:: TTS_examples/check_tty_messages.jpg

    """
    nb_of_messages_found = 0
    nb_of_expected_messages = len(expected_replies_list)

    # Get list of reply received so far
    replies_list = ttserverlib.TTServer.currentMessage.getRepliesList()

    # Check if all expected replies have been received. If not, keep looping.
    for expected_reply in expected_replies_list:
        if expected_reply not in replies_list:
            ttserverlib.TTServer.currentMessage.loop(1, max_loop_nb-1, 0)
        else:
            nb_of_messages_found += 1

    # Return a failure if maximum loop number has been reached
    # without finding all expected messages
    if (len(replies_list) >= max_loop_nb) and (nb_of_messages_found != nb_of_expected_messages):
        return 1
    else:
        return 0

def match(regular_expression, text=""):
    """
    Function used to match a regular expression in a text.\n
    Regular expressions are those available in Perl and default text is the reply received in TTS if it exists.\n
    
    :Example:
    >>> generic_lib.match("^\s\d{3}", " 12345")
    
    """

    # Default text is the whole TTS response if it exists
    if (text == "") and (ttserverlib.TTServer.currentMessage.getRepliesList() != []):
        text = ttserverlib.TTServer.currentMessage.getReplyBody()

    # Check that the text contains something that matches the regular expression
    if re.search(regular_expression, text) is not None:
        return 0

    return 1


def search_in_alf_logs(global_regression, search_pattern, reg_exp, node='', start_time='',
                       duration='', message_type='', group_number=0, as_boolean=False,
                       ongoing_run=False, match=True, last_occurrence = False):
    '''
        This method performs a search using ALFv3 and parses logs to find the pattern passed as parameter in reg_exp parameter

        :Arguments:
            - global_regression -- TTS global_regression object
            - search_pattern -- search pattern. It can be simple or complex (pattern1__pattern2).
              The __ is used as AND operator
            - reg_exp -- regular expression to match the pattern
            - node -- for SI search, leave the default value, otherwise add the BE or FE or STATS name (RDI, etc..)
              in this form: BE_RDI (for BE search) or FE_RDI (for FE search) or STATS_PAP (for STATS search)
            - start_time -- ALF start time timestamp in format 16:43:45.756380. Timestamp is not GMT!
            - duration -- ALF search duration in format 10S for seconds and 10M for minutes
            - message_type: to search only for specific message (EDIFACT, RAW, XML, etc..). Default search
              is opened to all type of messages
            - group_number -- reg expr group number
            - as_boolean -- if True, it checks only if your reg_exp exists, if False, the value found is returned
            - ongoing_run -- True/False. This boolean has to be set True if you want to get ALF logs from a
              running script and not at the end of the script
            - match -- True/False. If True the function returns TTS_MATCH_COMPARISON_OK/TTS_MATCH_COMPARISON_FAILURE
              otherwise TTS_NOMATCH_COMPARISON_OK/TTS_NOMATCH_COMPARISON_FAILURE
            - last_occurrence -- True/False. If True the function returns the last found occurrence

        :Example:

            >>> generic_lib.search_in_alf_logs(global_regression, RLOC, "HTTP:(\d+)", group_number=1) --> perform a SI search and
                return the value of the reg exp if there is a match
            >>> generic_lib.search_in_alf_logs(global_regression, RLOC, nationality=(.*)affluence=", node='BE_RDI', as_boolean=True)
                --> perform a BE search on RDI and check if the reg_exp exists
    '''

    alfv3result_payload = get_alf_logs(global_regression, search_pattern, node=node,
                                       start_time=start_time, duration=duration,
                                       message_type=message_type, ongoing_run=ongoing_run)[0]

    tmp_payload_sorted = sorted(alfv3result_payload.keys())

    found_value_lst = list()
    
    for tmp in tmp_payload_sorted:
        payload = alfv3result_payload[tmp]

        if as_boolean:
            if parse_string(payload, reg_exp, 0, as_boolean) != None:
                print "Reg exp '" + reg_exp + "' matches in message " + '[' + tmp + ']'

                if match:
                    return ttserverlib.TTServer.currentMessage.TTS_MATCH_COMPARISON_OK
                return ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK
        else:
            try:
                found_value = parse_string(payload, reg_exp, group_number)
                print "Reg exp '" + reg_exp + "' matches in message " + '[' + tmp + ']'
                print 'Found value: ' + found_value
                
                if last_occurrence:
                    found_value_lst.append(str(found_value))
                else:
                    return str(found_value)
            except AttributeError:
                pass

    if last_occurrence:
        return found_value_lst[-1]

    if match:
        return ttserverlib.TTServer.currentMessage.TTS_MATCH_COMPARISON_FAILURE

    return ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE


def get_alf_logs(global_regression, search_pattern, first_fail='', node='', start_time='',
                 duration='', message_type='', ongoing_run=False):
    '''
        This method get ALF logs using ALFv3

        :Arguments:
            - global_regression -- TTS global_regression object
            - search_pattern -- search pattern. It can be simple or complex (pattern1__pattern2).
              The __ is used as AND operator
            - first_fail -- if default value, the .log related to the current script is parsed to
              extract the first timestamp and script duration. If you want to start alf search from the first
              failed timestamp, use value 'YES'
            - node -- for SI search, leave the default value, otherwise add the BE or FE or STATS name (RDI, etc..)
              in this form: BE___RDI (for BE search) or FE___RDI (for FE search) or STATS_PAP (for STATS search)
            - start_time -- ALF start time timestamp in format 16:43:45.756380. Timestamp is not GMT!
            - duration -- ALF search duration in format 10S for seconds and 10M for minutes
            - message_type: to search only for specific message (EDIFACT, RAW, XML, etc..). Default search
              is opened to all type of messages
            - ongoing_run -- True/False. This boolean has to be set True if you want to get ALF logs from a
              running script and not at the end of the script

        :Example:

            >>> generic_lib.get_alf_logs(global_regression, RLOC) --> for SI search
            >>> generic_lib.get_alf_logs(global_regression, RLOC, node='BE___RDI') --> for BE search
            >>> generic_lib.get_alf_logs(global_regression, RLOC, node='STATS___PAP') --> for STATS search
            >>> generic_lib.get_alf_logs(global_regression, RLOC, node='BE___SON_PK1___SON_PK2') --> for BE search on more applications
            >>> generic_lib.get_alf_logs(global_regression, RLOC, first_fail='YES') --> SI search from first fail
            >>> generic_lib.get_alf_logs(global_regression, RLOC, node='BE___RDI', ongoing_run=True) --> get logs from
            a running execution
    '''

    end_of_loop = False
    next_line = 0
    offset_exp_date = 365

    #decode user and password (BASE64)
    user = 'YXF0bg=='
    pwd = 'M1R3bWl2R1l4aTJ5WA=='
    user = user.decode('base64', 'strict')
    pwd = pwd.decode('base64', 'strict')

    tts_scenario_path = global_regression.TTS_ScenarioPath + '.log'
    current_date = time.strftime("%Y-%m-%d")

    #if first_fail = 'YES' parse .log to extract timestamp of first failed transaction
    if first_fail == 'YES':
        with open(tts_scenario_path, 'r') as log_file:
            filedata = log_file.read()
            file_data_split = filedata.split('\n')

            for index, item in enumerate(file_data_split):
                if parse_string(item, "' Match        KO(.*)", 0, True) != None:
                    #check if it's a loop
                    if parse_string(item, "' Match        KO(.*)", 1) != '':
                        #go ahead until the end of the loop
                        while not end_of_loop:
                            next_line += 1
                            #check if loop has gone fine
                            if parse_string(file_data_split[index + next_line], "' Match        OK", 0, True) != None:
                                end_of_loop = True
                            if parse_string(file_data_split[index + next_line], "' Match        KO(?! - Loop)", 0, True) != None:
                                start_time_first_fail = file_data_split[index + next_line - 2]
                                break
                    else:
                        start_time_first_fail = file_data_split[index - 2]

                    #if it's still false, it means that a loop or a single transaction is ended with KO
                    if not end_of_loop:
                        break
                    else:
                        #reset flag because loop ends with OK
                        end_of_loop = False

        script_start_time = start_time_first_fail.split(' ')[4]
        print 'Start time of first failed transaction: ' + script_start_time
        script_duration = get_script_duration(tts_scenario_path, ongoing_run)[0]
    elif first_fail == '' and start_time != '':
        #use start_time and duration passed as parameter
        script_start_time = start_time

        if duration == '':
            raise 'Duration parameter must be defined'

        script_duration = duration
    else:
        #case first_fail = '' and ongoing_run = True/False
        script_duration, script_start_time = get_script_duration(tts_scenario_path, ongoing_run)

    #Determine whether or not Daylight Savings Time (DST) is currently in effect
    if bool(time.localtime( ).tm_isdst):
        #daylight saving time applied
        offset = 2
    else:
        offset = 1

    #set script start time - 1H
    datetime_object = datetime.datetime.strptime(script_start_time, '%H:%M:%S.%f')
    datetime_object = datetime_object - timedelta(hours=offset)
    script_start_time = datetime_object.strftime('%H:%M:%S')
    
    #set search expiration date to one year
    datetime_object_exp_date = datetime.datetime.strptime(current_date, "%Y-%m-%d")
    datetime_object_exp_date = datetime_object_exp_date + timedelta(days=offset_exp_date)
    search_exp_date = datetime_object_exp_date.strftime("%Y/%m/%d")

    #change parameters according to test system
    test_system = global_regression.TEST_SYSTEM
    if test_system == 'FRT':
        test_system = "FVT"
        #wait as in FRT some delays can occur
        time.sleep(30)

    alf_data = {"phase": test_system,
                "startTime": current_date + "T" + script_start_time,
                "types": '',
                "applications": "",
                "duration": "PT" + script_duration,
                "expirationDate" : search_exp_date
               }

    #discriminate between BE and SI search
    if node == '':
        alf_data["types"] = ["SI_MSG"]
        #set default search on ALL farms
        alf_data["applications"] = ["SIALT", "SICIF", "SIDCS", "SIDMZ", "SIHTH", "SITN", "SIWEB", "SIYBS"]

        #when search is performed on the SI, for FRT and UAT, the only test system permitted is PDT
        if test_system in ['FVT', 'UAT']:
            alf_data["phase"] = "PDT"
    elif 'BE' in node:
        #BE search
        alf_data["types"] = ["BE"]
        
        if len(node.split('___')) > 2:
            #search on more applications
            alf_data["applications"] = node.split('___')[1:]
        else:                                                                            
            alf_data["applications"] = [node.split('___')[1]]
    elif 'FE' in node:
        #FE search
        alf_data["types"] = ["FE"]
        
        if len(node.split('___')) > 2:
            #search on more applications
            alf_data["applications"] = node.split('___')[1:]
        else:
            alf_data["applications"] = [node.split('___')[1]]
    elif 'STATS' in node:
        #STATS search
        alf_data["types"] = ["STATS"]
        
        if len(node.split('___')) > 2:
            #search on more applications
            alf_data["applications"] = node.split('___')[1:]
        else:
            alf_data["applications"] = [node.split('___')[1]]

    #check if search pattern is complex
    if '__' in search_pattern:
        complex_pattern = list()
        for i in search_pattern.split('__'):
            complex_pattern.append(i)

        alf_data["complexPattern"] = [complex_pattern]
    else:
        alf_data["pattern"] = search_pattern

    alfv3_ctrl = AlfController(user, pwd, 0)
    
    if node == '':
        alf_data.update({"scope" : "SI"})
    else:
        alf_data.update({"scope" : "OBE"})

    try:
        alfv3_result = alfv3_ctrl.start_search_and_get_results(alf_data, 1, 120)
        alf_url = alfv3_ctrl.get_alf_url(alfv3_ctrl.searchid)

        print "ALF: " + alf_url

        alfv3result_payload, alfv3result_header = create_dict(alfv3_result, message_type)
    except Exception, exception:
        print str(exception)
    finally:
        alfv3_result = []

    return alfv3result_payload, alfv3result_header

# TO BE DONE: replace utf-8 chars by <special_char> in create_ptr()
# def create_ptr(global_regression, user, search_criteria="", delay=0):
#     """
#     Function used to automatically create a PTR with data from a failing script.\n
#     :Example:
#     - generic_lib.create_ptr("D:\Travail\Products\SEV1-2 production PTRs\TR09479062\TR09479062.cry")
#     """
#
#     # Connection to Win@proach API
#     client = suds.client.Client(url="http://nceowssrv01:8080/winaproachws/services/WinAproachWS?wsdl", username=base64.b64decode("YXF0bg=="), password=base64.b64decode("eGhFZXRBbzlzdzJ5WA=="))
#
#     # Create readable .xml file from .rex file
#     scenario_name = os.path.splitext(global_regression.TTS_ScenarioPath)[0]
#     shutil.copyfile(global_regression.TTS_ScenarioPath + ".rex", scenario_name + ".xml")
#     # Closes the xml file properly
#     xml_file = open(scenario_name + ".xml", "a")
#     xml_file.write("</xml>")
#     xml_file.close()
#
#     # Get scenario and failing entry
#     scenario = ""
#     mismatch_found = 1
#     transaction_list = \
#     xml.etree.ElementTree.parse(scenario_name + ".xml").getroot().findall("TRANSACTION")
#     for transaction in transaction_list:
#         # Log comments if any
#         if transaction.find("COMMENT") is not None:
#             scenario += "\n\">" + transaction.find("COMMENT").text + "\n"
#         # Log query sent
#         query = transaction.find("QUERY")
#         for part_of_query in query:
#             if part_of_query.tag == "TEXT":
#                 scenario += part_of_query.text
#             elif part_of_query.tag in ["VARIABLE", "REGULAR_EXPRESSION"]:
#                 scenario += part_of_query.find("VALUE").text
#         scenario += "\n"
#         # Log actual and expected reponse only for first mismatch,\
#         # but all queries in case of loop
#         if (transaction.get("match") == "KO") and (mismatch_found == 0):
#             mismatch_found = 1
#             comparison_list = transaction.findall("COMPARISON")
#             for comparison in comparison_list:
#                 expected_response = ""
#                 actual_response = ""
#                 for part_of_comparison in comparison:
#                     if part_of_comparison.tag == "TEXT":
#                         expected_response += part_of_comparison.text
#                         actual_response += part_of_comparison.text
#                     elif part_of_comparison.tag == "VARIABLE":
#                         expected_response += part_of_comparison.find("VALUE").text
#                         actual_response += part_of_comparison.find("VALUE").text
#                     elif part_of_comparison.tag == "REGULAR_EXPRESSION":
#                         expected_response += part_of_comparison.find("EXPRESSION").text
#                         actual_response += part_of_comparison.find("VALUE").text
#                     elif part_of_comparison.tag == "UNMATCH":
#                         if part_of_comparison.find("EXPECTED").find("TEXT") is not None:
#                             expected_response += \
#                             part_of_comparison.find("EXPECTED").find("TEXT").text
#                         if part_of_comparison.find("RECEIVED").find("TEXT") is not None:
#                             actual_response += part_of_comparison.find("RECEIVED").find("TEXT").text
#                 # Log received only once
#                 if comparison == comparison_list[0]:
#                     scenario += "\n! What was received:\n"
#                     scenario += "''Response:\n''" + \
#                     actual_response.replace("&amp;\n", "&\n''").replace("&gt;", ">") + "\n"
#                     scenario += "\n# What was expected:\n"
#                 scenario += "''Response:\n''" + \
#                 expected_response.replace("&amp;\n", "&\n''").replace("&gt;", ">") + "\n"
#             scenario += "\n"
#
#     if (mismatch_found == 0) or (socket.gethostname() == "ncegcoreg01"):
#         return 1
#
#     # Delete xml file created
#     os.remove(scenario_name + ".xml")
#
#     # Search ALF logs
#     if search_criteria == "":
#         search_criteria = global_regression.ATID
#     alf_logs = search_alf_logs(global_regression, search_criteria, delay)
#
#     # Write PTR body
#     description = "* Description:\n\n"
#     description += "  - ATID: " + global_regression.ATID + "\n"
#     description += "  - Script: " \
#     + global_regression.TTS_ScenarioPath[len(global_regression.TTS_RootDir)+1:] + "\n\n"
#     description += "* Scenario:\n\n" + scenario + "\n\n"
#     description += "* ALF logs:\n\n" + alf_logs + "\n\n"
#     description = description.replace("\n\n\n", "\n\n") # Remove two consecutives blank lines
#
#     # PTR creation
#     ptr_nb = client.service.createPTR(user, "NCEDOM", "[NR issue] Invalid response", description)
#
#     # Set keywords
#     if hasattr(global_regression, "PRODUCT_CODE"):
#         client.service.setKeyword(ptr_nb, "P-" + global_regression.PRODUCT_CODE + " E-" + global_regression.TEST_SYSTEM + " I-S")
#     else:
#         client.service.setKeyword(ptr_nb, "P-XXX E-" + global_regression.TEST_SYSTEM + " I-S")
#
#     # Attach script, logs and results to the PTR
#     #client.service.updateRecordFromSword(ptr_nb, "S0E0F", "TESTING RECORD FOR CPHILIBERT")
#     #client.service.attachContentToRecord(ptr_nb, "cphilibert", "NCEDOM", \
#     #[global_regression.TTS_ScenarioPath + "txt"])
#
#     print ptr_nb
#     return ptr_nb


def check_xml(list_of_xpaths, message=None, list_of_namespaces=None, global_regression=None, display_output=0):
    """Check an xml message against a grammar (see more here: how_to_test_xml_messages_) and return TTS_NOMATCH_COMPARISON_OK if ok, TTS_NOMATCH_COMPARISON_FAILURE otherwise.

    .. _how_to_test_xml_messages: https://rndwww.nce.amadeus.net/confluence/display/QTNQATF/How+to+test+XML+messages

    :Non-keyword arguments:
        - list_of_xpaths -- list of xpaths to be checked.
        - message -- message to be checked (default: None, i.e. last reply received).
        - list_of_namespaces -- list of namespaces present in the message (default: None).
        - global_regression -- TTS global_regression object in case you need to assign a value to a variable (default: None).
        - display_output -- 0 or 1 for comparison traces (default: 0)

    :Example:

    >>> list_of_xpaths = ["/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion:",\
                                "/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@name[3]:%\w*",\
                                "/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@name[3]:" + my_value1,\
                                "/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@name[1]:=/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@name[2]",\
                                "/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@price:!",\
                                "/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@name:!" + my_value2,\
                                "/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@name[2]:!=/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@name[3]",\
                                "/AMA_TTR_InternalFlatDisplayTTR_CTX_RS/Success/TTR/BookingFile/Bookings/Excursion/@name:>new_variable"]
    >>> generic_lib.check_xml(list_of_xpaths)
    0

    """
    # Initiate message
    if message is None:
        message = ttserverlib.TTServer.currentMessage.getReplyBody()
    if list_of_namespaces != None:
        for namespace in list_of_namespaces:
            message = message.replace(namespace + ":", "")
            list_of_xpaths = [xpath.replace(namespace + ":", "") for xpath in list_of_xpaths]

    # Check all xpaths
    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK
    for xpath in list_of_xpaths:
        # Parse xpath lines
        separator = ""
        additional = ""
        xpath_expr = re.match("([^:]*):(!?%?=?>?)(.*)", xpath)
        if xpath_expr is not None:
            xpath = xpath_expr.group(1)
            separator = xpath_expr.group(2)
            additional = xpath_expr.group(3)
        index_1 = 0
        xpath_expr = re.match("(.*)\[(\d*)\]$", xpath) # For getValueFromXPath(), xpath can contain a [index] except at the end
        if xpath_expr is not None:
            xpath = xpath_expr.group(1)
            index_1 = int(xpath_expr.group(2))-1 # getValueFromXPath() starts indexes at 0 when parameter, at 1 when within the path

        if separator in ["", "%"]:
            # Test the presence of an xpath
            if additional == "":
                if ttserverlib.TTServer.xmlUtils.testXpath(message, xpath, display_output): # testXpath() returns 0 when successful
                    ttserverlib.printErrorInDialog("ERROR: check_xml()\nXpath: " + xpath + " is not present in XML message: ")
                    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
            else:
                # Test the value of an xpath
                value = ttserverlib.TTServer.xmlUtils.getValueFromXPath(message, xpath, index_1, display_output)
                if (separator == "" and additional != value) or (separator == "%" and re.match("^" + additional + "$", value) is None):
                    if value is not None:
                        ttserverlib.printErrorInDialog("ERROR: check_xml()\nXpath: " + xpath + "\nValue given: " + additional + "\nValue in XML message: " + value)
                    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
        elif separator in ["!", "!%"]:
            # Test the absence of an xpath
            if additional == "":
                if not ttserverlib.TTServer.xmlUtils.testXpath(message, xpath, display_output): # testXpath() returns 0 when successful
                    ttserverlib.printErrorInDialog("ERROR: check_xml()\nXpath: " + xpath + " is present in XML message: ")
                    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
            # Test the non-value of an xpath
            else:
                value = ttserverlib.TTServer.xmlUtils.getValueFromXPath(message, xpath, index_1, display_output)
                if (separator == "!" and additional == value) or (separator == "!%" and re.match("^" + additional + "$", value) is not None):
                    if value is not None:
                        ttserverlib.printErrorInDialog("ERROR: check_xml()\nXpath: " + xpath + "\nValue given: " + additional + "\nValue in XML message: " + value)
                    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
        # Test the difference of 2 xpaths
        elif separator == "!=":
            index_2 = 0
            xpath_expr = re.match("(.*)\[(\d*)\]$", additional) # For getValueFromXPath(), xpath can contain a [index] except at the end
            if xpath_expr is not None:
                additional = xpath_expr.group(1)
                index_2 = int(xpath_expr.group(2))-1 # getValueFromXPath() starts indexes at 0 when parameter, at 1 when within the path
            value_1 = ttserverlib.TTServer.xmlUtils.getValueFromXPath(message, xpath, index_1, display_output)
            value_2 = ttserverlib.TTServer.xmlUtils.getValueFromXPath(message, additional, index_2, display_output)
            if value_1 == value_2:
                ttserverlib.printErrorInDialog("ERROR: check_xml()\nXpath1: " + xpath + "\nValue in XML message: " + value_1 + "\nXpath2: " + additional + "\nValue in XML message: " + value_2)
                result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
        # Test the egality of 2 xpaths
        elif separator == "=":
            index_2 = 0
            xpath_expr = re.match("(.*)\[(\d*)\]$", additional) # For getValueFromXPath(), xpath can contain a [index] except at the end
            if xpath_expr is not None:
                additional = xpath_expr.group(1)
                index_2 = int(xpath_expr.group(2))-1 # getValueFromXPath() starts indexes at 0 when parameter, at 1 when within the path
            value_1 = ttserverlib.TTServer.xmlUtils.getValueFromXPath(message, xpath, index_1, display_output)
            value_2 = ttserverlib.TTServer.xmlUtils.getValueFromXPath(message, additional, index_2, display_output)
            if value_1 != value_2:
                ttserverlib.printErrorInDialog("ERROR: check_xml()\nXpath1: " + xpath + "\nXpath2: " + additional + "\nValue in XML message: " + value_1)
                result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
        # Assign the value of an xpath to a variable
        elif separator == ">":
            exec("global_regression." + additional + " = ttserverlib.TTServer.xmlUtils.getValueFromXPath(message, xpath, " + str(index_1) + ", " + str(display_output) + ")")
        # Wrong operation
        else:
            ttserverlib.printErrorInDialog("ERROR: check_xml()\nInvalid separator")
            result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE

    return result


def check_json(list_of_jpaths, message=None, global_regression=None):
    """Check a json message against a grammar (see more here: how_to_test_json_messages_) and return TTS_NOMATCH_COMPARISON_OK if ok, TTS_NOMATCH_COMPARISON_FAILURE otherwise.

    .. _how_to_test_json_messages: https://rndwww.nce.amadeus.net/confluence/display/QTNQATF/How+to+test+JSON+messages

    :Non-keyword arguments:
        - list_of_xpaths -- list of xpaths to be checked.
        - message -- message to be checked (default: None, i.e. last reply received).
        - global_regression -- TTS global_regression object in case you need to assign a value to a variable (default: None).

    :Example:

    >>> list_of_jpaths = ["History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Number:",\
                                "History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Number:%\d*",\
                                "History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Number:341",\
                                "History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Number:=History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Number",\
                                "History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Nkjbhfjkvhskh:!",\
                                "History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Number:!342",\
                                "History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Number:!=History.Air.Bookings.0.FlightImages.0.FlightIdentifier.AirlineCode",\
                                "History.Air.Bookings.0.FlightImages.0.FlightIdentifier.Number:>my_variable"]
    >>> generic_lib.check_json(list_of_jpaths)
    0

    """
    # Initiate message
    if message is None:
        message = ttserverlib.TTServer.currentMessage.getReplyBody()
        message = re.match("(.*?)({.*)", message).group(2)
    message = message.replace("\\", "")

    # Check all jpaths
    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK
    for jpath in list_of_jpaths:
        json_expr = json.loads(message)
        # Parse jpath lines
        separator = ""
        additional = ""
        jpath_expr = re.match("(.*):(!?%?=?>?)(.*)", jpath)
        if jpath_expr is not None:
            jpath = jpath_expr.group(1)
            jpath = jpath.replace("[", ".").replace("]", "")
            separator = jpath_expr.group(2)
            additional = jpath_expr.group(3)

        jpath_expr = re.match("(.*)\[(\d*)\].*", jpath)
        if jpath_expr is not None:
            jpath = jpath_expr.group(1)

        if separator in ["", "%"]:
            # Test the presence of a jpath
            if additional == "":
                for elt in jpath.split("."):
                    if elt.isdigit():
                        elt = int(elt)
                    if isinstance(json_expr, dict) and elt in json_expr.keys():
                        json_expr = json_expr[elt]
                    elif isinstance(json_expr, list) and elt in range(len(json_expr)):
                        json_expr = json_expr[elt]
                    else:
                        result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
                        break
            else:
                # Test the value of a jpath
                for elt in jpath.split("."):
                    if elt.isdigit():
                        elt = int(elt)
                    json_expr = json_expr[elt]
                if (separator == "" and additional != str(json_expr)) or (separator == "%" and re.match("^" + additional + "$", str(json_expr)) is None):
                    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
        elif separator in ["!", "!%"]:
            break_performed = 0
            # Test the absence of a jpath
            if additional == "":
                for elt in jpath.split("."):
                    if elt.isdigit():
                        elt = int(elt)
                    if isinstance(json_expr, dict) and elt not in json_expr.keys():
                        break_performed = 1
                        break
                    elif isinstance(json_expr, list) and elt not in range(len(json_expr)):
                        break_performed = 1
                        break
                    else:
                        json_expr = json_expr[elt]
                if break_performed == 0:
                    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
            # Test the non-value of a jpath
            else:
                for elt in jpath.split("."):
                    if elt.isdigit():
                        elt = int(elt)
                    json_expr = json_expr[elt]
                if (separator == "!" and additional == str(json_expr)) or (separator == "!%" and re.match("^" + additional + "$", str(json_expr)) is not None):
                    result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
        # Test the difference of 2 jpaths
        elif separator == "!=":
            for elt in jpath.split("."):
                if elt.isdigit():
                    elt = int(elt)
                json_expr = json_expr[elt]
            json_expr_2 = json.loads(message)
            for elt in additional.split("."):
                if elt.isdigit():
                    elt = int(elt)
                json_expr_2 = json_expr_2[elt]
            if json_expr == json_expr_2:
                result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
        # Test the egality of 2 jpaths
        elif separator == "=":
            for elt in jpath.split("."):
                if elt.isdigit():
                    elt = int(elt)
                json_expr = json_expr[elt]
            json_expr_2 = json.loads(message)
            for elt in additional.split("."):
                if elt.isdigit():
                    elt = int(elt)
                json_expr_2 = json_expr_2[elt]
            if json_expr != json_expr_2:
                result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE
        # Assign the value of a jpath to a variable
        elif separator == ">":
            for elt in jpath.split("."):
                if elt.isdigit():
                    elt = int(elt)
                json_expr = json_expr[elt]
            exec("global_regression." + additional + " = " + json_expr)
        # Wrong operation
        else:
            ttserverlib.printErrorInDialog("ERROR: check_json()\nInvalid separator")
            result = ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_FAILURE

    return result


def abort(text):
    """Print given message in TTS console and in the error pop-up and abort test execution.

    :Non-keyword arguments:
        - text -- text to be displayed to the user.

    """
    ttserverlib.printErrorInDialog(text + "\n")
    ttserverlib.TTServer.currentClient.abort()

    return 0

def redefine_terminal(office_id, global_regression, configuration="cry", logs="NO", configuration2=""):
    """
        This function is used to reset ATID or to reset ATID and redefine the ATID in the office passed as parameter
        
        :Example:
        
        >>> generic_lib.redefine_terminal("", global_regression)
        ATID reset
        
        >>> generic_lib.redefine_terminal("NCE1A00QA", global_regression)
        ATID reset and redefinition of the ATID in office NCE1A00QA
        
        >>> generic_lib.redefine_terminal("", global_regression, configuration2="cry2")
        ATID reset for both the ATIDs!! To use if you have more than one ATID
        
        >>> generic_lib.redefine_terminal("NCE1A00QA", global_regression, configuration2="cry2")
        ATID reset and redefinition of the ATID in office NCE1A00QA for both the ATIDs!! To use if you have more than one ATID
    """

    nlc_none = False
    second_atid = False
    nb_loop = 1
    nb_atid = ""

    # Create redefine_terminal script with a unique identifier
    script_name = "redefine_terminal_" + generic_lib.get_date() + "_" + generic_lib.get_time() + "." + configuration

    if (logs.upper() != "YES") and (logs.upper() != "NO"):
        script_path = os.path.join(os.path.normpath(logs), script_name)
    else:
        script_path = os.path.join(os.getcwd(), script_name)

    #get current configuration to check new line value
    socket = ttserverlib.targetsMap[configuration]
    new_line_value = socket.config.newlineCharacter

    if new_line_value == 0:
        #value is NLC_None
        nlc_none = True
        
    #check if a second ATID is set. This can be used to simulate interactions on the same time
    if hasattr(global_regression, 'ATID2'):
        second_atid = True
        nb_loop = 2

    # Write the script itself
    script = open(script_path, "w")


    for i in range(0, nb_loop):
        # Script part
        script.write("\n'Check ATID" + nb_atid + "\n")
        script.write("JD\n")
        script.write("''Response:\n")
        script.write("''{.*}{=global_regression.ATID" + nb_atid + "}{.*}\n")
        
        script.write("\n'Reset ATID" + nb_atid + "\n")
        script.write("OK-WE/L-{=global_regression.ATID" + nb_atid + "}\n")
        script.write("''Response:\n")
        
        if nlc_none:
            script.write("''{.*}DELETED OK\\n&\n")
            script.write("''  DELETION FINISHED\\n&\n")
        else:
            script.write("''{.*}DELETED OK&\n")
            script.write("''  DELETION FINISHED&\n")
    
        script.write("''>\n")
        
        script.write("\n''wait:3\n")
        
        #if office_id is not specified, only the reset ATID is done
        if office_id != "":
            #check security code basing on the corporate qualifier code of the office
            if office_id[5] in ["0", "1"]:
                security_code = "C3DAP"
            else:
                security_code = "C5AGY"
            
            script.write("\n'Redefine ATID" + nb_atid + " in the new office\n")
            script.write("OK-WY/C-" + security_code + "/W-AMAD/T-NCE/S-80x22/O-" + office_id + "/A-NCE/L-{=global_regression.ATID" + nb_atid + "}\n")
            script.write("''Response:\n")
            script.write("''{.*}INITIALIZED FOR: NETWORK {.*}\n")
            
            script.write("\n''wait:3\n")
            
            script.write("\n'Check that the ATID" + nb_atid + " is defined in the expected office\n")
            script.write("JD\n")
            script.write("''Response:\n")
            
            if nlc_none:
                script.write("''\\n&\n")
                script.write("''{=global_regression.ATID" + nb_atid + "}         " + office_id + "\\n&\n")
            else:
                script.write("''&\n")
                script.write("''{=global_regression.ATID" + nb_atid + "}         " + office_id + "&\n")
            
            script.write("''{*}\n")
            
        nb_atid = "2"    
        
        if second_atid:
            #get current configuration to check new line value
            try:
                socket = ttserverlib.targetsMap[configuration2]
                new_line_value = socket.config.newlineCharacter
            except KeyError:
                print "No target defined for a configuration labelled " + configuration2

            if new_line_value == 0:
                #value is NLC_None
                nlc_none = True
    
            if i == 0:
                script.write("''Conversation: " + configuration2 +"\n")
    
    # End of clean_pnrs editing
    script.close()

    # Launch clean_pnrs script when necessary
    if (logs.upper() == "YES") or (logs.upper() == "NO"):
        generic_lib.run_tts_script(script_path, None, 1, configuration, logs, global_regression)

    return 1


def attempt_transactions(transaction_list):
    """
    Loop on different transactions until expected reply received.\n
    reset_globals() must be used in Match block (TTS) to reset global \
    used in attempt_transactions(). Indeed, calling twice attempt_transaction() \
    in the same script might otherwise cause issues.\n
    
    :Example:

    >>> {=generic_lib.attempt_transactions([SSAF1234Y12MARNCECDG1, \
    SSAF5678Y12MARNCECDG1, SSAF910Y12MARNCECDG1])}
    -''Response:
    -''RP/{*}
    -''Match: generic_lib.reset_globals()

    """

    global TRANSACTION_NB

    # Errors handling
    if transaction_list == []:
        print"- Leaving attempt_transactions(): ERROR PATH - invalid transaction_list"
        return 1

    # Get expected transaction and manage TRANSACTION_NB
    transaction = transaction_list[TRANSACTION_NB]
    if TRANSACTION_NB < len(transaction_list) - 1:
        TRANSACTION_NB += 1
    else:
        reset_globals()

    # Return expected transaction
    return transaction

def reset_globals():
    """
    Function used in Match block (TTS) to reset globals used \
    in the library to prevent any issue.
    """

    global TRANSACTION_NB

    # Reset globals
    TRANSACTION_NB = 0

    return 0

def pad(chain_of_characters, output_length, padding_character='0', side='LEFT'):
    """
    Function used to pad a chain of characters.\n
    Example::

    - generic_lib.pad(12, 4) returns '0012'

    """

    # Errors handling
    if output_length - len(str(chain_of_characters)) < 0:
        return chain_of_characters
    elif len(str(padding_character)) != 1:
        return chain_of_characters

    # initialize data:
    padding_length = output_length - len(str(chain_of_characters))

    # Pad chain_of_characters
    if side.upper() == 'LEFT':
        chain_of_characters =\
            str(padding_character)*padding_length + str(chain_of_characters)
    elif side.upper() == 'RIGHT':
        chain_of_characters =\
            str(chain_of_characters) + str(padding_character)*padding_length
    # Errors handling
    else:
        return chain_of_characters

    # Return padded alphanumeric
    return chain_of_characters


def _compare_level(received, expected, parent_key):
    """Internal recursive function, do not use outside this package! Used in compare_json_as_string().

    Compare two python objects decoded from a json string. Expected may be a
    regex pattern. If the objects are dictionaries or lists, iterate recursively
    on their contents.

    :param received: the object received
    :param expected: the expected object. Can be a regex pattern: '/pattern/'
    :param str parent_key: the key for the current level. Used to report errors.

    :return: True if the comparison failed.
    """

    comparison_failure = False
    
    if expected == '/*/':
        # accept everything
        comparison_failure = False
        return comparison_failure



    if isinstance(received, dict):
        if not isinstance(expected, dict):
            print "Match error on key '{}': received a dict but expected a {}.".format(parent_key,
                                                                                       type(expected).__name__)
            comparison_failure = True
            # We cannot compare further, so return
            return comparison_failure

        # Both received and expected are dicts, compare their contents
        rec_keys = set(received.keys())
        exp_keys = set(filter(lambda x: x != '/*/', expected.keys()))
        if rec_keys - exp_keys and '/*/' not in expected:
            print "Match error on key '{}': unexpected keys {}.".format(parent_key, list(rec_keys - exp_keys))
            comparison_failure = True
        if exp_keys - rec_keys:
            print "Match error on key '{}': missing keys {}.".format(parent_key, list(exp_keys - rec_keys))
            comparison_failure = True

        # Recursively compare the contents of all common fields
        for key in rec_keys & exp_keys:
            comparison_failure |= _compare_level(received[key], expected[key], "{}.{}".format(parent_key, key))

    elif isinstance(received, list):
        if not isinstance(expected, list):
            print "Match error on key '{}': received a list but expected a {}.".format(parent_key,
                                                                                       type(expected).__name__)
            comparison_failure = True
            # We cannot compare further, so return
            return comparison_failure

        if len(received) != len(expected):
            print "Match error on key '{}': received {} elements, expected {}.".format(parent_key,
                                                                                       len(received), len(expected))
            comparison_failure = True

        # Recursively compare the elements in the list
        for i in xrange(min(len(received), len(expected))):
            comparison_failure |= _compare_level(received[i], expected[i], "{}[{}]".format(parent_key, i))

    elif isinstance(expected, basestring) and expected.startswith('/') and expected.endswith('/'):
        # regular expression: '/pattern/'
        if not isinstance(received, basestring):
            # Compare the string representation of the object to the pattern
            received = str(received)

        if re.match(expected[1:-1], received) is None:
            print "Match error on key '{}': '{}' does not match regular expression '{}'.".format(parent_key,
                                                                                                 received,
                                                                                                 expected[1:-1])
            comparison_failure = True
    else:
        # Not a dict, not a list, not a regex... Simply compare both values then!
        if received != expected:
            print "Match error: value differs for key '{}': received '{}' instead of '{}'.".format(parent_key,
                                                                                                   received, expected)
            comparison_failure = True

    return comparison_failure


def clean_json_from_tts(received):
    """Remove undesired escapes added by TTS on a response json string. Used in compare_json_as_string().

    :param str received: the received json string captured by TTS.

    :return: a clean copy of the json string, parsable by json package.
    """
    return received.replace('\\{', '{').replace('\\}', '}').replace('\\:', ':').replace('\\*', '*').replace('\\\\"', '\\"').replace("\\'", "\\\\'").replace('\\%', '%').replace('\\&', '&')


def compare_json_as_string(received_json, expected_json, response_ok, response_ko):
    """Compare two json as string. To check json structure use function check_json()

    Clean the received_json, load the received and expected json strings into
    python objects and recursively compare them. Regular expression patterns
    can be specified in the expected_json, as strings starting and ending with
    slashes (e.g. '{"boardDate": "/\\d{4}-\\d{2}-\\d{2}/"}'). Double the
    backslashes so that the json module does not interpret them as escapes.

    If differences are found, detailed messages are printed in the standard
    output. This does not stop the comparison, so all differences are printed.

    :param received_json: the json string captured by TTS in the reply.
    :param expected_json: the json string we expect to get.
    :param response_ok: value to return if the comparison is successful.
    :param response_ko: value to return if the comparison fails.

    :type received_json: str
    :type expected_json: str
    
    Example::

    - generic_lib.compare_json_as_string(received_json, expected_json, TTServer.currentMessage.TTS_MATCH_COMPARISON_OK, TTServer.currentMessage.TTS_MATCH_COMPARISON_FAILURE)
    """

    received_json = clean_json_from_tts(received_json)
    try:
        json_received = json.loads(received_json)
    except Exception, e:
        print 'Error while decoding received json: {}'.format(e)
        print received_json[:20], '...', received_json[-20:]
        return response_ko

    try:
        json_expected = json.loads(expected_json)
    except Exception, e:
        print 'Error while decoding expected json: {}'.format(e)
        print expected_json[:20], '...', expected_json[-20:]
        return response_ko

    comparison_failure = _compare_level(json_received, json_expected, '')

    if comparison_failure:
        return response_ko
    else:
        return response_ok
    
    
def add_asso(asso_list, type_, list_of_elts):
    """
    The function returns what should be appended to a booking entry to take into account a pax or seg asso.
    """
    
    booking_suffix = ''
    if asso_list != []:
        booking_suffix += '/' + type_
        for asso in asso_list:
            booking_suffix += str(list_of_elts.index(asso) + 1)
            if asso != asso_list[-1]:
                booking_suffix += ','

    return booking_suffix    
