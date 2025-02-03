<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry"><SCRIPT type="Initialize">import json
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
        assert_equal(actual=contacts_10[&apos;freeFlowFormat&apos;], expected=&apos;E+MBAUER@YKT.COM&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_11[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_11[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-12&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_11[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33611258545&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_11[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_11[&apos;freeFlowFormat&apos;], expected=&apos;M+33611258545&apos;, item_name=&apos;contact freeFlowFormat&apos;)

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
        assert_equal(actual=contacts_9[&apos;freeFlowFormat&apos;], expected=&apos;E+MBAUER@YKT.COM&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_10[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_10[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-12&quot;, item_name=&apos;contacts id&apos;)
        assert_equal(actual=contacts_10[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+33611258545&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_10[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_10[&apos;freeFlowFormat&apos;], expected=&apos;M+33611258545&apos;, item_name=&apos;contact freeFlowFormat&apos;)

    except Exception as e:
        print(&apos;OpenPNR Feed validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR Feed validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="250" beginLine="249" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:15.625278 - 11 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="11:34:15.683546 - 11 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="251" beginLine="250" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:15.684121 - 11 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="11:34:15.744656 - 11 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="252" beginLine="251" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:15.744916 - 11 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="11:34:15.820874 - 11 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="259" beginLine="258" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:15.821231 - 11 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="11:34:15.899619 - 11 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="261" beginLine="260" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:17.902073 - 11 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="11:34:17.966529 - 11 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="265" responseBeginLine="265" endLine="263" beginLine="262" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:17.966765 - 11 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.HELAY08NA-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="11:34:18.201902 - 11 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/11SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" responseEndLine="290" responseBeginLine="281" endLine="279" beginLine="274" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:18.204704 - 11 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEG]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=json\&amp;output=protobufBase64 HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header"><VALUE><![CDATA[eyJub25jZSI6Ik56YzNNVFU0TWpZd056UTVNemswTWc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMDk6MzQ6MTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiaGE0dWY0REZwUmgxUWRJRzZWMmhEYmhDSFhNPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
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
\}]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="11:34:18.338851 - 11 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DMFQ2JN6L6]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1610]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_protobuf%=.*}]]></EXPRESSION><VALUE><![CDATA[ShYaFDIwMjQtMDctMTBUMDg6MzU6MjVaeiQKC3N0YWtlaG9sZGVyEgVQQVgtMSIOEgVNT1JUWRoFU01JVEiCAZABCgdwcm9kdWN0EAEaBUFJUi0zIk4KGgoDTkNFGhMyMDI0LTEwLTAxVDE2OjM1OjAwEgUKA0xIUiIlCgkKAjZYEgM1NjISGAoBWRITCgFZEg4KATAiCUJJRF9QUklDRUoCTk5CLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFOCgdjb250YWN0EgRBUC0yIgwaCjA2NjA2NjA2NjBCAQFiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFXCgdjb250YWN0EgVBUC0xMiIUCAMaEExPTigwMjA4KTg3Nzg3ODdCAQFiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFSCgdjb250YWN0EgVBUC0xMCIPCAIaC0ZSQTY5Njg2ODY5QgEBYiwKC3N0YWtlaG9sZGVyEgVQQVgtMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBWQoHY29udGFjdBIFQVAtMTEyFgoUQkFSVEBTUFJJTkdGSUVMRC5DT01CAQFiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFTCgdjb250YWN0EgVBUC0xMyIQEAMaDEdCMTcxNTg2OTY1MkIBAWIsCgtzdGFrZWhvbGRlchIFUEFYLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAVQKB2NvbnRhY3QSBUFQLTE0IhEIARACGgtGUkE2OTY4Njg2OUIBAWIsCgtzdGFrZWhvbGRlchIFUEFYLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAVUKB2NvbnRhY3QSBUFQLTE1IhIIARABGgwrMzM2NjYwMDA2NjZCAQFiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFRCgdjb250YWN0EgVBUC0xNiIOGgwrMzM2MDAwMDA2NjZCAQNiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFhCgdjb250YWN0EgVBUC0xN0IBAloeChwxQS8qKioxQTAqKiotVy9NKzE0NjE3NTEzMTQ1YiwKC3N0YWtlaG9sZGVyEgVQQVgtMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBUwoHY29udGFjdBIFQVAtMTgyEAoOTUJBVUVSQFlLVC5DT01CAQJiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFRCgdjb250YWN0EgVBUC0xOSIOGgwrMzM2MTEyNTg1NDVCAQJiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugEVChFhdXRvbWF0ZWQtcHJvY2VzcxgF]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="8" responseEndLine="319" responseBeginLine="308" endLine="306" beginLine="299" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:18.341178 - 11 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEG]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/ HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header2"><VALUE><![CDATA[eyJub25jZSI6Ik5qazRNREl6Tnprd016TXpPRGszTWc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMDk6MzQ6MTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoicjdEcVIrSG9RU3dMdWI5K0FoQlFoa0tYcy9BPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[ShYaFDIwMjQtMDctMTBUMDg6MzU6MjVaeiQKC3N0YWtlaG9sZGVyEgVQQVgtMSIOEgVNT1JUWRoFU01JVEiCAZABCgdwcm9kdWN0EAEaBUFJUi0zIk4KGgoDTkNFGhMyMDI0LTEwLTAxVDE2OjM1OjAwEgUKA0xIUiIlCgkKAjZYEgM1NjISGAoBWRITCgFZEg4KATAiCUJJRF9QUklDRUoCTk5CLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFOCgdjb250YWN0EgRBUC0yIgwaCjA2NjA2NjA2NjBCAQFiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFXCgdjb250YWN0EgVBUC0xMiIUCAMaEExPTigwMjA4KTg3Nzg3ODdCAQFiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFSCgdjb250YWN0EgVBUC0xMCIPCAIaC0ZSQTY5Njg2ODY5QgEBYiwKC3N0YWtlaG9sZGVyEgVQQVgtMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBWQoHY29udGFjdBIFQVAtMTEyFgoUQkFSVEBTUFJJTkdGSUVMRC5DT01CAQFiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFTCgdjb250YWN0EgVBUC0xMyIQEAMaDEdCMTcxNTg2OTY1MkIBAWIsCgtzdGFrZWhvbGRlchIFUEFYLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAVQKB2NvbnRhY3QSBUFQLTE0IhEIARACGgtGUkE2OTY4Njg2OUIBAWIsCgtzdGFrZWhvbGRlchIFUEFYLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAVUKB2NvbnRhY3QSBUFQLTE1IhIIARABGgwrMzM2NjYwMDA2NjZCAQFiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFRCgdjb250YWN0EgVBUC0xNiIOGgwrMzM2MDAwMDA2NjZCAQNiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFhCgdjb250YWN0EgVBUC0xN0IBAloeChwxQS8qKioxQTAqKiotVy9NKzE0NjE3NTEzMTQ1YiwKC3N0YWtlaG9sZGVyEgVQQVgtMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBUwoHY29udGFjdBIFQVAtMTgyEAoOTUJBVUVSQFlLVC5DT01CAQJiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgFRCgdjb250YWN0EgVBUC0xOSIOGgwrMzM2MTEyNTg1NDVCAQJiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugEVChFhdXRvbWF0ZWQtcHJvY2VzcxgF]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></QUERY><COMPARISON compareAt="11:34:19.245010 - 11 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 201 Created&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DMFQ5JN6L6]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[3993]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;reference&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[23VJK6]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;, &amp;
    &quot;version&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;, &amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_protobuf2%=.*}]]></EXPRESSION><VALUE><![CDATA[ChEyM1ZKSzYtMjAyNC0wOS0xMRIDcG5yGgYyM1ZKSzYiATA6VRoUMjAyNC0wOS0xMVQwOTozNDowMFoiPQoiCglOQ0UxQTA5NTUSCDEyMzQ1Njc1GgIxQSIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOS0xMVQwOTozNDoxOFp6+wUKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMSIOEgVNT1JUWRoFU01JVEhyPAoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTIaFXByb2Nlc3NlZFBuci5jb250YWN0c3I8Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtMxoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzcjwKB2NvbnRhY3QSGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC00GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPAoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTUaFXByb2Nlc3NlZFBuci5jb250YWN0c3I8Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtNhoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzcjwKB2NvbnRhY3QSGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC03GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPAoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTgaFXByb2Nlc3NlZFBuci5jb250YWN0c3I8Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtORoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC0xMBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC0xMRoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC0xMhoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA1MTA0MTNERTAwMDA1MURBggHEAgoHcHJvZHVjdBABGhsyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQUlSLTEimQIKGgoDTkNFGhMyMDI0LTEwLTAxVDA2OjAwOjAwEhoKA0xIUhoTMjAyNC0xMC0wMVQwNzoxMDowMCJNCgkKAjZYEgM1NjISJQoBWRIDCgFZGhIKABIMCgQaAjFBEgQqAkZSIAEiB0VDT05PTVkyGTZYLTU2Mi0yMDI0LTEwLTAxLU5DRS1MSFJKAkhLYoQBChBzZWdtZW50LWRlbGl2ZXJ5EhsyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQktHLTEaEDUwMDUxM0RFMDAwMTkyOEFaQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzigEBRZIBALIBeQoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTJCAQFaDAoKMDY2MDY2MDY2MGJBCgtzdGFrZWhvbGRlchIaMjNWSks2LTIwMjQtMDktMTEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAYEBCgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtMyIUCAMaEExPTigwMjA4KTg3Nzg3ODdCAQFiQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF8Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtNCIPCAIaC0ZSQTY5Njg2ODY5QgEBYkEKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBgwEKB2NvbnRhY3QSGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC01MhYKFEJBUlRAU1BSSU5HRklFTEQuQ09NQgEBYkEKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBfQoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTYiEBADGgxHQjE3MTU4Njk2NTJCAQFiQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF+Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtNyIRCAEQAhoLRlJBNjk2ODY4NjlCAQFiQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF/Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtOCISCAEQARoMKzMzNjY2MDAwNjY2QgEBYkEKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBewoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTkiDhoMKzMzNjAwMDAwNjY2QgEDYkEKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBqAEKB2NvbnRhY3QSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC0xMCIOGgwrMTQ2MTc1MTMxNDVCAQJaKgooMUEvTkNFMUEwOTU1LVcsKioqMUEwKioqLVcvTSsxNDYxNzUxMzE0NWJBCgtzdGFrZWhvbGRlchIaMjNWSks2LTIwMjQtMDktMTEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAZIBCgdjb250YWN0EhsyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtMTEyEAoOTUJBVUVSQFlLVC5DT01CAQJaEgoQRStNQkFVRVJAWUtULkNPTWJBCgtzdGFrZWhvbGRlchIaMjNWSks2LTIwMjQtMDktMTEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAY0BCgdjb250YWN0EhsyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtMTIiDhoMKzMzNjExMjU4NTQ1QgECWg8KDU0rMzM2MTEyNTg1NDViQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHWAQoRYXV0b21hdGVkLXByb2Nlc3MSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1USy0xMxgFIhMyMDI0LTA5LTExVDAwOjAwOjAwKgsKCU5DRTFBMDk1NVpBCgtzdGFrZWhvbGRlchIaMjNWSks2LTIwMjQtMDktMTEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbMjNWSks2LTIwMjQtMDktMTEtUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="9" responseEndLine="344" responseBeginLine="337" endLine="335" beginLine="329" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:19.247249 - 11 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEG]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header3"><VALUE><![CDATA[eyJub25jZSI6Ik9UUTVOekF6T1RrM09ERTRNemMwT1E9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMDk6MzQ6MTAuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiNXhpYnZxTHdZM2M2Q3J6UFRFQ2lLQVpyWFZvPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf2"><VALUE><![CDATA[ChEyM1ZKSzYtMjAyNC0wOS0xMRIDcG5yGgYyM1ZKSzYiATA6VRoUMjAyNC0wOS0xMVQwOTozNDowMFoiPQoiCglOQ0UxQTA5NTUSCDEyMzQ1Njc1GgIxQSIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOS0xMVQwOTozNDoxOFp6+wUKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMSIOEgVNT1JUWRoFU01JVEhyPAoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTIaFXByb2Nlc3NlZFBuci5jb250YWN0c3I8Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtMxoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzcjwKB2NvbnRhY3QSGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC00GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPAoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTUaFXByb2Nlc3NlZFBuci5jb250YWN0c3I8Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtNhoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzcjwKB2NvbnRhY3QSGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC03GhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPAoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTgaFXByb2Nlc3NlZFBuci5jb250YWN0c3I8Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtORoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC0xMBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC0xMRoVcHJvY2Vzc2VkUG5yLmNvbnRhY3Rzcj0KB2NvbnRhY3QSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC0xMhoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA1MTA0MTNERTAwMDA1MURBggHEAgoHcHJvZHVjdBABGhsyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQUlSLTEimQIKGgoDTkNFGhMyMDI0LTEwLTAxVDA2OjAwOjAwEhoKA0xIUhoTMjAyNC0xMC0wMVQwNzoxMDowMCJNCgkKAjZYEgM1NjISJQoBWRIDCgFZGhIKABIMCgQaAjFBEgQqAkZSIAEiB0VDT05PTVkyGTZYLTU2Mi0yMDI0LTEwLTAxLU5DRS1MSFJKAkhLYoQBChBzZWdtZW50LWRlbGl2ZXJ5EhsyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQktHLTEaEDUwMDUxM0RFMDAwMTkyOEFaQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzigEBRZIBALIBeQoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTJCAQFaDAoKMDY2MDY2MDY2MGJBCgtzdGFrZWhvbGRlchIaMjNWSks2LTIwMjQtMDktMTEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAYEBCgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtMyIUCAMaEExPTigwMjA4KTg3Nzg3ODdCAQFiQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF8Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtNCIPCAIaC0ZSQTY5Njg2ODY5QgEBYkEKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBgwEKB2NvbnRhY3QSGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC01MhYKFEJBUlRAU1BSSU5HRklFTEQuQ09NQgEBYkEKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBfQoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTYiEBADGgxHQjE3MTU4Njk2NTJCAQFiQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF+Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtNyIRCAEQAhoLRlJBNjk2ODY4NjlCAQFiQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgF/Cgdjb250YWN0EhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtOCISCAEQARoMKzMzNjY2MDAwNjY2QgEBYkEKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBewoHY29udGFjdBIaMjNWSks2LTIwMjQtMDktMTEtUE5SLUFQLTkiDhoMKzMzNjAwMDAwNjY2QgEDYkEKC3N0YWtlaG9sZGVyEhoyM1ZKSzYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBqAEKB2NvbnRhY3QSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1BUC0xMCIOGgwrMTQ2MTc1MTMxNDVCAQJaKgooMUEvTkNFMUEwOTU1LVcsKioqMUEwKioqLVcvTSsxNDYxNzUxMzE0NWJBCgtzdGFrZWhvbGRlchIaMjNWSks2LTIwMjQtMDktMTEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAZIBCgdjb250YWN0EhsyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtMTEyEAoOTUJBVUVSQFlLVC5DT01CAQJaEgoQRStNQkFVRVJAWUtULkNPTWJBCgtzdGFrZWhvbGRlchIaMjNWSks2LTIwMjQtMDktMTEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAY0BCgdjb250YWN0EhsyM1ZKSzYtMjAyNC0wOS0xMS1QTlItQVAtMTIiDhoMKzMzNjExMjU4NTQ1QgECWg8KDU0rMzM2MTEyNTg1NDViQQoLc3Rha2Vob2xkZXISGjIzVkpLNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHWAQoRYXV0b21hdGVkLXByb2Nlc3MSGzIzVkpLNi0yMDI0LTA5LTExLVBOUi1USy0xMxgFIhMyMDI0LTA5LTExVDAwOjAwOjAwKgsKCU5DRTFBMDk1NVpBCgtzdGFrZWhvbGRlchIaMjNWSks2LTIwMjQtMDktMTEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbMjNWSks2LTIwMjQtMDktMTEtUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="11:34:19.378965 - 11 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DMFQ9JN6L7]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[5372]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;23VJK6-2024-09-11&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;23VJK6&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-11T09:34:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0955&quot;, &amp;
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
        &quot;dateTime&quot;: &quot;2024-09-11T09:34:18Z&quot;&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;MORTY&quot;, &amp;
                    &quot;lastName&quot;: &quot;SMITH&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-3&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-4&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-5&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-6&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-7&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-8&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-9&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-10&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-11&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-12&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;510413DE000051DA&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-01T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-01T07:10:00&quot;&amp;
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
                    &quot;id&quot;: &quot;6X-562-2024-10-01-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;500513DE0001928A&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;0660660660&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-3&quot;, &amp;
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
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-4&quot;, &amp;
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
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-5&quot;, &amp;
            &quot;email&quot;: \{&amp;
                &quot;address&quot;: &quot;BART@SPRINGFIELD.COM&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-6&quot;, &amp;
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
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-7&quot;, &amp;
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
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-8&quot;, &amp;
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
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-9&quot;, &amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33600000666&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;INFORMATION&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-10&quot;, &amp;
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
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-11&quot;, &amp;
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
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AP-12&quot;, &amp;
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
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-TK-13&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-09-11T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0955&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;23VJK6-2024-09-11-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="10" responseEndLine="368" responseBeginLine="355" endLine="353" beginLine="352" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:19.381451 - 11 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;-&apos;, received &apos;S&apos;." compareAt="11:34:19.549643 - 11 Sep 2024"><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[--- RLR {*}---&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[SECURED PNR&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RP/NCE1A0955/NCE1A0955 {*}/{*} {*}Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[&gt;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{(local).*?AP} 0660660660&amp;
]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  4 APA LON(0208)8778787]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&amp;
  5 APB FRA69686869&amp;
  6 APE BART@SPRINGFIELD.COM&amp;
  7 APF GB1715869652&amp;
  8 APH FRA69686869&amp;
  9 API +33600000666&amp;
 10 APM +33666000666&amp;
 11 APN 1A/NCE1A0955-W,***1A0***-W/M+14617513145&amp;
 12 APN E+MBAUER@YKT.COM&amp;
 13 APN M+33611258545&amp;
]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{*}]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="388" responseBeginLine="386" endLine="384" beginLine="380" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:19.607478 - 11 Sep 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="11:34:19.849281 - 11 Sep 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:23VJK6::110924:0934&apos;&amp;
RSI+RP:YGSU:NCE1A0955:12345675+NCE1A0955+NCE+NCE1A0955:1127YG:110924:12345675:0934&apos;&amp;
LFT+3:P12+--- RLR ---&apos;&amp;
STX+RLR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[0]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:10:5&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+SMITH::1+MORTY&apos;&amp;
ETI+:1+UN:Y:Y::SMITH:MORTY&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+011024:0600:011024:0710+NCE+LHR+6X+562:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:23VJK6&apos;&amp;
RPI+1+HK&apos;&amp;
APD+ERJ:0:0210::2+++648:M++M:CM&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+011024:0600:011024:0710+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
REF+PT:1&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+0660660660&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:3+AP+4&apos;&amp;
LFT+3:6+LON(0208)8778787&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:4+AP+5&apos;&amp;
LFT+3:3+FRA69686869&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:5+AP+6&apos;&amp;
LFT+3:P02+BART@SPRINGFIELD.COM&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:6+AP+7&apos;&amp;
LFT+3:P01+GB1715869652&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:7+AP+8&apos;&amp;
LFT+3:4+FRA69686869&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:9+AP+9&apos;&amp;
LFT+3:P03+\+33600000666&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:8+AP+10&apos;&amp;
LFT+3:7+\+33666000666&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:10+AP+11&apos;&amp;
LFT+3:5:N+1A/NCE1A0955-W,\*\*\*1A0\*\*\*-W/M\+14617513145&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:11+AP+12&apos;&amp;
LFT+3:5:N+E\+MBAUER@YKT.COM&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:12+AP+13&apos;&amp;
LFT+3:5:N+M\+33611258545&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:13+TK+14&apos;&amp;
TKE++OK:110924::NCE1A0955]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11"><QUERY filename="" loop="0" sentAt="11:34:19.850227 - 11 Sep 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="421" responseBeginLine="408" endLine="406" beginLine="400" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="looping"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:19.992550 - 11 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A0001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_AY"><VALUE><![CDATA[33]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 69: Missing character(s)" compareAt="11:34:20.522676 - 11 Sep 2024"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_AY"><VALUE><![CDATA[33]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication_AY"><VALUE><![CDATA[33]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="421" responseBeginLine="408" endLine="406" beginLine="400" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="1" sentAt="11:34:23.536825 - 11 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A0001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_AY"><VALUE><![CDATA[33]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 69: Missing character(s)" compareAt="11:34:23.624245 - 11 Sep 2024"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_AY"><VALUE><![CDATA[33]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[23VJK6]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication_AY"><VALUE><![CDATA[33]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="442" responseBeginLine="436" endLine="434" beginLine="430" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/APx/APx_Create_Feed_AY.cry" loop="0" sentAt="11:34:26.695163 - 11 Sep 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="11:34:26.751102 - 11 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PUPIRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+002IS33ANL0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+SONPK{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PUPIRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[BLB+{*}+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C{%raw_binary%=(multi).*}UNT\x1D2\x1D1\x1C&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION></TRANSACTION><ERROR filename="" line="456" severity="Fatal Error">The variable &apos;global_regression.openpnr_payload&apos; is not defined</ERROR><STATISTIC><STATISTIC_ELEMENT name="Message in">15</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">20973</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">15</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">14555</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">9</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">15</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">14</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.933333</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">11128.8</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.161</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">2851</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">25</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">9</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">3</STATISTIC_ELEMENT></STATISTIC></xml>