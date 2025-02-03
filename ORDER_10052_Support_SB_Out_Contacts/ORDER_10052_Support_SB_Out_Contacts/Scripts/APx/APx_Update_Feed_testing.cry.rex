<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry"><SCRIPT type="Initialize">import json
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

</SCRIPT><TRANSACTION transactionCounter="1" endLine="137" beginLine="136" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:20.545162 - 19 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="11:11:20.591604 - 19 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="138" beginLine="137" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:20.592161 - 19 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="11:11:20.642891 - 19 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="139" beginLine="138" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:20.643516 - 19 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="11:11:20.709250 - 19 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="146" beginLine="145" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:20.709625 - 19 Aug 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="11:11:20.762258 - 19 Aug 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="148" beginLine="147" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:22.766461 - 19 Aug 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="11:11:22.818830 - 19 Aug 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="152" responseBeginLine="152" endLine="150" beginLine="149" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:22.819636 - 19 Aug 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[****************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="11:11:23.078696 - 19 Aug 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/19AUG/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="159" beginLine="158" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><COMMENT> 2. Create simple PNR with mandatory elements</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:23.080238 - 19 Aug 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1ADVN/ZXHK]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="11:11:23.194117 - 19 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.ADVN/ZXHK&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="160" beginLine="159" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:23.194823 - 19 Aug 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight_6X_daily.book(1)}]]></EXPRESSION><VALUE><![CDATA[SS6X562Y11OCTNCELHR1]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="11:11:23.616036 - 19 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.ADVN/ZXHK&amp;
  2  6X 562 Y 11OCT 5 NCELHR DK1  0600 0710  11OCT  E  0 ERJ CM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="161" beginLine="160" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:23.616455 - 19 Aug 2024"><TEXT><![CDATA[APTEST]]></TEXT></QUERY><REPLY receiveAt="11:11:23.744810 - 19 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.ADVN/ZXHK&amp;
  2  6X 562 Y 11OCT 5 NCELHR DK1  0600 0710  11OCT  E  0 ERJ CM&amp;
  3 AP TEST&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="162" beginLine="161" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:23.745323 - 19 Aug 2024"><TEXT><![CDATA[TKOK;RFTEST]]></TEXT></QUERY><REPLY receiveAt="11:11:23.920556 - 19 Aug 2024" filename="">RP/NCE6X0100/&amp;
RF TEST&amp;
  1.ADVN/ZXHK&amp;
  2  6X 562 Y 11OCT 5 NCELHR DK1  0600 0710  11OCT  E  0 ERJ CM&amp;
  3 AP TEST&amp;
  4 TK OK19AUG/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="163" beginLine="162" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:23.921137 - 19 Aug 2024"><TEXT><![CDATA[ES/G]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-B]]></TEXT></QUERY><REPLY receiveAt="11:11:24.167843 - 19 Aug 2024" filename="">RP/NCE6X0100/&amp;
RF TEST&amp;
  1.ADVN/ZXHK&amp;
  2  6X 562 Y 11OCT 5 NCELHR DK1  0600 0710  11OCT  E  0 ERJ CM&amp;
  3 AP TEST&amp;
  4 TK OK19AUG/NCE6X0100&amp;
  * ES/G B NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="169" responseBeginLine="167" endLine="164" beginLine="163" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:24.168530 - 19 Aug 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="11:11:24.674780 - 19 Aug 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 19AUG24/0911]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8ELW8P]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  1.ADVN/ZXHK&amp;
  2  6X 562 Y 11OCT 5 NCELHR HK1  0600 0710  11OCT  E  6X/8ELW8P&amp;
  3 AP TEST&amp;
  4 TK OK19AUG/NCE6X0100&amp;
  * ES/G 19AUG/YGSU/NCE6X0100&amp;
    NCE6X0100-B&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="238" responseBeginLine="237" endLine="235" beginLine="178" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:25.683356 - 19 Aug 2024"><TEXT><![CDATA[PATCH /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[/elements HTTP/1.1&amp;
Content-Type: text/plain&amp;
Debug-Format: json&amp;
If-Match: 4&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header"><VALUE><![CDATA[eyJub25jZSI6Ik1EWXdOamt6TXpjMU1UZzVOVGMyTVE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMTlUMDk6MTE6MTYuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiSXRIZWN6UVVLc0VlVVNoTHg0cUdJVnZtNm9RPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
[&amp;
    \{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
\t\t\t&quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-08-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-AP-11&quot;,&amp;
\t\t\t&quot;purpose&quot;: [&amp;
\t\t\t\t&quot;STANDARD&quot;&amp;
\t\t\t],&amp;
\t\t\t&quot;freeFlowFormat&quot;: &quot;0660660660&quot;,&amp;
\t\t\t&quot;travelerRefs&quot;: [&amp;
\t\t\t\t\{&amp;
\t\t\t\t\t&quot;type&quot;: &quot;stakeholder&quot;,&amp;
\t\t\t\t\t&quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-08-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
\t\t\t\t\t&quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
\t\t\t\t\}&amp;
\t\t\t]&amp;
\t\t\}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
        &quot;model&quot;: &quot;Contact&quot;,&amp;
        &quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
\t\t\t&quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-08-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-SSR-9&quot;,&amp;
\t\t\t&quot;purpose&quot;: [&amp;
\t\t\t\t&quot;NOTIFICATION&quot;&amp;
\t\t\t],&amp;
\t\t\t&quot;travelerRefs&quot;: [&amp;
\t\t\t\t\{&amp;
\t\t\t\t\t&quot;type&quot;: &quot;stakeholder&quot;,&amp;
\t\t\t\t\t&quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-08-19]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
\t\t\t\t\t&quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
\t\t\t\t\}&amp;
\t\t\t],&amp;
\t\t\t&quot;isDeclined&quot;: true,&amp;
\t\t\t&quot;security&quot;: \{&amp;
\t\t\t\t&quot;allowedParties&quot;: [&amp;
\t\t\t\t\t\{&amp;
\t\t\t\t\t\t&quot;party&quot;: \{&amp;
\t\t\t\t\t\t\t&quot;company&quot;: \{&amp;
\t\t\t\t\t\t\t\t&quot;code&quot;: &quot;6X&quot;&amp;
\t\t\t\t\t\t\t\}&amp;
\t\t\t\t\t\t\}&amp;
\t\t\t\t\t\}&amp;
\t\t\t\t]&amp;
\t\t\t\}&amp;
\t\t\}&amp;
    \}&amp;
]]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="11:11:26.002170 - 19 Aug 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[412 Other Error]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ama-request-id:0001EZUXGIGK71&amp;
content-length:134&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;errors&quot;: [&amp;
        \{&amp;
            &quot;status&quot;: 412, &amp;
            &quot;detail&quot;: &quot;Please GET the last version of PNR&quot;, &amp;
            &quot;title&quot;: &quot;DESYNCHRONIZED PNR: UNABLE TO PROCEED&quot;, &amp;
            &quot;code&quot;: 29648&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="14" responseEndLine="265" responseBeginLine="254" endLine="253" beginLine="247" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:26.003673 - 19 Aug 2024"><TEXT><![CDATA[GET /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[ HTTP/1.1&amp;
Content-Type: text/plain&amp;
Debug-format: json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header2"><VALUE><![CDATA[eyJub25jZSI6Ik1ERTRPVEF3TURjek16UTRPRFExTXc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMTlUMDk6MTE6MTYuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiYWFQSmtRTXd3dVNVbStEbmdSVWRLRW1TdHZvPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
]]></TEXT></QUERY><COMPARISON compareAt="11:11:26.313139 - 19 Aug 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001EZUXKIGK72]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1317]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;reference&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;, &amp;
    &quot;version&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;, &amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_protobuf%=.*}]]></EXPRESSION><VALUE><![CDATA[ChE4RUxXOFAtMjAyNC0wOC0xORIDcG5yGgY4RUxXOFAiATE6VRoUMjAyNC0wOC0xOVQwOToxMTowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOC0xOVQwOToxMToyNVp6igEKC3N0YWtlaG9sZGVyEho4RUxXOFAtMjAyNC0wOC0xOS1QTlItTk0tMSIMEgRaWEhLGgRBRFZOcjwKB2NvbnRhY3QSGjhFTFc4UC0yMDI0LTA4LTE5LVBOUi1BUC0yGhVwcm9jZXNzZWRQbnIuY29udGFjdHOiARISEDYxMEJGM0M2MDAwMDQyMzaCAcQCCgdwcm9kdWN0EAEaGzhFTFc4UC0yMDI0LTA4LTE5LVBOUi1BSVItMSKZAgoaCgNOQ0UaEzIwMjQtMTAtMTFUMDY6MDA6MDASGgoDTEhSGhMyMDI0LTEwLTExVDA3OjEwOjAwIk0KCQoCNlgSAzU2MhIlCgFZEgMKAVkaEgoAEgwKBBoCNlgSBCoCRlIgASIHRUNPTk9NWTIZNlgtNTYyLTIwMjQtMTAtMTEtTkNFLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzhFTFc4UC0yMDI0LTA4LTE5LVBOUi1CS0ctMRoQNjAwQzkzQzcwMDAwRDA5RlpBCgtzdGFrZWhvbGRlchIaOEVMVzhQLTIwMjQtMDgtMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgEAsgFzCgdjb250YWN0Eho4RUxXOFAtMjAyNC0wOC0xOS1QTlItQVAtMkIBAVoGCgRURVNUYkEKC3N0YWtlaG9sZGVyEho4RUxXOFAtMjAyNC0wOC0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEho4RUxXOFAtMjAyNC0wOC0xOS1QTlItVEstMxgFIhMyMDI0LTA4LTE5VDAwOjAwOjAwKgsKCU5DRTZYMDEwMFpBCgtzdGFrZWhvbGRlchIaOEVMVzhQLTIwMjQtMDgtMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbOEVMVzhQLTIwMjQtMDgtMTktUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="290" responseBeginLine="283" endLine="281" beginLine="275" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:26.315954 - 19 Aug 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header3"><VALUE><![CDATA[eyJub25jZSI6Ik9ESXlOakl5TXpNMk9EazVNRGswTVE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMTlUMDk6MTE6MTYuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoieXFrNHY3WVJMMUFxZS94T3dXNHB3aVZqMGNFPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[ChE4RUxXOFAtMjAyNC0wOC0xORIDcG5yGgY4RUxXOFAiATE6VRoUMjAyNC0wOC0xOVQwOToxMTowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOC0xOVQwOToxMToyNVp6igEKC3N0YWtlaG9sZGVyEho4RUxXOFAtMjAyNC0wOC0xOS1QTlItTk0tMSIMEgRaWEhLGgRBRFZOcjwKB2NvbnRhY3QSGjhFTFc4UC0yMDI0LTA4LTE5LVBOUi1BUC0yGhVwcm9jZXNzZWRQbnIuY29udGFjdHOiARISEDYxMEJGM0M2MDAwMDQyMzaCAcQCCgdwcm9kdWN0EAEaGzhFTFc4UC0yMDI0LTA4LTE5LVBOUi1BSVItMSKZAgoaCgNOQ0UaEzIwMjQtMTAtMTFUMDY6MDA6MDASGgoDTEhSGhMyMDI0LTEwLTExVDA3OjEwOjAwIk0KCQoCNlgSAzU2MhIlCgFZEgMKAVkaEgoAEgwKBBoCNlgSBCoCRlIgASIHRUNPTk9NWTIZNlgtNTYyLTIwMjQtMTAtMTEtTkNFLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzhFTFc4UC0yMDI0LTA4LTE5LVBOUi1CS0ctMRoQNjAwQzkzQzcwMDAwRDA5RlpBCgtzdGFrZWhvbGRlchIaOEVMVzhQLTIwMjQtMDgtMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgEAsgFzCgdjb250YWN0Eho4RUxXOFAtMjAyNC0wOC0xOS1QTlItQVAtMkIBAVoGCgRURVNUYkEKC3N0YWtlaG9sZGVyEho4RUxXOFAtMjAyNC0wOC0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEho4RUxXOFAtMjAyNC0wOC0xOS1QTlItVEstMxgFIhMyMDI0LTA4LTE5VDAwOjAwOjAwKgsKCU5DRTZYMDEwMFpBCgtzdGFrZWhvbGRlchIaOEVMVzhQLTIwMjQtMDgtMTktUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbOEVMVzhQLTIwMjQtMDgtMTktUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" validate="manual" matchMessage="Match failed with error code 1: Callback rejected:Match function exits on unspecified Error." compareAt="11:11:26.469183 - 19 Aug 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001EZUXMIGK72]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2068]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8ELW8P-2024-08-19&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8ELW8P&quot;, &amp;
    &quot;version&quot;: &quot;1&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-19T09:11:00Z&quot;, &amp;
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
        &quot;dateTime&quot;: &quot;2024-08-19T09:11:25Z&quot;&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;ZXHK&quot;, &amp;
                    &quot;lastName&quot;: &quot;ADVN&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610BF3C600004236&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-11T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-11T07:10:00&quot;&amp;
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
                    &quot;id&quot;: &quot;6X-562-2024-10-11-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;600C93C70000D09F&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;TEST&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-08-19T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" responseEndLine="305" responseBeginLine="301" endLine="299" beginLine="298" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:26.470562 - 19 Aug 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 171: A character does not match, expected &apos;A&apos;, received &apos;T&apos;." compareAt="11:11:26.946782 - 19 Aug 2024"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           AA]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 19AUG24/0911]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?AP}]]></EXPRESSION><VALUE><![CDATA[  1.ADVN/ZXHK&amp;
  2  6X 562 Y 11OCT 5 NCELHR HK1  0600 0710  11OCT  E  6X/8ELW8P&amp;
  3 AP]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ TEST&amp;
  4 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[AP 0612345678]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[TK OK19AUG/NCE6X0100]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  5 OPC-10OCT:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
  * ES/G 19AUG/YGSU/NCE6X0100&amp;
    NCE6X0100-B&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="17" responseEndLine="325" responseBeginLine="323" endLine="321" beginLine="317" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:27.005709 - 19 Aug 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="11:11:27.250257 - 19 Aug 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8ELW8P::190824:0911&apos;&amp;
RSI+RP:AASU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:1127YG:190824:00631002:0911&apos;&amp;
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
SEQ++2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:10:15&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+ADVN::1+ZXHK&apos;&amp;
ETI+:1+UN:Y:Y::ADVN:ZXHK&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+111024:0600:111024:0710+NCE+LHR+6X+562:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8ELW8P&apos;&amp;
RPI+1+HK&apos;&amp;
APD+ERJ:0:0210::5+++648:M++M:CM&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+111024:0600:111024:0710+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+TEST&apos;&amp;
EMS++OT:3+TK+4&apos;&amp;
TKE++OK:190824::NCE6X0100&apos;&amp;
EMS++OT:8+OPC+5&apos;&amp;
OPE+NCE6X0100:101024:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:0+ES&apos;&amp;
ISI+NCE6X0100:B+190824:YGSU:NCE6X0100+G]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="18" endLine="335" beginLine="334" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 1
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:27.251781 - 19 Aug 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="11:11:27.311181 - 19 Aug 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240819:0911+0128NFD4390002+00LH2A1MWV0002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+********&apos;&amp;
UCI+00LH2A1MWV0002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+0128NFD4390002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18"><QUERY filename="" loop="0" sentAt="11:11:27.312603 - 19 Aug 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="367" responseBeginLine="354" endLine="351" beginLine="345" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:27.450601 - 19 Aug 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[19AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="11:11:27.562299 - 19 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[19AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240819\:09\:11\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:19:09:11:24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4634285978]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:08:19:09:11:24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="387" responseBeginLine="381" endLine="380" beginLine="376" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:27.613661 - 19 Aug 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4634285978]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:08:19:09:11:24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="11:11:27.673801 - 19 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4634285978]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:19:09:11:24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1521]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xD1\x0B\x12\xF4\x0A\x0A\x118ELW8P-2024-08-19\x12\x03pnr\x1A\x068ELW8P&quot;\x010:g\x1A\x142024-08-19T09:11:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x041127\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x10TEST-1A/YGARNIERJ\xBE\x03\x1A\x142024-08-19T09:11:24Z&quot;\x0D\x0A\x0B\x0A\x09NCE6X0100*\x04TEST:H\x12\x10historyChangeLog\x18\x01&quot;\x1A8ELW8P-2024-08-19-PNR-NM-1*\x0Bstakeholder2\x09travelers:D\x12\x10historyChangeLog\x18\x01&quot;\x1B8ELW8P-2024-08-19-PNR-AIR-1*\x07product2\x08products:c\x12\x10historyChangeLog\x18\x01&quot;\x1B8ELW8P-2024-08-19-PNR-BKG-1*\x10segment-delivery2\x1Eproducts/airSegment/deliveries:C\x12\x10historyChangeLog\x18\x01&quot;\x1A8ELW8P-2024-08-19-PNR-AP-2*\x07contact2\x08contacts:W\x12\x10historyChangeLog\x18\x01&quot;\x1A8ELW8P-2024-08-19-PNR-TK-3*\x11automated-process2\x12automatedProcessesz\x8A\x01\x0A\x0Bstakeholder\x12\x1A8ELW8P-2024-08-19-PNR-NM-1&quot;\x0C\x12\x04ZXHK\x1A\x04ADVNr&lt;\x0A\x07contact\x12\x1A8ELW8P-2024-08-19-PNR-AP-2\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x10610BF3C600004236\x82\x01\xC8\x02\x0A\x07product\x10\x01\x1A\x1B8ELW8P-2024-08-19-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-10-11T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132024-10-11T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03562\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-562-2024-10-11-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8ELW8P-2024-08-19-PNR-BKG-1\x1A\x10600C93C70000D09FZA\x0A\x0Bstakeholder\x12\x1A8ELW8P-2024-08-19-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01r\x0A\x07contact\x12\x1A8ELW8P-2024-08-19-PNR-AP-2@\x01Z\x06\x0A\x04TESTbA\x0A\x0Bstakeholder\x12\x1A8ELW8P-2024-08-19-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8ELW8P-2024-08-19-PNR-TK-3\x18\x05&quot;\x132024-08-19T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A8ELW8P-2024-08-19-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8ELW8P-2024-08-19-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068ELW8P\x1A\x010&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="415" responseBeginLine="408" endLine="406" beginLine="401" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:27.675271 - 19 Aug 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline_4"><VALUE><![CDATA[eyJub25jZSI6Ik1qYzBOVEExTVRrMk56YzRNRE00Tnc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMTlUMDk6MTE6MTYuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJkMjlxVjE4SEx3VlIvaEo3WFRURmlqeEp2ZTA9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4RUxXOFAtMjAyNC0wOC0xORIDcG5yGgY4RUxXOFAiATA6ZxoUMjAyNC0wOC0xOVQwOToxMTowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0UqEFRFU1QtMUEvWUdBUk5JRVJKvgMaFDIwMjQtMDgtMTlUMDk6MTE6MjRaIg0KCwoJTkNFNlgwMTAwKgRURVNUOkgSEGhpc3RvcnlDaGFuZ2VMb2cYASIaOEVMVzhQLTIwMjQtMDgtMTktUE5SLU5NLTEqC3N0YWtlaG9sZGVyMgl0cmF2ZWxlcnM6RBIQaGlzdG9yeUNoYW5nZUxvZxgBIhs4RUxXOFAtMjAyNC0wOC0xOS1QTlItQUlSLTEqB3Byb2R1Y3QyCHByb2R1Y3RzOmMSEGhpc3RvcnlDaGFuZ2VMb2cYASIbOEVMVzhQLTIwMjQtMDgtMTktUE5SLUJLRy0xKhBzZWdtZW50LWRlbGl2ZXJ5Mh5wcm9kdWN0cy9haXJTZWdtZW50L2RlbGl2ZXJpZXM6QxIQaGlzdG9yeUNoYW5nZUxvZxgBIho4RUxXOFAtMjAyNC0wOC0xOS1QTlItQVAtMioHY29udGFjdDIIY29udGFjdHM6VxIQaGlzdG9yeUNoYW5nZUxvZxgBIho4RUxXOFAtMjAyNC0wOC0xOS1QTlItVEstMyoRYXV0b21hdGVkLXByb2Nlc3MyEmF1dG9tYXRlZFByb2Nlc3Nlc3qKAQoLc3Rha2Vob2xkZXISGjhFTFc4UC0yMDI0LTA4LTE5LVBOUi1OTS0xIgwSBFpYSEsaBEFEVk5yPAoHY29udGFjdBIaOEVMVzhQLTIwMjQtMDgtMTktUE5SLUFQLTIaFXByb2Nlc3NlZFBuci5jb250YWN0c6IBEhIQNjEwQkYzQzYwMDAwNDIzNoIByAIKB3Byb2R1Y3QQARobOEVMVzhQLTIwMjQtMDgtMTktUE5SLUFJUi0xIp0CChoKA05DRRoTMjAyNC0xMC0xMVQwNjowMDowMBIaCgNMSFIaEzIwMjQtMTAtMTFUMDc6MTA6MDAiTwoJCgI2WBIDNTYyEicKAVkSAwoBWRoUCgIIABIMCgQaAjZYEgQqAkZSIAEiB0VDT05PTVkyGTZYLTU2Mi0yMDI0LTEwLTExLU5DRS1MSFJKAkhLYoQBChBzZWdtZW50LWRlbGl2ZXJ5Ehs4RUxXOFAtMjAyNC0wOC0xOS1QTlItQktHLTEaEDYwMEM5M0M3MDAwMEQwOUZaQQoLc3Rha2Vob2xkZXISGjhFTFc4UC0yMDI0LTA4LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzigEBRZIBAggAsgFyCgdjb250YWN0Eho4RUxXOFAtMjAyNC0wOC0xOS1QTlItQVAtMkABWgYKBFRFU1RiQQoLc3Rha2Vob2xkZXISGjhFTFc4UC0yMDI0LTA4LTE5LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGjhFTFc4UC0yMDI0LTA4LTE5LVBOUi1USy0zGAUiEzIwMjQtMDgtMTlUMDA6MDA6MDAqCwoJTkNFNlgwMTAwWkEKC3N0YWtlaG9sZGVyEho4RUxXOFAtMjAyNC0wOC0xOS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0Ehs4RUxXOFAtMjAyNC0wOC0xOS1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" validate="manual" matchMessage="Match failed with error code 1: Callback rejected:Match function exits on unspecified Error." compareAt="11:11:27.840698 - 19 Aug 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001EZUXTIGK73]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2890]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8ELW8P-2024-08-19&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8ELW8P&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-19T09:11:00Z&quot;, &amp;
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
        &quot;comment&quot;: &quot;TEST-1A/YGARNIER&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-19T09:11:24Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;TEST&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
                &quot;elementType&quot;: &quot;stakeholder&quot;, &amp;
                &quot;path&quot;: &quot;travelers&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ELW8P-2024-08-19-PNR-AIR-1&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ELW8P-2024-08-19-PNR-BKG-1&quot;, &amp;
                &quot;elementType&quot;: &quot;segment-delivery&quot;, &amp;
                &quot;path&quot;: &quot;products/airSegment/deliveries&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ELW8P-2024-08-19-PNR-AP-2&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ELW8P-2024-08-19-PNR-TK-3&quot;, &amp;
                &quot;elementType&quot;: &quot;automated-process&quot;, &amp;
                &quot;path&quot;: &quot;automatedProcesses&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;ZXHK&quot;, &amp;
                    &quot;lastName&quot;: &quot;ADVN&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610BF3C600004236&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-11T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-10-11T07:10:00&quot;&amp;
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
                    &quot;id&quot;: &quot;6X-562-2024-10-11-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;600C93C70000D09F&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;TEST&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-08-19T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8ELW8P-2024-08-19-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="22" endLine="426" beginLine="425" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:27.842366 - 19 Aug 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ELW8P]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="11:11:28.140829 - 19 Aug 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  19AUG24/0911Z   8ELW8P&amp;
  1.ADVN/ZXHK&amp;
  2  6X 562 Y 11OCT 5 NCELHR HK1  0600 0710  11OCT  E  6X/8ELW8P&amp;
  3 AP TEST&amp;
  4 TK OK19AUG/NCE6X0100&amp;
  5 OPC-10OCT:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
  * ES/G 19AUG/YGSU/NCE6X0100&amp;
    NCE6X0100-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="427" beginLine="426" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:28.141570 - 19 Aug 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="11:11:28.508313 - 19 Aug 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  19AUG24/0911Z   8ELW8P&amp;
  1.ADVN/ZXHK&amp;
  2 AP TEST&amp;
  3 TK OK19AUG/NCE6X0100&amp;
  * ES/G 19AUG/YGSU/NCE6X0100&amp;
    NCE6X0100-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="428" beginLine="427" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:28.508953 - 19 Aug 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="11:11:28.922614 - 19 Aug 2024" filename="">END OF TRANSACTION COMPLETE - 8ELW8P&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="429" beginLine="428" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:28.922888 - 19 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="11:11:28.990432 - 19 Aug 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="434" beginLine="433" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:28.990658 - 19 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="11:11:29.122468 - 19 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="435" beginLine="434" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/APx/APx_Update_Feed_testing.cry" loop="0" sentAt="11:11:29.122934 - 19 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="11:11:29.218470 - 19 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">19775</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">6582</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.964286</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">8675.3</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.525</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">5377.86</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">61</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="CPS" name="Conversations/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">4</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">4</STATISTIC_ELEMENT></STATISTIC></xml>