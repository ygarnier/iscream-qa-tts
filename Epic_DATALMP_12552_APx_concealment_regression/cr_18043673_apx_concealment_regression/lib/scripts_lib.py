#!/usr/bin/env python
#-*- coding: UTF-8 -*-
"""
==== PDF Generic Library version 4.2.45 ===="

Scripts module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

import os
import ttserverlib
import pwd_lib
import generic_lib


def set_flight_flown(air_segment, rloc, configuration="cry", logs="NO", test_system=""):
    """Create and launch a TTS script which sets a flight as "flown" in the PNR.

    :Non-keyword arguments:
        - air_segment -- the object AirSegment() to set as "flown".
        - rloc -- the record locator of the PNR containing the flight to be set as "flown".
        - configuration -- the TTS key defined for the cryptic configuration of your suite (default: cry).
        - logs -- "YES", "NO" or any path where you want to store the script created - mostly for investigation purposes (default: NO).
        - test_system -- specify this parameter only if you want to use the function in FRT: test_system=FRT

    :Examples:

    >>> air_segment = generic_lib.AirSegment("BA", "123", "C", "12FEB23", "NCE", "CDG")

    >>> generic_lib.set_flight_flown(air_segment, "2RYUIH")

    """

    # Decode password (base 64)
    pwd = 'QW1hZGV1czE='
    pwd = pwd.decode('base64', 'strict')

    # Create get_dids_ucis_ppiscq and scripts with a unique identifier
    script_name = "set_flight_flown_" + generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + rloc + "." + configuration

    # Write the scripts somewhere where they will be launched by regression.
    if (logs.upper() != "YES") and (logs.upper() != "NO"):
        script_path = os.path.join(os.path.normpath(logs), script_name)
    else:
        script_path = os.path.join(os.getcwd(), script_name)

    script = open(script_path, "w")

    script.write("\nIG\nJO*\n\n")

    #sign 0007NR has specific permissions to use VPATCH (WO 13214026: LSS UPDATE: add VPATCH permission to sign 0007NR)
    script.write("JIA0007NR/SU-" + pwd + "\n")
    script.write("\n")
    script.write("RT" + rloc + "\n")
    script.write("VPATCH\n")
    script.write("find -p pnr/ (.*)" + air_segment.airline + "(.*)" + air_segment.flight_nb + "(.*)\n")
    script.write("''Response:\n")
    script.write("''{.*}/PNR/ACT/AIR/{%tattoo%=[0-9]*}/FIRST{.*}\n")
    script.write("\n")
    script.write("cd pnr/act/air/%tattoo%/first\n")
    script.write("replace -a " + air_segment.edi_dep_date + " " + generic_lib.get_date(offset=-3, output_format="DDMMYY") + "\n")

    # Debug mode
    if logs == "YES":
        script.write("ls\n")

    #script.write("addactivity -d C AIR PNR/ACT/AIR/%tattoo%\n")

    if test_system == "FRT":
        #see WO 12312534: Follow up PTR 11978080 : Create scenario in QTN Regression
        script.write("commit --skip-corruption-analysis -w 1234567\n")
    else:
        script.write("commit --skip-corruption-analysis\n")

    script.write("VEXIT\n")

    script.write("RT\n")
    script.write("RF PATCH_FLOWN_FLIGHT\n")
    script.write("ET\n")
    script.write("''Response:\n")
    script.write("''END OF TRANSACTION COMPLETE - {%RecLoc%=(local).{6}}{.*}\n")
    script.write("''NoMatch: TTServer.currentMessage.loop(1, 1, 0)\n")

    script.close()

    # Retrieve configuration used in regression
    socket = ttserverlib.targetsMap[configuration]

    # Make sure configuration will be fine for the script
    old_newlinecharacter = socket.config.newlineCharacter
    socket.config.newlineCharacter = 1
    old_host = socket.config.host
    socket.config.host = "sitst.tn3270.1a.amadeus.net"

    # Launch script
    client = ttserverlib.Client(socket, script_path, script_path + ".log", None, script_path + ".rex")
    client.start()
    client.wait()

    del client

    # Restore old configuration
    socket.config.newlineCharacter = old_newlinecharacter
    socket.config.host = old_host

    # Remove clean_flight and related scripts
    if logs.upper() == "NO":
        remove_logs(script_path)

    return 1


def unboard_pnrs(rloc_list, configuration="edi", logs="NO"):
    """Create and launch a TTS script which unboards the passengers of a list of PNRs given in input.

    :Non-keyword arguments:
        - rloc_list -- the list of record locators of the passengers to unboard.
        - configuration -- the TTS key defined for the PPISCQ configuration of your suite (default: edi).
        - logs -- "YES", "NO" or any path where you want to store the script created - mostly for investigation purposes (default: NO).

    :Example:

    >>> generic_lib.unboard_pnrs(["UY767B", "IUHIUH", "43JL89"])

    """
    # Create get_dids_ucis_ppiscq and scripts with a unique identifier
    unique_identifier = generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + generic_lib.random_alpha(5)
    script_name_ppiscq = "get_dids_ucis_ppiscq_" + unique_identifier + ".cry"
    script_name_psciuq = "unboard_pnrs_psciuq_" + unique_identifier + ".cry"

    # Indicator to clean unboard_pnrs_psciuq
    # (not necessary if nothing found in get_dids_ucis_ppiscq)
    clean_psciuq = 0

    # Write the scripts somewhere where they will be launched by regression
    if (logs.upper() != "YES") and (logs.upper() != "NO"):
        script_path_ppiscq = os.path.join(os.path.normpath(logs), script_name_ppiscq)
        script_path_psciuq = os.path.join(os.path.normpath(logs), script_name_psciuq)
    else:
        script_path_ppiscq = os.path.join(os.getcwd(), script_name_ppiscq)
        script_path_psciuq = os.path.join(os.getcwd(), script_name_psciuq)

    # unboard_pnrs_ppiscq editing
    script = open(script_path_ppiscq, "w")

    # Initialize part
    script.write("''Initialize:\n")
    script.write("import string, re\n")
    script.write("\n")
    script.write("rloc_dictionary = {}\n")
    script.write("dids_ucis_dictionary = {}\n")
    script.write("def parse_ppiscr(PPISCR):\n")
    script.write("    list_of_EDI_segments = string.split(PPISCR,\"'\")\n")
    script.write("    uci = ''\n")
    script.write("    rloc = ''\n")
    script.write("    for edi_seg in list_of_EDI_segments:\n")
    script.write(r"        l = re.search('RCI\+\:(\w*)', edi_seg)" + "\n")
    script.write("        if l:\n")
    script.write("            rloc = l.group(1)\n")
    script.write(r"        m = re.search('IRV\+(.*)\:UCI\:(\w*)', edi_seg)" + "\n")
    script.write("        if m:\n")
    script.write("            uci = m.group(2)\n")
    script.write(r"        n = re.search(\"IRV\+(.*)\:DID\:(\w*)\", edi_seg)" + "\n")
    script.write("        if n:\n")
    script.write("            dids_ucis_dictionary[n.group(2)] = uci\n")
    script.write("    rloc_dictionary[rloc] = dids_ucis_dictionary\n")
    script.write("    return 0\n")
    script.write("\n")

    # Finalize part
    script.write("''Finalize:\n")
    script.write("context.rloc_dictionary = rloc_dictionary\n")
    script.write("''End\n")
    script.write("\n")

    # Script part
    for rloc in rloc_list:
        script.write("UNH+1+PPISCQ:11:2:1A'&\n")
        script.write("ORG+00+:NCEJJ0SSC+++K+BR+A1002SKSU'&\n")
        script.write("RCI+:" + rloc + "'&\n")
        script.write("UNT+4+1'\n")
        script.write("''Response:\n")
        script.write("''{%PPISCR%=*}\n")
        script.write("''Match: parse_ppiscr(PPISCR)\n")

    # End of get_dids_ucis_ppiscq editing
    script.close()

    # Launch get_dids_ucis_ppiscq
    # and unboard_pnrs_psciuq scripts when necessary
    if (logs.upper() == "YES") or (logs.upper() == "NO"):

        # Retrieve configuration used for .cry
        socket = ttserverlib.targetsMap[configuration]

        # Launch get_dids_ucis_ppiscq script which gets
        # the dictionnary of segments/pax dids and corresponding pax UCIs
        client = ttserverlib.Client(socket, script_path_ppiscq, script_path_ppiscq + ".log", None, script_path_ppiscq + ".rex")
        client.start()
        client.wait()
        rloc_dictionary = client.context.rloc_dictionary
        del client

        # clean empty values
        for rloc in rloc_dictionary.keys():
            if rloc_dictionary.get(rloc) == {}:
                del rloc_dictionary[rloc]

        # unboard_pnrs_psciuq editing
        if rloc_dictionary != {}:
            clean_psciuq = 1
            script = open(script_path_psciuq, "w")

            # Script part
            for rloc in rloc_dictionary.keys():
                for did in rloc_dictionary.get(rloc).keys():
                    script.write("UNH+1+PSCIUQ:10:1:1A'&\n")
                    script.write("ORG+00+:NCE1A0955+++J+FR:EUR:EN+A8506GTGS+1A0A0B6E'&\n")
                    script.write("RCI+:" + rloc + "'&\n")
                    script.write("ACT+MOD'&\n")
                    script.write("IRV++++1ARES::UCI:" + rloc_dictionary.get(rloc).get(did) + "+DCSLON:6'&\n")
                    script.write("TIF+:A:55:M+:A:::MSTR'&\n")
                    script.write("TRA+AF'&\n")
                    script.write("SDI+++1955:6:21'&\n")
                    script.write("ATC++XSX'&\n")
                    script.write("DUM'&\n")
                    script.write("IRV++++1ARES::did:" + did + "'&\n")
                    script.write("ACT+MOD'&\n")
                    script.write("TVL+20121212:1150+NCE+ORY+AF+1234:Y'&\n")
                    script.write("REF+pax'&\n")
                    script.write("LOC+174+USA:162'&\n")
                    script.write("STX+ARQ:N'&\n")
                    script.write("STX+APR:X'&\n")
                    script.write("STX+AQQ:O'&\n")
                    script.write("STX+API:1'&\n")
                    script.write("STX+TCS:CTN'&\n")
                    script.write("NAT+2+FRA'&\n")
                    script.write("ACT+MOD'&\n")
                    script.write("IRV++++1ARES::did:" + did + "+DCSLON'&\n")
                    script.write("TII+1'&\n")
                    script.write("ODI+NCE+ORY'&\n")
                    script.write("STX+Npt:1'&\n")
                    script.write("REF+pax'&\n")
                    script.write("SSR++043H'&\n")
                    script.write("STX+CNA::CAS+nbD::BDS+nbG::CBS+REC::CRS+NRG::RGS+NCW::WLS+NFL::TPS'&\n")
                    script.write("SCI+Y'&\n")
                    script.write("CPY++3+AF'&\n")
                    script.write("UID++A'&\n")
                    script.write("APL+JFE'&\n")
                    script.write("UNT+34+1'\n")
                    script.write("''Response:\n")
                    script.write("''UNH+1+PSCIUR:10:1:1A+{*}'&\n")
                    script.write("''ERC+2'&\n")
                    script.write("''IFT++OK'&\n")
                    script.write("''RCI+:" + rloc + "'\n")
                    script.write("\n")

            # End of unboard_ pnrs_psciuq editing
            script.close()

            # Launch unboard_pnrs_psciuq script which gets
            # the dictionnary of segments/pax dids and corresponding pax UCIs
            client = ttserverlib.Client(socket, script_path_psciuq, script_path_psciuq + ".log", None, script_path_psciuq + ".rex")
            client.start()
            client.wait()
            del client

    # Remove get_dids_ucis_ppiscq and related scripts
    if logs == "NO":
        remove_logs(script_path_ppiscq)
        if clean_psciuq == 1:
            remove_logs(script_path_psciuq)

    # Default return
    return 1


def clean_pnrs(rloc_list, office=None, sign=None, configuration="cry", logs="NO"):
    """Create and launch a TTS script which cleans a list of PNRs given in input.

    :Non-keyword arguments:
        - rloc_list -- the list of record locators to be cleaned - XI command.
        - office -- the office you want to sign in for deletion (defaut: None, i.e. the office associated to your ATID).
        - sign -- the sign you want to use to login in office for deletion (defaut: None. If None, sign=0006NR).
        - configuration -- the TTS key defined for the cryptic configuration of your suite (default: cry).
        - logs -- "YES", "NO" or any path where you want to store the script created - mostly for investigation purposes (default: NO).

    :Example:

    >>> generic_lib.clean_pnrs(["UY767B", "IUHIUH", "43JL89"])

    """
    # Separate rloc_list in several list if more than 100 PNRs
    master_list = []
    while len(rloc_list) > 100:
        sublist = []
        for _ in range(0, min(100, len(rloc_list))):
            sublist.append(rloc_list.pop(0))
        master_list.append(sublist)
    if rloc_list != []:
        master_list.append(rloc_list)

    pwd = 'QU1BREVVUzE='
    pwd = pwd.decode('base64', 'strict')
    QA_OFFICE = "NCE1A00QA"    

    for sublist in master_list:
        # Create clean_pnrs script with a unique identifier
        script_name = "clean_pnrs_" + generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + str(master_list.index(sublist)) + "_" + generic_lib.random_alpha(5) + ".cry"

        if (logs.upper() != "YES") and (logs.upper() != "NO"):
            script_path = os.path.join(os.path.normpath(logs), script_name)
        else:
            script_path = os.path.join(os.getcwd(), script_name)

        # Write the script itself
        script = open(script_path, "w")

        # Initialize block
        script.write("''Initialize:\n")
        script.write("import generic_lib\n")
        script.write("sign_in = 'JI0103FR/SU' #sign for office NCE1A00QA\n")
        script.write("\n")
        script.write("def set_sign_in():\n")
        script.write("    global sign_in\n")
        if sign is None:
            script.write("    sign_in = 'JI0006NR/SU'\n")
        else:
            script.write("    sign_in = 'JI" + sign + "/SU'\n")
        script.write("    return ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK\n")
        script.write("''End\n")

        # Finalize block
        script.write("\n")
        script.write("''Finalize:\n")
        script.write("context.script_output_list = []\n")
        script.write("global sign_in\n")
        script.write("sign_in = 'JI0103FR/SU'\n")
        script.write("''End\n")
        script.write("\n")

        script.write("\n'Check if you are logged in office NCE1A00QA\n")
        script.write("JD\n")
        script.write("''Response:\n")
        script.write("''{.*}         " + QA_OFFICE + "{.*}\n")
        script.write("''Nomatch: set_sign_in()\n")

        # Script part
        script.write("\nIG\nJO*\n\n")
        if office is None:
            script.write("%sign_in%-"+ pwd + "\n")
        else:
            script.write("%sign_in%." + office + "-" + pwd + "\n")
        script.write("\n")



        for rloc in sublist:
            script.write("RT " + rloc + "\n")
            script.write("XI\n")
            script.write("RF generic_lib - CLEAN_PNRS;TK OK;AP generic_lib - CLEAN_PNRS\n")
            script.write("SR OTHS ZZ -TEST\n")
            script.write("ET\n")
            script.write("''Response:\n")
            script.write("''END OF TRANSACTION COMPLETE - " + rloc + "{*}\n")
            script.write("''NoMatch: TTServer.currentMessage.loop(1,1,0)\n")
            script.write("\n")
            script.write("IG\n")
            script.write("\n")

        script.write("JO\n")

        # End of clean_pnrs editing
        script.close()

        # Launch clean_pnrs script when necessary
        if (logs.upper() == "YES") or (logs.upper() == "NO"):
            generic_lib.run_tts_script(script_path, None, 1, configuration, logs)

        if (logs.upper() == "YES"):
            pwd_lib.hide_password_in_script(script_path, pwd)

    return 1


def clean_profiles(rloc_list, entity="T", office=None, sign=None, configuration="cry", logs="NO"):
    """Create and launch a TTS script which cleans a list of profiles given in input.

    :Non-keyword arguments:
        - rloc_list -- the list of record locators to be cleaned - XI command.
        - entity -- "T" or "C" for travellers or company profiles (default: T).
        - office -- the office you want to sign in for deletion (defaut: non, i.e. the office associated to your ATID).
        - configuration -- the TTS key defined for the cryptic configuration of your suite (default: cry).
        - logs -- "YES", "NO" or any path where you want to store the script created - mostly for investigation purposes (default: NO).

    :Example:

    >>> generic_lib.clean_profiles(["JHGIU8", "HGYF67", "23DS98"], "T")

    """
    script_name = "clean_profiles_" + generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + generic_lib.random_alpha(5) + ".cry"

    if (logs.upper() != "YES") and (logs.upper() != "NO"):
        script_path = os.path.join(os.path.normpath(logs), script_name)
    else:
        script_path = os.path.join(os.getcwd(), script_name)


    pwd = 'QU1BREVVUzE='
    pwd = pwd.decode('base64', 'strict')
    QA_OFFICE = "NCE1A00QA"

    script = open(script_path, "w")

    # Initialize block
    script.write("''Initialize:\n")
    script.write("import generic_lib\n")
    script.write("sign_in = 'JI0103FR/SU' #sign for office NCE1A00QA\n")
    script.write("\n")
    script.write("def set_sign_in():\n")
    script.write("    global sign_in\n")
    if sign is None:
        script.write("    sign_in = 'JI0006NR/SU'\n")
    else:
        script.write("    sign_in = 'JI" + sign + "/SU'\n")
    script.write("    return ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK\n")
    script.write("''End\n")

    # Finalize block
    script.write("\n")
    script.write("''Finalize:\n")
    script.write("context.script_output_list = []\n")
    script.write("global sign_in\n")
    script.write("sign_in = 'JI0103FR/SU'\n")
    script.write("''End\n")
    script.write("\n")

    script.write("\n'Check if you are logged in office NCE1A00QA\n")
    script.write("JD\n")
    script.write("''Response:\n")
    script.write("''{.*}         " + QA_OFFICE + "{.*}\n")
    script.write("''Nomatch: set_sign_in()\n")

    # Script part
    script.write("\nIG\nJO*\n\n")
    if office is None:
        script.write("%sign_in%-"+ pwd + "\n")
    else:
        script.write("%sign_in%." + office + "-" + pwd + "\n")
    script.write("\n")
    
    script.write("PM\n")

    deactivate = "PXR" + entity

    for rloc in rloc_list:
        script.write(deactivate + "/" + rloc + "\n")
        script.write("PE\n\n")

    script.write("PME\n")

    # End of clean_profiles editing
    script.close()

    # Launch clean_pnrs script when necessary
    if logs.upper() in ["YES", "NO"]:
        generic_lib.run_tts_script(script_path, None, 1, configuration, logs)

    if (logs.upper() == "YES"):
        pwd_lib.hide_password_in_script(script_path, pwd)

    return 1


def get_rlocs(flight, date, _class="ALL", configuration="cry", logs="NO"):
    """Create and launch a TTS script which gets a list of rlocs and return it.

    :Non-keyword arguments:
        - flight -- the flight that must be contained in the PNRs whose rlocs are returned.
        - date -- the date of the flight concerned.
        - _class -- the class of the flight concerned (defaut: "ALL").
        - configuration -- the TTS key defined for the cryptic configuration of your suite (default: cry).
        - logs -- "YES", "NO" or any path where you want to store the script created - mostly for investigation purposes (default: NO).

    :Example:

    >>> generic_lib.get_rlocs("AF1283", "12DEC", "Y")

    """
    script_name = "get_rlocs_" + generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + generic_lib.random_alpha(5) + ".cry"

    if (logs.upper() != "YES") and (logs.upper() != "NO"):
        script_path = os.path.join(os.path.normpath(logs), script_name)
    else:
        script_path = os.path.join(os.getcwd(), script_name)


    pwd = 'QU1BREVVUzE='
    pwd = pwd.decode('base64', 'strict')

    script = open(script_path, "w")

    # Initialize block
    script.write("''Initialize:\n")
    script.write("import re\n")
    script.write("\n")
    script.write("global LINE_NB\n")
    script.write("LINE_NB = 1\n")
    script.write("\n")
    if isinstance(flight, generic_lib.AirSegment):
        script.write("flight = \'" + flight.airline + flight.flight_nb + "\'\n")
    else:
        script.write("flight = \'" + flight + "\'\n")
    script.write("date = \'" + date + "\'\n")
    if _class != "ALL":
        script.write("_class = \'" + _class + "\'\n")
    script.write("rloc_list = []\n")
    script.write("\n")
    script.write("def exit_properly():\n")
    script.write("    context.end_loop = 1\n")
    script.write("    TTServer.currentClient.abortWithoutError()\n")
    script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n\n")
    script.write("def parse_response():\n")
    script.write("    global LINE_NB\n")
    script.write("    pnr = ttserverlib.TTServer.currentMessage.getReplyBody()\n")
    script.write(r"    rloc = re.findall('RP/\w*/.{25,35}\w*/\w*   (\w{6})', pnr)[0]" + "\n")
    script.write("    if rloc not in rloc_list:\n")
    script.write("        rloc_list.append(rloc)\n")
    script.write("    LINE_NB +=1\n")
    script.write("    ttserverlib.TTServer.currentMessage.loop(1, 200, 0)\n")
    script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
    script.write("''End\n")

    # Finalize block
    script.write("''Finalize:\n")
    script.write("context.script_output_list = [rloc_list]\n")
    script.write("''End\n")

    # Script part
    script.write("\nIG\nJO*\n\n")
    script.write("JI0103FR/SU-"+ pwd + "\n")
    script.write("\n")
    if _class == "ALL":
        script.write("LP/%flight%/%date%\n")
    else:
        script.write("LP/C(%_class%)/%flight%/%date%\n")
    script.write("''Response:\n")
    script.write("''{.*}CHECK FLIGHT NUMBER&\n")
    script.write("''>\n")
    script.write("''Response:\n")
    script.write("''{.*}FLIGHT NOT OPERATIONAL&\n")
    script.write("''>\n")
    script.write("''Match: exit_properly()\n")
    script.write("''NoMatch: TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK\n")
    script.write("\n")
    script.write("LP{=str(LINE_NB)}\n")
    script.write("''Response:\n")
    script.write("''{*}NO ITEMS&\n")
    script.write("''>\n")
    script.write("''Match: exit_properly()\n")
    script.write("''NoMatch: parse_response()\n")
    script.write("\nIG\nJO*\n\n")

    # End of clean_profiles editing
    script.close()

    # Launch clean_pnrs script when necessary
    if logs.upper() in ["YES", "NO"]:
        return_value = generic_lib.run_tts_script(script_path, None, 1, configuration, logs)[0]

    if (logs.upper() == "YES"):
        pwd_lib.hide_password_in_script(script_path, pwd)

    return return_value


def run_tts_script(script_path, input_list=None, repetition_nb=1, configuration=None, logs="NO", global_regression=None):
    """Create and launch a TTS script and return a list of variables that can be filled within your script.

    :Non-keyword arguments:
        - script_path -- the relative path to the script that must be launched.
        - repetition_nb -- the number of times the script will be launched (default: 1).
        - configuration -- the TTS key defined for the cryptic configuration of your suite (default: cry).
        - logs -- "YES", "NO" or any path where you want to store the script created - mostly for investigation purposes (default: NO).

    :Example:

    >>> generic_lib.run_tts_script("../create_pnr.cry", 10)

    """
    if logs.upper() not in ["YES", "NO"]:
        script_path = os.path.join(os.path.normpath(logs), script_path.split("/")[-1])

    # Retrieve configuration used in regression (either given or inferred from script extension)
    if configuration is None:
        socket = ttserverlib.targetsMap[script_path.split(".")[-1]]
    else:
        socket = ttserverlib.targetsMap[configuration]

    # Launch script given in input n times (n = repetition_nb)
    client = ttserverlib.Client(socket, script_path, script_path + ".log", None, script_path + ".rex")
    script_output_list = []
    client.context.input_list = input_list

    #if global_regression is passed as parameter, execution context can be shared between parent script and client
    if global_regression != None:
        client.context.global_regression=global_regression

    for _ in range(repetition_nb):
        client.start()
        client.wait()

        if hasattr(client.context, 'script_output_list'):
            script_output_list.extend(client.context.script_output_list) # Get output_variables from the script

        del client

    # Remove clean_profiles and related scripts
    if logs.upper() == "NO":
        remove_logs(script_path)

    return script_output_list


def remove_logs(script_path):
    """Remove a script and its logs (.log, .rex)."""
    os.remove(script_path)
    os.remove(script_path + ".log")
    os.remove(script_path + ".rex")

# def add_asso(asso_list, type_, list_of_elts):
#     """Return what should be appended to a booking entry to take into account a pax or seg asso."""
#     booking_suffix = ""
#     if asso_list != []:
#         booking_suffix += "/" + type_
#         for asso in asso_list:
#             booking_suffix += str(list_of_elts.index(asso) + 1)
#             if asso != asso_list[-1]:
#                 booking_suffix += ","
#
#     return booking_suffix

def clean_flight(flight, date, _class="ALL", configuration="cry", logs="NO", office=None):
    """
    
    Function launching a script which cleans a flight given in input. You can specify a class and keep the log if needed.
    
    :Example:

    >>> generic_lib.clean_flight('AF1234', '12MAR', 'Y')
    
    """

    # Create clean_flight script with a unique identifier where it is required
    script_name = 'clean_flight_' + generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + flight + _class + date + "_" + generic_lib.random_alpha(5) + ".cry"

    if (logs.upper() != "YES") and (logs.upper() != "NO"):
        script_path = os.path.join(os.path.normpath(logs), script_name)
    else:
        script_path = os.path.join(os.getcwd(), script_name)


    pwd = 'QU1BREVVUzE='
    pwd = pwd.decode('base64', 'strict')
    QA_OFFICE = "NCE1A00QA"

    script = open(script_path, "w")

    # Initialize block
    script.write("''Initialize:\n")
    script.write("import re\n")
    script.write("import generic_lib\n")
    script.write("\n")
    script.write("flight = \'" + flight + "\'\n")
    script.write("date = \'" + date + "\'\n")
    if _class != "ALL":
        script.write("_class = \'" + _class + "\'\n")
    script.write("\n")
    script.write("list_of_previous_rlocs = []\n")
    script.write("def parse(response):\n")
    script.write("    if (TTServer.currentMessage.getQueryBody().startswith('LP/')):\n")
    script.write("        if response.endswith('CHECK FLIGHT NUMBER\\n>')\\\n")
    script.write("        or 'NO PNRS FOUND' in response:\n")
    script.write("            context.end_loop = 1\n")
    script.write("            TTServer.currentClient.abortWithoutError()\n")
    script.write("    elif (TTServer.currentMessage.getQueryBody() == 'LP1'):\n")
    script.write("        if response.endswith('NO ITEMS\\n>')\\\n")
    script.write("        or response.endswith('NO MATCH FOR RECORD LOCATOR\\n>'):\n")
    script.write("            context.end_loop = 1\n")
    script.write("            TTServer.currentClient.abortWithoutError()\n")
    script.write("        else:\n")
    script.write("            rloc = re.findall('RP\/(.{54})(\w{6})', response)[0][1]\n")
    script.write("            if rloc in list_of_previous_rlocs:\n")
    script.write("                context.end_loop = 1\n")
    script.write("                TTServer.currentClient.abortWithoutError()\n")
    script.write("            list_of_previous_rlocs.append(rloc)\n")
    script.write("    elif TTServer.currentMessage.getQueryBody() == 'ET':\n")
    script.write("        if response.endswith('RESTRICTED\\n>'):\n")
    script.write("            context.end_loop = 1\n")
    script.write("            TTServer.currentClient.abortWithoutError()\n")
    script.write("        else:\n")
    script.write("            TTServer.currentMessage.loop(1,1,0)\n")
    script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
    script.write("\n")
    script.write("sign_in = 'JI0103FR/SU' #sign for office NCE1A00QA\n")
    script.write("\n")
    script.write("def set_sign_in():\n")
    script.write("    global sign_in\n")
    script.write("    sign_in = 'JI0006NR/SU'\n")
    script.write("    return ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK\n")
    script.write("''End\n")

    # Finalize block
    script.write("\n")
    script.write("''Finalize:\n")
    script.write("context.script_output_list = []\n")
    script.write("global sign_in\n")
    script.write("sign_in = 'JI0103FR/SU'\n")
    script.write("''End\n")
    script.write("\n")

    script.write("\n'Check if you are logged in office NCE1A00QA\n")
    script.write("JD\n")
    script.write("''Response:\n")
    script.write("''{.*}         " + QA_OFFICE + "{.*}\n")
    script.write("''Nomatch: set_sign_in()\n")

    # Script part
    script.write("\nIG\nJO*\n\n")
    script.write("\nIG\nJO*\n\n")
    if office is None:
        script.write("%sign_in%-"+ pwd + "\n")
    else:
        script.write("%sign_in%." + office + "-" + pwd + "\n")
    script.write("\n")
    
    if _class == "ALL":
        script.write("LP/%flight%/%date%\n")
    else:
        script.write("LP/C(%_class%)/%flight%/%date%\n")
    script.write("''Response:\n")
    script.write("''{%response%=*}\n")
    script.write("''Match: parse(response)\n")
    script.write("\n")
    script.write("LP1\n")
    script.write("''Response:\n")
    script.write("''{%response%=*}\n")
    script.write("''Match: parse(response)\n")
    script.write("\n")
    script.write("XI\n")
    script.write("RF generic_lib - CLEAN_FLIGHT;TK OK;AP generic_lib - CLEAN_FLIGHT\n")
    script.write("SR OTHS ZZ -TEST\n")
    script.write("ET\n")
    script.write("''Response:\n")
    script.write("''{%response%=*}\n")
    script.write("''Match: parse(response)\n")
    script.write("\n")
    script.write("''Wait: 1\n")
    script.write("\nIG\nJO*\n\n")

    # End of clean_flight editing
    script.close()

    # Launch clean_flight script only if necessary
    if (logs.upper() == "YES") or (logs.upper() == "NO"):
        # Retrieve configuration used in regression
        socket = ttserverlib.targetsMap[configuration]

        # Make sure configuration will be fine for the script
        old_newlinecharacter = socket.config.newlineCharacter
        socket.config.newlineCharacter = 1
        old_host = socket.config.host
        socket.config.host = "sitst.tn3270.1a.amadeus.net"

        client = ttserverlib.Client(socket, script_path, script_path + ".log", None, script_path + ".rex")

        # Store variable in client object to be able to use them in .cry script
        client.context.flight = flight
        client.context.date = date
        client.context._class = _class

        # Launch clean_flight script which deletes
        # given flight in the first PNR returned by LP
        number_of_executions = 0
        maximal_number_of_executions = 80
        client.context.end_loop = 0
        while (number_of_executions < maximal_number_of_executions)\
                and (not client.context.end_loop):
            client.start()
            client.wait()
            number_of_executions += 1
        del client

        # Display a warning to the user if maximal nb of execution is reached
        if number_of_executions >= maximal_number_of_executions:
            print "[generic_lib] WARNING:clean_flight() function has stopped due to maximal number of executions for " + flight + date + ", class " + _class + ". There may be some remaining pnrs containing the flight!"

        # Restore old configuration
        socket.config.newlineCharacter = old_newlinecharacter
        socket.config.host = old_host

    # Remove clean_flight and related scripts
    if logs.upper() == "NO":
        remove_logs(script_path)

    if (logs.upper() == "YES"):
        pwd_lib.hide_password_in_script(script_path, pwd)

    return 1

def create_pnr(pnr, rf_elt="RF generic_lib - CREATE_PNR", office="", configuration="cry", logs="NO"):
    """
    Function launching a script that creates a pnr containing given pnr elements
    (as classes defined in this library) and returns its rloc. You can keep the log if needed.\n
    
    :Non-keyword arguments:
        - pnr -- Pnr class object
    
    :Example: 
    >>> generic_lib.create_pnr(generic_lib.Pnr([generic_lib.PaxName('SIMPSON', 'HOMER')],[generic_lib.AirSegment('7S', '125', 'Y', '10MAY07', 'NCE', 'CDG')]))
    RLOC
        
    """
    
    # Create Create_pnr script with a unique identifier
    script_name = 'create_pnr_' + generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + generic_lib.random_alpha(5) + ".cry"
    
    if (logs.upper() != "YES") and (logs.upper() != "NO"):
        script_path = os.path.join(os.path.normpath(logs), script_name)
    else:
        script_path = os.path.join(os.getcwd(), script_name)


    pwd = 'QU1BREVVUzE='
    pwd = pwd.decode('base64', 'strict')
    QA_OFFICE = "NCE1A00QA"

    script = open(script_path, "w")

    # Initialize block
    script.write("''Initialize:\n")
    script.write("import generic_lib\n")
    script.write("sign_in = 'JI0103FR/SU' #sign for office NCE1A00QA\n")
    script.write("\n")
    script.write("def set_sign_in():\n")
    script.write("    global sign_in\n")
    script.write("    sign_in = 'JI0006NR/SU'\n")
    script.write("    return ttserverlib.TTServer.currentMessage.TTS_NOMATCH_COMPARISON_OK\n")
    script.write("''End\n")

    # Finalize block
    script.write("\n")
    script.write("''Finalize:\n")
    script.write("context.script_output_list = [rloc]\n")
    script.write("global sign_in\n")
    script.write("sign_in = 'JI0103FR/SU'\n")
    script.write("''End\n")
    script.write("\n")

    script.write("\n'Check if you are logged in office NCE1A00QA\n")
    script.write("JD\n")
    script.write("''Response:\n")
    script.write("''{.*}         " + QA_OFFICE + "{.*}\n")
    script.write("''Nomatch: set_sign_in()\n")

    # Script part
    script.write("\nIG\nJO*\n\n")
    if office == "":
        script.write("%sign_in%-"+ pwd + "\n")
    else:
        script.write("%sign_in%." + office + "-" + pwd + "\n")
    script.write("\n")

    # name addition
    nb_of_pax = 0
    list_of_names_added = []
    for pax in pnr.pax_list:
        if isinstance(pax, generic_lib.Group):
            nb_of_pax += pax.nb_of_pax
            for item in pax.individual_pax_list:
                list_of_names_added.append(item)
            script.write(pax.book() + '\n')
        elif isinstance(pax, generic_lib.PaxName):
            nb_of_pax += 1
            list_of_names_added.append(pax)
            script.write(pax.book() + '\n')
        elif isinstance(pax, generic_lib.PaxCluster):
            nb_of_pax += pax.nb_of_pax
            for index in range(pax.nb_of_pax):
                list_of_names_added.append(generic_lib.PaxName(pax.last_name, pax.first_names_list[index]))
            script.write(pax.book() + '\n')

    # segments
    list_of_air_segments_added = []
    for seg in pnr.seg_list:
        if isinstance(seg, generic_lib.AirSegment):
            list_of_air_segments_added.append(seg)
            if seg.flight_nb != 0:
                script.write(seg.book(nb_of_pax) + '\n')
            else:
                script.write('AN' + seg.date + seg.board_pt + seg.off_pt)
                if seg.airline != '':
                    script.write('/A' + seg.airline)
                script.write('\n')
                script.write('SS' + str(nb_of_pax) + seg._class + '1\n')
        elif isinstance(seg, generic_lib.SsrSegment):
            script.write(seg.book())
            script.write(generic_lib.add_asso(seg.pax_asso, 'S', list_of_air_segments_added))
            script.write(generic_lib.add_asso(seg.pax_asso, 'P', list_of_names_added))
            script.write('\n')
        elif isinstance(seg, generic_lib.HtlSegment) or isinstance(seg, generic_lib.CarSegment):
            script.write(seg.book())
            script.write(generic_lib.add_asso(seg.pax_asso, 'P', list_of_names_added))
            script.write('\n')
        elif isinstance(seg, str) and seg.startswith('TK'):
            script.write(seg + '\n')

    # Group handling
    if isinstance(pnr.pax_list[0], generic_lib.Group):
        script.write("SR GRPF -TEST\n")

    script.write(rf_elt + "\n")
    script.write("AP123\n")
    script.write("ET\n")
    script.write("''Response:\n")
    script.write("''END OF TRANSACTION COMPLETE - {%rloc%=*}&\n")
    script.write("''>\n")
    script.write("''NoMatch: TTServer.currentMessage.loop(1,1,0)\n")
    script.write("\nIG\nJO*\n\n")
    script.close()

    # Return rloc
    rloc = generic_lib.run_tts_script(script_path, None, 1, configuration, logs)[0]
    print rloc
    
    # Remove create_pnr and related scripts
    if logs.upper() == "NO":
        remove_logs(script_path)

    if (logs.upper() == "YES"):
        pwd_lib.hide_password_in_script(script_path, pwd)
    
    return rloc

# def create_configuration(key, test_system):
#     """Creates a TTS configuration of the given type."""
#     if key == "cry":
#         config = ttserverlib.Config()
#         config.transportHeader = ttserverlib.TH_TN3270
#         config.host = "sitst.tn3270.1a.amadeus.net"
#         config.port = {"PDT":16002, "SKL":16005, "DEV":16060, "DES":16061, "UAT":16062, "MIG":16063, "PRD":16065, "SUP":16066, "FRT":16067}[test_system]
#         config.timeout = 50.0
#         config.onTimeout = ttserverlib.RTO_Stop
#         config.tps = 0.0
#         config.cps = 0.0
#         config.sessionHeader = ttserverlib.SH_TN3270
#         config.conversationType = ttserverlib.CT_Stateless
#         config.ediCharSet = ttserverlib.ECS_Raw
#         config.newlineCharacter = ttserverlib.NLC_0A
#         config.useMultiLineRegularExpressions = 1
#         config.releaseCharacter = "\\"
#         config.maxSize = 409600
#         config.carf = global_regression.ATID
#         config.compareMode = ttserverlib.CM_AllWithoutDCX
#         config.origin = "FROM"
#         config.destin = ""
#
#     return config
