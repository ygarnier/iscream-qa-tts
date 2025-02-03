<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry"><SCRIPT type="Initialize">import json
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

        #Check hisotryChangeLog data for TK
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=2, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]

        #First changeLog section
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;remarks&apos;][0][&apos;type&apos;], expected=&apos;remark&apos;, item_name=&apos;historyChangeLog remarks/type&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;remarks&apos;][0][&apos;id&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-RM-4&quot;, item_name=&apos;historyChangeLog remarks/id&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;remarks&apos;][0][&apos;subType&apos;], expected=&apos;RM&apos;, item_name=&apos;historyChangeLog remarks/subType&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;remarks&apos;][0][&apos;content&apos;], expected=&apos;TEST&apos;, item_name=&apos;historyChangeLog remarks/content&apos;)

        #Second changeLog section
        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;REMOVE&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-RM-4&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;elementType&apos;], expected=&quot;remark&quot;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&quot;remarks&quot;, item_name=&apos;historyChangeLog path&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="88" beginLine="87" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:02.142183 - 02 Jul 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="14:32:02.225456 - 02 Jul 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="89" beginLine="88" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:02.226673 - 02 Jul 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="14:32:02.313005 - 02 Jul 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="90" beginLine="89" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:02.313124 - 02 Jul 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="14:32:02.415236 - 02 Jul 2024" filename="">&amp;
09CC2B44         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="97" beginLine="96" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:02.415374 - 02 Jul 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="14:32:02.503238 - 02 Jul 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="99" beginLine="98" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:04.519279 - 02 Jul 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="14:32:04.609736 - 02 Jul 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="105" responseBeginLine="105" endLine="103" beginLine="102" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:04.610151 - 02 Jul 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.DALWN0980-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="14:32:04.813633 - 02 Jul 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/02JUL/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="114" beginLine="113" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:04.814155 - 02 Jul 2024"><TEXT><![CDATA[NM1FRANK/JAMES]]></TEXT></QUERY><REPLY receiveAt="14:32:04.942120 - 02 Jul 2024" filename="">RP/DALWN0980/&amp;
  1.FRANK/JAMES&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="115" beginLine="114" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:04.942308 - 02 Jul 2024"><TEXT><![CDATA[AN20JUL DALATL]]></TEXT></QUERY><REPLY receiveAt="14:32:05.372554 - 02 Jul 2024" filename="">AN20JULDALATL&amp;
** SOUTHWEST AIRLINES TEXAS - AN ** ATL ATLANTA.USGA          18 SA 20JUL 0000&amp;
 1   WN2367  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  0640    0940  E0/73W       2:00&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 2   WN3831  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  0830    1140  E0/73H       2:10&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 3   WN4907  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  1300    1610  E0/73H N     2:10&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 4   WN1424  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  1750    2055  E0/7M8       2:05&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 5   WN2182  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  2005    2310  E0/73W       2:05&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 6   WN1569  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 DEN    0700    0800  E0/7M8&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9&amp;
     WN 118  Y9 X9 K9 L9 B9 Q9 H9 /DEN   ATL    0900    1200  E0/73W       4:00&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9 A9 J9 D9 V9&amp;
 7   WN 017  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 HOU    1110    1215  E0/73H&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
     WN2469  Y9 X9 K9 L9 B9 Q9 H9 /HOU   ATL N  1310    1610  E0/7M8 N     4:00&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="116" beginLine="115" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:05.372684 - 02 Jul 2024"><TEXT><![CDATA[SS1Y1]]></TEXT></QUERY><REPLY receiveAt="14:32:05.781914 - 02 Jul 2024" filename="">--- SFP ---&amp;
RP/DALWN0980/&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   73W E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:05.782088 - 02 Jul 2024"><TEXT><![CDATA[TKOK;APNCE;RFME]]></TEXT></QUERY><REPLY receiveAt="14:32:05.994138 - 02 Jul 2024" filename="">--- SFP ---&amp;
RP/DALWN0980/&amp;
RF ME&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   73W E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980&amp;
  5 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="118" beginLine="117" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:05.994277 - 02 Jul 2024"><TEXT><![CDATA[FPCA]]></TEXT></QUERY><REPLY receiveAt="14:32:06.214974 - 02 Jul 2024" filename="">--- SFP ---&amp;
RP/DALWN0980/&amp;
RF ME&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   73W E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980&amp;
  5 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  6 FP CA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" endLine="119" beginLine="118" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:06.215072 - 02 Jul 2024"><TEXT><![CDATA[FXP]]></TEXT></QUERY><REPLY receiveAt="14:32:06.904532 - 02 Jul 2024" filename="">FXP&amp;
&amp;
01 FRANK/JAMES&amp;
&amp;
LAST TKT DTE 03JUL24/23:59 LT in POS - SEE ADV PURCHASE&amp;
------------------------------------------------------------&amp;
     AL FLGT  BK   DATE  TIME  FARE BASIS      NVB  NVA   BG&amp;
 DFW&amp;
 ATL WN  2367 Y    20JUL 0640  YLN0P6L                    2P&amp;
&amp;
USD   485.92      20JUL24DFW WN ATL485.92USD485.92END&amp;
                  ZP DAL5.00XT USD 5.00-ZP USD 4.50-XF DAL&amp;
USD     5.60-AY   4.50&amp;
USD    36.44-US&amp;
USD     9.50-XT&amp;
USD   537.46&amp;
FARE FAMILIES:    (ENTER FQFn FOR DETAILS, FXY FOR UPSELL)&amp;
FARE FAMILY:FC1:1:ANY&amp;
FXU/TS TO UPSELL BUS FOR -216.00USD&amp;
BG CXR: WN&amp;
PRICED WITH VALIDATING CARRIER WN - REPRICE IF DIFFERENT VC&amp;
&gt;                                                 PAGE  2/ 3&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" endLine="120" beginLine="119" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:06.904692 - 02 Jul 2024"><TEXT><![CDATA[srdocswnhk1-p-gbr-36263623-usa-31mar89-m-12apr29-frank-james-h/p1]]></TEXT></QUERY><REPLY receiveAt="14:32:07.092233 - 02 Jul 2024" filename="">--- TST SFP ---&amp;
RP/DALWN0980/&amp;
RF ME&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   73W E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
  8 FP CA&amp;
  9 FV PAX WN/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="121" beginLine="120" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:07.092370 - 02 Jul 2024"><TEXT><![CDATA[ES ]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[-b]]></TEXT></QUERY><REPLY receiveAt="14:32:07.277244 - 02 Jul 2024" filename="">--- TST SFP ---&amp;
RP/DALWN0980/&amp;
RF ME&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   73W E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
  8 FP CA&amp;
  9 FV PAX WN/S2&amp;
  * ES/G B NCE1A0950&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="133" responseBeginLine="126" endLine="123" beginLine="122" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:07.277486 - 02 Jul 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="14:32:07.660506 - 02 Jul 2024" match="OK"><TEXT><![CDATA[--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 2JUL24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1232Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[2BT5V6]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?SSR}]]></EXPRESSION><VALUE><![CDATA[1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980&amp;
  5 SSR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?RM}]]></EXPRESSION><VALUE><![CDATA[6 RM]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  7 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
  8 FP CA&amp;
  9 FV PAX WN/S2&amp;
  * ES/G 02JUL/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" endLine="138" beginLine="137" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:09.666861 - 02 Jul 2024"><TEXT><![CDATA[IR]]></TEXT></QUERY><REPLY receiveAt="14:32:09.865323 - 02 Jul 2024" filename="">--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            AA/SU   2JUL24/1232Z   2BT5V6&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 OPC-03JUL:2359/1C8/WN CANCELLATION DUE TO NO TICKET DAL TIME&amp;
        ZONE/TKT/S2&amp;
  7 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  8 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
  9 FP CA&amp;
 10 FV PAX WN/S2&amp;
  * ES/G 02JUL/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" endLine="139" beginLine="138" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:09.865494 - 02 Jul 2024"><TEXT><![CDATA[TTP/ET/RT]]></TEXT></QUERY><REPLY receiveAt="14:32:11.176349 - 02 Jul 2024" filename="">OK ETICKET&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18" endLine="142" beginLine="141" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:11.176576 - 02 Jul 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2BT5V6]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="14:32:11.402461 - 02 Jul 2024" filename="">--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            YG/SU   2JUL24/1232Z   2BT5V6&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980//ETWN&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FA PAX 526-2520264697/ETWN/USD537.46/02JUL24/DALWN0980/45995&amp;
       132/S2&amp;
  8 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  9 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
 10 FP CA&amp;
 11 FV PAX WN/S2&amp;
  * ES/G 02JUL/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="19" endLine="145" beginLine="144" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:11.402802 - 02 Jul 2024"><TEXT><![CDATA[IR]]></TEXT></QUERY><REPLY receiveAt="14:32:11.679879 - 02 Jul 2024" filename="">--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            YG/SU   2JUL24/1232Z   2BT5V6&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 20JUL 6 DALATL HK1       1  0640 0940   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980//ETWN&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FA PAX 526-2520264697/ETWN/USD537.46/02JUL24/DALWN0980/45995&amp;
       132/S2&amp;
  8 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  9 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
 10 FP CA&amp;
 11 FV PAX WN/S2&amp;
  * ES/G 02JUL/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="20" endLine="146" beginLine="145" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:11.680075 - 02 Jul 2024"><TEXT><![CDATA[XE2]]></TEXT></QUERY><REPLY receiveAt="14:32:11.930071 - 02 Jul 2024" filename="">WARNING : SEGMENT DELETED - TST WILL BE DELETED IF ET/ER&amp;
ITINERARY CANCELLED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="21" endLine="147" beginLine="146" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:11.930241 - 02 Jul 2024"><TEXT><![CDATA[AN22JUL DALATL]]></TEXT></QUERY><REPLY receiveAt="14:32:12.391457 - 02 Jul 2024" filename="">AN22JULDALATL&amp;
** SOUTHWEST AIRLINES TEXAS - AN ** ATL ATLANTA.USGA          20 MO 22JUL 0000&amp;
 1   WN2367  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  0600    0905  E0/73W       2:05&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z2&amp;
 2   WN3831  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  0900    1205  E0/7M8       2:05&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9&amp;
 3   WN4907  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  1245    1550  E0/73H N     2:05&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 4   WN1424  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  1825    2130  E0/73W       2:05&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U4 G4&amp;
 5   WN2100  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  2050    2350  E0/73H       2:00&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 6   WN1143  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 MSY    0930    1055  E0/73W&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
     WN1577  Y9 X9 K9 L9 B9 Q9 H9 /MSY   ATL N  1135    1400  E0/73W       3:30&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 7   WN1992  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 AUS    1020    1115  E0/73W&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
     WN4491  Y9 X9 K9 L9 B9 Q9 H9 /AUS   ATL N  1155    1505  E0/73W       3:45&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="22" endLine="148" beginLine="147" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:12.391677 - 02 Jul 2024"><TEXT><![CDATA[SS1Y1]]></TEXT></QUERY><REPLY receiveAt="14:32:12.833498 - 02 Jul 2024" filename="">TICKET REVALIDATION/REISSUE IS RECOMMENDED&amp;
--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            YG/SU   2JUL24/1232Z   2BT5V6&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 22JUL 1 DALATL HK1       1  0600 0905   73W E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980//ETWN&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FHE PAX 526-2520264697&amp;
  8 FP CA&amp;
  * ES/G 02JUL/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="149" beginLine="148" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:12.833744 - 02 Jul 2024"><TEXT><![CDATA[RFF]]></TEXT></QUERY><REPLY receiveAt="14:32:13.017595 - 02 Jul 2024" filename="">TICKET REVALIDATION/REISSUE IS RECOMMENDED&amp;
--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            YG/SU   2JUL24/1232Z   2BT5V6&amp;
RF F&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 22JUL 1 DALATL HK1       1  0600 0905   73W E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980//ETWN&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FHE PAX 526-2520264697&amp;
  8 FP CA&amp;
  * ES/G 02JUL/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="151" beginLine="150" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:13.018001 - 02 Jul 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="14:32:13.397735 - 02 Jul 2024" filename="">TICKET REVALIDATION/REISSUE IS RECOMMENDED&amp;
--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            YG/SU   2JUL24/1232Z   2BT5V6&amp;
  1.FRANK/JAMES&amp;
  2  WN2367 Y 22JUL 1 DALATL HK1       1  0600 0905   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK02JUL/DALWN0980//ETWN&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FHE PAX 526-2520264697&amp;
  8 FP CA&amp;
  * ES/G 02JUL/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="155" beginLine="154" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:15.399291 - 02 Jul 2024"><TEXT><![CDATA[ttp/etrv/rt]]></TEXT></QUERY><REPLY receiveAt="14:32:16.680660 - 02 Jul 2024" filename="">OK PROCESSED - 2BT5V6&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="157" beginLine="156" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:16.680847 - 02 Jul 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="14:32:16.784370 - 02 Jul 2024" filename="">IGNORED - 2BT5V6&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" responseEndLine="178" responseBeginLine="176" endLine="174" beginLine="170" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:16.866573 - 02 Jul 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2BT5V6]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="14:32:17.095040 - 02 Jul 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:2BT5V6::020724:1232&apos;&amp;
RSI+RP:YGSU:DALWN0980:45995132+DALWN0980+EHD+DALWN0980:0447YG:020724:45995132:1232&apos;&amp;
LFT+3:P12+--- TST RLR SFP ---&apos;&amp;
STX+TST*RLR*SFP&apos;&amp;
UID+45995132:DALWN0980+A&apos;&amp;
SYS++WN:DAL&apos;&amp;
PRE+US&apos;&amp;
UID+45995132:DALWN0980+A&apos;&amp;
SYS++WN:DAL&apos;&amp;
PRE+US&apos;&amp;
UID+45995132:DALWN0980+A&apos;&amp;
SYS++WN:DAL&apos;&amp;
PRE+US&apos;&amp;
SEQ++7]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[6]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:7:26&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+FRANK::1+JAMES&apos;&amp;
ETI+:1+UN:Y:Y::FRANK:JAMES&apos;&amp;
ODI&apos;&amp;
EMS++ST:2+AIR+2&apos;&amp;
TVL+220724:0600:220724:0905+DAL+ATL+WN+2367:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+WN:2BT5V6&apos;&amp;
RPI+1+HK&apos;&amp;
STX+TSA&apos;&amp;
APD+73W:0:0205::1+:1+:N+721:M&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+220724:0600:220724:0905+DAL+ATL&apos;&amp;
IFT+ACO+AIRCRAFT OWNER SOUTHWEST AIRLINES TEXAS&apos;&amp;
DUM&apos;&amp;
SGR+BND+:2&apos;&amp;
DUM&apos;&amp;
EMS++OT:5+AP+3&apos;&amp;
LFT+3:5+NCE&apos;&amp;
EMS++OT:19+TK+4&apos;&amp;
TKE++OK:020724::DALWN0980:::ET:WN&apos;&amp;
EMS++OT:12+SSR+5&apos;&amp;
SSR+DOCS:HK:1:WN:::::P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/JAMES/H&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:26+RM+6&apos;&amp;
MIR+RM::NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN\: FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS - GGAMAUSHAZ&apos;&amp;
ERM+RM::NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN\: FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS - GGAMAUSHAZ&apos;&amp;
REF+ST:2&apos;&amp;
EMS++OT:30+FA+7&apos;&amp;
LFT+3:P06+PAX 526-2520264697/ETWN/02JUL24/DALWN0980/45995132&apos;&amp;
REF+ST:2*PT:1&apos;&amp;
EMS++OT:6+FP+8&apos;&amp;
LFT+3:16+CA&apos;&amp;
EMS++OT:0+ES&apos;&amp;
ISI+NCE1A0950:B+020724:YGSU:DALWN0980+G]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="28" endLine="188" beginLine="187" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 1
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:17.096362 - 02 Jul 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="14:32:17.178144 - 02 Jul 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240702:1232+0079XE327Y0002+00LH27L07K0002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+09CC2B44&apos;&amp;
UCI+00LH27L07K0002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+0079XE327Y0002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="28"><QUERY filename="" loop="0" sentAt="14:32:17.178588 - 02 Jul 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="29" responseEndLine="219" responseBeginLine="206" endLine="204" beginLine="198" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="looping"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:17.401459 - 02 Jul 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[++++FR:EUR:FR+A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2BT5V6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[02JUL24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[5]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 70: Missing character(s)" compareAt="14:32:17.518361 - 02 Jul 2024"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2BT5V6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[02JUL24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[5]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2BT5V6]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[5]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="29" responseEndLine="219" responseBeginLine="206" endLine="204" beginLine="198" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="1" sentAt="14:32:20.521874 - 02 Jul 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[++++FR:EUR:FR+A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2BT5V6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[02JUL24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[5]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 70: Missing character(s)" compareAt="14:32:20.623947 - 02 Jul 2024"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2BT5V6]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[02JUL24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[5]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2BT5V6]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[5]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="30" responseEndLine="240" responseBeginLine="234" endLine="232" beginLine="228" filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/SCOOP_9388_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/08_Revalidate_Ticket.cry" loop="0" sentAt="14:32:23.724466 - 02 Jul 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="14:32:23.805077 - 02 Jul 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PUPIRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+01HLMGQZUT0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PUPIRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[BLB+{*}+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C{%raw_binary%=(multi).*}UNT\x1D2\x1D1\x1C&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION></TRANSACTION><ERROR filename="" line="254" severity="Fatal Error">The variable &apos;global_regression.openpnr_payload&apos; is not defined</ERROR><STATISTIC><STATISTIC_ELEMENT name="Message in">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">12943</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">1358</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">5</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">31</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.96875</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">21666.4</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.299</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">9305.93</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">42</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">2</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">2</STATISTIC_ELEMENT></STATISTIC></xml>