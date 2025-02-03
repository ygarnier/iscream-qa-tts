<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry"><SCRIPT type="Initialize">import json
from lib.openpnr import extract_binary_payload
from lib.json_match import assert_equal, assert_found, assert_not_found, parse_json

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
        assert_equal(expected=&quot;NCE1A0955&quot;, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

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
        assert_equal(actual=contacts_1[&apos;freeFlowFormat&apos;], expected=&apos;0660660660&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_2[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_2[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-3&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_2[&apos;phone&apos;][&apos;category&apos;], expected=&quot;AGENCY&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_2[&apos;phone&apos;][&apos;number&apos;], expected=&quot;LON(0208)8778787&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_2[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_3[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_3[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-4&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;category&apos;], expected=&quot;BUSINESS&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;number&apos;], expected=&quot;FRA69686869&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_3[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_4[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_4[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-5&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_4[&apos;email&apos;][&apos;address&apos;], expected=&quot;BART@SPRINGFIELD.COM&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_4[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_5[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_5[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-6&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_5[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;FAX&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_5[&apos;phone&apos;][&apos;number&apos;], expected=&quot;GB1715869652&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_5[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_6[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_6[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-7&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;category&apos;], expected=&quot;PERSONAL&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;LANDLINE&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;number&apos;], expected=&quot;FRA69686869&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_6[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_7[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_7[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-8&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;category&apos;], expected=&quot;PERSONAL&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;MOBILE&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33666000666&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_7[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_8[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_8[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-9&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33600000666&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_8[&apos;purpose&apos;], expected=[u&apos;INFORMATION&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_9[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_9[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-10&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_9[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+14617513145&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_9[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_9[&apos;freeFlowFormat&apos;], expected=&apos;1A/NCE1A0955-W,***1A0***-W/M+14617513145&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_10[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_10[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-11&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_10[&apos;email&apos;][&apos;address&apos;], expected=&quot;MBAUER@YKT.COM&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_10[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_10[&apos;freeFlowFormat&apos;], expected=&apos;E+MBAUER@YKT.COM/EN&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_11[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_11[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-12&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_11[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33611258545&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_11[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_11[&apos;freeFlowFormat&apos;], expected=&apos;M+33611258545/EN&apos;, item_name=&apos;contact freeFlowFormat&apos;)

    except Exception as e:
        print(&apos;OpenPNR API validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR API validation successful&apos;)
    return TTS_OK


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
        assert_equal(expected=&quot;NCE1A0955&quot;, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        assert_equal(actual=len(openpnr[&apos;contacts&apos;]), expected=10, item_name=&apos;number of contacts&apos;)
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

        #Check service data for APx elements
        assert_equal(actual=contacts_1[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_1[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_1[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_1[&apos;freeFlowFormat&apos;], expected=&apos;0660660660&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_2[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_2[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-3&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_2[&apos;phone&apos;][&apos;category&apos;], expected=&quot;AGENCY&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_2[&apos;phone&apos;][&apos;number&apos;], expected=&quot;LON(0208)8778787&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_2[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_3[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_3[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-4&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;category&apos;], expected=&quot;BUSINESS&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;number&apos;], expected=&quot;FRA69686869&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_3[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_4[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_4[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-5&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_4[&apos;email&apos;][&apos;address&apos;], expected=&quot;BART@SPRINGFIELD.COM&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_4[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_5[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_5[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-6&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_5[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;FAX&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_5[&apos;phone&apos;][&apos;number&apos;], expected=&quot;GB1715869652&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_5[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_6[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_6[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-7&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;category&apos;], expected=&quot;PERSONAL&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;LANDLINE&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_6[&apos;phone&apos;][&apos;number&apos;], expected=&quot;FRA69686869&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_6[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_7[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_7[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-8&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;category&apos;], expected=&quot;PERSONAL&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;deviceType&apos;], expected=&quot;MOBILE&quot;, item_name=&apos;contact phone/deviceType&apos;)
        assert_equal(actual=contacts_7[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33666000666&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_7[&apos;purpose&apos;], expected=[u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)

        assert_equal(actual=contacts_8[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_8[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-9&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33600000666&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_8[&apos;purpose&apos;], expected=[u&apos;INFORMATION&apos;], item_name=&apos;contact purpose&apos;)

        # APN with office restricted due to the 6X publicationID (not 1A = not displayed in the feed)
        #assert_equal(actual=contacts_9[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        #assert_equal(actual=contacts_9[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-10&quot;, item_name=&apos;contacts id&apos;)
        #assert_equal(actual=contacts_9[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+14617513145&quot;, item_name=&apos;contact phone/number&apos;)
        #assert_equal(actual=contacts_9[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        #assert_equal(actual=contacts_9[&apos;freeFlowFormat&apos;], expected=&apos;1A/NCE1A0955-W,***1A0***-W/M+14617513145&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_9[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_9[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-11&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_9[&apos;email&apos;][&apos;address&apos;], expected=&quot;MBAUER@YKT.COM&quot;, item_name=&apos;contact phone/category&apos;)
        assert_equal(actual=contacts_9[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_9[&apos;freeFlowFormat&apos;], expected=&apos;E+MBAUER@YKT.COM/EN&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_10[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_10[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-12&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_10[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33611258545&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_10[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_10[&apos;freeFlowFormat&apos;], expected=&apos;M+33611258545/EN&apos;, item_name=&apos;contact freeFlowFormat&apos;)

    except Exception as e:
        print(&apos;OpenPNR Feed validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR Feed validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="250" beginLine="249" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:54.171719 - 24 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="14:32:54.270715 - 24 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="251" beginLine="250" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:54.273791 - 24 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="14:32:54.331265 - 24 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="252" beginLine="251" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:54.332050 - 24 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="14:32:54.399588 - 24 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="259" beginLine="258" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:54.400290 - 24 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="14:32:54.470991 - 24 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="261" beginLine="260" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:56.482302 - 24 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="14:32:56.541725 - 24 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="265" responseBeginLine="265" endLine="263" beginLine="262" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:56.542931 - 24 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.NCE1A0950-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="14:32:56.733149 - 24 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/24SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" responseEndLine="289" responseBeginLine="281" endLine="279" beginLine="274" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:56.738237 - 24 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGD]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=json\&amp;output=protobufBase64 HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header"><VALUE><![CDATA[eyJub25jZSI6Ik56UXlOamd6T1RJNE5qUTFOREV5TUE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMjRUMTI6MzI6NTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiTzA5L21ObkVQYVpPYWx6L1prdS9qMFJHemdzPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
]]></TEXT><VARIABLE name="input_json_APx"><VALUE><![CDATA[\{&amp;
    &quot;last_modification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-07-10T08:35:25Z&quot;&amp;
    \},&amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;,&amp;
            &quot;id&quot;: &quot;PAX-1&quot;,&amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;first_name&quot;: &quot;MORTY&quot;,&amp;
                    &quot;last_name&quot;: &quot;SMITH&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ],&amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;,&amp;
            &quot;sub_type&quot;: &quot;AIR&quot;,&amp;
            &quot;id&quot;: &quot;AIR-3&quot;,&amp;
            &quot;air_segment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iata_code&quot;: &quot;NCE&quot;,&amp;
                    &quot;local_date_time&quot;: &quot;2024-10-01T16:35:00&quot;&amp;
                \},&amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iata_code&quot;: &quot;LHR&quot;&amp;
                \},&amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flight_designator&quot;: \{&amp;
                        &quot;carrier_code&quot;: &quot;6X&quot;,&amp;
                        &quot;flight_number&quot;: &quot;562&quot;&amp;
                    \},&amp;
                    &quot;booking_class&quot;: \{&amp;
                        &quot;code&quot;: &quot;Y&quot;,&amp;
                        &quot;cabin&quot;: \{&amp;
                            &quot;code&quot;: &quot;Y&quot;,&amp;
                            &quot;bidPrice&quot;: \{&amp;
                                &quot;amount&quot;: &quot;0&quot;,&amp;
                                &quot;elementaryPriceType&quot;: &quot;BID_PRICE&quot;&amp;
                            \}&amp;
                        \}&amp;
                    \}&amp;
                \},&amp;
                &quot;booking_status_code&quot;: &quot;NN&quot;&amp;
            \},&amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ],&amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-2&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;0660660660&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-12&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;AGENCY&quot;,&amp;
                &quot;number&quot;: &quot;LON(0208)8778787&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-10&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;BUSINESS&quot;,&amp;
                &quot;number&quot;: &quot;FRA69686869&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-11&quot;,&amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;BART@SPRINGFIELD.COM&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-13&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;deviceType&quot;: &quot;FAX&quot;,&amp;
                &quot;number&quot;: &quot;GB1715869652&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-14&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;category&quot;: &quot;PERSONAL&quot;,&amp;
                &quot;deviceType&quot;: &quot;LANDLINE&quot;,&amp;
                &quot;number&quot;: &quot;FRA69686869&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-15&quot;,&amp;
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
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-16&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33600000666&quot;&amp;
            \},                 &amp;
            &quot;purpose&quot;: [&amp;
                &quot;INFORMATION&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-17&quot;,&amp;
            &quot;freeFlowFormat&quot;: &quot;1A/***1A0***-W/M+14617513145&quot;,&amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-18&quot;,&amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;MBAUER@YKT.COM&quot;&amp;
            \},&amp;
            &quot;language&quot;: &quot;EN&quot;,&amp;
            &quot;purpose&quot;: [&amp;
                &quot;NOTIFICATION&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-19&quot;,&amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33611258545&quot;&amp;
            \},&amp;
            &quot;language&quot;: &quot;EN&quot;,&amp;
            &quot;purpose&quot;: [&amp;
                 &quot;NOTIFICATION&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ],&amp;
    &quot;automated_processes&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;,&amp;
            &quot;code&quot;: &quot;OK&quot;&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;5&apos;." compareAt="14:32:56.905333 - 24 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[503 Service Unavailable]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[00018IB0YKBHIW]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[123]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[content-type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    \{&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;status&quot;: 503, &amp;
            &quot;code&quot;: 19, &amp;
            &quot;title&quot;: &quot;No available service for processing the request.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="8" responseEndLine="317" responseBeginLine="307" endLine="305" beginLine="298" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:56.907922 - 24 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGD]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/ HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header2"><VALUE><![CDATA[eyJub25jZSI6Ik56RTFOekl3T1RJMk16azNOekk1TkE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMjRUMTI6MzI6NTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoid1MwSnBKbVJ5L1g5anpSbmhhQ2JCWEFFT2Q0PSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;5&apos;." compareAt="14:32:57.058230 - 24 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[201 Created]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[503 Service Unavailable]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[00018IB10KBHIX]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[123]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[content-type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;reference&quot;: &quot;{%recloc%=.{6}}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    \{&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;version&quot;: &quot;{*}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;status&quot;: 503, &amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf2%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;code&quot;: 19, &amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;title&quot;: &quot;No available service for processing the request.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="9" responseEndLine="341" responseBeginLine="335" endLine="333" beginLine="327" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:57.062326 - 24 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGD]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header3"><VALUE><![CDATA[eyJub25jZSI6Ik1ETTFNRE0wTWpNeU56ZzFPRGsyTVE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMjRUMTI6MzI6NTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoia1dtellQTW1VWm5oakg5WitVM2podUo2M1o0PSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;5&apos;." compareAt="14:32:57.212499 - 24 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[503 Service Unavailable]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[00018IB12KBHIX]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[123]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[etag:1]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[content-type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[    &quot;errors&quot;: [&amp;
        \{&amp;
            &quot;status&quot;: 503, &amp;
            &quot;code&quot;: 19, &amp;
            &quot;title&quot;: &quot;No available service for processing the request.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="10" responseEndLine="365" responseBeginLine="352" endLine="350" beginLine="349" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:57.214695 - 24 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;-&apos;, received &apos;I&apos;." compareAt="14:32:57.329108 - 24 Sep 2024"><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[--- RLR {*}---&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[INVALID&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RP/NCE1A0955/NCE1A0955 {*}/{*} {*}Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[&gt;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{(local).*?AP} 0660660660&amp;
]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  4 APA LON(0208)8778787]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&amp;
  5 APB FRA69686869&amp;
  6 APE BART@SPRINGFIELD.COM&amp;
  7 APF GB1715869652&amp;
  8 APH FRA69686869&amp;
  9 API +33600000666&amp;
 10 APM +33666000666&amp;
 11 APN 1A/NCE1A0955-W,***1A0***-W/M+14617513145&amp;
 12 APN E+MBAUER@YKT.COM/EN&amp;
 13 APN M+33611258545/EN&amp;
]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{*}]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="405" responseBeginLine="392" endLine="390" beginLine="384" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="looping"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:32:57.416228 - 24 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[24SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="14:32:57.463009 - 24 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PURCRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[24SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+00K72X3RLY0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PURCRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[IRV+ENV+0]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[IRV+ENV+0]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="405" responseBeginLine="392" endLine="390" beginLine="384" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="1" sentAt="14:33:00.476152 - 24 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[24SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="14:33:00.524937 - 24 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PURCRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[24SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+01D6RU7GG70001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PURCRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[IRV+ENV+0]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[IRV+ENV+0]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="426" responseBeginLine="420" endLine="418" beginLine="414" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_DEV.cry" loop="0" sentAt="14:33:03.580819 - 24 Sep 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="14:33:03.626669 - 24 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PUPIRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+01D79LHGY20001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+SONPK{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PUPIRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[BLB+{*}+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C{%raw_binary%=(multi).*}UNT\x1D2\x1D1\x1C&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION></TRANSACTION><ERROR filename="" line="440" severity="Fatal Error">The variable &apos;global_regression.openpnr_payload&apos; is not defined</ERROR><STATISTIC><STATISTIC_ELEMENT name="Message in">13</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">2532</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">13</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">8750</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">8</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">13</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">13</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">9457.6</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.317</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">1237.83</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">13</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">8</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">6</STATISTIC_ELEMENT></STATISTIC></xml>