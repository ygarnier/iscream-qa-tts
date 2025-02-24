#!/usr/bin/env python
#-*- coding: UTF-8 -*-
"""
==== PDF Generic Library version 4.2.45 ===="

Settings module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""
#import paramiko
#import base64

#   .tables to get the list of tables
#   .schema <table> to get the list of columns of the table

# def check_apt_on_obe(airline, dict_of_indicators, backend="PDT", new_indicator=None):
#     """Get a list of indicators from an airline's APT on OBE and return their value or, if values are provided, compare them and return 0 if ok, 1 otherwise.
#
#     Non-keyword argument:
#     airline -- the airline whose APT must be checked.
#     dict_of_indicators -- the dictionnary of indicators to be checked and their value.
#     backend -- the backend on which to check the APT (default: PDT).
#     new_indicator -- a dictionnary of an indicator's TPF name and its OBE name - for new indicators.
#
#     Examples::
#     >>> generic_lib.check_apt_on_obe("AF", {"L":""})
#     Y
#
#     >>> generic_lib.check_apt_on_obe("AF", {"L":"Y"})
#     0
#
#     """
#     # Define APT mapping between TPF and OBE names
#     apt_mapping_table = {"B":"aaussim", "77":"accimg", "AMP":"amp", "INV-AMQ":"amq", "APN":"apn", "AT2-EC1":"at2ec1", "AT2-EC2":"at2ec2", "AT2-EC3":"at2ec3", "AT2-EC4":"at2ec4", "AT2-EMC":"at2emc", "AT2-EMT":"at2emt", "AT2-ERC":"at2erc",
#                          "AT2-ERF":"at2erf", "AT2-ERT":"at2ert", "AT3-EMO":"at3emo", "AT3-ERD":"at3erd", "ATC-EMA":"atcema", "ATC-EMB":"atcemb", "ATC-EMM":"atcemm", "ATC-EMN":"atcemn", "ATC-EMS":"atcems", "ATC-ERO":"atcero",
#                          "ATC-ERS":"atcers", "ATC-NRG":"atcnrg", "ATG":"atg", "ATL-ATE":"atlate", "ATL-ATH":"atlath", "ATL-ATS":"atlats", "ATL-ATV":"atlatv", "ASR":"asr", "AU2-SRV":"au2srv", "AUX/AFL":"auxafl", "AUX-ATX":"auxatx", "AUX_CAR":"auxcar",
#                          "AUX_FQR":"auxfqr", "AUX-HTL":"auxhtl", "AUX_IAP":"auxiap", "AUX_RTB":"aux_rtb", "AUX-TUR":"auxtur", "AV2-AFQ":"av2afq", "AV2-ANM":"av2anm", "AV2-DID":"av2did", "AV2-ERN":"av2ern", "AV2-JSE":"av2jse",
#                          "AV2-NGI":"NGI_Hosted", "AV2-PSI":"av2psi", "AV2-UMN":"av2umn", "AV3-CPR":"av3cpr", "AV3-CSP":"av3csp", "AV3-JS3":"av3js3", "AV3-NJD":"av3njd", "AV3-SAD":"av3sad", "AV3-TIE":"av3tie", "AVC":"avc", "AVL-ADA":"avlada",
#                          "AVL-ALL":"avlall", "AVL-CAB":"avlcab", "AVL-D11":"avld11", "AVL-JDA":"avljda", "AVL-LHL":"avllhl", "AVL-LKD":"avllkd", "AVL-PST":"avlpst", "BP":"bpi", ":0":"chgnm", "D":"claim", "!0":"copy", "CST":"cst",
#                          "11":"daseat", "33":"day_chg", "INV_DFI":"dfi", "DP":"dpf", "EMD-USE":"emduse", "EMF":"emf", "EMI-DUH":"emiduh", "ERD":"erd", ":2":"ersp", "ERT":"ert", "ERV":"erv", "ETK-CAP":"etkcap", "ETK-DOM":"etk_dom", "ETK_ILN":"etkiln",
#                          "ETK-INT":"etk_int", "ETK-SET":"etk_set", "ETK-SRD":"etksrd", "ETK-TKI":"etktki", "ETK-TNE":"etktne", "ETS":"ets", "INV-FLI":"fli", "FPO":"fpo", "FTI":"fti", "HB":"hbp", "HR":"hrs", "RT":"RoutingOtherairline", "HX":"hx", "88":"i88",
#                          "!1":"iasl", "J":"seat_exg_agrmt", "0":"Access_Sell", "S":"id16", "T":"id17", "H":"id20", "P":"id23", "Q":"TTY_Agreement", "N":"avs_exceptn", "1":"id30", "I":"id31", "C":"id32", "3":"id34", "4":"pd_point_mgrt", "5":"Sponsored",
#                          "6":"rcv_img_pnr", "A":"id40", "L":"system_user", "M":"nk_code", "F":"i6", "R":"id47", "U":"id50", "V":"id51", "W":"id52", "X":"alph_num_flt", "O":"id54", "G":"id55", "Y":"id56", "7":"id60", "8":"id61", "9":"optn_num_funct", "AA":"tktl", "BB":"id64",
#                          "CC":"tty_mgrt", "EE":"nco_agrmt", "FF":"id70", "GG":"id71", "HH":"id72", "II":"id73", "JJ":"its_rloc", "MM":"queue_man_aux", "NN":"req_pos_inf", "OO":"rcv_form_paymt", "PP":"rcv_fare_discnt", "QQ":"id83", "RR":"inf_pax", "SS":"tty_accpt_adp",
#                          "WW":"accpt_pkl", "XX":"id92", "YY":"id93", "ZZ":"accpt_px", "00":"cia_agrmt", "IN2-ABC":"in2abc", "IN2-CHC":"in2chc", "IN2-PCC":"in2pcc", "IN2-PLC":"in2plc", "IN2-PLF":"in2plf", "IN2-RAI":"in2rai", "IN2-RPI":"in2rpi",
#                          "IN2-TAG":"in2tag", "Z":"intasr", "E":"inv_fqtv", "INV-PFK":"invpfk", "22":"iseat", "LL":"iseot", "$1":"ivlpx", "LCA":"lca_dei8", "LCD-LCI":"lci", "LCD-LRA":"lra", "99":"long_eot", "INV-LOT":"lot", "IRU-IPR":"iruipr",
#                          "IRU-IVA":"iruiva", "MA2-ABI":"ma2abi", "MA2-ALC":"ma2alc", "MA2-BRD":"ma2brd", "MA2-DMC":"ma2dmc", "MA2-FFU":"ma2ffu", "MA2-SBF":"ma2sbf", "MA2-SSL":"ma2ssl", "MAG-ASB":"magasb", "MAG-AVS":"magavs",
#                          "MAG-AXT":"axt", "MAG-DLX":"magdlx", "MAG-FXL":"magfxl", "MAG-ISB":"magisb", "MAG-IXL":"magixl", "MAG-PAH":"magpah", "MAR-1AL":"mar1al", "MAR-AGR":"maragr", "MAR-FAM":"marfam", "MAR-ODC":"marodc",
#                          "MAR-ONL":"maronl", "MAR-REC":"marrec", "MAR-SEL":"marsel", "MAR-SIT":"sit", "DD":"mgrclaim", "NGP":"NGP_NGI_MigPhase", "$0":"nonair", "INV-NRM":"nrm", "NZ":"ord", ":1":"pkpl", "POI":"poi", "PN2-DCO":"pn2dco", "PN2-EXR":"exr",
#                          "PN2-KWT":"key_word_part", "PN2-SR3":"pn2sr3", "PN2-SVC":"pn2svc", "PN2-TIF":"pn2tif", "PN2-VFV":"vfv_fqtv", "PN2-VIW":"pn2viw", "PN3-HXK":"hxk", "PN3-MEV":"pn3mev", "PN3-MFF":"pn3mff", "PN3-MIG":"pn3mig",
#                          "PN3-NCH":"pn3nch", "PN3-SXX":"sxx", "PN3-SYN":"pn3syn", "PN3-VFF":"pn3vff", "PN4-AER":"pn4aer", "PN4-CTD":"ctd", "PN4-FAO":"fao", "PN4-FAS":"fas", "PN4-FES":"fes", "PN4-FMO":"fmo", "PN4-FMS":"fms", "PN4-NCC":"pn4ncc",
#                          "PN5-ASR":"pn5asr", "PN5-DUM":"pn5dum", "PN5-IMO":"pn5imo", "PN5-LCC":"lca", "PN5-POS":"pos", "PN5-TKL":"pn5tkl", "PN5-TLO":"pn5tlo", "PN5-TTY":"no_tty_synch", "PN6-APM":"pn6apm", "PN6-BS1":"bs1",
#                          "PN6-CBE":"pn6cbe", "PN6-LCP":"pn6lcp", "PN6-OST":"pn6ost", "PN6-PNL":"pnl", "PN6-SCF":"pn6scf", "PN6-TLA":"pn6tla", "PN7-BS2":"pn7bs2", "PN7-DKS":"pn7dks", "PN7-ELD":"pn7eld", "PN7-EOA":"pn7eoa",
#                          "PN7-ETL":"pn7etl", "PN7-MFQ":"pn7mfq", "PN7-MKR":"pn7mkr", "PN7-TPR":"pn7tpr", "PN8-CPS":"pn8cps", "PN8-MRE":"pn8mre", "PN8-NME":"pn8nme", "PN8-QFH":"pn8qfh", "PN8-QMT":"pn8qmt", "PN8-WMO":"pn8wmo",
#                          "PN9-BSX":"pn9bsx", "PN9-GCR":"pn9gcr", "PN9-GNR":"pn9gnr", "PN9-GSR":"pn9gsr", "PN9-IQC":"pn9iqc", "PN9-PBP":"pn9pbp", "PN9-QMC":"pn9qmc", "PN9-RVL":"pn9rvl", "PNA-ANT":"pnaant", "PNA-BTF":"pnabtf",
#                          "PNA-BTR":"pnabtr", "PNA-COC":"pnacoc", "PNA-EPA":"pnaepa", "PNA-GAC":"pnagac", "PNA-PRN":"pnaprn", "PNB-INF":"pnbinf", "PNR-DAF":"daf", "PNR-NMP":"pnrnmp", "PNR_NMR":"pnrnmr", "PNR-SPT":"spt",
#                          "PNR-SPU":"pnrspu", "PNR_SR1":"pnrsr1", "PNR-SR2":"pnrsr2", "PNR-SRI":"pnrsri", "RAL-RSP":"ralrsp", "VV":"rcv_grp", "UU":"rcv_osi", "TT":"rcv_ssr", "55":"rcv_typ", "RMD":"rmd", "K":"routseat", "RPS":"rps",
#                          "RS":"rsv", ":3":"s95umage", "SAH":"sah", "$2":"seatcd", "SEL-API":"selapi", "SEL-APU":"selapu", "SEL-BRO":"selbro", "SEL-EPI":"selepi", "SEL-GNC":"gnc", "SEL-PD7":"pd7", "SEL-PD8":"pd8", "SEL-SSR":"ssr", "INV-SIM":"sim",
#                          "SMS-CSM":"smscsm", "SMS-NAC":"smsnac", "SMS-NCD":"smsncd", "SMS-SNF":"smssnf", "SR":"srg", "SRQ":"srq", "SS2-AFO":"ss2afo", "SS2-FAC":"ss2fac", "SS2-FFF":"ss2fff", "SS2-FFN":"ss2ffn", "SS2-FFS":"ss2ffs",
#                          "SS2-IWC":"ss2iwc", "SS2-PAF":"ss2paf", "SS2-SAD":"ss2sad", "SS3-TPS":"ss3tps", "SSM-CSS":"ssmcss", "SSM-FOD":"ssmfod", "SSM-JDL":"ssmjdl", "SSM-JOU":"ssmjou", "SSM-MOD":"ssmmod", "SSM-MRL":"ssmmrl",
#                          "SSM-ODF":"ssmodf", "SSM-POD":"ssmpod", "SSU-NGS":"ssungs", "SSU-NPD":"ssunpd", "SSU-NRC":"ssunrc", "SSU-NSU":"ssunsu", "INV-SUP":"sup", "KK":"svcseg", "66":"tknprv", "TKT-MDB":"tktmdb", "TKT-NTO":"tktnto",
#                          "TKT-RPW":"tktrpw", "TKT-VAT":"tktvat", "TTY-ADR":"ttyadr", "TTY-CLO":"ttyclo", "44":"ttyinp", "TTY-ORL":"ttyorl", "TT1-SCI":"tt1sci", "MR":"ver", "2":"zonehs"}
#
#     # Add new indicator if provided
#     if (new_indicator is not None) and isinstance(new_indicator, dict):
#         apt_mapping_table.update(new_indicator)
#
#     # Build SQL list of OBE indicators
#     list_of_obe_indicators = []
#     for tpf_indicator in dict_of_indicators.keys():
#         if tpf_indicator in apt_mapping_table.keys():
#             list_of_obe_indicators.append(apt_mapping_table[tpf_indicator])
#     obe_indicators = ",".join(list_of_obe_indicators)
#
#     # Retrieve list of values from database
#     ssh_client = paramiko.SSHClient()
#     ssh_client.load_system_host_keys()
#     ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#     ssh_client.connect("ncegcolnx225", username="typreg", password=base64.b64decode("QW1hZGV1czA2"))
#
#     sql_request = "select " + obe_indicators + " from crb_apt_table where airline_code in ('" + airline + "');"
#     unix_command = "\"cd ./gmc/data/SQLite/rfd/; sqlite3 \\$(ls -t *.db | head -1) \\\""
#     ssh_command = "ush -q -n oltp -o rdi -p " + backend + " -F " + unix_command + sql_request + '\\" "'
#     # return is stdin, stdout, stderr
#     stdout = ssh_client.exec_command(ssh_command)[1]
#     values_list = stdout.readline().rstrip("\n").split("|")
#
#     ssh_client.close()
#
#     # Compare values
#     if values_list == dict_of_indicators.values():
#         return 0
#
#     return 1
#
# def check_ogi_table_on_obe(airline, expected_pdp_value=None, backend="PDT"):
#     """Get PDP for an airline's OGI table on OBE and return its value or, if provided, compare it and return 0 if ok, 1 otherwise.
#
#     Non-keyword argument:
#     airline -- the airline whose OGI table must be checked.
#     expected_pdp_value -- the value of the PDP that must be compared (default: None).
#     backend -- the backend on which to check the OGI table (default: PDT).
#
#     Examples::
#     >>> generic_lib.check_ogi_table_on_obe("2Y")
#     BIDRM2Y
#
#     >>> generic_lib.check_ogi_table_on_obe("2Y", "BIDXX2Y")
#     1
#
#     """
#     # Retrieve list of values from database
#     ssh_client = paramiko.SSHClient()
#     ssh_client.load_system_host_keys()
#     ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#     ssh_client.connect("ncegcolnx225", username="typreg", password=base64.b64decode("QW1hZGV1czA2"))
#
#     sql_request = "select special_routing_address from rfd_ogi where airline_code in ('" + airline + "');"
#     unix_command = "\"cd ./gmc/data/SQLite/rfd/; sqlite3 \\$(ls -t *.db | head -1) \\\""
#     ssh_command = "ush -q -n oltp -o rdi -p " + backend + " -F " + unix_command + sql_request + '\\" "'
#
#     # return is stdin, stdout, stderr
#     stdout = ssh_client.exec_command(ssh_command)[1]
#
#     pdp_value = stdout.readline().rstrip("\n")
#
#     ssh_client.close()
#
#     # Display values if none has been provided, compare them otherwise
#     if expected_pdp_value is None:
#         print pdp_value
#     elif pdp_value == expected_pdp_value:
#         return 0
#
#     return 1
#
# def check_cia_table_on_obe(system, type_, expected_value=None, backend="PDT"):
#     """Get values contained in a system's CIA table on OBE and return them or, if provided, compare them and return 0 if ok, 1 otherwise.
#
#     Non-keyword argument:
#     system -- the system whose CIA table must be checked.
#     type_ -- type of data to be retrieved
#     expected_value -- the value that must be compared (default: None).
#     backend -- the backend on which to check the CIA table (default: PDT).
#
#     Examples::
#     >>> generic_lib.check_cia_table_on_obe("1G", "SMI")
#     AKA
#
#     >>> generic_lib.check_cia_table_on_obe("1G", "B", "AF")
#     0
#
#     """
#     # Retrieve list of values from database
#     ssh_client = paramiko.SSHClient()
#     ssh_client.load_system_host_keys()
#     ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#     ssh_client.connect("ncegcolnx225", username="typreg", password=base64.b64decode("QW1hZGV1czA2"))
#
#     if type_.upper() == "SMI":
#         sql_request = "select value from cia_smi where crs_code in ('" + system + "');"
#     else:
#         sql_request = "select value from cia where crs_code in ('" + system + "');"
#     unix_command = "\"cd gmc/data/SQLite; sqlite3 \\$(ls -t cia*.db | head -1) \\\""
#     ssh_command = "ush -n oltp -o rdi -p " + backend + " -C -i 1 " + unix_command + sql_request + '\\" "'
#
#     # return is stdin, stdout, stderr
#     stdout = ssh_client.exec_command(ssh_command)[1]
#
#     list_of_results = []
#     for line in stdout.readlines():
#         if (type_ == "SMI") and line.rstrip("\n").split("\x1b[0m")[-2].endswith("No output"):
#             list_of_results.append("")
#         else:
#             list_of_results.append(line.rstrip("\n").split("\x1b[0m")[-1])
#
#     ssh_client.close()
#
#     # Display values if no airline provided, check if contained otherwise
#     if expected_value is None:
#         if type_ == "SMI":
#             return list_of_results[0]
#         else:
#             return list_of_results
#     elif expected_value in list_of_results:
#         return 0
#
#     return 1
#
# def get_offices(mask, dict_of_indicators, logs="NO"):
#     """
#     Function getting offices with correct settings. Be careful to give mask precise enough.\n
#     Example::
#     - generic_lib.get_offices('PARAF0***/FR', {'EAS':"YES", 'LNG':"EN"})
#     """
#     # Create get_offices script with a unique identifier where it is required
#     identifier = generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + generic_lib.random_alpha(5)
#     script_name_offices = 'get_offices_' + identifier + ".cry"
#     script_name_indicators = 'get_indicators_' + identifier + ".cry"
#     if (logs.upper() != "YES") and (logs.upper() != "NO"):
#         script_path_offices = os.path.join(os.path.normpath(logs), script_name_offices)
#         script_path_indicators = os.path.join(os.path.normpath(logs), script_name_indicators)
#     else:
#         script_path_offices = os.path.join(os.getcwd(), script_name_offices)
#         script_path_indicators = os.path.join(os.getcwd(), script_name_indicators)
#
#     # Retrieve configuration used for .cry
#     TODO
#
#     if isinstance(mask, list):
#         list_of_offices = mask
#     else:
#         script = open(script_path_offices, 'w')
#
#         # Initialize block
#         script.write("''Initialize:\n")
#         script.write("import re\n")
#         script.write("\n")
#         script.write("list_of_offices = []\n")
#         script.write("def parse(Raw_Response):\n")
#         script.write("    list_of_lines = Raw_Response.split(\"\\n\")\n")
#         script.write("    for line in list_of_lines:\n")
#         script.write("        for elt in line.split(\" \"):\n")
#         script.write("            if re.match('^" + mask[:-3].replace('*', '.') + "$', elt) and (elt not in list_of_offices):\n")
#         script.write("                list_of_offices.append(elt)\n")
#         script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#         script.write("\n")
#         script.write("def loop(Raw_Response):\n")
#         script.write(r"    if re.search('\)>$', Raw_Response):" + "\n")
#         script.write("        parse(Raw_Response)\n")
#         script.write("        ttserverlib.TTServer.currentMessage.loop(1, 20, 0)\n")
#         script.write("    else:\n")
#         script.write("        parse(Raw_Response)\n")
#         script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#         script.write("''End\n")
#         script.write("\n")
#
#         # Finalize part
#         script.write("''Finalize:\n")
#         script.write("context.list_of_offices = list_of_offices\n")
#         script.write("''End\n")
#         script.write("\n")
#
#         # Script part
#         script.write("\nIG\nJO*\n\n")
#         script.write("JIA0001AA/SU\n")
#         script.write("\n")
#         script.write("O*TAYA/OIDSEL/" + mask + "\n")
#         script.write("''Response:\n")
#         script.write("''{%Raw_Response%=*}\n")
#         script.write("''Match: parse(Raw_Response)\n")
#         script.write("\n")
#         script.write("MD\n")
#         script.write("''Response:\n")
#         script.write("''{%Raw_Response%=*}\n")
#         script.write("''Match: loop(Raw_Response)\n")
#         script.write("\n")
#         script.write("JO*\n")
#         script.write("\n")
#
#         # End of get_offices editing
#         script.close()
#
#         # Launch get_offices script
#         client = ttserverlib.Client(socket, script_path_offices, script_path_offices + ".log", None, script_path_offices + ".rex")
#         client.start()
#         client.wait()
#         list_of_offices = client.context.list_of_offices
#         del client
#
#     # Create get_indicators script with a unique identifier where it is required
#     for indicator in list_of_indicators:
#         script = open(script_path_indicators, 'w')
#
#         # Initialize block
#         script.write("''Initialize:\n")
#         if (indicator == 'ANC') or (indicator == 'LAT'):
#             script.write("import re\n")
#             script.write("\n")
#             script.write("list_of_offices = []\n")
#             script.write("def parse(Raw_Response, office):\n")
#             script.write("    list_of_lines = Raw_Response.split(\"\\\\n\")\n")
#             script.write("    for line in list_of_lines:\n")
#             script.write("        for elt in line.split(\"  \"):\n")
#             script.write("            if re.match('" + list_of_values[list_of_indicators.index(indicator)] + "', elt):\n")
#             script.write("                list_of_offices.append(office)\n")
#             script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#             script.write("\n")
#             script.write("def loop(Raw_Response, office):\n")
#             script.write(r"    if re.search('\)>$', Raw_Response):" + "\n")
#             script.write("        parse(Raw_Response, office)\n")
#             script.write("        ttserverlib.TTServer.currentMessage.loop(1, 20, 0)\n")
#             script.write("    else:\n")
#             script.write("        parse(Raw_Response, office)\n")
#             script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#         else:
#             script.write("list_of_offices = []\n")
#             script.write("def add(office):\n")
#             script.write("    list_of_offices.append(office)\n")
#             script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#         script.write("''End\n")
#         script.write("\n")
#
#         # Finalize part
#         script.write("''Finalize:\n")
#         script.write("context.list_of_offices = list_of_offices\n")
#         script.write("''End\n")
#         script.write("\n")
#
#         # Script part
#         script.write("\n")
#         script.write("IG\n")
#         script.write("JO*\n")
#         script.write("\n")
#
#         for office in list_of_offices:
#             script.write("JIA0001AA/SU." + office + "\n")
#             script.write("\n")
#             script.write("PVA" + office + "/" + indicator + "\n")
#             script.write("''Response:\n")
#             if (indicator == 'ANC') or (indicator == 'LAT'):
#                 script.write("''{.*}" + indicator + r"{.*}-{\s*}{%Raw_Response%=*}" + "\n")
#                 script.write("''Match: parse(Raw_Response,'" + office + "')\n")
#                 script.write("\n")
#                 script.write("MD")
#                 script.write("''Response:\n")
#                 script.write("''{%Raw_Response%=*}\n")
#                 script.write("''Match: parse(Raw_Response,'" + office + "')\n")
#             else:
#                 script.write("''{.*}" + indicator + r"{.*}-{\s*}"\
#                     + list_of_values[list_of_indicators.index(indicator)] + "{*}\n")
#                 script.write("''Match: add('" + office + "')\n")
#             script.write("\n")
#             script.write("JO*\n")
#             script.write("\n")
#
#         script.write("JO*\n")
#         script.write("\n")
#
#         # End of get_indicators editing
#         script.close()
#
#         # Launch get_indicators script
#         client = ttserverlib.Client(socket, script_path_indicators, script_path_indicators + ".log", None, script_path_indicators + ".rex")
#         client.start()
#         client.wait()
#
#         list_of_offices = client.context.list_of_offices
#         del client
#
#         # Remove get_indicators and related scripts
#         if logs.upper() == "NO":
#             generic_lib.remove_logs(script_path_indicators)
#
#     # Restore old configuration
#     socket.config.newlineCharacter = old_newlinecharacter
#     socket.config.host = old_host
#
#     # Remove get_offices and related scripts
#     if logs.upper() == "NO":
#         generic_lib.remove_logs(script_path_offices)
#
#     print list_of_offices
#     return list_of_offices
#
# def get_airlines(dict_of_indicators, logs="NO"):
#     """
#     Function getting airlines with correct APT settings.\n
#     WARNING: it takes around 20 minutes to run.\n
#     Example::
#     - generic_lib.get_airlines(['L', 'PN5-POS'], ['Y', 'N'])
#     """
#     # Create get_airlines with a unique identifier where it is required
#     script_name_airlines = 'get_airlines_' + generic_lib.get_date() + "_" + generic_lib.get_time() + "_" + generic_lib.random_alpha(5) + ".cry"
#     if (logs.upper() != "YES") and (logs.upper() != "NO"):
#         script_path_airlines = os.path.join(os.path.normpath(logs), script_name_airlines)
#     else:
#         script_path_airlines = os.path.join(os.getcwd(), script_name_airlines)
#
#     # Launch script to get the list of valid airlines
#     list_of_airlines = []
#     for first_letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789':
#         generic_lib.debug(script_path_airlines)
#         script = open(script_path_airlines, 'w')
#
#         # Initialize block
#         script.write("''Initialize:\n")
#         script.write("import re\n")
#         script.write("\n")
#         script.write("Response = ''\n")
#         script.write("def initialize(Raw_Response):\n")
#         script.write("    global Response\n")
#         script.write("    Response = ''\n")
#         script.write("    parse(Raw_Response)\n")
#         script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#         script.write("\n")
#         script.write("def parse(Raw_Response):\n")
#         script.write("    global Response\n")
#         script.write("    if not re.match('AIRLINE NOT IN TABLE', Raw_Response):\n")
#         script.write("        Response += Raw_Response\n")
#         script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#         script.write("\n")
#         script.write("def loop(Raw_Response):\n")
#         script.write("    global Response\n")
#         script.write("    if re.match('REQUESTED DISPLAY NOT SCROLLABLE', Raw_Response):\n")
#         script.write("        return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#         script.write(r"    if re.search('\)>$', Raw_Response):" + "\n")
#         script.write("        parse(Raw_Response)\n")
#         script.write("        ttserverlib.TTServer.currentMessage.loop(1,5,0)\n")
#         script.write("    else:\n")
#         script.write("        parse(Raw_Response)\n")
#         script.write("        airline_To_Add = 1\n")
#         script.write("        for indicator in list_of_indicators:\n")
#         script.write("            if not re.search('-', indicator):\n")
#         script.write(r"                k = re.search('\s' + indicator + '-([A-Z ./]*):(\w*)', Response)" + "\n")
#         script.write("                if (k is not None) and (k.group(2) != list_of_values[list_of_indicators.index(indicator)]):\n")
#         script.write("                    airline_To_Add = 0\n")
#         script.write("            else:\n")
#         script.write("                Splitted_indicator = indicator.split('-')\n")
#         script.write(r"                k = re.search(Splitted_indicator[0] + '-(.*)' + Splitted_indicator[1] + '/(\w*)', Response)" + "\n")
#         script.write("                if (k is not None) and (k.group(2) != list_of_values[list_of_indicators.index(indicator)]):\n")
#         script.write("                    airline_To_Add = 0\n")
#         script.write("        if (airline_To_Add == 1):\n")
#         script.write(r"            list_of_airlines.append(re.search('--\s(\w*)\s--', Response).group(1))" + "\n")
#         script.write("    return TTServer.currentMessage.TTS_MATCH_COMPARISON_OK\n")
#         script.write("''End\n")
#         script.write("\n")
#
#         # Finalize part
#         script.write("''Finalize:\n")
#         script.write("context.list_of_airlines = list_of_airlines\n")
#         script.write("''End\n")
#         script.write("\n")
#
#         # Script part
#         script.write("\nIG\nJO*\n\n")
#         script.write("JIA0001AA/SU\n")
#         script.write("\n")
#
#         for second_letter\
#         in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789':
#             script.write("VICH-" + first_letter + second_letter + "\n")
#             script.write("''Response:\n")
#             script.write("''{%Raw_Response%=*}\n")
#             script.write("''Match: initialize(Raw_Response)\n")
#             script.write("\n")
#             script.write("MD\n")
#             script.write("''Response:\n")
#             script.write("''{%Raw_Response%=*}\n")
#             script.write("''Match: loop(Raw_Response)\n")
#             script.write("\n")
#         script.write("JO*\n")
#         script.write("\n")
#
#         # End of get_airlines editing
#         script.close()
#
#         # Retrieve configuration used for .cry
#         TODO
#
#         # Launch get_airlines script
#         client = ttserverlib.Client(socket, script_path_airlines, script_path_airlines + ".log", None, script_path_airlines + ".rex")
#
#         # Store variable in client object to use them in .cry script
#         client.context.list_of_indicators = list_of_indicators
#         client.context.list_of_values = list_of_values
#         client.context.list_of_airlines = list_of_airlines
#
#         client.start()
#         client.wait()
#
#         list_of_airlines = client.context.list_of_airlines
#         del client
#
#     # Remove get_airlines and related scripts
#     if logs.upper() == "NO":
#         generic_lib.remove_logs(script_path_airlines)
#
#     print list_of_airlines
#     return list_of_airlines
