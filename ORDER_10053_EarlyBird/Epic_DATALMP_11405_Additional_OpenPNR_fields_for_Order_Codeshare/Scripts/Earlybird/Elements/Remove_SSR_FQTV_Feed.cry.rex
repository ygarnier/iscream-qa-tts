<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry"><SCRIPT type="Initialize">import json
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
        for field in [&apos;id&apos;, &apos;reference&apos;, &apos;creation&apos;, &apos;lastModification&apos;, &apos;travelers&apos;, &apos;products&apos;, &apos;contacts&apos;]:
            assert_found(field, container=openpnr)

        expected_openpnr_id = recloc + &apos;-&apos; + today
        assert_equal(actual=openpnr[&apos;id&apos;], expected=expected_openpnr_id, item_name=&apos;OpenPNR id field&apos;)
        assert_not_found(&apos;creation/date&apos;, container=openpnr)
        assert_found(&apos;creation/dateTime&apos;, container=openpnr)
        assert_found(&apos;creation/pointOfSale/office/id&apos;, container=openpnr)
        assert_equal(expected=test_user_1A_extended_office, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        #Check hisotryChangeLog data for exempted service SSR FQTV
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=2, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]


        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;loyaltyRequests&apos;][0][&apos;type&apos;], expected=&apos;service&apos;, item_name=&apos;historyChangeLog service/type&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;loyaltyRequests&apos;][0][&apos;subType&apos;], expected=&apos;SPECIAL_SERVICE_REQUEST&apos;, item_name=&apos;historyChangeLog service/subType&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;loyaltyRequests&apos;][0][&apos;id&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-SSR-6&quot;, item_name=&apos;historyChangeLog serviceid&apos;)

        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;REMOVE&apos;, item_name=&apos;changeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-SSR-6&quot;, item_name=&apos;changeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;elementType&apos;], expected=&quot;service&quot;, item_name=&apos;changeLog elementType&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&quot;loyaltyRequests&quot;, item_name=&apos;changeLog path&apos;)

        #Check deadlinks are no more visible in &apos;products&apos; and &apos;travelers&apos; section
        # TO COMPLETE

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="89" beginLine="88" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:11.295167 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:18:11.350780 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="90" beginLine="89" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:11.351375 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:18:11.410585 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="91" beginLine="90" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:11.410676 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:18:11.482498 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="98" beginLine="97" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:11.482716 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:18:11.538662 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="100" beginLine="99" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:13.540293 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:18:13.597956 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="106" responseBeginLine="106" endLine="104" beginLine="103" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:13.598146 - 27 Jun 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:18:13.763367 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="116" beginLine="115" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:13.764180 - 27 Jun 2024"><TEXT><![CDATA[ffa6x-741852963]]></TEXT></QUERY><REPLY receiveAt="08:18:13.995993 - 27 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.GARCIA/MARIA MS&amp;
  2 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:13.996318 - 27 Jun 2024"><TEXT><![CDATA[AN30DECNCELHR/A6X]]></TEXT></QUERY><REPLY receiveAt="08:18:14.160329 - 27 Jun 2024" filename="">AN30DECNCELHR/A6X&amp;
** AMADEUS SIX - AN ** LHR HEATHROW.GB                       186 MO 30DEC 0000&amp;
 1   6X1561  Y9                   /NCE   LHR    0305    0415  E0/320       2:10&amp;
 2   6X1562  Y9                   /NCE   LHR    0315    0425  E0/320       2:10&amp;
 3   6X1563  Y9                   /NCE   LHR    0415    0515  E0/320       2:00&amp;
 4   6X 559  J9 D9 I9 U9 Y9       /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 5   6X 556  J9 DL I9 Y9          /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 6   6X 557  J9 DL I9 Y9          /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 7   6X 558  J9 DL I9 Y9          /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 8   6X 562  J9 D9 I9 U9 Y9       /NCE   LHR    0600    0710  E0/ERJ       2:10&amp;
 9   6X5504  J9 D9 I9 U9 Y9 B9 H9 /NCE 1 LHR 5  0600    1000  E0/330       5:00&amp;
             K9 M9 V9 G9 E9&amp;
10   6X7747  J9 C9 D9 I9 U9 Y9 B9 /NCE 2 LHR 5  0700    0800  E0/343       2:00&amp;
             M9 K9 Q9 G9 E9&amp;
11   6X7898  P9 J9 C9 D9 I9 U9 Y9 /NCE   LHR    0730    0840  E0/744       2:10&amp;
             B9 M9 K9 Q9 G9 E9&amp;
12   6X1131  P9 J9 C9 D9 I9 U9 Y9 /NCE   LHR    0730    0840  E0/744       2:10&amp;
             B9 M9 K9 Q9 G9 E9&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="118" beginLine="117" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:14.160698 - 27 Jun 2024"><TEXT><![CDATA[SS1Y1]]></TEXT></QUERY><REPLY receiveAt="08:18:14.622826 - 27 Jun 2024" filename="">--- RLP ---&amp;
RP/NCE6X0100/&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR DK1  0305 0415  30DEC  E  0 320&amp;
     SEE RTSVC&amp;
  3 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="121" beginLine="120" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:14.623016 - 27 Jun 2024"><TEXT><![CDATA[AP MYAGENCY]]></TEXT></QUERY><REPLY receiveAt="08:18:14.752558 - 27 Jun 2024" filename="">--- RLP ---&amp;
RP/NCE6X0100/&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR DK1  0305 0415  30DEC  E  0 320&amp;
     SEE RTSVC&amp;
  3 AP MYAGENCY&amp;
  4 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="122" beginLine="121" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:14.752973 - 27 Jun 2024"><TEXT><![CDATA[TKOK]]></TEXT></QUERY><REPLY receiveAt="08:18:14.870817 - 27 Jun 2024" filename="">--- RLP ---&amp;
RP/NCE6X0100/&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR DK1  0305 0415  30DEC  E  0 320&amp;
     SEE RTSVC&amp;
  3 AP MYAGENCY&amp;
  4 TK OK27JUN/NCE6X0100&amp;
  5 *SSR FQTV YY HK/ 6X741852963 SAPPHIRE/SILV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="130" responseBeginLine="127" endLine="124" beginLine="123" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:14.871735 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="08:18:15.577119 - 27 Jun 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[RLP ]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 27JUN24/0618]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8RODXG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?FQTV}]]></EXPRESSION><VALUE><![CDATA[  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR HK1  0305 0415  30DEC  E  6X/8RODXG&amp;
  3 AP MYAGENCY&amp;
  4 TK OK27JUN/NCE6X0100&amp;
  5 *SSR FQTV]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ 6X HK/ 6X741852963 SAPPHIRE/SILV&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" endLine="134" beginLine="133" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:17.587319 - 27 Jun 2024"><TEXT><![CDATA[XE5]]></TEXT></QUERY><REPLY receiveAt="08:18:18.121000 - 27 Jun 2024" filename="">PNR UPDATED BY PARALLEL PROCESS-PLEASE VERIFY PNR CONTENT&amp;
--- RLR RLP ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  27JUN24/0618Z   8RODXG&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR HK1  0305 0415  30DEC  E  6X/8RODXG&amp;
  3 AP MYAGENCY&amp;
  4 TK OK27JUN/NCE6X0100&amp;
  5 OPC-29DEC:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="136" beginLine="135" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:20.134624 - 27 Jun 2024"><TEXT><![CDATA[RF TEST]]></TEXT></QUERY><REPLY receiveAt="08:18:20.307426 - 27 Jun 2024" filename="">--- RLR RLP ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  27JUN24/0618Z   8RODXG&amp;
RF TEST&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR HK1  0305 0415  30DEC  E  6X/8RODXG&amp;
  3 AP MYAGENCY&amp;
  4 TK OK27JUN/NCE6X0100&amp;
  5 OPC-29DEC:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" endLine="137" beginLine="136" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:20.307905 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="08:18:20.788998 - 27 Jun 2024" filename="">--- RLR RLP ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  27JUN24/0618Z   8RODXG&amp;
  1.GARCIA/MARIA MS&amp;
  2  6X1561 Y 30DEC 1 NCELHR HK1  0305 0415  30DEC  E  6X/8RODXG&amp;
  3 AP MYAGENCY&amp;
  4 TK OK27JUN/NCE6X0100&amp;
  5 OPC-29DEC:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="16" endLine="145" beginLine="144" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><SCRIPT type="Exec"># Compose the expected PNR ID used in OpenPNR, e.g. ABC123-2025-05-27
openpnr_id = recloc + &apos;-&apos; + today
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:20.790336 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:18:20.873179 - 27 Jun 2024" filename="">IGNORED - 8RODXG&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" responseEndLine="160" responseBeginLine="158" endLine="156" beginLine="152" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:20.874561 - 27 Jun 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RODXG]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:18:21.139245 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8RODXG::270624:0618&apos;&amp;
RCI+1A:DR4AFV:F&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
RSI+RP:YGSU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:0447YG:270624:00631002:0618&apos;&amp;
LFT+3:P12+--- RLR RLP ---&apos;&amp;
STX+RLR*RLP&apos;&amp;
UID+00631002:NCE6X0100+A&apos;&amp;
SYS++6X:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+00631002:NCE6X0100+A&apos;&amp;
SYS++6X:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+00631002:NCE6X0100+A&apos;&amp;
SYS++6X:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2025:1:3&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+GARCIA::1+MARIA MS&apos;&amp;
ETI+:1+UN:Y:Y::GARCIA:MARIA MS&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+301224:0305:301224:0415+NCE+LHR+6X+1561:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8RODXG&apos;&amp;
RPI+1+HK&apos;&amp;
APD+320:0:0210::1+++648:M&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+301224:0305:301224:0415+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:4+AP+3&apos;&amp;
LFT+3:5+MYAGENCY&apos;&amp;
EMS++OT:5+TK+4&apos;&amp;
TKE++OK:270624::NCE6X0100&apos;&amp;
EMS++OT:10+OPC+5&apos;&amp;
OPE+NCE6X0100:291224:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="17"><QUERY filename="" loop="0" sentAt="08:18:21.140603 - 27 Jun 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="18" responseEndLine="193" responseBeginLine="180" endLine="178" beginLine="172" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:21.200845 - 27 Jun 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RODXG]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[3]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:18:21.275138 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RODXG]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[3]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RODXG]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240627\:06\:18\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[3]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:18:20]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4450618546]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:18:20]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="213" responseBeginLine="207" endLine="206" beginLine="202" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:21.276815 - 27 Jun 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4450618546]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:06:27:06:18:20]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:18:21.326255 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4450618546]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:18:20]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1415]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xE7\x0A\x12\x8A\x0A\x0A\x118RODXG-2024-06-27\x12\x03pnr\x1A\x068RODXG&quot;\x013:h\x1A\x142024-06-27T06:18:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x11TEST-1A/YOANNTESTJ\xC7\x02\x1A\x142024-06-27T06:18:20Z&quot;\x0D\x0A\x0B\x0A\x09NCE6X0100*\x04TEST:\xCC\x01\x12\x0FentityChangeLogB\xB8\x01\x92\x01\xB4\x01\x0A\x07service\x12\x1B8RODXG-2024-06-27-PNR-SSR-6\x1A\x04FQTV \x01*\x04\x0A\x026X2\x02HKZ7\x0A\x09741852963\x10\x01\x1A\x0D\x0A\x04SILV\x1A\x013*\x026X&quot;\x17\x0A\x04SAPP\x12\x08SAPPHIRE\x1A\x012*\x02*O(\x01rA\x0A\x0Bstakeholder\x12\x1A8RODXG-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers:K\x12\x10historyChangeLog\x18\x02&quot;\x1B8RODXG-2024-06-27-PNR-SSR-6*\x07service2\x0FloyaltyRequestsz\x90\x01\x0A\x0Bstakeholder\x12\x1A8RODXG-2024-06-27-PNR-NM-1&quot;\x12\x12\x08MARIA MS\x1A\x06GARCIAr&lt;\x0A\x07contact\x12\x1A8RODXG-2024-06-27-PNR-AP-4\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x106103939100014544\x82\x01\xCA\x02\x0A\x07product\x10\x01\x1A\x1B8RODXG-2024-06-27-PNR-AIR-1&quot;\x9F\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-12-30T03:05:00\x12\x1A\x0A\x03LHR\x1A\x132024-12-30T04:15:00&quot;Q\x0A\x0A\x0A\x026X\x12\x041561\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x1A6X-1561-2024-12-30-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8RODXG-2024-06-27-PNR-BKG-2\x1A\x106003F39100060043ZA\x0A\x0Bstakeholder\x12\x1A8RODXG-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01v\x0A\x07contact\x12\x1A8RODXG-2024-06-27-PNR-AP-4@\x01Z\x0A\x0A\x08MYAGENCYbA\x0A\x0Bstakeholder\x12\x1A8RODXG-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8RODXG-2024-06-27-PNR-TK-5\x18\x05&quot;\x132024-06-27T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A8RODXG-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8RODXG-2024-06-27-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068RODXG\x1A\x013&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="240" responseBeginLine="234" endLine="232" beginLine="227" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:21.327645 - 27 Jun 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik1UTXlOek00TVRNeE1qRXpNall5Tmc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDYtMjdUMDY6MTg6MDkuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJIY3c3VUoza1RWM3E4SzMvZ1B1UnNtWFdoOXM9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4Uk9EWEctMjAyNC0wNi0yNxIDcG5yGgY4Uk9EWEciATM6aBoUMjAyNC0wNi0yN1QwNjoxODowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQwNDQ3EgJZRxoCU1UqAkZSMgNOQ0UqEVRFU1QtMUEvWU9BTk5URVNUSscCGhQyMDI0LTA2LTI3VDA2OjE4OjIwWiINCgsKCU5DRTZYMDEwMCoEVEVTVDrMARIPZW50aXR5Q2hhbmdlTG9nQrgBkgG0AQoHc2VydmljZRIbOFJPRFhHLTIwMjQtMDYtMjctUE5SLVNTUi02GgRGUVRWIAEqBAoCNlgyAkhLWjcKCTc0MTg1Mjk2MxABGg0KBFNJTFYaATMqAjZYIhcKBFNBUFASCFNBUFBISVJFGgEyKgIqTygBckEKC3N0YWtlaG9sZGVyEho4Uk9EWEctMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyczpLEhBoaXN0b3J5Q2hhbmdlTG9nGAIiGzhST0RYRy0yMDI0LTA2LTI3LVBOUi1TU1ItNioHc2VydmljZTIPbG95YWx0eVJlcXVlc3RzepABCgtzdGFrZWhvbGRlchIaOFJPRFhHLTIwMjQtMDYtMjctUE5SLU5NLTEiEhIITUFSSUEgTVMaBkdBUkNJQXI8Cgdjb250YWN0Eho4Uk9EWEctMjAyNC0wNi0yNy1QTlItQVAtNBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA2MTAzOTM5MTAwMDE0NTQ0ggHKAgoHcHJvZHVjdBABGhs4Uk9EWEctMjAyNC0wNi0yNy1QTlItQUlSLTEinwIKGgoDTkNFGhMyMDI0LTEyLTMwVDAzOjA1OjAwEhoKA0xIUhoTMjAyNC0xMi0zMFQwNDoxNTowMCJRCgoKAjZYEgQxNTYxEicKAVkSAwoBWRoUCgIIABIMCgQaAjZYEgQqAkZSIAEiB0VDT05PTVkyGjZYLTE1NjEtMjAyNC0xMi0zMC1OQ0UtTEhSSgJIS2KEAQoQc2VnbWVudC1kZWxpdmVyeRIbOFJPRFhHLTIwMjQtMDYtMjctUE5SLUJLRy0yGhA2MDAzRjM5MTAwMDYwMDQzWkEKC3N0YWtlaG9sZGVyEho4Uk9EWEctMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc4oBAUWSAQIIALIBdgoHY29udGFjdBIaOFJPRFhHLTIwMjQtMDYtMjctUE5SLUFQLTRAAVoKCghNWUFHRU5DWWJBCgtzdGFrZWhvbGRlchIaOFJPRFhHLTIwMjQtMDYtMjctUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnO6AdUBChFhdXRvbWF0ZWQtcHJvY2VzcxIaOFJPRFhHLTIwMjQtMDYtMjctUE5SLVRLLTUYBSITMjAyNC0wNi0yN1QwMDowMDowMCoLCglOQ0U2WDAxMDBaQQoLc3Rha2Vob2xkZXISGjhST0RYRy0yMDI0LTA2LTI3LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzYj0KB3Byb2R1Y3QSGzhST0RYRy0yMDI0LTA2LTI3LVBOUi1BSVItMRoVcHJvY2Vzc2VkUG5yLnByb2R1Y3Rz]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="08:18:21.483328 - 27 Jun 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KUT38FQ6UL]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2892]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8RODXG-2024-06-27&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8RODXG&quot;, &amp;
    &quot;version&quot;: &quot;3&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:18:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;, &amp;
                &quot;iataNumber&quot;: &quot;00631002&quot;, &amp;
                &quot;systemCode&quot;: &quot;6X&quot;, &amp;
                &quot;agentType&quot;: &quot;AIRLINE&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;0447&quot;, &amp;
                &quot;initials&quot;: &quot;YG&quot;, &amp;
                &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                &quot;countryCode&quot;: &quot;FR&quot;, &amp;
                &quot;cityCode&quot;: &quot;NCE&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;TEST-1A/YOANNTEST&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:18:20Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;TEST&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;entityChangeLog&quot;, &amp;
                &quot;oldEntity&quot;: \{&amp;
                    &quot;loyaltyRequests&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;service&quot;, &amp;
                            &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-SSR-6&quot;, &amp;
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
                                    &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-NM-1&quot;, &amp;
                                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                                \}&amp;
                            ]&amp;
                        \}&amp;
                    ]&amp;
                \}&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;REMOVE&quot;, &amp;
                &quot;elementId&quot;: &quot;8RODXG-2024-06-27-PNR-SSR-6&quot;, &amp;
                &quot;elementType&quot;: &quot;service&quot;, &amp;
                &quot;path&quot;: &quot;loyaltyRequests&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;MARIA MS&quot;, &amp;
                    &quot;lastName&quot;: &quot;GARCIA&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-AP-4&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6103939100014544&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-AIR-1&quot;, &amp;
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
                        &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-BKG-2&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6003F39100060043&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-AP-4&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;MYAGENCY&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-TK-5&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-06-27T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8RODXG-2024-06-27-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" endLine="254" beginLine="253" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:21.484866 - 27 Jun 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="08:18:21.571469 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="22" endLine="255" beginLine="254" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:21.572150 - 27 Jun 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="08:18:21.662547 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="256" beginLine="255" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:21.663091 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:18:21.737704 - 27 Jun 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="260" beginLine="259" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:21.738354 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:18:21.902171 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="261" beginLine="260" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_SSR_FQTV_Feed.cry" loop="0" sentAt="08:18:21.902723 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:18:21.977431 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">14951</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">3029</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">25</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.961538</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">10691.7</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.876</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">4590.05</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">42</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">2</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>