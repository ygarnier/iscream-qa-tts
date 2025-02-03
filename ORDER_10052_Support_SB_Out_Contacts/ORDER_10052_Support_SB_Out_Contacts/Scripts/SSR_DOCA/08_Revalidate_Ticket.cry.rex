<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry"><SCRIPT type="Initialize">import json
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

</SCRIPT><TRANSACTION transactionCounter="1" endLine="88" beginLine="87" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:17.747026 - 28 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="18:26:17.830584 - 28 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="89" beginLine="88" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:17.831454 - 28 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="18:26:17.911839 - 28 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="90" beginLine="89" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:17.912124 - 28 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="18:26:18.046182 - 28 Aug 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="97" beginLine="96" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:18.047063 - 28 Aug 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="18:26:18.130556 - 28 Aug 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="99" beginLine="98" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:20.133685 - 28 Aug 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="18:26:20.219000 - 28 Aug 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="105" responseBeginLine="105" endLine="103" beginLine="102" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:20.219880 - 28 Aug 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.DALWN0980-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[GVxyuXx77768bg+]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="18:26:20.409046 - 28 Aug 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/28AUG/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="114" beginLine="113" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:20.410514 - 28 Aug 2024"><TEXT><![CDATA[NM1FRANK/JAMES]]></TEXT></QUERY><REPLY receiveAt="18:26:20.538767 - 28 Aug 2024" filename="">RP/DALWN0980/&amp;
  1.FRANK/JAMES&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="115" beginLine="114" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:20.539382 - 28 Aug 2024"><TEXT><![CDATA[AN20OCT DALATL]]></TEXT></QUERY><REPLY receiveAt="18:26:20.779850 - 28 Aug 2024" filename="">AN20OCTDALATL&amp;
** SOUTHWEST AIRLINES TEXAS - AN ** ATL ATLANTA.USGA          53 SU 20OCT 0000&amp;
 1   WN3531  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  0640    0935  E0/7M8       1:55&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9 A9 J9&amp;
 2   WN1371  Y9 X9 K9 L9 B9 Q5    /DAL 1 ATL N  0815    1110  E0/7M8       1:55&amp;
 3   WN 470  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  1320    1615  E0/73H N     1:55&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 4   WN 350  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  1610    1910  E0/7M8       2:00&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9&amp;
 5   WN2458  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  1825    2125  E0/7M8       2:00&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9&amp;
 6   WN1336  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 ATL N  2200    0055+1E0/73W       1:55&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9 A9 J9&amp;
 7   WN6546  Y9 X9 K9 Q9 H9 W9 R9 /DAL 1 DEN    1300    1400  E0/73H N&amp;
             O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9 A9 J9 D9 V9&amp;
     WN 243  Y9 X9 K9 L9 B9 Q9 H9 /DEN   ATL    1500    1730  E0/73W       3:30&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P9 U9 G9 E9 Z9 F9 A9 J9 D9 V9&amp;
 8   WN 352  Y9 X9 K9 L9 B9 Q9 H9 /DAL 1 MSY    1730    1855  E0/73W&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P6&amp;
     WN4365  Y9 X9 K9 L9 B9 Q9 H9 /MSY   ATL N  1945    2205  E0/73W       3:35&amp;
             W9 R9 O9 M9 S9 N9 T9 I9 C9 P6&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="116" beginLine="115" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:20.780412 - 28 Aug 2024"><TEXT><![CDATA[SS1Y1]]></TEXT></QUERY><REPLY receiveAt="18:26:21.301656 - 28 Aug 2024" filename="">--- SFP ---&amp;
RP/DALWN0980/&amp;
  1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   7M8 E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:21.302275 - 28 Aug 2024"><TEXT><![CDATA[TKOK;APNCE;RFME]]></TEXT></QUERY><REPLY receiveAt="18:26:21.516435 - 28 Aug 2024" filename="">--- SFP ---&amp;
RP/DALWN0980/&amp;
RF ME&amp;
  1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   7M8 E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/DALWN0980&amp;
  5 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="118" beginLine="117" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:21.516919 - 28 Aug 2024"><TEXT><![CDATA[FPCA]]></TEXT></QUERY><REPLY receiveAt="18:26:21.737250 - 28 Aug 2024" filename="">--- SFP ---&amp;
RP/DALWN0980/&amp;
RF ME&amp;
  1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   7M8 E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/DALWN0980&amp;
  5 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  6 FP CA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" endLine="119" beginLine="118" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:21.737866 - 28 Aug 2024"><TEXT><![CDATA[FXP]]></TEXT></QUERY><REPLY receiveAt="18:26:22.440312 - 28 Aug 2024" filename="">FXP&amp;
&amp;
01 FRANK/JAMES&amp;
&amp;
LAST TKT DTE 29AUG24/23:59 LT in POS - SEE ADV PURCHASE&amp;
------------------------------------------------------------&amp;
     AL FLGT  BK   DATE  TIME  FARE BASIS      NVB  NVA   BG&amp;
 DFW&amp;
 ATL WN  3531 Y    20OCT 0640  YLN0P6L                    2P&amp;
&amp;
USD   491.05      20OCT24DFW WN ATL491.05USD491.05END&amp;
                  ZP DAL5.00XT USD 5.00-ZP USD 4.50-XF DAL&amp;
USD     5.60-AY   4.50&amp;
USD    36.83-US&amp;
USD     9.50-XT&amp;
USD   542.98&amp;
FARE FAMILIES:    (ENTER FQFn FOR DETAILS, FXY FOR UPSELL)&amp;
FARE FAMILY:FC1:1:ANY&amp;
FXU/TS TO UPSELL BUS FOR -251.00USD&amp;
BG CXR: WN&amp;
PRICED WITH VALIDATING CARRIER WN - REPRICE IF DIFFERENT VC&amp;
&gt;                                                 PAGE  2/ 3&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" endLine="120" beginLine="119" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:22.440522 - 28 Aug 2024"><TEXT><![CDATA[srdocswnhk1-p-gbr-36263623-usa-31mar89-m-12apr29-frank-james-h/p1]]></TEXT></QUERY><REPLY receiveAt="18:26:22.605420 - 28 Aug 2024" filename="">--- TST SFP ---&amp;
RP/DALWN0980/&amp;
RF ME&amp;
  1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   7M8 E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/DALWN0980&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
  8 FP CA&amp;
  9 FV PAX WN/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="121" beginLine="120" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:22.611494 - 28 Aug 2024"><TEXT><![CDATA[ES ]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[-b]]></TEXT></QUERY><REPLY receiveAt="18:26:22.871982 - 28 Aug 2024" filename="">--- TST SFP ---&amp;
RP/DALWN0980/&amp;
RF ME&amp;
  1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   7M8 E 0&amp;
     SEE RTSVC - TRAFFIC RESTRICTION EXISTS&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/DALWN0980&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
  8 FP CA&amp;
  9 FV PAX WN/S2&amp;
  * ES/G B NCE1A0950&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="133" responseBeginLine="126" endLine="123" beginLine="122" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:22.872383 - 28 Aug 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="18:26:23.242188 - 28 Aug 2024" match="OK"><TEXT><![CDATA[--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[28AUG24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1626Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[2KLQYJ]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?SSR}]]></EXPRESSION><VALUE><![CDATA[1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/DALWN0980&amp;
  5 SSR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?RM}]]></EXPRESSION><VALUE><![CDATA[6 RM]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  7 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
  8 FP CA&amp;
  9 FV PAX WN/S2&amp;
  * ES/G 28AUG/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" endLine="138" beginLine="137" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:25.255283 - 28 Aug 2024"><TEXT><![CDATA[IR]]></TEXT></QUERY><REPLY receiveAt="18:26:25.463959 - 28 Aug 2024" filename="">--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            AA/SU  28AUG24/1626Z   2KLQYJ&amp;
  1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/DALWN0980&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 OPC-29AUG:2359/1C8/WN CANCELLATION DUE TO NO TICKET DAL TIME&amp;
        ZONE/TKT/S2&amp;
  7 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  8 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
  9 FP CA&amp;
 10 FV PAX WN/S2&amp;
  * ES/G 28AUG/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" endLine="139" beginLine="138" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:25.464527 - 28 Aug 2024"><TEXT><![CDATA[TTP/ET/RT]]></TEXT></QUERY><REPLY receiveAt="18:26:27.218357 - 28 Aug 2024" filename="">OK ETICKET&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18" endLine="142" beginLine="141" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:27.218558 - 28 Aug 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2KLQYJ]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="18:26:27.464253 - 28 Aug 2024" filename="">--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            YG/SU  28AUG24/1626Z   2KLQYJ&amp;
  1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/DALWN0980//ETWN&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FA PAX 526-2520495571/ETWN/USD542.98/28AUG24/DALWN0980/45995&amp;
       132/S2&amp;
  8 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  9 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
 10 FP CA&amp;
 11 FV PAX WN/S2&amp;
  * ES/G 28AUG/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="19" endLine="145" beginLine="144" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:27.464714 - 28 Aug 2024"><TEXT><![CDATA[IR]]></TEXT></QUERY><REPLY receiveAt="18:26:27.678198 - 28 Aug 2024" filename="">--- TST RLR SFP ---&amp;
RP/DALWN0980/DALWN0980            YG/SU  28AUG24/1626Z   2KLQYJ&amp;
  1.FRANK/JAMES&amp;
  2  WN3531 Y 20OCT 7 DALATL HK1       1  0640 0935   *1A/E*&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/DALWN0980//ETWN&amp;
  5 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  6 RM NOTIFY PASSENGER PRIOR TO TICKET PURCHASE \&amp; CHECK-IN:&amp;
       FEDERAL LAWS FORBID THE CARRIAGE OF HAZARDOUS MATERIALS -&amp;
       GGAMAUSHAZ/S2&amp;
  7 FA PAX 526-2520495571/ETWN/USD542.98/28AUG24/DALWN0980/45995&amp;
       132/S2&amp;
  8 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  9 FE PAX NONTRANSFERABLE -BG:WN/S2&amp;
 10 FP CA&amp;
 11 FV PAX WN/S2&amp;
  * ES/G 28AUG/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="20" endLine="146" beginLine="145" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:27.678575 - 28 Aug 2024"><TEXT><![CDATA[XE2]]></TEXT></QUERY><REPLY receiveAt="18:26:27.919772 - 28 Aug 2024" filename="">WARNING : SEGMENT DELETED - TST WILL BE DELETED IF ET/ER&amp;
ITINERARY CANCELLED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="21" endLine="147" beginLine="146" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:27.919952 - 28 Aug 2024"><TEXT><![CDATA[AN22JUL DALATL]]></TEXT></QUERY><REPLY receiveAt="18:26:28.079275 - 28 Aug 2024" filename="">AN22JULDALATL&amp;
** SOUTHWEST AIRLINES TEXAS - AN ** ATL ATLANTA.USGA         328 TU 22JUL 0000&amp;
NO AVAILABILITY FOR SELECTED PREFERENCE&amp;
NO MORE LATER FLTS   22JUL DAL ATL&amp;
CK ALT*ORIG ADS DFW JDB RBD&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="22" endLine="148" beginLine="147" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:28.079865 - 28 Aug 2024"><TEXT><![CDATA[SS1Y1]]></TEXT></QUERY><REPLY receiveAt="18:26:28.320057 - 28 Aug 2024" filename="">CHECK LINE NUMBER&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="149" beginLine="148" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:28.320227 - 28 Aug 2024"><TEXT><![CDATA[RFF]]></TEXT></QUERY><REPLY receiveAt="18:26:28.492688 - 28 Aug 2024" filename="">TICKET REVALIDATION/REISSUE IS RECOMMENDED&amp;
--- TST RLR ---&amp;
RP/DALWN0980/DALWN0980            YG/SU  28AUG24/1626Z   2KLQYJ&amp;
RF F&amp;
  1.FRANK/JAMES&amp;
  2 AP NCE&amp;
  3 TK OK28AUG/DALWN0980//ETWN&amp;
  4 SSR DOCS WN HK1 P/GBR/36263623/USA/31MAR89/M/12APR29/FRANK/J&amp;
       AMES/H&amp;
  5 FHE PAX 526-2520495571&amp;
  6 FP CA&amp;
  * ES/G 28AUG/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="151" beginLine="150" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:28.493278 - 28 Aug 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="18:26:28.659024 - 28 Aug 2024" filename="">WARNING:AIRLINE CODE NOT IN ITINERARY-SSR/OSI CANCELLED AT EOT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="152" beginLine="151" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:28.659234 - 28 Aug 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="18:26:28.956189 - 28 Aug 2024" filename="">TICKET REVALIDATION/REISSUE IS RECOMMENDED&amp;
--- TST ---&amp;
RP/DALWN0980/DALWN0980            YG/SU  28AUG24/1626Z   2KLQYJ&amp;
  1.FRANK/JAMES&amp;
  2 AP NCE&amp;
  3 TK OK28AUG/DALWN0980//ETWN&amp;
  4 FHE PAX 526-2520495571&amp;
  5 FP CA&amp;
  * ES/G 28AUG/YGSU/DALWN0980&amp;
    NCE1A0950-B&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="156" beginLine="155" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:30.959817 - 28 Aug 2024"><TEXT><![CDATA[ttp/etrv/rt]]></TEXT></QUERY><REPLY receiveAt="18:26:31.135724 - 28 Aug 2024" filename="">NEED ITINERARY&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="158" beginLine="157" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:31.135873 - 28 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="18:26:31.234490 - 28 Aug 2024" filename="">IGNORED - 2KLQYJ&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="28" responseEndLine="179" responseBeginLine="177" endLine="175" beginLine="171" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:31.308315 - 28 Aug 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2KLQYJ]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="18:26:31.487926 - 28 Aug 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[ERC+12183:INF:1A&apos;&amp;
TXF+3:::::M:1+TICKET REVALIDATION/REISSUE IS RECOMMENDED&apos;&amp;
RCI+1A:2KLQYJ::280824:1626&apos;&amp;
RSI+RP:YGSU:DALWN0980:45995132+DALWN0980+EHD+DALWN0980:1127YG:280824:45995132:1626&apos;&amp;
LFT+3:P12+--- TST ---&apos;&amp;
STX+TST&apos;&amp;
UID+45995132:DALWN0980+A&apos;&amp;
SYS++WN:DAL&apos;&amp;
PRE+US&apos;&amp;
UID+45995132:DALWN0980+A&apos;&amp;
SYS++WN:DAL&apos;&amp;
PRE+US&apos;&amp;
UID+45995132:DALWN0980+A&apos;&amp;
SYS++WN:DAL&apos;&amp;
PRE+US&apos;&amp;
SEQ++4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:10:24&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+FRANK::1+JAMES&apos;&amp;
ETI+:1+UN:Y:Y::FRANK:JAMES&apos;&amp;
DUM&apos;&amp;
EMS++OT:5+AP+2&apos;&amp;
LFT+3:5+NCE&apos;&amp;
EMS++OT:19+TK+3&apos;&amp;
TKE++OK:280824::DALWN0980:::ET:WN&apos;&amp;
EMS++OT:23+FHE+4&apos;&amp;
LFT+3:P15+PAX 526-2520495571&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:6+FP+5&apos;&amp;
LFT+3:16+CA&apos;&amp;
EMS++OT:0+ES&apos;&amp;
ISI+NCE1A0950:B+280824:YGSU:DALWN0980+G]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="29" endLine="189" beginLine="188" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 1
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:31.490363 - 28 Aug 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="18:26:31.566559 - 28 Aug 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240828:1626+01RGREGNYE0002+00LH2AIV1Z0002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+********&apos;&amp;
UCI+00LH2AIV1Z0002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+01RGREGNYE0002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="29"><QUERY filename="" loop="0" sentAt="18:26:31.567390 - 28 Aug 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="30" responseEndLine="220" responseBeginLine="207" endLine="205" beginLine="199" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:31.748370 - 28 Aug 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[++++FR:EUR:FR+A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2KLQYJ]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="18:26:32.203695 - 28 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2KLQYJ]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[2KLQYJ]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240828\:16\:26\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication_WN"><VALUE><![CDATA[599]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:16:26:27]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[0]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:16:26:27]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="31" responseEndLine="241" responseBeginLine="235" endLine="233" beginLine="229" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10052_Support_SB_Out/ORDER_10052_Support_SB_Out/Scripts/SSR_DOCA/08_Revalidate_Ticket.cry" loop="0" sentAt="18:26:32.279157 - 28 Aug 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:08:28:16:26:27]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 50: Missing character(s)" compareAt="18:26:32.354778 - 28 Aug 2024"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SONPK1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:16:26:27]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[BLB+{*}+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C{%raw_binary%=(multi).*}UNT\x1D2\x1D1\x1C&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION></TRANSACTION><ERROR filename="" line="255" severity="Fatal Error">The variable &apos;global_regression.openpnr_payload&apos; is not defined</ERROR><STATISTIC><STATISTIC_ELEMENT name="Message in">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">10141</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">1163</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">5</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">14618.1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.349</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">8254.42</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">56</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">2</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">5</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">1</STATISTIC_ELEMENT></STATISTIC></xml>