<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry"><SCRIPT type="Initialize">import json
import re
import generic_lib

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
        assert_equal(expected=&quot;NCE6X0100&quot;, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        assert_equal(actual=len(openpnr[&apos;contacts&apos;]), expected=3, item_name=&apos;number of contacts&apos;)
        contacts_1 = openpnr[&apos;contacts&apos;][0]
        contacts_2 = openpnr[&apos;contacts&apos;][1]
        contacts_3 = openpnr[&apos;contacts&apos;][2]

        #Check service data for AB and AM element
        assert_equal(actual=contacts_1[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_1[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_1[&apos;purpose&apos;], expected= [u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_1[&apos;freeFlowFormat&apos;], expected=&apos;0660660660&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_2[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_2[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AB-9&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_2[&apos;addresseeName&apos;][&apos;fullName&apos;], expected=&quot;MR SIMPSON&quot;, item_name=&apos;contact addresseeName/fullName&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;category&apos;], expected= &quot;BUSINESS&quot;, item_name=&apos;contact address/category&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;lines&apos;][0], expected= &quot;LONG ST&quot;, item_name=&apos;contact address/lines&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;postalCode&apos;], expected= &quot;BS7890&quot;, item_name=&apos;contact address/postalCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;countryCode&apos;], expected= &quot;US&quot;, item_name=&apos;contact address/countryCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;cityName&apos;], expected= &quot;NEWTOWN&quot;, item_name=&apos;contact address/cityName&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;stateCode&apos;], expected= &quot;NY&quot;, item_name=&apos;contact address/stateCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;postalBox&apos;], expected= &quot;12344&quot;, item_name=&apos;contact address/postalBox&apos;)
        assert_equal(actual=contacts_2[&apos;purpose&apos;][0], expected= &quot;BILLING&quot;, item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_2[&apos;addresseeCompany&apos;][&apos;name&apos;], expected= &quot;GREAT COMPANY&quot;, item_name=&apos;contact addresseeCompany/name&apos;)

        assert_equal(actual=contacts_3[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_3[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AM-10&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_3[&apos;addresseeName&apos;][&apos;fullName&apos;], expected=&quot;MR SIMPSON&quot;, item_name=&apos;contact addresseeName/fullName&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;category&apos;], expected= &quot;BUSINESS&quot;, item_name=&apos;contact address/category&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;lines&apos;][0], expected= &quot;12 LONG STREET&quot;, item_name=&apos;contact address/lines&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;postalCode&apos;], expected= &quot;BS7890&quot;, item_name=&apos;contact address/postalCode&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;countryCode&apos;], expected= &quot;US&quot;, item_name=&apos;contact address/countryCode&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;cityName&apos;], expected= &quot;NEWTOWN&quot;, item_name=&apos;contact address/cityName&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;stateCode&apos;], expected= &quot;NY&quot;, item_name=&apos;contact address/stateCode&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;postalBox&apos;], expected= &quot;12344&quot;, item_name=&apos;contact address/postalBox&apos;)
        assert_equal(actual=contacts_3[&apos;purpose&apos;][0], expected= &quot;MAILING&quot;, item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_3[&apos;addresseeCompany&apos;][&apos;name&apos;], expected= &quot;GREAT COMPANY&quot;, item_name=&apos;contact addresseeCompany/name&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="111" beginLine="110" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:54.418544 - 11 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:45:54.490410 - 11 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="112" beginLine="111" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:54.492336 - 11 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:45:54.566717 - 11 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="113" beginLine="112" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:54.566926 - 11 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:45:54.659154 - 11 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="120" beginLine="119" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:54.659502 - 11 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:45:54.739524 - 11 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="122" beginLine="121" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:56.754315 - 11 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:45:56.834258 - 11 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="126" responseBeginLine="126" endLine="124" beginLine="123" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:56.834580 - 11 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="10:45:57.061415 - 11 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/11SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="133" beginLine="132" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><COMMENT> 2. Create simple PNR with mandatory elements</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:57.061764 - 11 Sep 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1ATBU/MYTU]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:45:57.185784 - 11 Sep 2024" filename="">RP/NCE6X0100/&amp;
  1.ATBU/MYTU&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="134" beginLine="133" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:57.186230 - 11 Sep 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight_6X_daily.book(1)}]]></EXPRESSION><VALUE><![CDATA[SS6X562Y03NOVNCELHR1]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:45:57.685316 - 11 Sep 2024" filename="">RP/NCE6X0100/&amp;
  1.ATBU/MYTU&amp;
  2  6X 562 Y 03NOV 7 NCELHR DK1  0600 0710  03NOV  E  0 ERJ CM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="135" beginLine="134" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:57.685765 - 11 Sep 2024"><TEXT><![CDATA[AP 0660660660]]></TEXT></QUERY><REPLY receiveAt="10:45:57.822037 - 11 Sep 2024" filename="">RP/NCE6X0100/&amp;
  1.ATBU/MYTU&amp;
  2  6X 562 Y 03NOV 7 NCELHR DK1  0600 0710  03NOV  E  0 ERJ CM&amp;
  3 AP 0660660660&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="136" beginLine="135" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:57.822142 - 11 Sep 2024"><TEXT><![CDATA[TKOK;RFTEST]]></TEXT></QUERY><REPLY receiveAt="10:45:58.001480 - 11 Sep 2024" filename="">RP/NCE6X0100/&amp;
RF TEST&amp;
  1.ATBU/MYTU&amp;
  2  6X 562 Y 03NOV 7 NCELHR DK1  0600 0710  03NOV  E  0 ERJ CM&amp;
  3 AP 0660660660&amp;
  4 TK OK11SEP/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="142" responseBeginLine="140" endLine="137" beginLine="136" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:58.001794 - 11 Sep 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="10:45:58.487151 - 11 Sep 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 11SEP24/0845]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[94TQF6]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  1.ATBU/MYTU&amp;
  2  6X 562 Y 03NOV 7 NCELHR HK1  0600 0710  03NOV  E  6X/94TQF6&amp;
  3 AP 0660660660&amp;
  4 TK OK11SEP/NCE6X0100&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="242" responseBeginLine="232" endLine="230" beginLine="152" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:59.493152 - 11 Sep 2024"><TEXT><![CDATA[PATCH /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[/elements HTTP/1.1&amp;
Content-Type: application/json&amp;
If-Match: 1&amp;
Debug-Format: json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik9UVXhNVFkxTlRJeE1qTTVPRGs1TlE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMDg6NDU6NDkuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJ1MUhNZktlS2xBRTFnM1VMY0M0cE5FZ3ZHRE09In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
[&amp;
    \{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
\t\t\t&quot;purpose&quot;: [&amp;
            &quot;BILLING&quot;&amp;
\t\t\t],&amp;
\t\t\t&quot;addresseeName&quot;: \{&amp;
\t\t\t\t&quot;fullName&quot;: &quot;MR SIMPSON&quot;&amp;
\t\t\t\},&amp;
\t\t\t&quot;address&quot;: \{&amp;
\t\t\t\t&quot;category&quot;: &quot;BUSINESS&quot;,&amp;
\t\t\t\t&quot;lines&quot;: [&amp;
\t\t\t\t\t&quot;LONG ST&quot;,&amp;
\t\t\t\t\t&quot;TEST TEST&quot;&amp;
\t\t\t\t],&amp;
\t\t\t\t&quot;postalCode&quot;: &quot;BS7890&quot;,&amp;
\t\t\t\t&quot;countryCode&quot;: &quot;US&quot;,&amp;
\t\t\t\t&quot;cityName&quot;: &quot;NEWTOWN&quot;,&amp;
\t\t\t\t&quot;stateCode&quot;: &quot;NY&quot;,&amp;
\t\t\t\t&quot;postalBox&quot;: &quot;12344&quot;&amp;
\t\t\t\},&amp;
\t\t\t&quot;travelerRefs&quot;: [&amp;
\t\t\t\t\{&amp;
\t\t\t\t\t&quot;type&quot;: &quot;stakeholder&quot;,&amp;
\t\t\t\t\t&quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-11]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
\t\t\t\t\t&quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
\t\t\t\t\}&amp;
\t\t\t],&amp;
\t\t\t&quot;addresseeCompany&quot;: \{&amp;
\t\t\t\t&quot;name&quot;: &quot;GREAT COMPANY&quot;&amp;
\t\t\t\}&amp;
\t\t\}&amp;
\t\},&amp;
\t\{&amp;
\t\t&quot;action&quot;: &quot;add&quot;,&amp;
\t\t&quot;model&quot;: &quot;Contact&quot;,&amp;
\t\t&quot;element&quot;: \{&amp;
\t\t\t&quot;type&quot;: &quot;contact&quot;,&amp;
\t\t\t&quot;purpose&quot;: [&amp;
\t\t\t\t&quot;MAILING&quot;&amp;
\t\t\t],&amp;
\t\t\t&quot;addresseeName&quot;: \{&amp;
\t\t\t\t&quot;fullName&quot;: &quot;MR SIMPSON&quot;&amp;
\t\t\t\},&amp;
\t\t\t&quot;address&quot;: \{&amp;
\t\t\t\t&quot;category&quot;: &quot;BUSINESS&quot;,&amp;
\t\t\t\t&quot;lines&quot;: [&amp;
\t\t\t\t\t&quot;12 LONG STREET&quot;,&amp;
\t\t\t\t\t&quot;TEST TEST&quot;&amp;
\t\t\t\t],&amp;
\t\t\t\t&quot;postalCode&quot;: &quot;BS7890&quot;,&amp;
\t\t\t\t&quot;countryCode&quot;: &quot;US&quot;,&amp;
\t\t\t\t&quot;cityName&quot;: &quot;NEWTOWN&quot;,&amp;
\t\t\t\t&quot;stateCode&quot;: &quot;NY&quot;,&amp;
\t\t\t\t&quot;postalBox&quot;: &quot;12344&quot;&amp;
\t\t\t\},&amp;
\t\t\t&quot;travelerRefs&quot;: [&amp;
\t\t\t\t\{&amp;
\t\t\t\t\t&quot;type&quot;: &quot;stakeholder&quot;,&amp;
\t\t\t\t\t&quot;id&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="today"><VALUE><![CDATA[2024-09-11]]></VALUE></VARIABLE><TEXT><![CDATA[-PNR-NM-1&quot;,&amp;
\t\t\t\t\t&quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
\t\t\t\t\}&amp;
\t\t\t],&amp;
\t\t\t&quot;addresseeCompany&quot;: \{&amp;
\t\t\t\t&quot;name&quot;: &quot;GREAT COMPANY&quot;&amp;
\t\t\t\}&amp;
\t\t\}&amp;
\t\}&amp;
]]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="10:45:59.664193 - 11 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[401 Unauthorized]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DM337JN4CN]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
con]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[tent-length:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[content-]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[length:109]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;reference&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    \{&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;version&quot;: &quot;{*}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;status&quot;: 401, &amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[        &quot;code&quot;: 701, &amp;
            &quot;title&quot;: &quot;Wrong authentication credentials.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="270" responseBeginLine="259" endLine="258" beginLine="252" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:59.666784 - 11 Sep 2024"><TEXT><![CDATA[GET /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[ HTTP/1.1&amp;
Content-Type: text/plain&amp;
Debug-format: json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header_airline_2"><VALUE><![CDATA[eyJub25jZSI6Ik1ERXpNamN6T1RjME5UY3pNakU1Tnc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMDg6NDU6NDkuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJWY25ZWjVJcC9mUzhqOERpSi85RnBQeTRGcWs9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="10:45:59.821156 - 11 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[401 Unauthorized]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DM339JN4CN]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
con]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[tent-length:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[content-]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[length:109]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;reference&quot;: &quot;]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    \{&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;version&quot;: &quot;{*}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;status&quot;: 401, &amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;code&quot;: 701, &amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;title&quot;: &quot;Wrong authentication credentials.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="14" responseEndLine="295" responseBeginLine="288" endLine="286" beginLine="280" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:59.823094 - 11 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline_3"><VALUE><![CDATA[eyJub25jZSI6Ik5qYzBOemczTURRNE16WTBNamd5Tnc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMDg6NDU6NDkuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJnb3V1MENzdGFuWDdlaUgyUFk2eDR4NDlscmc9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="10:45:59.986768 - 11 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[401 Unauthorized]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DM33BJN4CN]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
con]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[tent-length:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[etag:1]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
content-]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[length:109]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[    &quot;errors&quot;: [&amp;
        \{&amp;
            &quot;status&quot;: 401, &amp;
            &quot;code&quot;: 701, &amp;
            &quot;title&quot;: &quot;Wrong authentication credentials.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="313" responseBeginLine="307" endLine="304" beginLine="303" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:45:59.988290 - 11 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 76: The pattern match failed." compareAt="10:46:00.550611 - 11 Sep 2024"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           AA]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 11SEP24/0845]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{(local).*?AB} CY-GREAT COMPANY/NA-MR SIMPSON/A1-LONG ST/A2-TEST TEST/&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[  1.ATBU/MYTU&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[  ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[     PO-12344/ZP-BS7890/CI-NEWTOWN/ST-NY/CO-US]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2  6X 562 Y 03NOV 7 NCELHR HK1  0600 0710  03NOV  E  6X/94TQF6]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
  ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[7 AM CY-GREAT COMPANY/NA-MR SIMPSON/A1-12 LONG STREET/A2-TEST]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[3 AP 0660660660]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
  ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[     TEST/PO-12344/ZP-BS7890/CI-NEWTOWN/ST-NY/CO-US]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[4 TK OK11SEP/NCE6X0100]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  5 OPC-11SEP:1047/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" responseEndLine="333" responseBeginLine="331" endLine="329" beginLine="325" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:01.613981 - 11 Sep 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:46:01.980450 - 11 Sep 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:94TQF6::110924:0845&apos;&amp;
RSI+RP:AASU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:1127YG:110924:00631002:0845&apos;&amp;
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
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:11:7&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+ATBU::1+MYTU&apos;&amp;
ETI+:1+UN:Y:Y::ATBU:MYTU&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+031124:0600:031124:0710+NCE+LHR+6X+562:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:94TQF6&apos;&amp;
RPI+1+HK&apos;&amp;
APD+ERJ:0:0210::7+++648:M++M:CM&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+031124:0600:031124:0710+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+0660660660&apos;&amp;
EMS++OT:3+TK+4&apos;&amp;
TKE++OK:110924::NCE6X0100&apos;&amp;
EMS++OT:7+OPC+5&apos;&amp;
OPE+NCE6X0100:110924:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::1047&apos;&amp;
REF+ST:1*PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16"><QUERY filename="" loop="0" sentAt="10:46:01.981429 - 11 Sep 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="17" responseEndLine="366" responseBeginLine="353" endLine="350" beginLine="344" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:02.136571 - 11 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:46:03.062866 - 11 Sep 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240911\:08\:45\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:09:11:08:45:59]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4706914624]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:09:11:08:45:59]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="18" responseEndLine="386" responseBeginLine="380" endLine="379" beginLine="375" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:03.117296 - 11 Sep 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4706914624]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:09:11:08:45:59]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:46:03.184126 - 11 Sep 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4706914624]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:09:11:08:45:59]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1146]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xDA\x08\x12\xFD\x07\x0A\x1194TQF6-2024-09-11\x12\x03pnr\x1A\x0694TQF6&quot;\x011:u\x1A\x142024-09-11T08:45:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x041127\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x1E1APUB/RSI/ATL-0001AA/NCE1A0955J4\x1A\x142024-09-11T08:45:58Z&quot;\x0D\x0A\x0B\x0A\x09NCE1A0238*\x0D1APUB/RSI/ATLz\x8A\x01\x0A\x0Bstakeholder\x12\x1A94TQF6-2024-09-11-PNR-NM-1&quot;\x0C\x12\x04MYTU\x1A\x04ATBUr&lt;\x0A\x07contact\x12\x1A94TQF6-2024-09-11-PNR-AP-2\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x10610A63DD0001209A\x82\x01\xC8\x02\x0A\x07product\x10\x01\x1A\x1B94TQF6-2024-09-11-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-11-03T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132024-11-03T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03562\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-562-2024-11-03-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B94TQF6-2024-09-11-PNR-BKG-1\x1A\x10600AC3DE00001327ZA\x0A\x0Bstakeholder\x12\x1A94TQF6-2024-09-11-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01x\x0A\x07contact\x12\x1A94TQF6-2024-09-11-PNR-AP-2@\x01Z\x0C\x0A\x0A0660660660bA\x0A\x0Bstakeholder\x12\x1A94TQF6-2024-09-11-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A94TQF6-2024-09-11-PNR-TK-3\x18\x05&quot;\x132024-09-11T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A94TQF6-2024-09-11-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B94TQF6-2024-09-11-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x0694TQF6\x1A\x011&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="414" responseBeginLine="407" endLine="405" beginLine="400" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:03.184873 - 11 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline_4"><VALUE><![CDATA[eyJub25jZSI6Ik5EZzJNVGswTVRZNU1qSTVNakkzTWc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMDg6NDU6NDkuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJpYXpLZzdseG9UUkRxa2F6OWtrdFJ1VTVQdE09In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE5NFRRRjYtMjAyNC0wOS0xMRIDcG5yGgY5NFRRRjYiATE6dRoUMjAyNC0wOS0xMVQwODo0NTowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0UqHjFBUFVCL1JTSS9BVEwtMDAwMUFBL05DRTFBMDk1NUo0GhQyMDI0LTA5LTExVDA4OjQ1OjU4WiINCgsKCU5DRTFBMDIzOCoNMUFQVUIvUlNJL0FUTHqKAQoLc3Rha2Vob2xkZXISGjk0VFFGNi0yMDI0LTA5LTExLVBOUi1OTS0xIgwSBE1ZVFUaBEFUQlVyPAoHY29udGFjdBIaOTRUUUY2LTIwMjQtMDktMTEtUE5SLUFQLTIaFXByb2Nlc3NlZFBuci5jb250YWN0c6IBEhIQNjEwQTYzREQwMDAxMjA5QYIByAIKB3Byb2R1Y3QQARobOTRUUUY2LTIwMjQtMDktMTEtUE5SLUFJUi0xIp0CChoKA05DRRoTMjAyNC0xMS0wM1QwNjowMDowMBIaCgNMSFIaEzIwMjQtMTEtMDNUMDc6MTA6MDAiTwoJCgI2WBIDNTYyEicKAVkSAwoBWRoUCgIIABIMCgQaAjZYEgQqAkZSIAEiB0VDT05PTVkyGTZYLTU2Mi0yMDI0LTExLTAzLU5DRS1MSFJKAkhLYoQBChBzZWdtZW50LWRlbGl2ZXJ5Ehs5NFRRRjYtMjAyNC0wOS0xMS1QTlItQktHLTEaEDYwMEFDM0RFMDAwMDEzMjdaQQoLc3Rha2Vob2xkZXISGjk0VFFGNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzigEBRZIBAggAsgF4Cgdjb250YWN0Eho5NFRRRjYtMjAyNC0wOS0xMS1QTlItQVAtMkABWgwKCjA2NjA2NjA2NjBiQQoLc3Rha2Vob2xkZXISGjk0VFFGNi0yMDI0LTA5LTExLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGjk0VFFGNi0yMDI0LTA5LTExLVBOUi1USy0zGAUiEzIwMjQtMDktMTFUMDA6MDA6MDAqCwoJTkNFNlgwMTAwWkEKC3N0YWtlaG9sZGVyEho5NFRRRjYtMjAyNC0wOS0xMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0Ehs5NFRRRjYtMjAyNC0wOS0xMS1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="10:46:03.352350 - 11 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[401 Unauthorized]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DM33FJN4CR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
con]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[tent-length:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[etag:1]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
content-]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[length:109]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[    &quot;errors&quot;: [&amp;
        \{&amp;
            &quot;status&quot;: 401, &amp;
            &quot;code&quot;: 701, &amp;
            &quot;title&quot;: &quot;Wrong authentication credentials.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" endLine="426" beginLine="425" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:03.353196 - 11 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[94TQF6]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:46:03.591648 - 11 Sep 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  11SEP24/0845Z   94TQF6&amp;
  1.ATBU/MYTU&amp;
  2  6X 562 Y 03NOV 7 NCELHR HK1  0600 0710  03NOV  E  6X/94TQF6&amp;
  3 AP 0660660660&amp;
  4 TK OK11SEP/NCE6X0100&amp;
  5 OPC-11SEP:1047/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="21" endLine="427" beginLine="426" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:03.591923 - 11 Sep 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="10:46:03.849888 - 11 Sep 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  11SEP24/0845Z   94TQF6&amp;
  1.ATBU/MYTU&amp;
  2 AP 0660660660&amp;
  3 TK OK11SEP/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="22" endLine="428" beginLine="427" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:03.850023 - 11 Sep 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="10:46:04.237739 - 11 Sep 2024" filename="">END OF TRANSACTION COMPLETE - 94TQF6&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="429" beginLine="428" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:04.237862 - 11 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:46:04.327411 - 11 Sep 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="434" beginLine="433" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:04.327522 - 11 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:46:04.492714 - 11 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="435" beginLine="434" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Update_Feed.cry" loop="0" sentAt="10:46:04.492845 - 11 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:46:04.581224 - 11 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">7197</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">5099</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">25</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.961538</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">10163.8</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.683</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">5880.88</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">57</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">2</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">5</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">5</STATISTIC_ELEMENT></STATISTIC></xml>