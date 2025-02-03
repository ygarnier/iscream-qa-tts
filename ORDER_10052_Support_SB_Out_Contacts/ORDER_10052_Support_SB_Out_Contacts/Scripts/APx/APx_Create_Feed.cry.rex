<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry"><SCRIPT type="Initialize">import json
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

</SCRIPT><TRANSACTION transactionCounter="1" endLine="250" beginLine="249" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:05.187756 - 24 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="11:40:05.286639 - 24 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="251" beginLine="250" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:05.288829 - 24 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="11:40:05.341724 - 24 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="252" beginLine="251" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:05.342236 - 24 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="11:40:05.408953 - 24 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="259" beginLine="258" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:05.409730 - 24 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="11:40:05.463351 - 24 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="261" beginLine="260" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:07.473201 - 24 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="11:40:07.528454 - 24 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="265" responseBeginLine="265" endLine="263" beginLine="262" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:07.529357 - 24 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.NCE1A0950-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="11:40:07.716154 - 24 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/24SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" responseEndLine="290" responseBeginLine="281" endLine="279" beginLine="274" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:07.720779 - 24 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGD]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=json\&amp;output=protobufBase64 HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header"><VALUE><![CDATA[eyJub25jZSI6Ik1qRTROREkxTnpFNE1EY3dPVFEzTUE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMjRUMDk6NDA6MDEuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiZnE2MlZCNkFIK01nOTZFekh5SlY5d0ZiTkg4PSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
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
\}]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;5&apos;." compareAt="11:40:07.886112 - 24 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[503 Service Unavailable]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[00018HTQKKB9IV]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[123]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[content-type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        \{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;status&quot;: 503, &amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;code&quot;: 19, &amp;
            &quot;title&quot;: &quot;No available service for processing the request.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="8" responseEndLine="319" responseBeginLine="308" endLine="306" beginLine="299" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:07.889535 - 24 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGD]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/ HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header2"><VALUE><![CDATA[eyJub25jZSI6Ik5UZzVOakEyTXpJMk5UWTJNVGs0TkE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMjRUMDk6NDA6MDEuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiQ25UTlU0dzhvNHZxUGtEYVZpcEFhZEFMeWprPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;5&apos;." compareAt="11:40:08.033979 - 24 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[201 Created]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[503 Service Unavailable]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[00018HTQMKB9IV]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[123]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[content-type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        \{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;reference&quot;: &quot;{%recloc%=.{6}}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;status&quot;: 503, &amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;version&quot;: &quot;{*}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;code&quot;: 19, &amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf2%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;title&quot;: &quot;No available service for processing the request.&quot;, &amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="9" responseEndLine="344" responseBeginLine="337" endLine="335" beginLine="329" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:08.037534 - 24 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGD]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header3"><VALUE><![CDATA[eyJub25jZSI6Ik56Z3hPREE1TlRJNU56QTVPVEF3TWc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMjRUMDk6NDA6MDEuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoicWtzeHN0aCtpTS85K0w0d2lBbno1N2g2WmswPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;5&apos;." compareAt="11:40:08.178608 - 24 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[503 Service Unavailable]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[00018HTQOKB9IW]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[123]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[etag:1]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[content-type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[        \{&amp;
            &quot;status&quot;: 503, &amp;
            &quot;code&quot;: 19, &amp;
            &quot;title&quot;: &quot;No available service for processing the request.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="10" responseEndLine="368" responseBeginLine="355" endLine="353" beginLine="352" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed.cry" loop="0" sentAt="11:40:08.179980 - 24 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;-&apos;, received &apos;E&apos;." compareAt="11:40:08.284037 - 24 Sep 2024"><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[--- RLR {*}---&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[ERROR:&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RP/NCE1A0955/NCE1A0955 {*}/{*} {*}Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[Timestamp        : 2024/09/24 - 09:40:08.207 GMT&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{(local).*?AP} 0660660660&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[A: srvEX02M&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  4 APA LON(0208)8778787]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[B: ********]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  5 APB FRA69686869]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[C: Terminal]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  6 APE BART@SPRINGFIELD.COM]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[D: 1ASITNEUD]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  7 APF GB1715869652]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[E: Root/1DEVDIRECT]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  8 APH FRA69686869]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[F: RT]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  9 API +33600000666]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[G: Yes]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[ 10 APM +33666000666]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[H: No / No]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[ 11 APN 1A/NCE1A0955-W,***1A0***-W/M+14617513145]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[Practice Training: No]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[ 12 APN E+MBAUER@YKT.COM/EN]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[Shared Conversation: 1]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[ 13 APN M+33611258545/EN]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[Outbound TN3270 Session :]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&lt;None&gt;&amp;
DCXID            : LWI$2O$RP2UW0KE36ON7EA7OD1&amp;
Z: 7 4::1 -&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION>