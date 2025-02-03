<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry"><SCRIPT type="Initialize">import json
import re
import generic_lib

from lib.openpnr import extract_binary_payload
from lib.json_match import assert_equal, assert_found, assert_not_found, parse_json
from generic_lib import flatten


# [ \{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;%Json_AP_Patch_Add%&quot; \},\{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;%Json_APF_Patch_Add%&quot; \},\{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;%Json_APA_Patch_Add%&quot; \},\{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;%Json_APB_Patch_Add%&quot; \},\{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;%Json_APE_Patch_Add%&quot; \},\{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;%Json_APH_Patch_Add%&quot; \}, \{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;%Json_APM_Patch_Add%&quot; \}, \{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;free_flow_format \{value: &apos;1A/***1A0***-W/M+14617513145/EN&apos;\} purpose: NOTIFICATION traveler_refs \{ type: &apos;stakeholder&apos; id: &apos;%recloc%-%today%-PNR-NM-1&apos; ref: &apos;processed_pnr.travelers&apos;}\&quot; \}, \{&quot;action&quot;: &quot;add&quot;, &quot;model&quot;: &quot;Contact&quot;, &quot;id&quot;: null, &quot;element&quot;: &quot;email \{address: &quot;BART@SPRINGFIELD.COM&quot;\} purpose: NOTIFICATION traveler_refs \{type: &quot;stakeholder&quot;, id: &quot;%recloc%-%today%-PNR-NM-1&quot;, ref: &quot;processed_pnr.travelers&quot;\}&quot; \}]


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
        assert_equal(expected=&quot;NCE6X0100&quot;, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        assert_equal(actual=len(openpnr[&apos;contacts&apos;]), expected=8, item_name=&apos;number of contacts&apos;)
        contacts_1 = openpnr[&apos;contacts&apos;][0]
        contacts_2 = openpnr[&apos;contacts&apos;][1]
        contacts_3 = openpnr[&apos;contacts&apos;][2]
        contacts_4 = openpnr[&apos;contacts&apos;][3]
        contacts_5 = openpnr[&apos;contacts&apos;][4]
        contacts_6 = openpnr[&apos;contacts&apos;][5]
        contacts_7 = openpnr[&apos;contacts&apos;][6]
        contacts_8 = openpnr[&apos;contacts&apos;][7]

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
        assert_equal(actual=contacts_8[&apos;phone&apos;][&apos;number&apos;], expected=&quot;+14617513145&quot;, item_name=&apos;contact phone/number&apos;)
        assert_equal(actual=contacts_8[&apos;purpose&apos;], expected=[u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_8[&apos;freeFlowFormat&apos;], expected=&apos;6X/SYD6X0102-W,***6X0***-W/M+14617513145&apos;, item_name=&apos;contact freeFlowFormat&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="137" beginLine="136" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:46.582394 - 20 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:46:46.631228 - 20 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="138" beginLine="137" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:46.632986 - 20 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:46:46.686480 - 20 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="139" beginLine="138" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:46.687082 - 20 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:46:46.753165 - 20 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="146" beginLine="145" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:46.753487 - 20 Aug 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:46:46.805469 - 20 Aug 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="148" beginLine="147" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:48.807279 - 20 Aug 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:46:48.875144 - 20 Aug 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="152" responseBeginLine="152" endLine="150" beginLine="149" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:48.875363 - 20 Aug 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[****************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="10:46:49.027107 - 20 Aug 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/20AUG/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="159" beginLine="158" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><COMMENT> 2. Create simple PNR with mandatory elements</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:49.027747 - 20 Aug 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1ACAH/TLMD]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:46:49.119802 - 20 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.ACAH/TLMD&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="160" beginLine="159" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:49.120023 - 20 Aug 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight_6X_daily.book(1)}]]></EXPRESSION><VALUE><![CDATA[SS6X562Y12OCTNCELHR1]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:46:49.502746 - 20 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.ACAH/TLMD&amp;
  2  6X 562 Y 12OCT 6 NCELHR DK1  0600 0710  12OCT  E  0 ERJ CM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="161" beginLine="160" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:49.503009 - 20 Aug 2024"><TEXT><![CDATA[APTEST]]></TEXT></QUERY><REPLY receiveAt="10:46:49.611318 - 20 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.ACAH/TLMD&amp;
  2  6X 562 Y 12OCT 6 NCELHR DK1  0600 0710  12OCT  E  0 ERJ CM&amp;
  3 AP TEST&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="162" beginLine="161" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:49.611417 - 20 Aug 2024"><TEXT><![CDATA[TKOK;RFTEST]]></TEXT></QUERY><REPLY receiveAt="10:46:49.749857 - 20 Aug 2024" filename="">RP/NCE6X0100/&amp;
RF TEST&amp;
  1.ACAH/TLMD&amp;
  2  6X 562 Y 12OCT 6 NCELHR DK1  0600 0710  12OCT  E  0 ERJ CM&amp;
  3 AP TEST&amp;
  4 TK OK20AUG/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="163" beginLine="162" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:49.750339 - 20 Aug 2024"><TEXT><![CDATA[ES/G]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-B]]></TEXT></QUERY><REPLY receiveAt="10:46:49.958755 - 20 Aug 2024" filename="">RP/NCE6X0100/&amp;
RF TEST&amp;
  1.ACAH/TLMD&amp;
  2  6X 562 Y 12OCT 6 NCELHR DK1  0600 0710  12OCT  E  0 ERJ CM&amp;
  3 AP TEST&amp;
  4 TK OK20AUG/NCE6X0100&amp;
  * ES/G B NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="169" responseBeginLine="167" endLine="164" beginLine="163" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:49.958902 - 20 Aug 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="10:46:50.474115 - 20 Aug 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 20AUG24/0846]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8K3MRG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  1.ACAH/TLMD&amp;
  2  6X 562 Y 12OCT 6 NCELHR HK1  0600 0710  12OCT  E  6X/8K3MRG&amp;
  3 AP TEST&amp;
  4 TK OK20AUG/NCE6X0100&amp;
  * ES/G 20AUG/YGSU/NCE6X0100&amp;
    NCE6X0100-B&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="207" responseBeginLine="206" endLine="204" beginLine="178" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:51.476521 - 20 Aug 2024"><TEXT><![CDATA[PATCH /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[/elements HTTP/1.1&amp;
Content-Type: text/plain&amp;
Debug-Format: json&amp;
If-Match: 1&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header"><VALUE><![CDATA[eyJub25jZSI6Ik1qQXdOemMzTkRFMk16YzJNVGs1T0E9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMjBUMDg6NDY6NDIuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiOGhnOXBVallVb3JpNjFMaTNnb3Z2NG1BcXJVPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
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
                    &quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-08-20]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
\t\t\}&amp;
\t\}&amp;
]]]></TEXT></QUERY><COMPARISON compareAt="10:46:52.250348 - 20 Aug 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ama-request-id:0001KPOZ4IIDQ3&amp;
content-length:2411&amp;
etag:2&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;reference&quot;: &quot;8K3MRG&quot;, &amp;
    &quot;version&quot;: &quot;2&quot;, &amp;
    &quot;openPnr&quot;: \{&amp;
        &quot;id&quot;: &quot;8K3MRG-2024-08-20&quot;, &amp;
        &quot;type&quot;: &quot;pnr&quot;, &amp;
        &quot;reference&quot;: &quot;8K3MRG&quot;, &amp;
        &quot;version&quot;: &quot;2&quot;, &amp;
        &quot;creation&quot;: \{&amp;
            &quot;dateTime&quot;: &quot;2024-08-20T08:46:00Z&quot;, &amp;
            &quot;pointOfSale&quot;: \{&amp;
                &quot;office&quot;: \{&amp;
                    &quot;id&quot;: &quot;NCE6X0100&quot;, &amp;
                    &quot;iataNumber&quot;: &quot;00631002&quot;, &amp;
                    &quot;systemCode&quot;: &quot;6X&quot;, &amp;
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
            &quot;dateTime&quot;: &quot;2024-08-20T08:46:51Z&quot;&amp;
        \}, &amp;
        &quot;travelers&quot;: [&amp;
            \{&amp;
                &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                &quot;names&quot;: [&amp;
                    \{&amp;
                        &quot;firstName&quot;: &quot;TLMD&quot;, &amp;
                        &quot;lastName&quot;: &quot;ACAH&quot;&amp;
                    \}&amp;
                ], &amp;
                &quot;contacts&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-10&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;contact&quot;, &amp;
                        &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-2&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                    \}&amp;
                ], &amp;
                &quot;passenger&quot;: \{&amp;
                    &quot;uniqueIdentifier&quot;: &quot;610CF3C70001348A&quot;&amp;
                \}&amp;
            \}&amp;
        ], &amp;
        &quot;products&quot;: [&amp;
            \{&amp;
                &quot;type&quot;: &quot;product&quot;, &amp;
                &quot;subType&quot;: &quot;AIR&quot;, &amp;
                &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AIR-1&quot;, &amp;
                &quot;airSegment&quot;: \{&amp;
                    &quot;departure&quot;: \{&amp;
                        &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                        &quot;localDateTime&quot;: &quot;2024-10-12T06:00:00&quot;&amp;
                    \}, &amp;
                    &quot;arrival&quot;: \{&amp;
                        &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                        &quot;localDateTime&quot;: &quot;2024-10-12T07:10:00&quot;&amp;
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
                                        &quot;systemCode&quot;: &quot;6X&quot;&amp;
                                    \}, &amp;
                                    &quot;login&quot;: \{&amp;
                                        &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                    \}&amp;
                                \}, &amp;
                                &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                            \}, &amp;
                            &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                        \}, &amp;
                        &quot;id&quot;: &quot;6X-562-2024-10-12-NCE-LHR&quot;&amp;
                    \}, &amp;
                    &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                    &quot;deliveries&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-BKG-1&quot;, &amp;
                            &quot;distributionId&quot;: &quot;600D03C700038DCD&quot;, &amp;
                            &quot;traveler&quot;: \{&amp;
                                &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                                &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
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
                &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-2&quot;, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;freeFlowFormat&quot;: &quot;TEST&quot;, &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}, &amp;
            \{&amp;
                &quot;type&quot;: &quot;contact&quot;, &amp;
                &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-10&quot;, &amp;
                &quot;purpose&quot;: [&amp;
                    &quot;STANDARD&quot;&amp;
                ], &amp;
                &quot;freeFlowFormat&quot;: &quot;0660660660&quot;, &amp;
                &quot;travelerRefs&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ]&amp;
            \}&amp;
        ], &amp;
        &quot;automatedProcesses&quot;: [&amp;
            \{&amp;
                &quot;type&quot;: &quot;automated-process&quot;, &amp;
                &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-TK-3&quot;, &amp;
                &quot;code&quot;: &quot;OK&quot;, &amp;
                &quot;dateTime&quot;: &quot;2024-08-20T00:00:00&quot;, &amp;
                &quot;office&quot;: \{&amp;
                    &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
                \}, &amp;
                &quot;travelers&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                        &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                    \}&amp;
                ], &amp;
                &quot;products&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;product&quot;, &amp;
                        &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AIR-1&quot;, &amp;
                        &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                    \}&amp;
                ]&amp;
            \}&amp;
        ]&amp;
    \}&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="14" responseEndLine="234" responseBeginLine="223" endLine="222" beginLine="216" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:52.251951 - 20 Aug 2024"><TEXT><![CDATA[GET /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[ HTTP/1.1&amp;
Content-Type: text/plain&amp;
Debug-format: json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header2"><VALUE><![CDATA[eyJub25jZSI6Ik5EazFNamszT1RZMk16ZzFNREF5TVE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMjBUMDg6NDY6NDIuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoicHNheDNhenBjYWZZWTJkdURkUnFNSGlyR2pzPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
]]></TEXT></QUERY><COMPARISON compareAt="10:46:52.525893 - 20 Aug 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KPOZ6IIDQ4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1569]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;reference&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;, &amp;
    &quot;version&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;, &amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_protobuf%=.*}]]></EXPRESSION><VALUE><![CDATA[ChE4SzNNUkctMjAyNC0wOC0yMBIDcG5yGgY4SzNNUkciATI6VRoUMjAyNC0wOC0yMFQwODo0NjowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOC0yMFQwODo0Njo1MVp6yQEKC3N0YWtlaG9sZGVyEho4SzNNUkctMjAyNC0wOC0yMC1QTlItTk0tMSIMEgRUTE1EGgRBQ0FIcj0KB2NvbnRhY3QSGzhLM01SRy0yMDI0LTA4LTIwLVBOUi1BUC0xMBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzcjwKB2NvbnRhY3QSGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1BUC0yGhVwcm9jZXNzZWRQbnIuY29udGFjdHOiARISEDYxMENGM0M3MDAwMTM0OEGCAcQCCgdwcm9kdWN0EAEaGzhLM01SRy0yMDI0LTA4LTIwLVBOUi1BSVItMSKZAgoaCgNOQ0UaEzIwMjQtMTAtMTJUMDY6MDA6MDASGgoDTEhSGhMyMDI0LTEwLTEyVDA3OjEwOjAwIk0KCQoCNlgSAzU2MhIlCgFZEgMKAVkaEgoAEgwKBBoCNlgSBCoCRlIgASIHRUNPTk9NWTIZNlgtNTYyLTIwMjQtMTAtMTItTkNFLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzhLM01SRy0yMDI0LTA4LTIwLVBOUi1CS0ctMRoQNjAwRDAzQzcwMDAzOERDRFpBCgtzdGFrZWhvbGRlchIaOEszTVJHLTIwMjQtMDgtMjAtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgEAsgFzCgdjb250YWN0Eho4SzNNUkctMjAyNC0wOC0yMC1QTlItQVAtMkIBAVoGCgRURVNUYkEKC3N0YWtlaG9sZGVyEho4SzNNUkctMjAyNC0wOC0yMC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBegoHY29udGFjdBIbOEszTVJHLTIwMjQtMDgtMjAtUE5SLUFQLTEwQgEBWgwKCjA2NjA2NjA2NjBiQQoLc3Rha2Vob2xkZXISGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1USy0zGAUiEzIwMjQtMDgtMjBUMDA6MDA6MDAqCwoJTkNFNlgwMTAwWkEKC3N0YWtlaG9sZGVyEho4SzNNUkctMjAyNC0wOC0yMC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0Ehs4SzNNUkctMjAyNC0wOC0yMC1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="259" responseBeginLine="252" endLine="250" beginLine="244" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:52.528903 - 20 Aug 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header3"><VALUE><![CDATA[eyJub25jZSI6Ik5qTXlORE15TkRBME9Ea3pNak01Tmc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMjBUMDg6NDY6NDIuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiTk16UmoyZC9hU0RUODZNVWE2eEg4eDhnU3M0PSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[ChE4SzNNUkctMjAyNC0wOC0yMBIDcG5yGgY4SzNNUkciATI6VRoUMjAyNC0wOC0yMFQwODo0NjowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOC0yMFQwODo0Njo1MVp6yQEKC3N0YWtlaG9sZGVyEho4SzNNUkctMjAyNC0wOC0yMC1QTlItTk0tMSIMEgRUTE1EGgRBQ0FIcj0KB2NvbnRhY3QSGzhLM01SRy0yMDI0LTA4LTIwLVBOUi1BUC0xMBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzcjwKB2NvbnRhY3QSGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1BUC0yGhVwcm9jZXNzZWRQbnIuY29udGFjdHOiARISEDYxMENGM0M3MDAwMTM0OEGCAcQCCgdwcm9kdWN0EAEaGzhLM01SRy0yMDI0LTA4LTIwLVBOUi1BSVItMSKZAgoaCgNOQ0UaEzIwMjQtMTAtMTJUMDY6MDA6MDASGgoDTEhSGhMyMDI0LTEwLTEyVDA3OjEwOjAwIk0KCQoCNlgSAzU2MhIlCgFZEgMKAVkaEgoAEgwKBBoCNlgSBCoCRlIgASIHRUNPTk9NWTIZNlgtNTYyLTIwMjQtMTAtMTItTkNFLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzhLM01SRy0yMDI0LTA4LTIwLVBOUi1CS0ctMRoQNjAwRDAzQzcwMDAzOERDRFpBCgtzdGFrZWhvbGRlchIaOEszTVJHLTIwMjQtMDgtMjAtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgEAsgFzCgdjb250YWN0Eho4SzNNUkctMjAyNC0wOC0yMC1QTlItQVAtMkIBAVoGCgRURVNUYkEKC3N0YWtlaG9sZGVyEho4SzNNUkctMjAyNC0wOC0yMC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBegoHY29udGFjdBIbOEszTVJHLTIwMjQtMDgtMjAtUE5SLUFQLTEwQgEBWgwKCjA2NjA2NjA2NjBiQQoLc3Rha2Vob2xkZXISGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1USy0zGAUiEzIwMjQtMDgtMjBUMDA6MDA6MDAqCwoJTkNFNlgwMTAwWkEKC3N0YWtlaG9sZGVyEho4SzNNUkctMjAyNC0wOC0yMC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0Ehs4SzNNUkctMjAyNC0wOC0yMC1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" validate="manual" matchMessage="Match failed with error code 1: Callback rejected:Match function exits on unspecified Error." compareAt="10:46:52.670395 - 20 Aug 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KPOZ9IIDQ4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2364]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8K3MRG-2024-08-20&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8K3MRG&quot;, &amp;
    &quot;version&quot;: &quot;2&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-20T08:46:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;, &amp;
                &quot;iataNumber&quot;: &quot;00631002&quot;, &amp;
                &quot;systemCode&quot;: &quot;6X&quot;, &amp;
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
        &quot;dateTime&quot;: &quot;2024-08-20T08:46:51Z&quot;&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;TLMD&quot;, &amp;
                    &quot;lastName&quot;: &quot;ACAH&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-10&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610CF3C70001348A&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-12T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-12T07:10:00&quot;&amp;
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
                                    &quot;systemCode&quot;: &quot;6X&quot;&amp;
                                \}, &amp;
                                &quot;login&quot;: \{&amp;
                                    &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                        \}, &amp;
                        &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-562-2024-10-12-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;600D03C700038DCD&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;TEST&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-10&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;0660660660&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-08-20T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" responseEndLine="274" responseBeginLine="270" endLine="268" beginLine="267" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:52.672540 - 20 Aug 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 176: A character does not match, expected &apos;1&apos;, received &apos;6&apos;." compareAt="10:46:53.066642 - 20 Aug 2024"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 20AUG24/0846]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?AP}]]></EXPRESSION><VALUE><![CDATA[  1.ACAH/TLMD&amp;
  2  6X 562 Y 12OCT 6 NCELHR HK1  0600 0710  12OCT  E  6X/8K3MRG&amp;
  3 AP]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ TEST&amp;
  4 AP 06]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[12345678]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[60660660]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  5 TK OK20AUG/NCE6X0100&amp;
  6 OPC-11OCT:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
  * ES/G 20AUG/YGSU/NCE6X0100&amp;
    NCE6X0100-B&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="17" responseEndLine="294" responseBeginLine="292" endLine="290" beginLine="286" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:53.118199 - 20 Aug 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:46:53.371629 - 20 Aug 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8K3MRG::200824:0846&apos;&amp;
RSI+RP:YGSU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:1127YG:200824:00631002:0846&apos;&amp;
LFT+3:P12+--- RLR ---&apos;&amp;
STX+RLR&apos;&amp;
UID+00631002:NCE6X0100+A&apos;&amp;
SYS++6X:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+00631002:NCE6X0100+A&apos;&amp;
SYS++6X:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:10:16&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+ACAH::1+TLMD&apos;&amp;
ETI+:1+UN:Y:Y::ACAH:TLMD&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+121024:0600:121024:0710+NCE+LHR+6X+562:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8K3MRG&apos;&amp;
RPI+1+HK&apos;&amp;
APD+ERJ:0:0210::6+++648:M++M:CM&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+121024:0600:121024:0710+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+TEST&apos;&amp;
EMS++OT:10+AP+4&apos;&amp;
LFT+3:5+0660660660&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:3+TK+5&apos;&amp;
TKE++OK:200824::NCE6X0100&apos;&amp;
EMS++OT:8+OPC+6&apos;&amp;
OPE+NCE6X0100:111024:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:0+ES&apos;&amp;
ISI+NCE6X0100:B+200824:YGSU:NCE6X0100+G]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="18" endLine="304" beginLine="303" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 1
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:53.373598 - 20 Aug 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="10:46:53.423633 - 20 Aug 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240820:0846+012ETECP830002+00LH2A3GFX0002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+********&apos;&amp;
UCI+00LH2A3GFX0002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+012ETECP830002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18"><QUERY filename="" loop="0" sentAt="10:46:53.424550 - 20 Aug 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="336" responseBeginLine="323" endLine="320" beginLine="314" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:53.563044 - 20 Aug 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[20AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:46:53.944134 - 20 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[20AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240820\:08\:46\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:20:08:46:51]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4637641448]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:08:20:08:46:51]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="356" responseBeginLine="350" endLine="349" beginLine="345" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:54.006573 - 20 Aug 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4637641448]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:08:20:08:46:51]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:46:54.077917 - 20 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4637641448]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:20:08:46:51]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1140]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xD4\x08\x12\xF7\x07\x0A\x118K3MRG-2024-08-20\x12\x03pnr\x1A\x068K3MRG&quot;\x011:u\x1A\x142024-08-20T08:46:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x041127\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x1E1APUB/ATL/RSI-0001AA/NCE1A0955J4\x1A\x142024-08-20T08:46:50Z&quot;\x0D\x0A\x0B\x0A\x09NCE1A0238*\x0D1APUB/ATL/RSIz\x8A\x01\x0A\x0Bstakeholder\x12\x1A8K3MRG-2024-08-20-PNR-NM-1&quot;\x0C\x12\x04TLMD\x1A\x04ACAHr&lt;\x0A\x07contact\x12\x1A8K3MRG-2024-08-20-PNR-AP-2\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x10610CF3C70001348A\x82\x01\xC8\x02\x0A\x07product\x10\x01\x1A\x1B8K3MRG-2024-08-20-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-10-12T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132024-10-12T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03562\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-562-2024-10-12-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8K3MRG-2024-08-20-PNR-BKG-1\x1A\x10600D03C700038DCDZA\x0A\x0Bstakeholder\x12\x1A8K3MRG-2024-08-20-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01r\x0A\x07contact\x12\x1A8K3MRG-2024-08-20-PNR-AP-2@\x01Z\x06\x0A\x04TESTbA\x0A\x0Bstakeholder\x12\x1A8K3MRG-2024-08-20-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8K3MRG-2024-08-20-PNR-TK-3\x18\x05&quot;\x132024-08-20T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A8K3MRG-2024-08-20-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8K3MRG-2024-08-20-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068K3MRG\x1A\x011&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="384" responseBeginLine="377" endLine="375" beginLine="370" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:54.079223 - 20 Aug 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline_4"><VALUE><![CDATA[eyJub25jZSI6Ik1qY3pOek00TURjeU9USTNNakkyTlE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMjBUMDg6NDY6NDIuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJuMU9SKzlHaGR2QzIxblFuUHg2dndtb3NQQ0k9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4SzNNUkctMjAyNC0wOC0yMBIDcG5yGgY4SzNNUkciATE6dRoUMjAyNC0wOC0yMFQwODo0NjowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0UqHjFBUFVCL0FUTC9SU0ktMDAwMUFBL05DRTFBMDk1NUo0GhQyMDI0LTA4LTIwVDA4OjQ2OjUwWiINCgsKCU5DRTFBMDIzOCoNMUFQVUIvQVRML1JTSXqKAQoLc3Rha2Vob2xkZXISGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1OTS0xIgwSBFRMTUQaBEFDQUhyPAoHY29udGFjdBIaOEszTVJHLTIwMjQtMDgtMjAtUE5SLUFQLTIaFXByb2Nlc3NlZFBuci5jb250YWN0c6IBEhIQNjEwQ0YzQzcwMDAxMzQ4QYIByAIKB3Byb2R1Y3QQARobOEszTVJHLTIwMjQtMDgtMjAtUE5SLUFJUi0xIp0CChoKA05DRRoTMjAyNC0xMC0xMlQwNjowMDowMBIaCgNMSFIaEzIwMjQtMTAtMTJUMDc6MTA6MDAiTwoJCgI2WBIDNTYyEicKAVkSAwoBWRoUCgIIABIMCgQaAjZYEgQqAkZSIAEiB0VDT05PTVkyGTZYLTU2Mi0yMDI0LTEwLTEyLU5DRS1MSFJKAkhLYoQBChBzZWdtZW50LWRlbGl2ZXJ5Ehs4SzNNUkctMjAyNC0wOC0yMC1QTlItQktHLTEaEDYwMEQwM0M3MDAwMzhEQ0RaQQoLc3Rha2Vob2xkZXISGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzigEBRZIBAggAsgFyCgdjb250YWN0Eho4SzNNUkctMjAyNC0wOC0yMC1QTlItQVAtMkABWgYKBFRFU1RiQQoLc3Rha2Vob2xkZXISGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGjhLM01SRy0yMDI0LTA4LTIwLVBOUi1USy0zGAUiEzIwMjQtMDgtMjBUMDA6MDA6MDAqCwoJTkNFNlgwMTAwWkEKC3N0YWtlaG9sZGVyEho4SzNNUkctMjAyNC0wOC0yMC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0Ehs4SzNNUkctMjAyNC0wOC0yMC1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" validate="manual" matchMessage="Match failed with error code 1: Callback rejected:Match function exits on unspecified Error." compareAt="10:46:54.229414 - 20 Aug 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KPOZFIIDQ6]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2181]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8K3MRG-2024-08-20&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8K3MRG&quot;, &amp;
    &quot;version&quot;: &quot;1&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-20T08:46:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;, &amp;
                &quot;iataNumber&quot;: &quot;00631002&quot;, &amp;
                &quot;systemCode&quot;: &quot;6X&quot;, &amp;
                &quot;agentType&quot;: &quot;AIRLINE&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;1127&quot;, &amp;
                &quot;initials&quot;: &quot;YG&quot;, &amp;
                &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                &quot;countryCode&quot;: &quot;FR&quot;, &amp;
                &quot;cityCode&quot;: &quot;NCE&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;1APUB/ATL/RSI-0001AA/NCE1A0955&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-20T08:46:50Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0238&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;1APUB/ATL/RSI&quot;&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;TLMD&quot;, &amp;
                    &quot;lastName&quot;: &quot;ACAH&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610CF3C70001348A&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-12T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-12T07:10:00&quot;&amp;
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
                                    &quot;systemCode&quot;: &quot;6X&quot;&amp;
                                \}, &amp;
                                &quot;login&quot;: \{&amp;
                                    &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                        \}, &amp;
                        &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-562-2024-10-12-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;600D03C700038DCD&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;TEST&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-08-20T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8K3MRG-2024-08-20-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="22" endLine="395" beginLine="394" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:54.232472 - 20 Aug 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8K3MRG]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:46:54.453920 - 20 Aug 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  20AUG24/0846Z   8K3MRG&amp;
  1.ACAH/TLMD&amp;
  2  6X 562 Y 12OCT 6 NCELHR HK1  0600 0710  12OCT  E  6X/8K3MRG&amp;
  3 AP TEST&amp;
  4 AP 0660660660&amp;
  5 TK OK20AUG/NCE6X0100&amp;
  6 OPC-11OCT:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
  * ES/G 20AUG/YGSU/NCE6X0100&amp;
    NCE6X0100-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="396" beginLine="395" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:54.454182 - 20 Aug 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="10:46:54.678973 - 20 Aug 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  20AUG24/0846Z   8K3MRG&amp;
  1.ACAH/TLMD&amp;
  2 AP TEST&amp;
  3 AP 0660660660&amp;
  4 TK OK20AUG/NCE6X0100&amp;
  * ES/G 20AUG/YGSU/NCE6X0100&amp;
    NCE6X0100-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="397" beginLine="396" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:54.679383 - 20 Aug 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="10:46:55.105886 - 20 Aug 2024" filename="">END OF TRANSACTION COMPLETE - 8K3MRG&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="398" beginLine="397" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:55.106361 - 20 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:46:55.170594 - 20 Aug 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="403" beginLine="402" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:55.170778 - 20 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:46:55.292763 - 20 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="404" beginLine="403" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/Elements_Update_Feed_testing.cry" loop="0" sentAt="10:46:55.293231 - 20 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:46:55.361078 - 20 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">24911</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">5921</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.964286</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">8788</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.777</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">5496.66</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">62</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="CPS" name="Conversations/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">3</STATISTIC_ELEMENT></STATISTIC></xml>