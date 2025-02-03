<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry"><SCRIPT type="Initialize">import json
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
        assert_equal(expected=OFFICE_AY_01, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        #Check hisotryChangeLog data for exempted service SSR VGML
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=6, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]
        changeLog_3 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][2]
        changeLog_4 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][3]
        changeLog_5 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][4]
        changeLog_6 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][5]

        #First changeLog section
        assert_equal(actual=changeLog_1[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_1[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_1[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-NM-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_1[&apos;path&apos;], expected=&quot;travelers&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Second changeLog section
        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-AIR-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&quot;products&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Third changeLog section
        assert_equal(actual=changeLog_3[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_3[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_3[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-BKG-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_3[&apos;path&apos;], expected=&quot;products/airSegment/deliveries&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Fourth changeLog section
        assert_equal(actual=changeLog_4[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_4[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_4[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-AP-3&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_4[&apos;path&apos;], expected=&quot;contacts&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Fifth changeLog section
        assert_equal(actual=changeLog_5[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_5[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_5[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-TK-2&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_5[&apos;path&apos;], expected=&quot;automatedProcesses&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Sixth changeLog section
        assert_equal(actual=changeLog_6[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_6[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_6[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-SSR-4&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_6[&apos;path&apos;], expected=&quot;products&quot;, item_name=&apos;historyChangeLog path&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="114" beginLine="113" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:55.427626 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:16:55.476634 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="115" beginLine="114" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:55.477194 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:16:55.527724 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="116" beginLine="115" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:55.527938 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:16:55.590231 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="123" beginLine="122" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:55.590426 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:16:55.642358 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="125" beginLine="124" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:57.654739 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:16:57.709054 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="131" responseBeginLine="131" endLine="129" beginLine="128" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:57.709878 - 27 Jun 2024"><TEXT><![CDATA[Ji]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="OFFICE_AY_01"><VALUE><![CDATA[CDG7S0002]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:16:57.886540 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="140" beginLine="139" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:57.887539 - 27 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1AFIO/PFCU]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="08:16:57.988216 - 27 Jun 2024" filename="">RP/CDG7S0002/&amp;
  1.AFIO/PFCU&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="141" beginLine="140" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:57.988636 - 27 Jun 2024"><TEXT><![CDATA[an18aprcdglhr/a6X]]></TEXT></QUERY><REPLY receiveAt="08:16:58.121945 - 27 Jun 2024" filename="">AN18APRCDGLHR/A6X&amp;
** AMADEUS AVAILABILITY - AN ** LHR HEATHROW.GB              295 FR 18APR 0000&amp;
 1   6X9806  F9 AL J9 DL I9 Y9 B9 /CDG   LHR    0730    0800  E0/777       1:30&amp;
             H9 K9 M9 L9 N9 O9 Q9 GL&amp;
 2   6X 303  C9 D9 I9 UL Y9 B9 H9 /CDG 1 LHR 4  0745    0815  E0/319       1:30&amp;
             K9 M9 L9 N9 O9 Q9 GL&amp;
 3   6X 301  C9 D9 I9 UL Y9 B9 H9 /CDG   LHR    0745    0815  E0/319       1:30&amp;
             K9 M9 L9 N9 O9 Q9 GL&amp;
 4   6X 301A C9 D9 I9 U9 Y9 B9 H9 /CDG   LHR    0745    0815  E0/319       1:30&amp;
             K9 M9 L9 V9 N9 O9 S9 Q9 G9 X9 E9&amp;
 5   6X7060  J9 Y9                /CDG   LHR    0920    0930   0/738       1:10&amp;
 6   6X7061  J9 Y9                /CDG   LHR    0920    0930   0/738       1:10&amp;
 7   6X7062  J9 Y9                /CDG   LHR    0920    0930   0/738       1:10&amp;
 8   6X7063  J9 Y9                /CDG   LHR    0920    0930   0/738       1:10&amp;
 9   6X7064  J9 Y9                /CDG   LHR    0920    0930   0/738       1:10&amp;
10   6X7065  J9 Y9                /CDG   LHR    0920    0930   0/738       1:10&amp;
11   6X7066  J9 Y9                /CDG   LHR    0920    0930   0/738       1:10&amp;
12   6X7067  J9 Y9                /CDG   LHR    0920    0930   0/738       1:10&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="142" beginLine="141" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:58.122318 - 27 Jun 2024"><TEXT><![CDATA[SS1Y1]]></TEXT></QUERY><REPLY receiveAt="08:16:58.479536 - 27 Jun 2024" filename="">RP/CDG7S0002/&amp;
  1.AFIO/PFCU&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   777 E 0&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="143" beginLine="142" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:58.480323 - 27 Jun 2024"><TEXT><![CDATA[TKOK; APOK; RFYG]]></TEXT></QUERY><REPLY receiveAt="08:16:58.657144 - 27 Jun 2024" filename="">RP/CDG7S0002/&amp;
RF YG&amp;
  1.AFIO/PFCU&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   777 E 0&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="146" beginLine="145" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:58.657531 - 27 Jun 2024"><TEXT><![CDATA[SR VGML]]></TEXT></QUERY><REPLY receiveAt="08:16:58.806036 - 27 Jun 2024" filename="">RP/CDG7S0002/&amp;
RF YG&amp;
  1.AFIO/PFCU&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   777 E 0&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
  5 #SSR VGML 6X HK1/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="153" responseBeginLine="150" endLine="148" beginLine="147" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:58.806515 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="08:16:59.254628 - 27 Jun 2024" match="OK"><TEXT><![CDATA[--- RLR ---&amp;
RP/]]></TEXT><VARIABLE name="OFFICE_AY_01"><VALUE><![CDATA[CDG7S0002]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="OFFICE_AY_01"><VALUE><![CDATA[CDG7S0002]]></VALUE></VARIABLE><TEXT><![CDATA[            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[27JUN24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0616]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8ROYV9]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?#SSR}]]></EXPRESSION><VALUE><![CDATA[  1.AFIO/PFCU&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   *1A/E*&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
  5 #SSR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ VGML 6X HK1/S2&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" endLine="157" beginLine="156" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:59.255215 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:16:59.322322 - 27 Jun 2024" filename="">IGNORED - 8ROYV9&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="158" beginLine="157" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:59.322727 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:16:59.443367 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" endLine="159" beginLine="158" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:59.443765 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:16:59.511953 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="16" endLine="165" beginLine="164" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><COMMENT> 3. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:16:59.512514 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:16:59.565219 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" endLine="167" beginLine="166" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:01.574679 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:17:01.629294 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18" responseEndLine="171" responseBeginLine="171" endLine="169" beginLine="168" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:01.630067 - 27 Jun 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:17:01.813820 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="191" responseBeginLine="189" endLine="187" beginLine="183" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:01.816230 - 27 Jun 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROYV9]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:17:02.119820 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8ROYV9::270624:0617&apos;&amp;
RSI+RP:AASU:CDG7S0002+CDG7S0002+CDG+CDG7S0002:0447YG:270624::0616&apos;&amp;
LFT+3:P12+--- RLR ---&apos;&amp;
STX+RLR&apos;&amp;
UID+:CDG7S0002&apos;&amp;
SYS++7S:CDG&apos;&amp;
PRE+FR&apos;&amp;
UID+:CDG7S0002&apos;&amp;
SYS++7S:CDG&apos;&amp;
PRE+FR&apos;&amp;
UID+:NCE1A07CE+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2025:4:22&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+AFIO::1+PFCU&apos;&amp;
ETI+:1+UN:Y:Y::AFIO:PFCU&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+180425:0730:180425:0800+CDG+LHR+6X+9806:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8ROYV9&apos;&amp;
RPI+1+HK&apos;&amp;
APD+777:0:0130::5+++216:M&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+180425:0730:180425:0800+CDG+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:3+AP+3&apos;&amp;
LFT+3:5+OK&apos;&amp;
EMS++OT:2+TK+4&apos;&amp;
TKE++OK:270624::CDG7S0002&apos;&amp;
EMS++OT:4+SSR+5&apos;&amp;
SSR+VGML:HK:1:6X&apos;&amp;
PTS+++++G+0AR&apos;&amp;
STX+EXE&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:8+OPC+6&apos;&amp;
OPE+CDG7S0002:170425:1:8:6X CANCELLATION DUE TO NO TICKET CDG TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="19"><QUERY filename="" loop="0" sentAt="08:17:02.120913 - 27 Jun 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="224" responseBeginLine="211" endLine="209" beginLine="203" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:02.176447 - 27 Jun 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROYV9]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:17:02.244343 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROYV9]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROYV9]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240627\:06\:16\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:16:59]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4450611178]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:16:59]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="244" responseBeginLine="238" endLine="237" beginLine="233" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:02.245320 - 27 Jun 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4450611178]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:06:27:06:16:59]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:17:02.295198 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4450611178]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:16:59]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1848]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\x98\x0E\x12\xBB\x0D\x0A\x118ROYV9-2024-06-27\x12\x03pnr\x1A\x068ROYV9&quot;\x010:S\x1A\x142024-06-27T06:16:00Z&quot;*\x0A\x0F\x0A\x09CDG7S0002\x1A\x027S\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02FR2\x03CDG*\x0FYG-1A/YOANNTESTJ\x82\x04\x1A\x142024-06-27T06:16:58Z&quot;\x0D\x0A\x0B\x0A\x09CDG7S0002*\x02YG:H\x12\x10historyChangeLog\x18\x01&quot;\x1A8ROYV9-2024-06-27-PNR-NM-1*\x0Bstakeholder2\x09travelers:D\x12\x10historyChangeLog\x18\x01&quot;\x1B8ROYV9-2024-06-27-PNR-AIR-1*\x07product2\x08products:c\x12\x10historyChangeLog\x18\x01&quot;\x1B8ROYV9-2024-06-27-PNR-BKG-1*\x10segment-delivery2\x1Eproducts/airSegment/deliveries:C\x12\x10historyChangeLog\x18\x01&quot;\x1A8ROYV9-2024-06-27-PNR-AP-3*\x07contact2\x08contacts:W\x12\x10historyChangeLog\x18\x01&quot;\x1A8ROYV9-2024-06-27-PNR-TK-2*\x11automated-process2\x12automatedProcesses:D\x12\x10historyChangeLog\x18\x01&quot;\x1B8ROYV9-2024-06-27-PNR-SSR-4*\x07product2\x08productsz\x8A\x01\x0A\x0Bstakeholder\x12\x1A8ROYV9-2024-06-27-PNR-NM-1&quot;\x0C\x12\x04PFCU\x1A\x04AFIOr&lt;\x0A\x07contact\x12\x1A8ROYV9-2024-06-27-PNR-AP-3\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x1061039391000144E3\x82\x01\x89\x03\x0A\x07product\x10\x01\x1A\x1B8ROYV9-2024-06-27-PNR-AIR-1&quot;\x9F\x02\x0A\x1A\x0A\x03CDG\x1A\x132025-04-18T07:30:00\x12\x1A\x0A\x03LHR\x1A\x132025-04-18T08:00:00&quot;Q\x0A\x0A\x0A\x026X\x12\x049806\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01M\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x027S\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x1A6X-9806-2025-04-18-CDG-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8ROYV9-2024-06-27-PNR-BKG-1\x1A\x106003F3910006014CZA\x0A\x0Bstakeholder\x12\x1A8ROYV9-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00:=\x0A\x07product\x12\x1B8ROYV9-2024-06-27-PNR-SSR-4\x1A\x15processedPnr.products\x82\x01\xD4\x01\x0A\x07product\x10\x02\x1A\x1B8ROYV9-2024-06-27-PNR-SSR-4*(\x1A\x04VGML \x01*\x04\x0A\x026X2\x02HK:\x02\x08\x01b\x08\x0A\x01G\x12\x030AR\x82\x01\x02\x08\x00\x90\x01\x04:=\x0A\x07product\x12\x1B8ROYV9-2024-06-27-PNR-AIR-1\x1A\x15processedPnr.productsBA\x0A\x0Bstakeholder\x12\x1A8ROYV9-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01p\x0A\x07contact\x12\x1A8ROYV9-2024-06-27-PNR-AP-3@\x01Z\x04\x0A\x02OKbA\x0A\x0Bstakeholder\x12\x1A8ROYV9-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8ROYV9-2024-06-27-PNR-TK-2\x18\x05&quot;\x132024-06-27T00:00:00*\x0B\x0A\x09CDG7S0002ZA\x0A\x0Bstakeholder\x12\x1A8ROYV9-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8ROYV9-2024-06-27-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068ROYV9\x1A\x010&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="22" responseEndLine="271" responseBeginLine="265" endLine="263" beginLine="258" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:02.297583 - 27 Jun 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik1UTTFNekExTmpNM056VXdOek13Tnc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDYtMjdUMDY6MTY6NTQuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJaZGFxZEc2N1IwWkJzZ1lSTnE4eElqa1NTQ2s9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4Uk9ZVjktMjAyNC0wNi0yNxIDcG5yGgY4Uk9ZVjkiATA6UxoUMjAyNC0wNi0yN1QwNjoxNjowMFoiKgoPCglDREc3UzAwMDIaAjdTEhcKBDA0NDcSAllHGgJTVSoCRlIyA0NERyoPWUctMUEvWU9BTk5URVNUSoIEGhQyMDI0LTA2LTI3VDA2OjE2OjU4WiINCgsKCUNERzdTMDAwMioCWUc6SBIQaGlzdG9yeUNoYW5nZUxvZxgBIho4Uk9ZVjktMjAyNC0wNi0yNy1QTlItTk0tMSoLc3Rha2Vob2xkZXIyCXRyYXZlbGVyczpEEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGzhST1lWOS0yMDI0LTA2LTI3LVBOUi1BSVItMSoHcHJvZHVjdDIIcHJvZHVjdHM6YxIQaGlzdG9yeUNoYW5nZUxvZxgBIhs4Uk9ZVjktMjAyNC0wNi0yNy1QTlItQktHLTEqEHNlZ21lbnQtZGVsaXZlcnkyHnByb2R1Y3RzL2FpclNlZ21lbnQvZGVsaXZlcmllczpDEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGjhST1lWOS0yMDI0LTA2LTI3LVBOUi1BUC0zKgdjb250YWN0Mghjb250YWN0czpXEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGjhST1lWOS0yMDI0LTA2LTI3LVBOUi1USy0yKhFhdXRvbWF0ZWQtcHJvY2VzczISYXV0b21hdGVkUHJvY2Vzc2VzOkQSEGhpc3RvcnlDaGFuZ2VMb2cYASIbOFJPWVY5LTIwMjQtMDYtMjctUE5SLVNTUi00Kgdwcm9kdWN0Mghwcm9kdWN0c3qKAQoLc3Rha2Vob2xkZXISGjhST1lWOS0yMDI0LTA2LTI3LVBOUi1OTS0xIgwSBFBGQ1UaBEFGSU9yPAoHY29udGFjdBIaOFJPWVY5LTIwMjQtMDYtMjctUE5SLUFQLTMaFXByb2Nlc3NlZFBuci5jb250YWN0c6IBEhIQNjEwMzkzOTEwMDAxNDRFM4IBiQMKB3Byb2R1Y3QQARobOFJPWVY5LTIwMjQtMDYtMjctUE5SLUFJUi0xIp8CChoKA0NERxoTMjAyNS0wNC0xOFQwNzozMDowMBIaCgNMSFIaEzIwMjUtMDQtMThUMDg6MDA6MDAiUQoKCgI2WBIEOTgwNhInCgFZEgMKAU0aFAoCCAASDAoEGgI3UxIEKgJGUiABIgdFQ09OT01ZMho2WC05ODA2LTIwMjUtMDQtMTgtQ0RHLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzhST1lWOS0yMDI0LTA2LTI3LVBOUi1CS0ctMRoQNjAwM0YzOTEwMDA2MDE0Q1pBCgtzdGFrZWhvbGRlchIaOFJPWVY5LTIwMjQtMDYtMjctUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgECCAA6PQoHcHJvZHVjdBIbOFJPWVY5LTIwMjQtMDYtMjctUE5SLVNTUi00GhVwcm9jZXNzZWRQbnIucHJvZHVjdHOCAdQBCgdwcm9kdWN0EAIaGzhST1lWOS0yMDI0LTA2LTI3LVBOUi1TU1ItNCooGgRWR01MIAEqBAoCNlgyAkhLOgIIAWIICgFHEgMwQVKCAQIIAJABBDo9Cgdwcm9kdWN0Ehs4Uk9ZVjktMjAyNC0wNi0yNy1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0c0JBCgtzdGFrZWhvbGRlchIaOFJPWVY5LTIwMjQtMDYtMjctUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOyAXAKB2NvbnRhY3QSGjhST1lWOS0yMDI0LTA2LTI3LVBOUi1BUC0zQAFaBAoCT0tiQQoLc3Rha2Vob2xkZXISGjhST1lWOS0yMDI0LTA2LTI3LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGjhST1lWOS0yMDI0LTA2LTI3LVBOUi1USy0yGAUiEzIwMjQtMDYtMjdUMDA6MDA6MDAqCwoJQ0RHN1MwMDAyWkEKC3N0YWtlaG9sZGVyEho4Uk9ZVjktMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0Ehs4Uk9ZVjktMjAyNC0wNi0yNy1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="08:17:02.449779 - 27 Jun 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KUT0DFQ6SE]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[3553]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8ROYV9-2024-06-27&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8ROYV9&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:16:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;CDG7S0002&quot;, &amp;
                &quot;systemCode&quot;: &quot;7S&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;0447&quot;, &amp;
                &quot;initials&quot;: &quot;YG&quot;, &amp;
                &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                &quot;countryCode&quot;: &quot;FR&quot;, &amp;
                &quot;cityCode&quot;: &quot;CDG&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;YG-1A/YOANNTEST&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:16:58Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;CDG7S0002&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;YG&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROYV9-2024-06-27-PNR-NM-1&quot;, &amp;
                &quot;elementType&quot;: &quot;stakeholder&quot;, &amp;
                &quot;path&quot;: &quot;travelers&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROYV9-2024-06-27-PNR-AIR-1&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROYV9-2024-06-27-PNR-BKG-1&quot;, &amp;
                &quot;elementType&quot;: &quot;segment-delivery&quot;, &amp;
                &quot;path&quot;: &quot;products/airSegment/deliveries&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROYV9-2024-06-27-PNR-AP-3&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROYV9-2024-06-27-PNR-TK-2&quot;, &amp;
                &quot;elementType&quot;: &quot;automated-process&quot;, &amp;
                &quot;path&quot;: &quot;automatedProcesses&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROYV9-2024-06-27-PNR-SSR-4&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;PFCU&quot;, &amp;
                    &quot;lastName&quot;: &quot;AFIO&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-AP-3&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;61039391000144E3&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;CDG&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2025-04-18T07:30:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2025-04-18T08:00:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;9806&quot;&amp;
                    \}, &amp;
                    &quot;bookingClass&quot;: \{&amp;
                        &quot;code&quot;: &quot;Y&quot;, &amp;
                        &quot;cabin&quot;: \{&amp;
                            &quot;code&quot;: &quot;M&quot;&amp;
                        \}, &amp;
                        &quot;subClass&quot;: \{&amp;
                            &quot;code&quot;: 0, &amp;
                            &quot;pointOfSale&quot;: \{&amp;
                                &quot;office&quot;: \{&amp;
                                    &quot;systemCode&quot;: &quot;7S&quot;&amp;
                                \}, &amp;
                                &quot;login&quot;: \{&amp;
                                    &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                        \}, &amp;
                        &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-9806-2025-04-18-CDG-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6003F3910006014C&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-NM-1&quot;, &amp;
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
                    &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-SSR-4&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;SERVICE&quot;, &amp;
            &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-SSR-4&quot;, &amp;
            &quot;service&quot;: \{&amp;
                &quot;code&quot;: &quot;VGML&quot;, &amp;
                &quot;subType&quot;: &quot;SPECIAL_SERVICE_REQUEST&quot;, &amp;
                &quot;serviceProvider&quot;: \{&amp;
                    &quot;code&quot;: &quot;6X&quot;&amp;
                \}, &amp;
                &quot;status&quot;: &quot;HK&quot;, &amp;
                &quot;nip&quot;: 1, &amp;
                &quot;priceCategory&quot;: \{&amp;
                    &quot;code&quot;: &quot;G&quot;, &amp;
                    &quot;subCode&quot;: &quot;0AR&quot;&amp;
                \}, &amp;
                &quot;isChargeable&quot;: false, &amp;
                &quot;paymentStatus&quot;: &quot;EXEMPTED&quot;&amp;
            \}, &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-AP-3&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;OK&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-TK-2&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-06-27T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;CDG7S0002&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8ROYV9-2024-06-27-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="23" endLine="285" beginLine="284" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:02.451299 - 27 Jun 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="08:17:02.534148 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="286" beginLine="285" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:02.534542 - 27 Jun 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="08:17:02.620076 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="287" beginLine="286" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:02.620495 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:17:02.690799 - 27 Jun 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="291" beginLine="290" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:02.691126 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:17:02.815335 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="292" beginLine="291" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SSR_Feed.cry" loop="0" sentAt="08:17:02.815602 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:17:02.881791 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">16115</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">3723</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.964286</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">7463.9</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.348</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">3375.02</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">45</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>