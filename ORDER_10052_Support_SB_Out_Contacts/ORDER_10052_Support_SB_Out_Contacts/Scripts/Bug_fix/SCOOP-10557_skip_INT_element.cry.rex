<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry"><SCRIPT type="Initialize">import json
import generic_lib
from lib.openpnr import extract_binary_payload
from lib.json_match import assert_equal, assert_found, assert_not_found, parse_json

RLOC  = generic_lib.generate_rloc()

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
        assert_equal(expected=&quot;SYD6X0102&quot;, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        assert_equal(actual=len(openpnr[&apos;contacts&apos;]), expected=3, item_name=&apos;number of contacts&apos;)
        contacts_1 = openpnr[&apos;contacts&apos;][0]
        contacts_2 = openpnr[&apos;contacts&apos;][1]
        contacts_3 = openpnr[&apos;contacts&apos;][2]

        #Check service data for AB and AM element
        assert_equal(actual=contacts_1[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_1[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_1[&apos;purpose&apos;], expected= [u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_1[&apos;freeFlowFormat&apos;], expected=&apos;+33600000666&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_2[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_2[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AB-3&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_2[&apos;addresseeName&apos;][&apos;fullName&apos;], expected=&quot;MR SIMPSON&quot;, item_name=&apos;contact addresseeName/fullName&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;category&apos;], expected= &quot;BUSINESS&quot;, item_name=&apos;contact address/category&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;lines&apos;][0], expected= &quot;LONG STREET&quot;, item_name=&apos;contact address/lines&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;postalCode&apos;], expected= &quot;BS7890&quot;, item_name=&apos;contact address/postalCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;countryCode&apos;], expected= &quot;US&quot;, item_name=&apos;contact address/countryCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;cityName&apos;], expected= &quot;NEWTOWN&quot;, item_name=&apos;contact address/cityName&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;stateCode&apos;], expected= &quot;NY&quot;, item_name=&apos;contact address/stateCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;postalBox&apos;], expected= &quot;12344&quot;, item_name=&apos;contact address/postalBox&apos;)
        assert_equal(actual=contacts_2[&apos;purpose&apos;][0], expected= &quot;BILLING&quot;, item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_2[&apos;addresseeCompany&apos;][&apos;name&apos;], expected= &quot;GREAT COMPANY&quot;, item_name=&apos;contact addresseeCompany/name&apos;)


        assert_equal(actual=contacts_3[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_3[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AM-4&quot;, item_name=&apos;contact id&apos;)
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

</SCRIPT><TRANSACTION transactionCounter="1" endLine="112" beginLine="111" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:09.959836 - 12 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="16:52:10.005620 - 12 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" responseEndLine="115" responseBeginLine="114" endLine="113" beginLine="112" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:10.006126 - 12 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><COMPARISON compareAt="16:52:10.056630 - 12 Sep 2024" match="OK"><TEXT><![CDATA[SIGN IN&amp;
&gt;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="3" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:10.056864 - 12 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="16:52:10.120023 - 12 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="124" beginLine="123" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:10.120495 - 12 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="16:52:10.202062 - 12 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="126" beginLine="125" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:12.204336 - 12 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="16:52:12.255979 - 12 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="130" responseBeginLine="130" endLine="128" beginLine="127" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:12.256823 - 12 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="16:52:12.453789 - 12 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/12SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="139" beginLine="138" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="N/A"><COMMENT> 2. Create a PNR via TTY with element SSR ASVC</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:12.454612 - 12 Sep 2024"><TEXT><![CDATA[T/CAT/ON]]></TEXT></QUERY><REPLY receiveAt="16:52:12.541361 - 12 Sep 2024" filename="">OK - ACTIVATED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="140" beginLine="139" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:12.541758 - 12 Sep 2024"><TEXT><![CDATA[T/CAT/CLEAR]]></TEXT></QUERY><REPLY receiveAt="16:52:12.627951 - 12 Sep 2024" filename="">DELETE - OK&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" responseEndLine="151" responseBeginLine="151" endLine="149" beginLine="141" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:12.628858 - 12 Sep 2024"><TEXT><![CDATA[YY&amp;
&amp;
MUCRM1A&amp;
&amp;
.HDQRM1S&amp;
&amp;
HDQ1S ]]></TEXT><VARIABLE name="RLOC"><VALUE><![CDATA[DSRP8C]]></VALUE></VARIABLE><TEXT><![CDATA[/13EG/27213082/ATH/1S/T/GR/EUR&amp;
&amp;
1EASY/AMZE&amp;
&amp;
6X460Y20SEP LHRMAD LK1&amp;
&amp;
SSR ASVC 6X NN1 LHRMAD 0460Y20SEP.C/99A/ASVC/ANGLING EQUIPMENT&amp;
&amp;
SSR ASVC 6X NN1 LHRMAD 0460Y20SEP.G/013/ASVC/IN FLIGHT ENTERTAINMENT]]></TEXT></QUERY><COMPARISON compareAt="16:52:13.635262 - 12 Sep 2024" match="OK"><TEXT><![CDATA[MSG OK - SENT]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="10" endLine="155" beginLine="154" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:17.649469 - 12 Sep 2024"><TEXT><![CDATA[T/CAT]]></TEXT></QUERY><REPLY receiveAt="16:52:17.747309 - 12 Sep 2024" filename="">HDQRM1S&amp;
.MUCRM1A 12145213&amp;
PDM&amp;
AKA&amp;
HDQ1S DSRP8C/13EG/27213082&amp;
MUC1A XXB2WX&amp;
1EASY/AMZE&amp;
6X460Y20SEP LHRMAD HK1&amp;
;&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="156" beginLine="155" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:17.747426 - 12 Sep 2024"><TEXT><![CDATA[T/CAT]]></TEXT></QUERY><REPLY receiveAt="16:52:17.835093 - 12 Sep 2024" filename="">HDQRM1S&amp;
.MUCRM1A 12145213&amp;
AKA&amp;
HDQ1S DSRP8C/13EG/27213082&amp;
MUC1A XXB2WX&amp;
1EASY/AMZE&amp;
6X460Y20SEP LHRMAD HK1&amp;
;&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="170" responseBeginLine="161" endLine="159" beginLine="158" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="OK"><COMMENT> Check PNR element by retrieving recloc</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:17.835315 - 12 Sep 2024"><TEXT><![CDATA[RTOA/1S-]]></TEXT><VARIABLE name="RLOC"><VALUE><![CDATA[DSRP8C]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="16:52:18.123524 - 12 Sep 2024" match="OK"><TEXT><![CDATA[--- RLR ---&amp;
RP/HDQ1S/HDQ1S]]></TEXT><VARIABLE name="RLOC"><VALUE><![CDATA[DSRP8C]]></VALUE></VARIABLE><TEXT><![CDATA[/13EG/2721308        ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[12SEP24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1452Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[XXB2WX]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  1.EASY/AMZE&amp;
  2  6X 460 Y ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20SEP]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ 5 LHRMAD HK1  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0830]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1150]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20SEP]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  E  6X.]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%RLOC2%=.{6}}]]></EXPRESSION><VALUE><![CDATA[XXB2WX]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  3 /SSR ASVC 6X HN1 C/99A/ASVC/ANGLING EQUIPMENT/S2&amp;
  4 SSR OTHS 1S MISSING SSR CTCM MOBILE OR SSR CTCE EMAIL OR SSR&amp;
       CTCR NON-CONSENT FOR 6X&amp;
  5]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ OPC-12SEP:1754/1C8/6X CANCELLATION DUE TO NO TICKET ATH TIME]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
        ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ZONE/TKT/S2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
&gt;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="184" responseBeginLine="175" endLine="173" beginLine="172" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:18.124186 - 12 Sep 2024"><TEXT><![CDATA[RT]]></TEXT><VARIABLE name="RLOC2"><VALUE><![CDATA[XXB2WX]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="16:52:18.340891 - 12 Sep 2024" match="OK"><TEXT><![CDATA[--- RLR ---&amp;
RP/HDQ1S/HDQ1S]]></TEXT><VARIABLE name="RLOC"><VALUE><![CDATA[DSRP8C]]></VALUE></VARIABLE><TEXT><![CDATA[/13EG/2721308        ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[12SEP24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1452Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[XXB2WX]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  1.EASY/AMZE&amp;
  2  6X 460 Y ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20SEP]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ 5 LHRMAD HK1  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0830]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1150]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20SEP]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  E  6X.]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%RLOC2%=.{6}}]]></EXPRESSION><VALUE><![CDATA[XXB2WX]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  3 /SSR ASVC 6X HN1 C/99A/ASVC/ANGLING EQUIPMENT/S2&amp;
  4 SSR OTHS 1S MISSING SSR CTCM MOBILE OR SSR CTCE EMAIL OR SSR&amp;
       CTCR NON-CONSENT FOR 6X&amp;
  5]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ OPC-12SEP:1754/1C8/6X CANCELLATION DUE TO NO TICKET ATH TIME]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
        ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ZONE/TKT/S2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
&gt;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="14" responseEndLine="215" responseBeginLine="202" endLine="200" beginLine="194" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:18.410950 - 12 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE6X0100++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="RLOC2"><VALUE><![CDATA[XXB2WX]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[12SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="16:52:18.779836 - 12 Sep 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="RLOC2"><VALUE><![CDATA[XXB2WX]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[12SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="RLOC2"><VALUE><![CDATA[XXB2WX]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240912\:14\:52\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:09:12:14:52:13]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[8224173157]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:09:12:14:52:13]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="235" responseBeginLine="229" endLine="228" beginLine="224" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:18.822085 - 12 Sep 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[8224173157]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:09:12:14:52:13]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="16:52:18.877035 - 12 Sep 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[8224173157]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:09:12:14:52:13]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2497]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xA1\x13\x12\xC4\x12\x0A\x11XXB2WX-2024-09-12\x12\x03pnr\x1A\x06XXB2WX&quot;\x010:\x89\x01\x1A\x142024-09-12T14:52:00Z&quot;=\x0A&quot;\x0A\x0413EG\x12\x0827213082\x1A\x021S&quot;\x0CTRAVEL_AGENT\x12\x17\x0A\x040000\x12\x021S\x1A\x02RM*\x02GR2\x03ATH*2HDQRM1S//HDQ1SDSRP8C/13EG/27213082/ATH/1S/T/GR/EURJ\x94\x08\x1A\x142024-09-12T14:52:13Z&quot;\x0D\x0A\x0B\x0A\x09HDQ RM 1S*2HDQRM1S//HDQ1SDSRP8C/13EG/27213082/ATH/1S/T/GR/EUR:H\x12\x10historyChangeLog\x18\x01&quot;\x1AXXB2WX-2024-09-12-PNR-NM-1*\x0Bstakeholder2\x09travelers:D\x12\x10historyChangeLog\x18\x01&quot;\x1BXXB2WX-2024-09-12-PNR-AIR-1*\x07product2\x08products:c\x12\x10historyChangeLog\x18\x01&quot;\x1BXXB2WX-2024-09-12-PNR-BKG-4*\x10segment-delivery2\x1Eproducts/airSegment/deliveries:D\x12\x10historyChangeLog\x18\x01&quot;\x1BXXB2WX-2024-09-12-PNR-SSR-7*\x07product2\x08products:\xA1\x02\x12\x0FentityChangeLogB\x8D\x02\x8A\x01\x89\x02\x0A\x13ticketing-reference\x12\x1BXXB2WX-2024-09-12-PNR-SSR-6\x18\x0F&quot;\x02NO25G/013/ASVC/IN FLIGHT ENTERTAINMENT.INVALID RFIC/RFISC:\x16\x1A\x142024-09-12T00:00:00ZJA\x0A\x0Bstakeholder\x12\x1AXXB2WX-2024-09-12-PNR-NM-1\x1A\x16processedPnr.travelersR=\x0A\x07product\x12\x1BXXB2WX-2024-09-12-PNR-AIR-1\x1A\x15processedPnr.products:Y\x12\x10historyChangeLog&quot;\x1BXXB2WX-2024-09-12-PNR-SSR-6*\x13ticketing-reference2\x13ticketingReferences:[\x12\x10historyChangeLog\x18\x01&quot;\x1BXXB2WX-2024-09-12-PNR-SSR-5*\x13ticketing-reference2\x13ticketingReferences:Y\x12\x10historyChangeLog&quot;\x1BXXB2WX-2024-09-12-PNR-SSR-6*\x13ticketing-reference2\x13ticketingReferences:G\x12\x10historyChangeLog\x18\x01&quot;\x1EXXB2WX-2024-09-12-PNR-ROA-4002*\x0132\x0EassociatedPnrsP\x08r4\x0A\x06DSRP8C\x10\x03&quot;\x08&quot;\x06\x0A\x04\x1A\x021S2\x1EXXB2WX-2024-09-12-PNR-ROA-4002zL\x0A\x0Bstakeholder\x12\x1AXXB2WX-2024-09-12-PNR-NM-1&quot;\x0C\x12\x04AMZE\x1A\x04EASY\xA2\x01\x12\x12\x10610203CF0002DF15\x82\x01\xE6\x02\x0A\x07product\x10\x01\x1A\x1BXXB2WX-2024-09-12-PNR-AIR-1&quot;\xFC\x01\x0A\x1D\x0A\x03LHR\x12\x011\x1A\x132024-09-20T00:00:00\x12\x1A\x0A\x03MAD\x1A\x132024-09-20T00:00:00&quot;+\x0A\x09\x0A\x026X\x12\x03460\x12\x03\x0A\x01Y2\x196X-460-2024-09-20-LHR-MADJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1BXXB2WX-2024-09-12-PNR-BKG-4\x1A\x10600453D300015EECZA\x0A\x0Bstakeholder\x12\x1AXXB2WX-2024-09-12-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00:=\x0A\x07product\x12\x1BXXB2WX-2024-09-12-PNR-SSR-7\x1A\x15processedPnr.products\x82\x01\x89\x02\x0A\x07product\x10\x02\x1A\x1BXXB2WX-2024-09-12-PNR-SSR-7*]\x1A\x04OTHS \x01*\x04\x0A\x021SjHMISSING SSR CTCM MOBILE OR SSR CTCE EMAIL OR SSR CTCR NON-CONSENT FOR 6X\x82\x01\x02\x08\x00:=\x0A\x07product\x12\x1BXXB2WX-2024-09-12-PNR-AIR-1\x1A\x15processedPnr.productsBA\x0A\x0Bstakeholder\x12\x1AXXB2WX-2024-09-12-PNR-NM-1\x1A\x16processedPnr.travelers\x92\x01\xF0\x01\x0A\x13ticketing-reference\x12\x1BXXB2WX-2024-09-12-PNR-SSR-5\x18\x0F&quot;\x02HN2\x1CC/99A/ASVC/ANGLING EQUIPMENT:\x16\x1A\x142024-09-12T00:00:00ZJA\x0A\x0Bstakeholder\x12\x1AXXB2WX-2024-09-12-PNR-NM-1\x1A\x16processedPnr.travelersR=\x0A\x07product\x12\x1BXXB2WX-2024-09-12-PNR-AIR-1\x1A\x15processedPnr.products\x92\x01\x89\x01\x0A\x13ticketing-reference\x12\x1BXXB2WX-2024-09-12-PNR-SSR-6\x18\x0F&quot;\x02NO25G/013/ASVC/IN FLIGHT ENTERTAINMENT.INVALID RFIC/RFISC:\x16\x1A\x142024-09-12T00:00:00ZJ\x00\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x06XXB2WX\x1A\x010&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" responseEndLine="263" responseBeginLine="256" endLine="254" beginLine="249" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/Bug_fix/SCOOP-10557_skip_INT_element.cry" loop="0" sentAt="16:52:18.879966 - 12 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header4"><VALUE><![CDATA[eyJub25jZSI6Ik16WTJPVFF6TWpNNE56STROek0zTlE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTJUMTQ6NTI6MDguMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiSjExRE9BR25KQTF5ZFNGd1lQUXJxeXl1REdNPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChFYWEIyV1gtMjAyNC0wOS0xMhIDcG5yGgZYWEIyV1giATA6iQEaFDIwMjQtMDktMTJUMTQ6NTI6MDBaIj0KIgoEMTNFRxIIMjcyMTMwODIaAjFTIgxUUkFWRUxfQUdFTlQSFwoEMDAwMBICMVMaAlJNKgJHUjIDQVRIKjJIRFFSTTFTLy9IRFExU0RTUlA4Qy8xM0VHLzI3MjEzMDgyL0FUSC8xUy9UL0dSL0VVUkqUCBoUMjAyNC0wOS0xMlQxNDo1MjoxM1oiDQoLCglIRFEgUk0gMVMqMkhEUVJNMVMvL0hEUTFTRFNSUDhDLzEzRUcvMjcyMTMwODIvQVRILzFTL1QvR1IvRVVSOkgSEGhpc3RvcnlDaGFuZ2VMb2cYASIaWFhCMldYLTIwMjQtMDktMTItUE5SLU5NLTEqC3N0YWtlaG9sZGVyMgl0cmF2ZWxlcnM6RBIQaGlzdG9yeUNoYW5nZUxvZxgBIhtYWEIyV1gtMjAyNC0wOS0xMi1QTlItQUlSLTEqB3Byb2R1Y3QyCHByb2R1Y3RzOmMSEGhpc3RvcnlDaGFuZ2VMb2cYASIbWFhCMldYLTIwMjQtMDktMTItUE5SLUJLRy00KhBzZWdtZW50LWRlbGl2ZXJ5Mh5wcm9kdWN0cy9haXJTZWdtZW50L2RlbGl2ZXJpZXM6RBIQaGlzdG9yeUNoYW5nZUxvZxgBIhtYWEIyV1gtMjAyNC0wOS0xMi1QTlItU1NSLTcqB3Byb2R1Y3QyCHByb2R1Y3RzOqECEg9lbnRpdHlDaGFuZ2VMb2dCjQKKAYkCChN0aWNrZXRpbmctcmVmZXJlbmNlEhtYWEIyV1gtMjAyNC0wOS0xMi1QTlItU1NSLTYYDyICTk8yNUcvMDEzL0FTVkMvSU4gRkxJR0hUIEVOVEVSVEFJTk1FTlQuSU5WQUxJRCBSRklDL1JGSVNDOhYaFDIwMjQtMDktMTJUMDA6MDA6MDBaSkEKC3N0YWtlaG9sZGVyEhpYWEIyV1gtMjAyNC0wOS0xMi1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc1I9Cgdwcm9kdWN0EhtYWEIyV1gtMjAyNC0wOS0xMi1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0czpZEhBoaXN0b3J5Q2hhbmdlTG9nIhtYWEIyV1gtMjAyNC0wOS0xMi1QTlItU1NSLTYqE3RpY2tldGluZy1yZWZlcmVuY2UyE3RpY2tldGluZ1JlZmVyZW5jZXM6WxIQaGlzdG9yeUNoYW5nZUxvZxgBIhtYWEIyV1gtMjAyNC0wOS0xMi1QTlItU1NSLTUqE3RpY2tldGluZy1yZWZlcmVuY2UyE3RpY2tldGluZ1JlZmVyZW5jZXM6WRIQaGlzdG9yeUNoYW5nZUxvZyIbWFhCMldYLTIwMjQtMDktMTItUE5SLVNTUi02KhN0aWNrZXRpbmctcmVmZXJlbmNlMhN0aWNrZXRpbmdSZWZlcmVuY2VzOkcSEGhpc3RvcnlDaGFuZ2VMb2cYASIeWFhCMldYLTIwMjQtMDktMTItUE5SLVJPQS00MDAyKgEzMg5hc3NvY2lhdGVkUG5yc1AIcjQKBkRTUlA4QxADIggiBgoEGgIxUzIeWFhCMldYLTIwMjQtMDktMTItUE5SLVJPQS00MDAyekwKC3N0YWtlaG9sZGVyEhpYWEIyV1gtMjAyNC0wOS0xMi1QTlItTk0tMSIMEgRBTVpFGgRFQVNZogESEhA2MTAyMDNDRjAwMDJERjE1ggHmAgoHcHJvZHVjdBABGhtYWEIyV1gtMjAyNC0wOS0xMi1QTlItQUlSLTEi/AEKHQoDTEhSEgExGhMyMDI0LTA5LTIwVDAwOjAwOjAwEhoKA01BRBoTMjAyNC0wOS0yMFQwMDowMDowMCIrCgkKAjZYEgM0NjASAwoBWTIZNlgtNDYwLTIwMjQtMDktMjAtTEhSLU1BREoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSG1hYQjJXWC0yMDI0LTA5LTEyLVBOUi1CS0ctNBoQNjAwNDUzRDMwMDAxNUVFQ1pBCgtzdGFrZWhvbGRlchIaWFhCMldYLTIwMjQtMDktMTItUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgECCAA6PQoHcHJvZHVjdBIbWFhCMldYLTIwMjQtMDktMTItUE5SLVNTUi03GhVwcm9jZXNzZWRQbnIucHJvZHVjdHOCAYkCCgdwcm9kdWN0EAIaG1hYQjJXWC0yMDI0LTA5LTEyLVBOUi1TU1ItNypdGgRPVEhTIAEqBAoCMVNqSE1JU1NJTkcgU1NSIENUQ00gTU9CSUxFIE9SIFNTUiBDVENFIEVNQUlMIE9SIFNTUiBDVENSIE5PTi1DT05TRU5UIEZPUiA2WIIBAggAOj0KB3Byb2R1Y3QSG1hYQjJXWC0yMDI0LTA5LTEyLVBOUi1BSVItMRoVcHJvY2Vzc2VkUG5yLnByb2R1Y3RzQkEKC3N0YWtlaG9sZGVyEhpYWEIyV1gtMjAyNC0wOS0xMi1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc5IB8AEKE3RpY2tldGluZy1yZWZlcmVuY2USG1hYQjJXWC0yMDI0LTA5LTEyLVBOUi1TU1ItNRgPIgJITjIcQy85OUEvQVNWQy9BTkdMSU5HIEVRVUlQTUVOVDoWGhQyMDI0LTA5LTEyVDAwOjAwOjAwWkpBCgtzdGFrZWhvbGRlchIaWFhCMldYLTIwMjQtMDktMTItUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNSPQoHcHJvZHVjdBIbWFhCMldYLTIwMjQtMDktMTItUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHOSAYkBChN0aWNrZXRpbmctcmVmZXJlbmNlEhtYWEIyV1gtMjAyNC0wOS0xMi1QTlItU1NSLTYYDyICTk8yNUcvMDEzL0FTVkMvSU4gRkxJR0hUIEVOVEVSVEFJTk1FTlQuSU5WQUxJRCBSRklDL1JGSVNDOhYaFDIwMjQtMDktMTJUMDA6MDA6MDBaSgA=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" validate="manual" matchMessage="Match failed with error code 1: Callback rejected:Match function exits on unspecified Error." compareAt="16:52:19.079907 - 12 Sep 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001E2ZLWJPFZ6]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4494]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;XXB2WX-2024-09-12&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;XXB2WX&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-12T14:52:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;13EG&quot;, &amp;
                &quot;iataNumber&quot;: &quot;27213082&quot;, &amp;
                &quot;systemCode&quot;: &quot;1S&quot;, &amp;
                &quot;agentType&quot;: &quot;TRAVEL_AGENT&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;0000&quot;, &amp;
                &quot;initials&quot;: &quot;1S&quot;, &amp;
                &quot;dutyCode&quot;: &quot;RM&quot;, &amp;
                &quot;countryCode&quot;: &quot;GR&quot;, &amp;
                &quot;cityCode&quot;: &quot;ATH&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;HDQRM1S//HDQ1SDSRP8C/13EG/27213082/ATH/1S/T/GR/EUR&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-12T14:52:13Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;HDQ RM 1S&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;HDQRM1S//HDQ1SDSRP8C/13EG/27213082/ATH/1S/T/GR/EUR&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;XXB2WX-2024-09-12-PNR-NM-1&quot;, &amp;
                &quot;elementType&quot;: &quot;stakeholder&quot;, &amp;
                &quot;path&quot;: &quot;travelers&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;XXB2WX-2024-09-12-PNR-AIR-1&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;XXB2WX-2024-09-12-PNR-BKG-4&quot;, &amp;
                &quot;elementType&quot;: &quot;segment-delivery&quot;, &amp;
                &quot;path&quot;: &quot;products/airSegment/deliveries&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-7&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;entityChangeLog&quot;, &amp;
                &quot;oldEntity&quot;: \{&amp;
                    &quot;ticketingReferences&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;ticketing-reference&quot;, &amp;
                            &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-6&quot;, &amp;
                            &quot;referenceTypeCode&quot;: &quot;ASVC_SSR&quot;, &amp;
                            &quot;referenceStatusCode&quot;: &quot;NO&quot;, &amp;
                            &quot;text&quot;: &quot;G/013/ASVC/IN FLIGHT ENTERTAINMENT.INVALID RFIC/RFISC&quot;, &amp;
                            &quot;creation&quot;: \{&amp;
                                &quot;dateTime&quot;: &quot;2024-09-12T00:00:00Z&quot;&amp;
                            \}, &amp;
                            &quot;traveler&quot;: \{&amp;
                                &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                                &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-NM-1&quot;, &amp;
                                &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                            \}, &amp;
                            &quot;products&quot;: [&amp;
                                \{&amp;
                                    &quot;type&quot;: &quot;product&quot;, &amp;
                                    &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-AIR-1&quot;, &amp;
                                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                                \}&amp;
                            ]&amp;
                        \}&amp;
                    ]&amp;
                \}&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;elementId&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-6&quot;, &amp;
                &quot;elementType&quot;: &quot;ticketing-reference&quot;, &amp;
                &quot;path&quot;: &quot;ticketingReferences&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-5&quot;, &amp;
                &quot;elementType&quot;: &quot;ticketing-reference&quot;, &amp;
                &quot;path&quot;: &quot;ticketingReferences&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;elementId&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-6&quot;, &amp;
                &quot;elementType&quot;: &quot;ticketing-reference&quot;, &amp;
                &quot;path&quot;: &quot;ticketingReferences&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;XXB2WX-2024-09-12-PNR-ROA-4002&quot;, &amp;
                &quot;elementType&quot;: &quot;3&quot;, &amp;
                &quot;path&quot;: &quot;associatedPnrs&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;pnrProperties&quot;: [&amp;
        &quot;OTHER_AIRLINE&quot;&amp;
    ], &amp;
    &quot;associatedPnrs&quot;: [&amp;
        \{&amp;
            &quot;reference&quot;: &quot;DSRP8C&quot;, &amp;
            &quot;associationType&quot;: &quot;OTHER_AIRLINE&quot;, &amp;
            &quot;creation&quot;: \{&amp;
                &quot;pointOfSale&quot;: \{&amp;
                    &quot;office&quot;: \{&amp;
                        &quot;systemCode&quot;: &quot;1S&quot;&amp;
                    \}&amp;
                \}&amp;
            \}, &amp;
            &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-ROA-4002&quot;&amp;
        \}&amp;
    ], &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;AMZE&quot;, &amp;
                    &quot;lastName&quot;: &quot;EASY&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610203CF0002DF15&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;terminal&quot;: &quot;1&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-09-20T00:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;MAD&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-09-20T00:00:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;460&quot;&amp;
                    \}, &amp;
                    &quot;bookingClass&quot;: \{&amp;
                        &quot;code&quot;: &quot;Y&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-460-2024-09-20-LHR-MAD&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-BKG-4&quot;, &amp;
                        &quot;distributionId&quot;: &quot;600453D300015EEC&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-NM-1&quot;, &amp;
                            &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                        \}&amp;
                    \}&amp;
                ], &amp;
                &quot;distributionMethod&quot;: &quot;E&quot;, &amp;
                &quot;notAcknowledged&quot;: false&amp;
            \}, &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-7&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;SERVICE&quot;, &amp;
            &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-7&quot;, &amp;
            &quot;service&quot;: \{&amp;
                &quot;code&quot;: &quot;OTHS&quot;, &amp;
                &quot;subType&quot;: &quot;SPECIAL_SERVICE_REQUEST&quot;, &amp;
                &quot;serviceProvider&quot;: \{&amp;
                    &quot;code&quot;: &quot;1S&quot;&amp;
                \}, &amp;
                &quot;text&quot;: &quot;MISSING SSR CTCM MOBILE OR SSR CTCE EMAIL OR SSR CTCR NON-CONSENT FOR 6X&quot;, &amp;
                &quot;isChargeable&quot;: false&amp;
            \}, &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;ticketingReferences&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;ticketing-reference&quot;, &amp;
            &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-5&quot;, &amp;
            &quot;referenceTypeCode&quot;: &quot;ASVC_SSR&quot;, &amp;
            &quot;referenceStatusCode&quot;: &quot;HN&quot;, &amp;
            &quot;text&quot;: &quot;C/99A/ASVC/ANGLING EQUIPMENT&quot;, &amp;
            &quot;creation&quot;: \{&amp;
                &quot;dateTime&quot;: &quot;2024-09-12T00:00:00Z&quot;&amp;
            \}, &amp;
            &quot;traveler&quot;: \{&amp;
                &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-NM-1&quot;, &amp;
                &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
            \}, &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;ticketing-reference&quot;, &amp;
            &quot;id&quot;: &quot;XXB2WX-2024-09-12-PNR-SSR-6&quot;, &amp;
            &quot;referenceTypeCode&quot;: &quot;ASVC_SSR&quot;, &amp;
            &quot;referenceStatusCode&quot;: &quot;NO&quot;, &amp;
            &quot;text&quot;: &quot;G/013/ASVC/IN FLIGHT ENTERTAINMENT.INVALID RFIC/RFISC&quot;, &amp;
            &quot;creation&quot;: \{&amp;
                &quot;dateTime&quot;: &quot;2024-09-12T00:00:00Z&quot;&amp;
            \}, &amp;
            &quot;traveler&quot;: \{\}&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION></TRANSACTION><ERROR filename="" line="273" severity="Fatal Error">The variable &apos;recloc&apos; is not defined</ERROR><STATISTIC><STATISTIC_ELEMENT name="Message in">16</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">14200</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">16</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">4363</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">5</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">16</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">17</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">1.0625</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">9131.4</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.395</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">2946.34</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">8</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">1</STATISTIC_ELEMENT></STATISTIC></xml>