<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry"><SCRIPT type="Initialize">import json
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
        assert_equal(expected=test_user_1A_extended_office, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        assert_equal(actual=len(openpnr[&apos;loyaltyRequests&apos;]), expected=1, item_name=&apos;number of loyaltyRequests&apos;)
        loyaltyRequests_1 = openpnr[&apos;loyaltyRequests&apos;][0]
        #Check service data for SSR FQTV element
        assert_equal(actual=loyaltyRequests_1[&apos;type&apos;], expected=&apos;service&apos;, item_name=&apos;loyaltyRequests type&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-SSR-6&quot;, item_name=&apos;automatedProcesses id&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;code&apos;], expected=&apos;FQTV&apos;, item_name=&apos;loyaltyRequests code&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;subType&apos;], expected=&apos;SPECIAL_SERVICE_REQUEST&apos;, item_name=&apos;loyaltyRequests subType&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;serviceProvider&apos;][&apos;code&apos;], expected=&apos;6X&apos;, item_name=&apos;loyaltyRequests/serviceProvider code&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;status&apos;], expected=&apos;HK&apos;, item_name=&apos;loyaltyRequests status&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;id&apos;], expected=&apos;741852963&apos;, item_name=&apos;loyaltyRequests membership/id&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;membershipType&apos;], expected=&apos;INDIVIDUAL&apos;, item_name=&apos;loyaltyRequests membershipType&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;activeTier&apos;][&apos;code&apos;], expected=&apos;SILV&apos;, item_name=&apos;loyaltyRequests membership/activeTier/code&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;activeTier&apos;][&apos;priorityCode&apos;], expected=&apos;3&apos;, item_name=&apos;loyaltyRequests membership/activeTier/priorityCode&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;activeTier&apos;][&apos;companyCode&apos;], expected=&apos;6X&apos;, item_name=&apos;loyaltyRequests membership/activeTier/companyCode&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;allianceTier&apos;][&apos;code&apos;], expected=&apos;SAPP&apos;, item_name=&apos;loyaltyRequests membership/allianceTier/code&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;allianceTier&apos;][&apos;name&apos;], expected=&apos;SAPPHIRE&apos;, item_name=&apos;loyaltyRequests membership/allianceTier/name&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;allianceTier&apos;][&apos;priorityCode&apos;], expected=&apos;2&apos;, item_name=&apos;loyaltyRequests membership/allianceTier/priorityCode&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;allianceTier&apos;][&apos;companyCode&apos;], expected=&apos;*O&apos;, item_name=&apos;loyaltyRequests membership/allianceTier/companyCode&apos;)
        assert_equal(actual=loyaltyRequests_1[&apos;membership&apos;][&apos;verificationStatus&apos;], expected=&apos;VERIFIED&apos;, item_name=&apos;loyaltyRequests membership/verificationStatus&apos;)


    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="91" beginLine="90" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:33.251958 - 28 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="17:47:33.303566 - 28 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="92" beginLine="91" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:33.304204 - 28 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="17:47:33.359420 - 28 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="93" beginLine="92" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:33.359550 - 28 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="17:47:33.426894 - 28 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="100" beginLine="99" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:33.427038 - 28 Aug 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="17:47:33.483633 - 28 Aug 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="102" beginLine="101" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:35.485392 - 28 Aug 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="17:47:35.545099 - 28 Aug 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="106" responseBeginLine="106" endLine="104" beginLine="103" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:35.545981 - 28 Aug 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[GVxyuXx77768bg+]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="17:47:35.703541 - 28 Aug 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/28AUG/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="116" beginLine="115" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:35.704595 - 28 Aug 2024"><TEXT><![CDATA[ffa6x-741852963]]></TEXT></QUERY><REPLY receiveAt="17:47:35.901906 - 28 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.GARCIA/MARIA MS&amp;
  2 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:35.902115 - 28 Aug 2024"><TEXT><![CDATA[AN30DECNCELHR/A6X]]></TEXT></QUERY><REPLY receiveAt="17:47:36.052790 - 28 Aug 2024" filename="">AN30DECNCELHR/A6X&amp;
** AMADEUS SIX - AN ** LHR HEATHROW.GB                       124 MO 30DEC 0000&amp;
 1   6X1561  Y9                   /NCE   LHR    0305    0415  E0/320       2:10&amp;
 2   6X1562  Y9                   /NCE   LHR    0315    0425  E0/320       2:10&amp;
 3   6X1563  Y9                   /NCE   LHR    0415    0515  E0/320       2:00&amp;
 4   6X 562  J9 D9 I9 U9 Y9       /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 5   6X 558  J9 DL I9 Y9          /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 6   6X 559  J9 D9 I9 U9 Y9       /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 7   6X 556  J9 DL I9 Y9          /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 8   6X 557  J9 DL I9 Y9          /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 9   6X5504  J9 DL I9 Y9 B9 H9 K9 /NCE 1 LHR 5  0600    1000  E0/330       5:00&amp;
             M9 V9 G9 E2&amp;
10   6X7747  J9 C9 D9 I9 U9 Y9 B9 /NCE 2 LHR 5  0700    0800  E0/343       2:00&amp;
             M9 K9 Q9 G9 E9&amp;
11   6X1140  P9 J9 C9 D9 I9 U9 Y9 /NCE   LHR    0730    0840  E0/744       2:10&amp;
             B9 M9 K9 Q9 G9 E9&amp;
12   6X1136  P9 J9 C9 D9 I9 U9 Y9 /NCE   LHR    0730    0840  E0/744       2:10&amp;
             B9 M9 K9 Q9 G9 E9&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="118" beginLine="117" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:36.053286 - 28 Aug 2024"><TEXT><![CDATA[SS1Y1]]></TEXT></QUERY><REPLY receiveAt="17:47:36.563723 - 28 Aug 2024" filename="">--- RLP ---&amp;
RP/NCE6X0100/&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR DK1  0305 0415  30DEC  E  0 320&amp;
     SEE RTSVC&amp;
  3 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="121" beginLine="120" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:36.564325 - 28 Aug 2024"><TEXT><![CDATA[AP MYAGENCY]]></TEXT></QUERY><REPLY receiveAt="17:47:36.692112 - 28 Aug 2024" filename="">--- RLP ---&amp;
RP/NCE6X0100/&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR DK1  0305 0415  30DEC  E  0 320&amp;
     SEE RTSVC&amp;
  3 AP MYAGENCY&amp;
  4 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="122" beginLine="121" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:36.692310 - 28 Aug 2024"><TEXT><![CDATA[TKOK]]></TEXT></QUERY><REPLY receiveAt="17:47:36.817201 - 28 Aug 2024" filename="">--- RLP ---&amp;
RP/NCE6X0100/&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR DK1  0305 0415  30DEC  E  0 320&amp;
     SEE RTSVC&amp;
  3 AP MYAGENCY&amp;
  4 TK OK28AUG/NCE6X0100&amp;
  5 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" endLine="123" beginLine="122" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:36.817313 - 28 Aug 2024"><TEXT><![CDATA[RF YG]]></TEXT></QUERY><REPLY receiveAt="17:47:36.952995 - 28 Aug 2024" filename="">--- RLP ---&amp;
RP/NCE6X0100/&amp;
RF YG&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR DK1  0305 0415  30DEC  E  0 320&amp;
     SEE RTSVC&amp;
  3 AP MYAGENCY&amp;
  4 TK OK28AUG/NCE6X0100&amp;
  5 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="133" responseBeginLine="130" endLine="128" beginLine="127" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:36.953362 - 28 Aug 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="17:47:37.516625 - 28 Aug 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[RLP ]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 28AUG24/1547]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[9VTEN8]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?FQTV}]]></EXPRESSION><VALUE><![CDATA[  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR HK1  0305 0415  30DEC  E  6X/9VTEN8&amp;
  3 AP MYAGENCY&amp;
  4 TK OK28AUG/NCE6X0100&amp;
  5 *SSR FQTV]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ 6X HK/ 6X741852963 SAPPHIRE/SILV&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="14" endLine="143" beginLine="142" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><SCRIPT type="Exec"># Compose the expected PNR ID used in OpenPNR, e.g. ABC123-2025-05-27
openpnr_id = recloc + &apos;-&apos; + today
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:37.519952 - 28 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="17:47:37.594226 - 28 Aug 2024" filename="">IGNORED - 9VTEN8&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="177" responseBeginLine="164" endLine="162" beginLine="156" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:40.668979 - 28 Aug 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9VTEN8]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="17:47:40.750671 - 28 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9VTEN8]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9VTEN8]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240828\:15\:47\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:15:47:37]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4666020795]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:15:47:37]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" responseEndLine="197" responseBeginLine="191" endLine="190" beginLine="186" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:40.795466 - 28 Aug 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4666020795]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:08:28:15:47:37]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="17:47:40.847956 - 28 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4666020795]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:15:47:37]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1923]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xE3\x0E\x12\x86\x0E\x0A\x119VTEN8-2024-08-28\x12\x03pnr\x1A\x069VTEN8&quot;\x010:e\x1A\x142024-08-28T15:47:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x041127\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x0EYG-1A/YGARNIERJ\x89\x04\x1A\x142024-08-28T15:47:37Z&quot;\x0D\x0A\x0B\x0A\x09NCE6X0100*\x02YG:H\x12\x10historyChangeLog\x18\x01&quot;\x1A9VTEN8-2024-08-28-PNR-NM-1*\x0Bstakeholder2\x09travelers:D\x12\x10historyChangeLog\x18\x01&quot;\x1B9VTEN8-2024-08-28-PNR-AIR-1*\x07product2\x08products:c\x12\x10historyChangeLog\x18\x01&quot;\x1B9VTEN8-2024-08-28-PNR-BKG-2*\x10segment-delivery2\x1Eproducts/airSegment/deliveries:C\x12\x10historyChangeLog\x18\x01&quot;\x1A9VTEN8-2024-08-28-PNR-AP-4*\x07contact2\x08contacts:W\x12\x10historyChangeLog\x18\x01&quot;\x1A9VTEN8-2024-08-28-PNR-TK-5*\x11automated-process2\x12automatedProcesses:K\x12\x10historyChangeLog\x18\x01&quot;\x1B9VTEN8-2024-08-28-PNR-SSR-6*\x07service2\x0FloyaltyRequestsz\xD6\x01\x0A\x0Bstakeholder\x12\x1A9VTEN8-2024-08-28-PNR-NM-1&quot;\x12\x12\x08MARIA MS\x1A\x06GARCIAr&lt;\x0A\x07contact\x12\x1A9VTEN8-2024-08-28-PNR-AP-4\x1A\x15processedPnr.contactszD\x0A\x07service\x12\x1B9VTEN8-2024-08-28-PNR-SSR-6\x1A\x1CprocessedPnr.loyaltyRequests\xA2\x01\x12\x12\x106101C3CF0001469B\x82\x01\xCA\x02\x0A\x07product\x10\x01\x1A\x1B9VTEN8-2024-08-28-PNR-AIR-1&quot;\x9F\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-12-30T03:05:00\x12\x1A\x0A\x03LHR\x1A\x132024-12-30T04:15:00&quot;Q\x0A\x0A\x0A\x026X\x12\x041561\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x1A6X-1561-2024-12-30-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B9VTEN8-2024-08-28-PNR-BKG-2\x1A\x10600283D000005040ZA\x0A\x0Bstakeholder\x12\x1A9VTEN8-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\x9A\x01\xF3\x01\x0A\x07service\x12\x1B9VTEN8-2024-08-28-PNR-SSR-6\x1A\x04FQTV \x01*\x04\x0A\x026X2\x02HKZ7\x0A\x09741852963\x10\x01\x1A\x0D\x0A\x04SILV\x1A\x013*\x026X&quot;\x17\x0A\x04SAPP\x12\x08SAPPHIRE\x1A\x012*\x02*O(\x01rA\x0A\x0Bstakeholder\x12\x1A9VTEN8-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelersz=\x0A\x07product\x12\x1B9VTEN8-2024-08-28-PNR-AIR-1\x1A\x15processedPnr.products\xB2\x01v\x0A\x07contact\x12\x1A9VTEN8-2024-08-28-PNR-AP-4@\x01Z\x0A\x0A\x08MYAGENCYbA\x0A\x0Bstakeholder\x12\x1A9VTEN8-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A9VTEN8-2024-08-28-PNR-TK-5\x18\x05&quot;\x132024-08-28T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A9VTEN8-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B9VTEN8-2024-08-28-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x069VTEN8\x1A\x010&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="17" responseEndLine="224" responseBeginLine="218" endLine="216" beginLine="211" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:40.849555 - 28 Aug 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik1EY3lNek0zTWpFM05UWTBNRGcxTWc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMjhUMTU6NDc6MjkuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJnYVk0YnVnQW9sWVJaZFJCL0tzUFVPTVZLS2M9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE5VlRFTjgtMjAyNC0wOC0yOBIDcG5yGgY5VlRFTjgiATA6ZRoUMjAyNC0wOC0yOFQxNTo0NzowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0UqDllHLTFBL1lHQVJOSUVSSokEGhQyMDI0LTA4LTI4VDE1OjQ3OjM3WiINCgsKCU5DRTZYMDEwMCoCWUc6SBIQaGlzdG9yeUNoYW5nZUxvZxgBIho5VlRFTjgtMjAyNC0wOC0yOC1QTlItTk0tMSoLc3Rha2Vob2xkZXIyCXRyYXZlbGVyczpEEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGzlWVEVOOC0yMDI0LTA4LTI4LVBOUi1BSVItMSoHcHJvZHVjdDIIcHJvZHVjdHM6YxIQaGlzdG9yeUNoYW5nZUxvZxgBIhs5VlRFTjgtMjAyNC0wOC0yOC1QTlItQktHLTIqEHNlZ21lbnQtZGVsaXZlcnkyHnByb2R1Y3RzL2FpclNlZ21lbnQvZGVsaXZlcmllczpDEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGjlWVEVOOC0yMDI0LTA4LTI4LVBOUi1BUC00Kgdjb250YWN0Mghjb250YWN0czpXEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGjlWVEVOOC0yMDI0LTA4LTI4LVBOUi1USy01KhFhdXRvbWF0ZWQtcHJvY2VzczISYXV0b21hdGVkUHJvY2Vzc2VzOksSEGhpc3RvcnlDaGFuZ2VMb2cYASIbOVZURU44LTIwMjQtMDgtMjgtUE5SLVNTUi02KgdzZXJ2aWNlMg9sb3lhbHR5UmVxdWVzdHN61gEKC3N0YWtlaG9sZGVyEho5VlRFTjgtMjAyNC0wOC0yOC1QTlItTk0tMSISEghNQVJJQSBNUxoGR0FSQ0lBcjwKB2NvbnRhY3QSGjlWVEVOOC0yMDI0LTA4LTI4LVBOUi1BUC00GhVwcm9jZXNzZWRQbnIuY29udGFjdHN6RAoHc2VydmljZRIbOVZURU44LTIwMjQtMDgtMjgtUE5SLVNTUi02Ghxwcm9jZXNzZWRQbnIubG95YWx0eVJlcXVlc3RzogESEhA2MTAxQzNDRjAwMDE0NjlCggHKAgoHcHJvZHVjdBABGhs5VlRFTjgtMjAyNC0wOC0yOC1QTlItQUlSLTEinwIKGgoDTkNFGhMyMDI0LTEyLTMwVDAzOjA1OjAwEhoKA0xIUhoTMjAyNC0xMi0zMFQwNDoxNTowMCJRCgoKAjZYEgQxNTYxEicKAVkSAwoBWRoUCgIIABIMCgQaAjZYEgQqAkZSIAEiB0VDT05PTVkyGjZYLTE1NjEtMjAyNC0xMi0zMC1OQ0UtTEhSSgJIS2KEAQoQc2VnbWVudC1kZWxpdmVyeRIbOVZURU44LTIwMjQtMDgtMjgtUE5SLUJLRy0yGhA2MDAyODNEMDAwMDA1MDQwWkEKC3N0YWtlaG9sZGVyEho5VlRFTjgtMjAyNC0wOC0yOC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc4oBAUWSAQIIAJoB8wEKB3NlcnZpY2USGzlWVEVOOC0yMDI0LTA4LTI4LVBOUi1TU1ItNhoERlFUViABKgQKAjZYMgJIS1o3Cgk3NDE4NTI5NjMQARoNCgRTSUxWGgEzKgI2WCIXCgRTQVBQEghTQVBQSElSRRoBMioCKk8oAXJBCgtzdGFrZWhvbGRlchIaOVZURU44LTIwMjQtMDgtMjgtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnN6PQoHcHJvZHVjdBIbOVZURU44LTIwMjQtMDgtMjgtUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHOyAXYKB2NvbnRhY3QSGjlWVEVOOC0yMDI0LTA4LTI4LVBOUi1BUC00QAFaCgoITVlBR0VOQ1liQQoLc3Rha2Vob2xkZXISGjlWVEVOOC0yMDI0LTA4LTI4LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGjlWVEVOOC0yMDI0LTA4LTI4LVBOUi1USy01GAUiEzIwMjQtMDgtMjhUMDA6MDA6MDAqCwoJTkNFNlgwMTAwWkEKC3N0YWtlaG9sZGVyEho5VlRFTjgtMjAyNC0wOC0yOC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0Ehs5VlRFTjgtMjAyNC0wOC0yOC1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 130: A character does not match, expected &apos;\n&apos;, received &apos;c&apos;." compareAt="17:47:41.003187 - 28 Aug 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[00019NJX5IXQJG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[3766]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[connection:close]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
\{&amp;
    &quot;id&quot;: &quot;9VTEN8-2024-08-28&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;9VTEN8&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-28T15:47:00Z&quot;, &amp;
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
        &quot;comment&quot;: &quot;YG-1A/YGARNIER&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-28T15:47:37Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;YG&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VTEN8-2024-08-28-PNR-NM-1&quot;, &amp;
                &quot;elementType&quot;: &quot;stakeholder&quot;, &amp;
                &quot;path&quot;: &quot;travelers&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VTEN8-2024-08-28-PNR-AIR-1&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VTEN8-2024-08-28-PNR-BKG-2&quot;, &amp;
                &quot;elementType&quot;: &quot;segment-delivery&quot;, &amp;
                &quot;path&quot;: &quot;products/airSegment/deliveries&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VTEN8-2024-08-28-PNR-AP-4&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VTEN8-2024-08-28-PNR-TK-5&quot;, &amp;
                &quot;elementType&quot;: &quot;automated-process&quot;, &amp;
                &quot;path&quot;: &quot;automatedProcesses&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VTEN8-2024-08-28-PNR-SSR-6&quot;, &amp;
                &quot;elementType&quot;: &quot;service&quot;, &amp;
                &quot;path&quot;: &quot;loyaltyRequests&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;MARIA MS&quot;, &amp;
                    &quot;lastName&quot;: &quot;GARCIA&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-AP-4&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;loyaltyAccruals&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;service&quot;, &amp;
                    &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-SSR-6&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.loyaltyRequests&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6101C3CF0001469B&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-12-30T03:05:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-12-30T04:15:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;1561&quot;&amp;
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
                    &quot;id&quot;: &quot;6X-1561-2024-12-30-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-BKG-2&quot;, &amp;
                        &quot;distributionId&quot;: &quot;600283D000005040&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-NM-1&quot;, &amp;
                            &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                        \}&amp;
                    \}&amp;
                ], &amp;
                &quot;distributionMethod&quot;: &quot;E&quot;, &amp;
                &quot;notAcknowledged&quot;: false&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;loyaltyRequests&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;service&quot;, &amp;
            &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-SSR-6&quot;, &amp;
            &quot;code&quot;: &quot;FQTV&quot;, &amp;
            &quot;subType&quot;: &quot;SPECIAL_SERVICE_REQUEST&quot;, &amp;
            &quot;serviceProvider&quot;: \{&amp;
                &quot;code&quot;: &quot;6X&quot;&amp;
            \}, &amp;
            &quot;status&quot;: &quot;HK&quot;, &amp;
            &quot;membership&quot;: \{&amp;
                &quot;id&quot;: &quot;741852963&quot;, &amp;
                &quot;membershipType&quot;: &quot;INDIVIDUAL&quot;, &amp;
                &quot;activeTier&quot;: \{&amp;
                    &quot;code&quot;: &quot;SILV&quot;, &amp;
                    &quot;priorityCode&quot;: &quot;3&quot;, &amp;
                    &quot;companyCode&quot;: &quot;6X&quot;&amp;
                \}, &amp;
                &quot;allianceTier&quot;: \{&amp;
                    &quot;code&quot;: &quot;SAPP&quot;, &amp;
                    &quot;name&quot;: &quot;SAPPHIRE&quot;, &amp;
                    &quot;priorityCode&quot;: &quot;2&quot;, &amp;
                    &quot;companyCode&quot;: &quot;*O&quot;&amp;
                \}, &amp;
                &quot;verificationStatus&quot;: &quot;VERIFIED&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-AP-4&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;MYAGENCY&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-TK-5&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-08-28T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;9VTEN8-2024-08-28-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="18" endLine="238" beginLine="237" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:41.004149 - 28 Aug 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="17:47:41.088873 - 28 Aug 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="19" endLine="239" beginLine="238" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:41.089028 - 28 Aug 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="17:47:41.168295 - 28 Aug 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="20" endLine="240" beginLine="239" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:41.168393 - 28 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="17:47:41.241950 - 28 Aug 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="21" endLine="244" beginLine="243" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:41.242068 - 28 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="17:47:41.368138 - 28 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="22" endLine="245" beginLine="244" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/SSR_FQTV_Feed.cry" loop="0" sentAt="17:47:41.368234 - 28 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="17:47:41.435042 - 28 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">22</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">14706</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">22</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">3388</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">5</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">22</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">22</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">8192.4</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.134</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">3025.93</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">36</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">2</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">5</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">1</STATISTIC_ELEMENT></STATISTIC></xml>