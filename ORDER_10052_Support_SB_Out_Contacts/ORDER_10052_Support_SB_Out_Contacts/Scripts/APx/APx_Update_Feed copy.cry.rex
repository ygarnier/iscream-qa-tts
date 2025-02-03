<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry"><SCRIPT type="Initialize">import json
import re
import generic_lib

from lib.openpnr import extract_binary_payload
from lib.json_match import assert_equal, assert_found, assert_not_found, parse_json
from generic_lib import flatten

execfile(global_regression.TTS_RootDir + &apos;/data/data_&apos; + global_regression.TEST_SYSTEM + &apos;.py&apos;)

TTS_OK = TTServer.currentMessage.TTS_MATCH_COMPARISON_OK
TTS_KO = TTServer.currentMessage.TTS_MATCH_COMPARISON_FAILURE

# As the specific conditions to evaluate depend on the test, the comparison function is in the individual script
# In case of match error, find the error details in TTS logs (not available in .log or in .rex file)
# Variables defined in data files (e.g., test user data) or in the current scripts (e.g., recloc)
# are directly available from inside the function.

def validate_openpnr(openpnr_json):
    try:
        openpnr = parse_json(openpnr_json)
        for field in [&apos;id&apos;, &apos;reference&apos;, &apos;creation&apos;, &apos;travelers&apos;, &apos;products&apos;, &apos;contacts&apos;]:
            assert_found(field, container=openpnr)

        expected_openpnr_id = recloc + &apos;-&apos; + today
        assert_equal(actual=openpnr[&apos;id&apos;], expected=expected_openpnr_id, item_name=&apos;OpenPNR id field&apos;)
        assert_not_found(&apos;creation/date&apos;, container=openpnr)
        assert_found(&apos;creation/dateTime&apos;, container=openpnr)
        assert_found(&apos;creation/pointOfSale/office/id&apos;, container=openpnr)
        assert_equal(expected=&quot;NCE1A0950&quot;, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        assert_equal(actual=len(openpnr[&apos;contacts&apos;]), expected=12, item_name=&apos;number of contacts&apos;)
        contacts_1 = openpnr[&apos;contacts&apos;][0]
        contacts_2 = openpnr[&apos;contacts&apos;][1]
        contacts_3 = openpnr[&apos;contacts&apos;][2]
        contacts_4 = openpnr[&apos;contacts&apos;][3]
        contacts_5 = openpnr[&apos;contacts&apos;][4]
        contacts_6 = openpnr[&apos;contacts&apos;][5]
        contacts_7 = openpnr[&apos;contacts&apos;][6]
        contacts_8 = openpnr[&apos;contacts&apos;][7]
        contacts_9 = openpnr[&apos;contacts&apos;][8]
        contacts_10 = openpnr[&apos;contacts&apos;][9]
        contacts_11 = openpnr[&apos;contacts&apos;][10]
        contacts_12 = openpnr[&apos;contacts&apos;][11]

        #Check service data for APx elements
        assert_equal(actual=contacts_1[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_1[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_1[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_1[&apos;freeFlowFormat&apos;], expected=&apos;TEST&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_2[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_2[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-9&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_2[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_2[&apos;freeFlowFormat&apos;], expected=&apos;0660660660&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_3[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_3[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-10&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;category&apos;], expected=&quot;AGENCY&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;number&apos;], expected=&quot;LON(0208)8778787&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_3[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_4[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_4[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-11&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_4[&apos;phone&apos;][&apos;category&apos;], expected=&quot;BUSINESS&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_4[&apos;phone&apos;][&apos;number&apos;], expected=&quot;FRA69686869&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_4[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_5[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_5[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-12&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_5[&apos;email&apos;][&apos;address&apos;], expected=&quot;BART@SPRINGFIELD.COM&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_5[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_6[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_6[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-13&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;FAX&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;number&apos;], expected=&quot;GB1715869652&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_6[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_7[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_7[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-14&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;category&apos;], expected=&quot;PERSONAL&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;LANDLINE&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;number&apos;], expected=&quot;FRA69686869&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_7[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_8[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_8[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-15&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;category&apos;], expected=&quot;PERSONAL&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;MOBILE&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33666000666&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_8[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_9[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_9[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-16&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_9[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33600000666&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_9[&apos;purpose&apos;], expected=[u&apos;INFORMATION&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_10[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_10[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-17&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_10[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+14617513145&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_10[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_10[&apos;freeFlowFormat&apos;], expected=&apos;1A/NCE1A0955-W,***1A0***-W/M+14617513145&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_11[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_11[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-18&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_11[&apos;email&apos;][&apos;address&apos;], expected=&quot;MBAUER@YKT.COM&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_11[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_11[&apos;freeFlowFormat&apos;], expected=&apos;E+MBAUER@YKT.COM&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_12[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_12[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-19&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_12[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33611258545&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_12[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_12[&apos;freeFlowFormat&apos;], expected=&apos;M+33611258545&apos;, item_name=&apos;contact freeFlowFormat&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK


# Feed comparison
def validate_openpnr_feed(openpnr_json):
    try:
        openpnr = parse_json(openpnr_json)
        for field in [&apos;id&apos;, &apos;reference&apos;, &apos;creation&apos;, &apos;travelers&apos;, &apos;products&apos;, &apos;contacts&apos;]:
            assert_found(field, container=openpnr)

        expected_openpnr_id = recloc + &apos;-&apos; + today
        assert_equal(actual=openpnr[&apos;id&apos;], expected=expected_openpnr_id, item_name=&apos;OpenPNR id field&apos;)
        assert_not_found(&apos;creation/date&apos;, container=openpnr)
        assert_found(&apos;creation/dateTime&apos;, container=openpnr)
        assert_found(&apos;creation/pointOfSale/office/id&apos;, container=openpnr)
        assert_equal(expected=&quot;NCE1A0950&quot;, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        assert_equal(actual=len(openpnr[&apos;contacts&apos;]), expected=11, item_name=&apos;number of contacts&apos;)
        contacts_1 = openpnr[&apos;contacts&apos;][0]
        contacts_2 = openpnr[&apos;contacts&apos;][1]
        contacts_3 = openpnr[&apos;contacts&apos;][2]
        contacts_4 = openpnr[&apos;contacts&apos;][3]
        contacts_5 = openpnr[&apos;contacts&apos;][4]
        contacts_6 = openpnr[&apos;contacts&apos;][5]
        contacts_7 = openpnr[&apos;contacts&apos;][6]
        contacts_8 = openpnr[&apos;contacts&apos;][7]
        contacts_9 = openpnr[&apos;contacts&apos;][8]
        contacts_10 = openpnr[&apos;contacts&apos;][9]
        contacts_11 = openpnr[&apos;contacts&apos;][10]

        #Check service data for APx elements
        assert_equal(actual=contacts_1[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_1[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_1[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_1[&apos;freeFlowFormat&apos;], expected=&apos;TEST&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_2[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_2[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-9&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_2[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_2[&apos;freeFlowFormat&apos;], expected=&apos;0660660660&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_3[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_3[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-10&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;category&apos;], expected=&quot;AGENCY&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;number&apos;], expected=&quot;LON(0208)8778787&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_3[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_4[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_4[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-11&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_4[&apos;phone&apos;][&apos;category&apos;], expected=&quot;BUSINESS&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_4[&apos;phone&apos;][&apos;number&apos;], expected=&quot;FRA69686869&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_4[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_5[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_5[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-12&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_5[&apos;email&apos;][&apos;address&apos;], expected=&quot;BART@SPRINGFIELD.COM&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_5[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_6[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_6[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-13&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;FAX&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;number&apos;], expected=&quot;GB1715869652&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_6[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_7[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_7[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-14&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;category&apos;], expected=&quot;PERSONAL&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;LANDLINE&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;number&apos;], expected=&quot;FRA69686869&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_7[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_8[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_8[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-15&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;category&apos;], expected=&quot;PERSONAL&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;MOBILE&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33666000666&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_8[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_9[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_9[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-16&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_9[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33600000666&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_9[&apos;purpose&apos;], expected=[u&apos;INFORMATION&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_10[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_10[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-18&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_10[&apos;email&apos;][&apos;address&apos;], expected=&quot;MBAUER@YKT.COM&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_10[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_10[&apos;freeFlowFormat&apos;], expected=&apos;E+MBAUER@YKT.COM&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_11[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_11[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-19&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_11[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33611258545&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_11[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_11[&apos;freeFlowFormat&apos;], expected=&apos;M+33611258545&apos;, item_name=&apos;contact freeFlowFormat&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="260" beginLine="259" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:15.100736 - 19 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:30:15.188174 - 19 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="261" beginLine="260" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:15.191040 - 19 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:30:15.344020 - 19 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="262" beginLine="261" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:15.344695 - 19 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:30:15.441576 - 19 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="269" beginLine="268" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:15.442085 - 19 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:30:15.522003 - 19 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="271" beginLine="270" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:17.537346 - 19 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:30:17.611816 - 19 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="275" responseBeginLine="275" endLine="273" beginLine="272" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:17.612053 - 19 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.NCE1A0950-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="10:30:17.793757 - 19 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/19SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
HBO TEST SIGNIN TEXT QA&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="282" beginLine="281" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><COMMENT> 2. Create simple PNR with mandatory elements</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:17.795325 - 19 Sep 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1AHYE/ZABW]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:30:17.928526 - 19 Sep 2024" filename="">RP/NCE1A0950/&amp;
  1.AHYE/ZABW&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="283" beginLine="282" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:17.929509 - 19 Sep 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight_6X_daily.book(1)}]]></EXPRESSION><VALUE><![CDATA[SS6X562Y11NOVNCELHR1]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:30:18.381733 - 19 Sep 2024" filename="">RP/NCE1A0950/&amp;
  1.AHYE/ZABW&amp;
  2  6X 562 Y 11NOV 1 NCELHR DK1  0600 0710  11NOV  E  0 ERJ CM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="284" beginLine="283" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:18.382302 - 19 Sep 2024"><TEXT><![CDATA[APTEST]]></TEXT></QUERY><REPLY receiveAt="10:30:18.525076 - 19 Sep 2024" filename="">RP/NCE1A0950/&amp;
  1.AHYE/ZABW&amp;
  2  6X 562 Y 11NOV 1 NCELHR DK1  0600 0710  11NOV  E  0 ERJ CM&amp;
  3 AP TEST&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="285" beginLine="284" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:18.525397 - 19 Sep 2024"><TEXT><![CDATA[TKOK;RFTEST]]></TEXT></QUERY><REPLY receiveAt="10:30:18.714898 - 19 Sep 2024" filename="">RP/NCE1A0950/&amp;
RF TEST&amp;
  1.AHYE/ZABW&amp;
  2  6X 562 Y 11NOV 1 NCELHR DK1  0600 0710  11NOV  E  0 ERJ CM&amp;
  3 AP TEST&amp;
  4 TK OK19SEP/NCE1A0950&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="291" responseBeginLine="289" endLine="286" beginLine="285" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:18.715332 - 19 Sep 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="10:30:19.266585 - 19 Sep 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/NCE1A0950/NCE1A0950 ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 19SEP24/0830]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[AF35RL]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[NCE1A0950/1127YG/19SEP24&amp;
  1.AHYE/ZABW&amp;
  2  6X 562 Y 11NOV 1 NCELHR HK1  0600 0710  11NOV  E  6X/AF35RL&amp;
  3 AP TEST&amp;
  4 TK OK19SEP/NCE1A0950&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="547" responseBeginLine="537" endLine="535" beginLine="300" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:20.278419 - 19 Sep 2024"><TEXT><![CDATA[PATCH /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[/elements HTTP/1.1&amp;
Content-Type: text/plain&amp;
Debug-Format: json&amp;
If-Match: 1&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header"><VALUE><![CDATA[eyJub25jZSI6Ik5ETTFPVGd5TXpreU1UZ3pNVFUzTnc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTlUMDg6MzA6MTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoidHZUakRMWjlqLzI3cHA2ZExHSStLaGt5anQ0PSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
[&amp;
    \{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;0660660660&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
\t\t\}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;AGENCY&quot;, &amp;
                &quot;number&quot;: &quot;LON(0208)8778787&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
\t\t\}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;BUSINESS&quot;,&amp;
                &quot;number&quot;: &quot;FRA69686869&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
\t\t\}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;BART@SPRINGFIELD.COM&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
\t\t\}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;deviceType&quot;: &quot;FAX&quot;, &amp;
                &quot;number&quot;: &quot;GB1715869652&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
\t\t\}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;PERSONAL&quot;,&amp;
                &quot;deviceType&quot;: &quot;LANDLINE&quot;,&amp;
                &quot;number&quot;: &quot;FRA69686869&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;PERSONAL&quot;,&amp;
                &quot;deviceType&quot;: &quot;MOBILE&quot;,&amp;
                &quot;number&quot;: &quot;+33666000666&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33600000666&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;INFORMATION&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ],&amp;
            &quot;freeFlowFormat&quot;: &quot;1A/***1A0***-W/M+14617513145&quot;,&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
\t\},&amp;
    \{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;MBAUER@YKT.COM&quot;&amp;
            \},&amp;
            &quot;language&quot;: &quot;EN&quot;,&amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ],&amp;
            &quot;freeFlowFormat&quot;: &quot;E+MBAUER@YKT.COM&quot;,&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
\t\},&amp;
    \{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33611258545&quot;&amp;
            \},&amp;
            &quot;language&quot;: &quot;EN&quot;,&amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ],&amp;
            &quot;freeFlowFormat&quot;: &quot;M+33611258545&quot;,&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
\t\}&amp;
]]]></TEXT></QUERY><COMPARISON compareAt="10:30:21.220520 - 19 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001NQ87IK1WYK]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[5718]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;reference&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;, &amp;
    &quot;version&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;, &amp;
    ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&quot;openPnr&quot;: \{&amp;
        &quot;id&quot;: &quot;AF35RL-2024-09-19&quot;, &amp;
        &quot;type&quot;: &quot;pnr&quot;, &amp;
        &quot;reference&quot;: &quot;AF35RL&quot;, &amp;
        &quot;version&quot;: &quot;2&quot;, &amp;
        &quot;creation&quot;: \{&amp;
            &quot;dateTime&quot;: &quot;2024-09-19T08:30:00Z&quot;, &amp;
            &quot;pointOfSale&quot;: \{&amp;
                &quot;office&quot;: \{&amp;
                    &quot;id&quot;: &quot;NCE1A0950&quot;, &amp;
                    &quot;iataNumber&quot;: &quot;12345675&quot;, &amp;
                    &quot;systemCode&quot;: &quot;1A&quot;, &amp;
                    &quot;agentType&quot;: &quot;AIRLINE&quot;&amp;
                \}, &amp;
                &quot;login&quot;: \{&amp;
                    &quot;numericSign&quot;: &quot;1127&quot;, &amp;
                    &quot;initials&quot;: &quot;YG&quot;, &amp;
                    &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                    &quot;countryCode&quot;: &quot;FR&quot;, &amp;
                    &quot;cityCode&quot;: &quot;NCE&quot;&amp;
                \}&amp;
            \}&amp;
        \}, &amp;
        &quot;lastModification&quot;: \{&amp;
            &quot;dateTime&quot;: &quot;2024-09-19T08:30:20Z&quot;&amp;
        \}, &amp;
        &quot;travelers&quot;: [&amp;
            \{&amp;
                &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                &quot;names&quot;: [&amp;
                    \{&amp;
                        &quot;firstName&quot;: &quot;ZABW&quot;, &amp;
                        &quot;lastName&quot;: &quot;AHYE&quot;&amp;
                    \}&amp;
                ], &amp;
                &quot;contacts&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-9&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-10&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-11&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-12&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-13&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-14&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-15&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-16&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-17&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-18&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-19&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-2&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}&amp;
                ], &amp;
                &quot;passenger&quot;: \{&amp;
                    &quot;uniqueIdentifier&quot;: &quot;610163E50002021C&quot;&amp;
                \}&amp;
            \}&amp;
        ], &amp;
        &quot;products&quot;: [&amp;
            \{&amp;
                &quot;type&quot;: &quot;product&quot;, &amp;
                &quot;subType&quot;: &quot;AIR&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AIR-1&quot;, &amp;
                &quot;airSegment&quot;: \{&amp;
                    &quot;departure&quot;: \{&amp;
                        &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                        &quot;localDateTime&quot;: &quot;2024-11-11T06:00:00&quot;&amp;
                    \}, &amp;
                    &quot;arrival&quot;: \{&amp;
                        &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                        &quot;localDateTime&quot;: &quot;2024-11-11T07:10:00&quot;&amp;
                    \}, &amp;
                    &quot;marketing&quot;: \{&amp;
                        &quot;flightDesignator&quot;: \{&amp;
                            &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                            &quot;flightNumber&quot;: &quot;562&quot;&amp;
                        \}, &amp;
                        &quot;bookingClass&quot;: \{&amp;
                            &quot;code&quot;: &quot;Y&quot;, &amp;
                            &quot;cabin&quot;: \{&amp;
                                &quot;code&quot;: &quot;Y&quot;&amp;
                            \}, &amp;
                            &quot;subClass&quot;: \{&amp;
                                &quot;code&quot;: 0, &amp;
                                &quot;pointOfSale&quot;: \{&amp;
                                    &quot;office&quot;: \{&amp;
                                        &quot;systemCode&quot;: &quot;1A&quot;&amp;
                                    \}, &amp;
                                    &quot;login&quot;: \{&amp;
                                        &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                    \}&amp;
                                \}, &amp;
                                &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                            \}, &amp;
                            &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                        \}, &amp;
                        &quot;id&quot;: &quot;6X-562-2024-11-11-NCE-LHR&quot;&amp;
                    \}, &amp;
                    &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                    &quot;deliveries&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-BKG-1&quot;, &amp;
                            &quot;distributionId&quot;: &quot;6001A3E500051D1F&quot;, &amp;
                            &quot;traveler&quot;: \{&amp;
                                &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                                &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                            \}&amp;
                        \}&amp;
                    ], &amp;
                    &quot;distributionMethod&quot;: &quot;E&quot;, &amp;
                    &quot;notAcknowledged&quot;: false&amp;
                \}&amp;
            \}&amp;
        ], &amp;
        &quot;contacts&quot;: [&amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-2&quot;, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;freeFlowFormat&quot;: &quot;TEST&quot;, &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-9&quot;, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;freeFlowFormat&quot;: &quot;0660660660&quot;, &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-10&quot;, &amp;
                &quot;phone&quot;: \{&amp;
                    &quot;category&quot;: &quot;AGENCY&quot;, &amp;
                    &quot;number&quot;: &quot;LON(0208)8778787&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-11&quot;, &amp;
                &quot;phone&quot;: \{&amp;
                    &quot;category&quot;: &quot;BUSINESS&quot;, &amp;
                    &quot;number&quot;: &quot;FRA69686869&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-12&quot;, &amp;
                &quot;email&quot;: \{&amp;
                    &quot;address&quot;: &quot;BART@SPRINGFIELD.COM&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-13&quot;, &amp;
                &quot;phone&quot;: \{&amp;
                    &quot;deviceType&quot;: &quot;FAX&quot;, &amp;
                    &quot;number&quot;: &quot;GB1715869652&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-14&quot;, &amp;
                &quot;phone&quot;: \{&amp;
                    &quot;category&quot;: &quot;PERSONAL&quot;, &amp;
                    &quot;deviceType&quot;: &quot;LANDLINE&quot;, &amp;
                    &quot;number&quot;: &quot;FRA69686869&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-15&quot;, &amp;
                &quot;phone&quot;: \{&amp;
                    &quot;category&quot;: &quot;PERSONAL&quot;, &amp;
                    &quot;deviceType&quot;: &quot;MOBILE&quot;, &amp;
                    &quot;number&quot;: &quot;+33666000666&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-16&quot;, &amp;
                &quot;phone&quot;: \{&amp;
                    &quot;number&quot;: &quot;+33600000666&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;INFORMATION&quot;&amp;
                ], &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-17&quot;, &amp;
                &quot;phone&quot;: \{&amp;
                    &quot;number&quot;: &quot;+14617513145&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;NOTIFICATION&quot;&amp;
                ], &amp;
                &quot;freeFlowFormat&quot;: &quot;1A/NCE1A0955-W,***1A0***-W/M+14617513145&quot;, &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-18&quot;, &amp;
                &quot;email&quot;: \{&amp;
                    &quot;address&quot;: &quot;MBAUER@YKT.COM&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;NOTIFICATION&quot;&amp;
                ], &amp;
                &quot;freeFlowFormat&quot;: &quot;E+MBAUER@YKT.COM&quot;, &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-19&quot;, &amp;
                &quot;phone&quot;: \{&amp;
                    &quot;number&quot;: &quot;+33611258545&quot;&amp;
                \}, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;NOTIFICATION&quot;&amp;
                ], &amp;
                &quot;freeFlowFormat&quot;: &quot;M+33611258545&quot;, &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}&amp;
        ], &amp;
        &quot;automatedProcesses&quot;: [&amp;
            \{&amp;
                &quot;type&quot;: &quot;automated-process&quot;, &amp;
                &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-TK-3&quot;, &amp;
                &quot;code&quot;: &quot;OK&quot;, &amp;
                &quot;dateTime&quot;: &quot;2024-09-19T00:00:00&quot;, &amp;
                &quot;office&quot;: \{&amp;
                    &quot;id&quot;: &quot;NCE1A0950&quot;&amp;
                \}, &amp;
                &quot;travelers&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ], &amp;
                &quot;products&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;product&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AIR-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                    \}&amp;
                ]&amp;
            \}&amp;
        ]&amp;
    \}&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="576" responseBeginLine="565" endLine="564" beginLine="558" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:21.222658 - 19 Sep 2024"><TEXT><![CDATA[GET /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[ HTTP/1.1&amp;
Content-Type: text/plain&amp;
Debug-format: json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header2"><VALUE><![CDATA[eyJub25jZSI6Ik9ESTNPRGcxTkRFNE5ESXpNVGd5TXc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTlUMDg6MzA6MTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoidUttU29pSDI3YnhnK042WkJXZk5LLy8xL0ZnPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
]]></TEXT></QUERY><COMPARISON compareAt="10:30:21.654672 - 19 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001NQ89PK1WYL]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4249]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;reference&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;, &amp;
    &quot;version&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;, &amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_protobuf%=.*}]]></EXPRESSION><VALUE><![CDATA[ChFBRjM1UkwtMjAyNC0wOS0xORIDcG5yGgZBRjM1UkwiATI6VRoUMjAyNC0wOS0xOVQwODozMDowMFoiPQoiCglOQ0UxQTA5NTASCDEyMzQ1Njc1GgIxQSIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOS0xOVQwODozMDoyMFp6vgYKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMSIMEgRaQUJXGgRBSFlFcjwKB2NvbnRhY3QSGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC05GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEwGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTExGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEyGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEzGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE0GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE1GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE2GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE3GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE4GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE5GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPAoHY29udGFjdBIaQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTIaFXByb2Nlc3NlZFBuci5jb250YWN0c6IBEhIQNjEwMTYzRTUwMDAyMDIxQ4IBxAIKB3Byb2R1Y3QQARobQUYzNVJMLTIwMjQtMDktMTktUE5SLUFJUi0xIpkCChoKA05DRRoTMjAyNC0xMS0xMVQwNjowMDowMBIaCgNMSFIaEzIwMjQtMTEtMTFUMDc6MTA6MDAiTQoJCgI2WBIDNTYyEiUKAVkSAwoBWRoSCgASDAoEGgIxQRIEKgJGUiABIgdFQ09OT01ZMhk2WC01NjItMjAyNC0xMS0xMS1OQ0UtTEhSSgJIS2KEAQoQc2VnbWVudC1kZWxpdmVyeRIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUJLRy0xGhA2MDAxQTNFNTAwMDUxRDFGWkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc4oBAUWSAQCyAXMKB2NvbnRhY3QSGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0yQgEBWgYKBFRFU1RiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF5Cgdjb250YWN0EhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtOUIBAVoMCgowNjYwNjYwNjYwYkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBggEKB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMCIUCAMaEExPTigwMjA4KTg3Nzg3ODdCAQFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF9Cgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTEiDwgCGgtGUkE2OTY4Njg2OUIBAWJBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAYQBCgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTIyFgoUQkFSVEBTUFJJTkdGSUVMRC5DT01CAQFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF+Cgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTMiEBADGgxHQjE3MTU4Njk2NTJCAQFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF/Cgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTQiEQgBEAIaC0ZSQTY5Njg2ODY5QgEBYkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBgAEKB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xNSISCAEQARoMKzMzNjY2MDAwNjY2QgEBYkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBfAoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE2Ig4aDCszMzYwMDAwMDY2NkIBA2JBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAagBCgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTciDhoMKzE0NjE3NTEzMTQ1QgECWioKKDFBL05DRTFBMDk1NS1XLCoqKjFBMCoqKi1XL00rMTQ2MTc1MTMxNDViQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgGSAQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE4MhAKDk1CQVVFUkBZS1QuQ09NQgECWhIKEEUrTUJBVUVSQFlLVC5DT01iQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgGNAQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE5Ig4aDCszMzYxMTI1ODU0NUIBAloPCg1NKzMzNjExMjU4NTQ1YkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItVEstMxgFIhMyMDI0LTA5LTE5VDAwOjAwOjAwKgsKCU5DRTFBMDk1MFpBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="14" responseEndLine="601" responseBeginLine="594" endLine="592" beginLine="586" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:21.658136 - 19 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header3"><VALUE><![CDATA[eyJub25jZSI6Ik5qUXdORE01TkRnek1qWTFNVGMyTlE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTlUMDg6MzA6MTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiRWZqZEpaWTl1ZnpuSWNpUzRvZGZMRU51dmp3PSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[ChFBRjM1UkwtMjAyNC0wOS0xORIDcG5yGgZBRjM1UkwiATI6VRoUMjAyNC0wOS0xOVQwODozMDowMFoiPQoiCglOQ0UxQTA5NTASCDEyMzQ1Njc1GgIxQSIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOS0xOVQwODozMDoyMFp6vgYKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMSIMEgRaQUJXGgRBSFlFcjwKB2NvbnRhY3QSGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC05GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEwGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTExGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEyGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEzGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE0GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE1GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE2GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE3GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE4GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE5GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPAoHY29udGFjdBIaQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTIaFXByb2Nlc3NlZFBuci5jb250YWN0c6IBEhIQNjEwMTYzRTUwMDAyMDIxQ4IBxAIKB3Byb2R1Y3QQARobQUYzNVJMLTIwMjQtMDktMTktUE5SLUFJUi0xIpkCChoKA05DRRoTMjAyNC0xMS0xMVQwNjowMDowMBIaCgNMSFIaEzIwMjQtMTEtMTFUMDc6MTA6MDAiTQoJCgI2WBIDNTYyEiUKAVkSAwoBWRoSCgASDAoEGgIxQRIEKgJGUiABIgdFQ09OT01ZMhk2WC01NjItMjAyNC0xMS0xMS1OQ0UtTEhSSgJIS2KEAQoQc2VnbWVudC1kZWxpdmVyeRIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUJLRy0xGhA2MDAxQTNFNTAwMDUxRDFGWkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc4oBAUWSAQCyAXMKB2NvbnRhY3QSGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0yQgEBWgYKBFRFU1RiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF5Cgdjb250YWN0EhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtOUIBAVoMCgowNjYwNjYwNjYwYkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBggEKB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMCIUCAMaEExPTigwMjA4KTg3Nzg3ODdCAQFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF9Cgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTEiDwgCGgtGUkE2OTY4Njg2OUIBAWJBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAYQBCgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTIyFgoUQkFSVEBTUFJJTkdGSUVMRC5DT01CAQFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF+Cgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTMiEBADGgxHQjE3MTU4Njk2NTJCAQFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF/Cgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTQiEQgBEAIaC0ZSQTY5Njg2ODY5QgEBYkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBgAEKB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xNSISCAEQARoMKzMzNjY2MDAwNjY2QgEBYkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBfAoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE2Ig4aDCszMzYwMDAwMDY2NkIBA2JBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAagBCgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTciDhoMKzE0NjE3NTEzMTQ1QgECWioKKDFBL05DRTFBMDk1NS1XLCoqKjFBMCoqKi1XL00rMTQ2MTc1MTMxNDViQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgGSAQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE4MhAKDk1CQVVFUkBZS1QuQ09NQgECWhIKEEUrTUJBVUVSQFlLVC5DT01iQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgGNAQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE5Ig4aDCszMzYxMTI1ODU0NUIBAloPCg1NKzMzNjExMjU4NTQ1YkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItVEstMxgFIhMyMDI0LTA5LTE5VDAwOjAwOjAwKgsKCU5DRTFBMDk1MFpBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="10:30:21.859021 - 19 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001NQ8A1K1WYL]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[5671]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;AF35RL-2024-09-19&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;AF35RL&quot;, &amp;
    &quot;version&quot;: &quot;2&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-19T08:30:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0950&quot;, &amp;
                &quot;iataNumber&quot;: &quot;12345675&quot;, &amp;
                &quot;systemCode&quot;: &quot;1A&quot;, &amp;
                &quot;agentType&quot;: &quot;AIRLINE&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;1127&quot;, &amp;
                &quot;initials&quot;: &quot;YG&quot;, &amp;
                &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                &quot;countryCode&quot;: &quot;FR&quot;, &amp;
                &quot;cityCode&quot;: &quot;NCE&quot;&amp;
            \}&amp;
        \}&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-19T08:30:20Z&quot;&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;ZABW&quot;, &amp;
                    &quot;lastName&quot;: &quot;AHYE&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-9&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-10&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-11&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-12&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-13&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-14&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-15&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-16&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-17&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-18&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-19&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610163E50002021C&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-11-11T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-11-11T07:10:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;562&quot;&amp;
                    \}, &amp;
                    &quot;bookingClass&quot;: \{&amp;
                        &quot;code&quot;: &quot;Y&quot;, &amp;
                        &quot;cabin&quot;: \{&amp;
                            &quot;code&quot;: &quot;Y&quot;&amp;
                        \}, &amp;
                        &quot;subClass&quot;: \{&amp;
                            &quot;code&quot;: 0, &amp;
                            &quot;pointOfSale&quot;: \{&amp;
                                &quot;office&quot;: \{&amp;
                                    &quot;systemCode&quot;: &quot;1A&quot;&amp;
                                \}, &amp;
                                &quot;login&quot;: \{&amp;
                                    &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                        \}, &amp;
                        &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-562-2024-11-11-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6001A3E500051D1F&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                            &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                        \}&amp;
                    \}&amp;
                ], &amp;
                &quot;distributionMethod&quot;: &quot;E&quot;, &amp;
                &quot;notAcknowledged&quot;: false&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;TEST&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-9&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;0660660660&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-10&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;AGENCY&quot;, &amp;
                &quot;number&quot;: &quot;LON(0208)8778787&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-11&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;BUSINESS&quot;, &amp;
                &quot;number&quot;: &quot;FRA69686869&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-12&quot;, &amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;BART@SPRINGFIELD.COM&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-13&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;deviceType&quot;: &quot;FAX&quot;, &amp;
                &quot;number&quot;: &quot;GB1715869652&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-14&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;PERSONAL&quot;, &amp;
                &quot;deviceType&quot;: &quot;LANDLINE&quot;, &amp;
                &quot;number&quot;: &quot;FRA69686869&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-15&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;PERSONAL&quot;, &amp;
                &quot;deviceType&quot;: &quot;MOBILE&quot;, &amp;
                &quot;number&quot;: &quot;+33666000666&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-16&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33600000666&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;INFORMATION&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-17&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+14617513145&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;1A/NCE1A0955-W,***1A0***-W/M+14617513145&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-18&quot;, &amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;MBAUER@YKT.COM&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;E+MBAUER@YKT.COM&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-19&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33611258545&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;M+33611258545&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-09-19T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0950&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="626" responseBeginLine="612" endLine="610" beginLine="609" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:21.861349 - 19 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="10:30:22.323740 - 19 Sep 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/NCE1A0950/NCE1A0950 ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 19SEP24/0830]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?AP}]]></EXPRESSION><VALUE><![CDATA[NCE1A0950/1127YG/19SEP24&amp;
  1.AHYE/ZABW&amp;
  2  6X 562 Y 11NOV 1 NCELHR HK1  0600 0710  11NOV  E  6X/AF35RL&amp;
  3 AP]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ TEST&amp;
  4 AP 0660660660&amp;
  5 APA LON(0208)8778787&amp;
  6 APB FRA69686869&amp;
  7 APE BART@SPRINGFIELD.COM&amp;
  8 APF GB1715869652&amp;
  9 APH FRA69686869&amp;
 10 API +33600000666&amp;
 11 APM +33666000666&amp;
 12 APN 1A/NCE1A0955-W,***1A0***-W/M+14617513145&amp;
 13 APN E+MBAUER@YKT.COM&amp;
 14 APN M+33611258545&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 15 TK OK19SEP/NCE1A0950&amp;
 16 OPC-10NOV:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" responseEndLine="646" responseBeginLine="644" endLine="642" beginLine="638" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:22.391692 - 19 Sep 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:30:22.649887 - 19 Sep 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:AF35RL::190924:0830&apos;&amp;
RSI+RP:YGSU:NCE1A0950:12345675+NCE1A0950+NCE+NCE1A0950:1127YG:190924:12345675:0830&apos;&amp;
LFT+3:P12+--- RLR ---&apos;&amp;
STX+RLR&apos;&amp;
UID+12345675:NCE1A0950+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+12345675:NCE1A0950+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:11:15&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+AHYE::1+ZABW&apos;&amp;
ETI+:1+UN:Y:Y::AHYE:ZABW&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+111124:0600:111124:0710+NCE+LHR+6X+562:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:AF35RL&apos;&amp;
RPI+1+HK&apos;&amp;
APD+ERJ:0:0210::1+++648:M++M:CM&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+111124:0600:111124:0710+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+TEST&apos;&amp;
EMS++OT:9+AP+4&apos;&amp;
LFT+3:5+0660660660&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:10+AP+5&apos;&amp;
LFT+3:6+LON(0208)8778787&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:11+AP+6&apos;&amp;
LFT+3:3+FRA69686869&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:12+AP+7&apos;&amp;
LFT+3:P02+BART@SPRINGFIELD.COM&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:13+AP+8&apos;&amp;
LFT+3:P01+GB1715869652&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:14+AP+9&apos;&amp;
LFT+3:4+FRA69686869&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:16+AP+10&apos;&amp;
LFT+3:P03+\+33600000666&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:15+AP+11&apos;&amp;
LFT+3:7+\+33666000666&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:17+AP+12&apos;&amp;
LFT+3:5:N+1A/NCE1A0955-W,\*\*\*1A0\*\*\*-W/M\+14617513145&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:18+AP+13&apos;&amp;
LFT+3:5:N+E\+MBAUER@YKT.COM&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:19+AP+14&apos;&amp;
LFT+3:5:N+M\+33611258545&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:3+TK+15&apos;&amp;
TKE++OK:190924::NCE1A0950&apos;&amp;
EMS++OT:7+OPC+16&apos;&amp;
OPE+NCE1A0950:101124:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="17" endLine="656" beginLine="655" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 0
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:22.650457 - 19 Sep 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="10:30:22.716193 - 19 Sep 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240919:0830+01HYOF28X90002+00FN4IXFZ20002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+********&apos;&amp;
UCI+00FN4IXFZ20002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+17&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+01HYOF28X90002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17"><QUERY filename="" loop="0" sentAt="10:30:22.716924 - 19 Sep 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="18" responseEndLine="688" responseBeginLine="675" endLine="672" beginLine="666" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:22.891200 - 19 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[19SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:30:23.655872 - 19 Sep 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[19SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240919\:08\:30\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:09:19:08:30:21]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[8236061672]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:09:19:08:30:21]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="708" responseBeginLine="702" endLine="701" beginLine="697" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:23.730789 - 19 Sep 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[8236061672]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:09:19:08:30:21]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:30:23.812039 - 19 Sep 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[8236061672]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:09:19:08:30:21]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[3770]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\x9A\x1D\x12\xBD\x1C\x0A\x11AF35RL-2024-09-19\x12\x03pnr\x1A\x06AF35RL&quot;\x012:U\x1A\x142024-09-19T08:30:00Z&quot;=\x0A&quot;\x0A\x09NCE1A0950\x12\x0812345675\x1A\x021A&quot;\x07AIRLINE\x12\x17\x0A\x041127\x12\x02YG\x1A\x02SU*\x02FR2\x03NCEJ\xF8\x05\x1A\x142024-09-19T08:30:20Z&quot;\x0D\x0A\x0B\x0A\x09NCE1A0955*\x11NDCX ORDER CREATE2\x03\x12\x011:C\x12\x10historyChangeLog\x18\x01&quot;\x1AAF35RL-2024-09-19-PNR-AP-9*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-10*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-11*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-12*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-13*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-14*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-15*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-16*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-18*\x07contact2\x08contacts:D\x12\x10historyChangeLog\x18\x01&quot;\x1BAF35RL-2024-09-19-PNR-AP-19*\x07contact2\x08contactsz\xFF\x05\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1&quot;\x0C\x12\x04ZABW\x1A\x04AHYEr&lt;\x0A\x07contact\x12\x1AAF35RL-2024-09-19-PNR-AP-9\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-10\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-11\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-12\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-13\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-14\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-15\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-16\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-18\x1A\x15processedPnr.contactsr=\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-19\x1A\x15processedPnr.contactsr&lt;\x0A\x07contact\x12\x1AAF35RL-2024-09-19-PNR-AP-2\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x10610163E50002021C\x82\x01\xC8\x02\x0A\x07product\x10\x01\x1A\x1BAF35RL-2024-09-19-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-11-11T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132024-11-11T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03562\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x021A\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-562-2024-11-11-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1BAF35RL-2024-09-19-PNR-BKG-1\x1A\x106001A3E500051D1FZA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01r\x0A\x07contact\x12\x1AAF35RL-2024-09-19-PNR-AP-2@\x01Z\x06\x0A\x04TESTbA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01x\x0A\x07contact\x12\x1AAF35RL-2024-09-19-PNR-AP-9@\x01Z\x0C\x0A\x0A0660660660bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\x81\x01\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-10&quot;\x14\x08\x03\x1A\x10LON(0208)8778787@\x01bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01|\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-11&quot;\x0F\x08\x02\x1A\x0BFRA69686869@\x01bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\x83\x01\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-122\x16\x0A\x14BART@SPRINGFIELD.COM@\x01bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\}\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-13&quot;\x10\x10\x03\x1A\x0CGB1715869652@\x01bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01~\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-14&quot;\x11\x08\x01\x10\x02\x1A\x0BFRA69686869@\x01bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\x7F\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-15&quot;\x12\x08\x01\x10\x01\x1A\x0C+33666000666@\x01bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\{\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-16&quot;\x0E\x1A\x0C+33600000666@\x03bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\x91\x01\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-182\x10\x0A\x0EMBAUER@YKT.COM@\x02Z\x12\x0A\x10E+MBAUER@YKT.COMbA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\x8C\x01\x0A\x07contact\x12\x1BAF35RL-2024-09-19-PNR-AP-19&quot;\x0E\x1A\x0C+33611258545@\x02Z\x0F\x0A\x0DM+33611258545bA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1AAF35RL-2024-09-19-PNR-TK-3\x18\x05&quot;\x132024-09-19T00:00:00*\x0B\x0A\x09NCE1A0950ZA\x0A\x0Bstakeholder\x12\x1AAF35RL-2024-09-19-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1BAF35RL-2024-09-19-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x06AF35RL\x1A\x012&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="736" responseBeginLine="729" endLine="727" beginLine="722" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:23.814079 - 19 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header4"><VALUE><![CDATA[eyJub25jZSI6Ik5EYzFNVEV4TnpRNE5EazVOelkwTkE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTlUMDg6MzA6MTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoidkpJcktveVVwYkhPQWNhd0FkMHlEZFVnYlk4PSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChFBRjM1UkwtMjAyNC0wOS0xORIDcG5yGgZBRjM1UkwiATI6VRoUMjAyNC0wOS0xOVQwODozMDowMFoiPQoiCglOQ0UxQTA5NTASCDEyMzQ1Njc1GgIxQSIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VK+AUaFDIwMjQtMDktMTlUMDg6MzA6MjBaIg0KCwoJTkNFMUEwOTU1KhFORENYIE9SREVSIENSRUFURTIDEgExOkMSEGhpc3RvcnlDaGFuZ2VMb2cYASIaQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTkqB2NvbnRhY3QyCGNvbnRhY3RzOkQSEGhpc3RvcnlDaGFuZ2VMb2cYASIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEwKgdjb250YWN0Mghjb250YWN0czpEEhBoaXN0b3J5Q2hhbmdlTG9nGAEiG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMSoHY29udGFjdDIIY29udGFjdHM6RBIQaGlzdG9yeUNoYW5nZUxvZxgBIhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTIqB2NvbnRhY3QyCGNvbnRhY3RzOkQSEGhpc3RvcnlDaGFuZ2VMb2cYASIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEzKgdjb250YWN0Mghjb250YWN0czpEEhBoaXN0b3J5Q2hhbmdlTG9nGAEiG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xNCoHY29udGFjdDIIY29udGFjdHM6RBIQaGlzdG9yeUNoYW5nZUxvZxgBIhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTUqB2NvbnRhY3QyCGNvbnRhY3RzOkQSEGhpc3RvcnlDaGFuZ2VMb2cYASIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE2Kgdjb250YWN0Mghjb250YWN0czpEEhBoaXN0b3J5Q2hhbmdlTG9nGAEiG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xOCoHY29udGFjdDIIY29udGFjdHM6RBIQaGlzdG9yeUNoYW5nZUxvZxgBIhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTkqB2NvbnRhY3QyCGNvbnRhY3Rzev8FCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEiDBIEWkFCVxoEQUhZRXI8Cgdjb250YWN0EhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtORoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMRoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMhoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMxoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xNBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xNRoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xNhoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xOBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xORoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzcjwKB2NvbnRhY3QSGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0yGhVwcm9jZXNzZWRQbnIuY29udGFjdHOiARISEDYxMDE2M0U1MDAwMjAyMUOCAcgCCgdwcm9kdWN0EAEaG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BSVItMSKdAgoaCgNOQ0UaEzIwMjQtMTEtMTFUMDY6MDA6MDASGgoDTEhSGhMyMDI0LTExLTExVDA3OjEwOjAwIk8KCQoCNlgSAzU2MhInCgFZEgMKAVkaFAoCCAASDAoEGgIxQRIEKgJGUiABIgdFQ09OT01ZMhk2WC01NjItMjAyNC0xMS0xMS1OQ0UtTEhSSgJIS2KEAQoQc2VnbWVudC1kZWxpdmVyeRIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUJLRy0xGhA2MDAxQTNFNTAwMDUxRDFGWkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc4oBAUWSAQIIALIBcgoHY29udGFjdBIaQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTJAAVoGCgRURVNUYkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBeAoHY29udGFjdBIaQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTlAAVoMCgowNjYwNjYwNjYwYkEKC3N0YWtlaG9sZGVyEhpBRjM1UkwtMjAyNC0wOS0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBgQEKB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMCIUCAMaEExPTigwMjA4KTg3Nzg3ODdAAWJBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAXwKB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xMSIPCAIaC0ZSQTY5Njg2ODY5QAFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgGDAQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTEyMhYKFEJBUlRAU1BSSU5HRklFTEQuQ09NQAFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF9Cgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTMiEBADGgxHQjE3MTU4Njk2NTJAAWJBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAX4KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xNCIRCAEQAhoLRlJBNjk2ODY4NjlAAWJBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAX8KB2NvbnRhY3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BUC0xNSISCAEQARoMKzMzNjY2MDAwNjY2QAFiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF7Cgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTYiDhoMKzMzNjAwMDAwNjY2QANiQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgGRAQoHY29udGFjdBIbQUYzNVJMLTIwMjQtMDktMTktUE5SLUFQLTE4MhAKDk1CQVVFUkBZS1QuQ09NQAJaEgoQRStNQkFVRVJAWUtULkNPTWJBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAYwBCgdjb250YWN0EhtBRjM1UkwtMjAyNC0wOS0xOS1QTlItQVAtMTkiDhoMKzMzNjExMjU4NTQ1QAJaDwoNTSszMzYxMTI1ODU0NWJBCgtzdGFrZWhvbGRlchIaQUYzNVJMLTIwMjQtMDktMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnO6AdUBChFhdXRvbWF0ZWQtcHJvY2VzcxIaQUYzNVJMLTIwMjQtMDktMTktUE5SLVRLLTMYBSITMjAyNC0wOS0xOVQwMDowMDowMCoLCglOQ0UxQTA5NTBaQQoLc3Rha2Vob2xkZXISGkFGMzVSTC0yMDI0LTA5LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzYj0KB3Byb2R1Y3QSG0FGMzVSTC0yMDI0LTA5LTE5LVBOUi1BSVItMRoVcHJvY2Vzc2VkUG5yLnByb2R1Y3Rz]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="10:30:24.026766 - 19 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001NQ8CSK1WYN]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[6769]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json_feed%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;AF35RL-2024-09-19&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;AF35RL&quot;, &amp;
    &quot;version&quot;: &quot;2&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-19T08:30:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0950&quot;, &amp;
                &quot;iataNumber&quot;: &quot;12345675&quot;, &amp;
                &quot;systemCode&quot;: &quot;1A&quot;, &amp;
                &quot;agentType&quot;: &quot;AIRLINE&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;1127&quot;, &amp;
                &quot;initials&quot;: &quot;YG&quot;, &amp;
                &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                &quot;countryCode&quot;: &quot;FR&quot;, &amp;
                &quot;cityCode&quot;: &quot;NCE&quot;&amp;
            \}&amp;
        \}&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-19T08:30:20Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0955&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;NDCX ORDER CREATE&quot;, &amp;
        &quot;correlationReference&quot;: \{&amp;
            &quot;correlationId&quot;: &quot;1&quot;&amp;
        \}, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-9&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-10&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-11&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-12&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-13&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-14&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-15&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-16&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-18&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;AF35RL-2024-09-19-PNR-AP-19&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;ZABW&quot;, &amp;
                    &quot;lastName&quot;: &quot;AHYE&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-9&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-10&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-11&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-12&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-13&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-14&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-15&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-16&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-18&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-19&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610163E50002021C&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-11-11T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-11-11T07:10:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;562&quot;&amp;
                    \}, &amp;
                    &quot;bookingClass&quot;: \{&amp;
                        &quot;code&quot;: &quot;Y&quot;, &amp;
                        &quot;cabin&quot;: \{&amp;
                            &quot;code&quot;: &quot;Y&quot;&amp;
                        \}, &amp;
                        &quot;subClass&quot;: \{&amp;
                            &quot;code&quot;: 0, &amp;
                            &quot;pointOfSale&quot;: \{&amp;
                                &quot;office&quot;: \{&amp;
                                    &quot;systemCode&quot;: &quot;1A&quot;&amp;
                                \}, &amp;
                                &quot;login&quot;: \{&amp;
                                    &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                        \}, &amp;
                        &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-562-2024-11-11-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6001A3E500051D1F&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                            &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                        \}&amp;
                    \}&amp;
                ], &amp;
                &quot;distributionMethod&quot;: &quot;E&quot;, &amp;
                &quot;notAcknowledged&quot;: false&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;TEST&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-9&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;0660660660&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-10&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;AGENCY&quot;, &amp;
                &quot;number&quot;: &quot;LON(0208)8778787&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-11&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;BUSINESS&quot;, &amp;
                &quot;number&quot;: &quot;FRA69686869&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-12&quot;, &amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;BART@SPRINGFIELD.COM&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-13&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;deviceType&quot;: &quot;FAX&quot;, &amp;
                &quot;number&quot;: &quot;GB1715869652&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-14&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;PERSONAL&quot;, &amp;
                &quot;deviceType&quot;: &quot;LANDLINE&quot;, &amp;
                &quot;number&quot;: &quot;FRA69686869&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-15&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;PERSONAL&quot;, &amp;
                &quot;deviceType&quot;: &quot;MOBILE&quot;, &amp;
                &quot;number&quot;: &quot;+33666000666&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-16&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33600000666&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;INFORMATION&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-18&quot;, &amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;MBAUER@YKT.COM&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;E+MBAUER@YKT.COM&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AP-19&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33611258545&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;M+33611258545&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-09-19T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0950&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;AF35RL-2024-09-19-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" endLine="747" beginLine="746" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:24.028023 - 19 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[AF35RL]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:30:24.484735 - 19 Sep 2024" filename="">--- RLR ---&amp;
RP/NCE1A0950/NCE1A0950            YG/SU  19SEP24/0830Z   AF35RL&amp;
NCE1A0950/1127YG/19SEP24&amp;
  1.AHYE/ZABW&amp;
  2  6X 562 Y 11NOV 1 NCELHR HK1  0600 0710  11NOV  E  6X/AF35RL&amp;
  3 AP TEST&amp;
  4 AP 0660660660&amp;
  5 APA LON(0208)8778787&amp;
  6 APB FRA69686869&amp;
  7 APE BART@SPRINGFIELD.COM&amp;
  8 APF GB1715869652&amp;
  9 APH FRA69686869&amp;
 10 API +33600000666&amp;
 11 APM +33666000666&amp;
 12 APN 1A/NCE1A0955-W,***1A0***-W/M+14617513145&amp;
 13 APN E+MBAUER@YKT.COM&amp;
 14 APN M+33611258545&amp;
 15 TK OK19SEP/NCE1A0950&amp;
 16 OPC-10NOV:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="22" endLine="748" beginLine="747" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:24.485311 - 19 Sep 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="10:30:24.790977 - 19 Sep 2024" filename="">--- RLR ---&amp;
RP/NCE1A0950/NCE1A0950            YG/SU  19SEP24/0830Z   AF35RL&amp;
NCE1A0950/1127YG/19SEP24&amp;
  1.AHYE/ZABW&amp;
  2 AP TEST&amp;
  3 AP 0660660660&amp;
  4 APA LON(0208)8778787&amp;
  5 APB FRA69686869&amp;
  6 APE BART@SPRINGFIELD.COM&amp;
  7 APF GB1715869652&amp;
  8 APH FRA69686869&amp;
  9 API +33600000666&amp;
 10 APM +33666000666&amp;
 11 APN 1A/NCE1A0955-W,***1A0***-W/M+14617513145&amp;
 12 APN E+MBAUER@YKT.COM&amp;
 13 APN M+33611258545&amp;
 14 TK OK19SEP/NCE1A0950&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="749" beginLine="748" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:24.791452 - 19 Sep 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="10:30:25.196088 - 19 Sep 2024" filename="">END OF TRANSACTION COMPLETE - AF35RL&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="750" beginLine="749" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:25.196861 - 19 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:30:25.296294 - 19 Sep 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="755" beginLine="754" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:25.297114 - 19 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:30:25.450460 - 19 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="756" beginLine="755" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Update_Feed copy.cry" loop="0" sentAt="10:30:25.450906 - 19 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:30:25.538903 - 19 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">56251</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">17261</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.962963</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">10448.1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">3.658</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">7056.07</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">67</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">2</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>