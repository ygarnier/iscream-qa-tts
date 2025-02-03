<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry"><SCRIPT type="Initialize">import json
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
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=2, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]


        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;products&apos;][0][&apos;type&apos;], expected=&apos;product&apos;, item_name=&apos;historyChangeLog service/type&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;products&apos;][0][&apos;subType&apos;], expected=&apos;SERVICE&apos;, item_name=&apos;historyChangeLog service/subType&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;products&apos;][0][&apos;id&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-SSR-4&quot;, item_name=&apos;historyChangeLog serviceid&apos;)

        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;REMOVE&apos;, item_name=&apos;changeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-SSR-4&quot;, item_name=&apos;changeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;elementType&apos;], expected=&quot;product&quot;, item_name=&apos;changeLog elementType&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&quot;products&quot;, item_name=&apos;changeLog path&apos;)

        #Check deadlinks are no more visible in &apos;products&apos; and &apos;travelers&apos; section
        # TO COMPLETE

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="88" beginLine="87" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:09.997473 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:19:10.073912 - 27 Jun 2024" filename="">IGNORED - 4GXBQT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="89" beginLine="88" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:10.074564 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:19:10.196260 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="90" beginLine="89" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:10.196704 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:19:10.261792 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="97" beginLine="96" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:10.262046 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:10.316831 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="99" beginLine="98" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:12.334695 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:12.390450 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="105" responseBeginLine="105" endLine="103" beginLine="102" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:12.391483 - 27 Jun 2024"><TEXT><![CDATA[Ji]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="OFFICE_AY_01"><VALUE><![CDATA[CDG7S0002]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:19:12.548085 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="114" beginLine="113" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:12.548674 - 27 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1AXIF/EMPK]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="08:19:12.644598 - 27 Jun 2024" filename="">RP/CDG7S0002/&amp;
  1.AXIF/EMPK&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="115" beginLine="114" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:12.645182 - 27 Jun 2024"><TEXT><![CDATA[an18aprcdglhr/a6X]]></TEXT></QUERY><REPLY receiveAt="08:19:12.777360 - 27 Jun 2024" filename="">AN18APRCDGLHR/A6X&amp;
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
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="116" beginLine="115" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:12.777799 - 27 Jun 2024"><TEXT><![CDATA[SS1Y1]]></TEXT></QUERY><REPLY receiveAt="08:19:13.123612 - 27 Jun 2024" filename="">RP/CDG7S0002/&amp;
  1.AXIF/EMPK&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   777 E 0&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:13.124071 - 27 Jun 2024"><TEXT><![CDATA[TKOK; APOK; RFYG]]></TEXT></QUERY><REPLY receiveAt="08:19:13.294898 - 27 Jun 2024" filename="">RP/CDG7S0002/&amp;
RF YG&amp;
  1.AXIF/EMPK&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   777 E 0&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="120" beginLine="119" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:13.295167 - 27 Jun 2024"><TEXT><![CDATA[SR VGML]]></TEXT></QUERY><REPLY receiveAt="08:19:13.442388 - 27 Jun 2024" filename="">RP/CDG7S0002/&amp;
RF YG&amp;
  1.AXIF/EMPK&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   777 E 0&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
  5 #SSR VGML 6X HK1/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="127" responseBeginLine="124" endLine="122" beginLine="121" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:13.443234 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="08:19:13.917126 - 27 Jun 2024" match="OK"><TEXT><![CDATA[--- RLR ---&amp;
RP/]]></TEXT><VARIABLE name="OFFICE_AY_01"><VALUE><![CDATA[CDG7S0002]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="OFFICE_AY_01"><VALUE><![CDATA[CDG7S0002]]></VALUE></VARIABLE><TEXT><![CDATA[            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[27JUN24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0619]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8RPINM]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?#SSR}]]></EXPRESSION><VALUE><![CDATA[  1.AXIF/EMPK&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   *1A/E*&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
  5 #SSR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ VGML 6X HK1/S2&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" endLine="132" beginLine="131" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:13.919422 - 27 Jun 2024"><TEXT><![CDATA[XE5]]></TEXT></QUERY><REPLY receiveAt="08:19:14.093967 - 27 Jun 2024" filename="">--- RLR ---&amp;
RP/CDG7S0002/CDG7S0002            YG/SU  27JUN24/0619Z   8RPINM&amp;
  1.AXIF/EMPK&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   *1A/E*&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="133" beginLine="132" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:14.094461 - 27 Jun 2024"><TEXT><![CDATA[RF TEST]]></TEXT></QUERY><REPLY receiveAt="08:19:14.247137 - 27 Jun 2024" filename="">--- RLR ---&amp;
RP/CDG7S0002/CDG7S0002            YG/SU  27JUN24/0619Z   8RPINM&amp;
RF TEST&amp;
  1.AXIF/EMPK&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   *1A/E*&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" endLine="134" beginLine="133" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:14.247627 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="08:19:14.708355 - 27 Jun 2024" filename="">--- RLR ---&amp;
RP/CDG7S0002/CDG7S0002            YG/SU  27JUN24/0619Z   8RPINM&amp;
  1.AXIF/EMPK&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1          0730 0800   *1A/E*&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="16" endLine="135" beginLine="134" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:14.708749 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:19:14.775265 - 27 Jun 2024" filename="">IGNORED - 8RPINM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" endLine="136" beginLine="135" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:14.775620 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:19:14.897799 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18" endLine="137" beginLine="136" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:14.898275 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:19:14.967183 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="19" endLine="143" beginLine="142" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><COMMENT> 3. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:14.967896 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:15.022928 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="20" endLine="145" beginLine="144" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:17.034534 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:17.090192 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="149" responseBeginLine="149" endLine="147" beginLine="146" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:17.090731 - 27 Jun 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:19:17.255616 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="22" responseEndLine="169" responseBeginLine="167" endLine="165" beginLine="161" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:17.257344 - 27 Jun 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RPINM]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:19:17.492182 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8RPINM::270624:0619&apos;&amp;
RSI+RP:AASU:CDG7S0002+CDG7S0002+CDG+CDG7S0002:0447YG:270624::0619&apos;&amp;
LFT+3:P12+--- RLR ---&apos;&amp;
STX+RLR&apos;&amp;
UID+:CDG7S0002&apos;&amp;
SYS++7S:CDG&apos;&amp;
PRE+FR&apos;&amp;
UID+:CDG7S0002&apos;&amp;
SYS++7S:CDG&apos;&amp;
PRE+FR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2025:4:22&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+AXIF::1+EMPK&apos;&amp;
ETI+:1+UN:Y:Y::AXIF:EMPK&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+180425:0730:180425:0800+CDG+LHR+6X+9806:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8RPINM&apos;&amp;
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
EMS++OT:8+OPC+5&apos;&amp;
OPE+CDG7S0002:170425:1:8:6X CANCELLATION DUE TO NO TICKET CDG TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="23" endLine="181" beginLine="180" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><SCRIPT type="Exec"># Decrease the envelope number by 1 to get the previous envelope number
env_num = int (env_num)
env_num = env_num - 1
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:19.500812 - 27 Jun 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="08:19:19.557996 - 27 Jun 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240627:0619+00GIVUTPN70002+00LH27B9J80002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+09CC2B44&apos;&amp;
UCI+00LH27B9J80002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+00GIVUTPN70002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23"><QUERY filename="" loop="0" sentAt="08:19:19.558851 - 27 Jun 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="24" responseEndLine="211" responseBeginLine="198" endLine="196" beginLine="190" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:19.616152 - 27 Jun 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RPINM]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:19:19.677183 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RPINM]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RPINM]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240627\:06\:19\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:19:14]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4450622579]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:19:14]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="25" responseEndLine="232" responseBeginLine="226" endLine="224" beginLine="220" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:19.678625 - 27 Jun 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4450622579]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:06:27:06:19:14]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:19:19.727289 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4450622579]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:19:14]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1408]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xE0\x0A\x12\x83\x0A\x0A\x118RPINM-2024-06-27\x12\x03pnr\x1A\x068RPINM&quot;\x011:U\x1A\x142024-06-27T06:19:00Z&quot;*\x0A\x0F\x0A\x09CDG7S0002\x1A\x027S\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02FR2\x03CDG*\x11TEST-1A/YOANNTESTJ\xDF\x02\x1A\x142024-06-27T06:19:14Z&quot;\x0D\x0A\x0B\x0A\x09CDG7S0002*\x04TEST:\xEB\x01\x12\x0FentityChangeLogB\xD7\x01z\xD4\x01\x0A\x07product\x10\x02\x1A\x1B8RPINM-2024-06-27-PNR-SSR-4*(\x1A\x04VGML \x01*\x04\x0A\x026X2\x02HK:\x02\x08\x01b\x08\x0A\x01G\x12\x030AR\x82\x01\x02\x08\x00\x90\x01\x04:=\x0A\x07product\x12\x1B8RPINM-2024-06-27-PNR-AIR-1\x1A\x15processedPnr.productsBA\x0A\x0Bstakeholder\x12\x1A8RPINM-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers:D\x12\x10historyChangeLog\x18\x02&quot;\x1B8RPINM-2024-06-27-PNR-SSR-4*\x07product2\x08productsz\x8A\x01\x0A\x0Bstakeholder\x12\x1A8RPINM-2024-06-27-PNR-NM-1&quot;\x0C\x12\x04EMPK\x1A\x04AXIFr&lt;\x0A\x07contact\x12\x1A8RPINM-2024-06-27-PNR-AP-3\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x10610383910000963D\x82\x01\xCA\x02\x0A\x07product\x10\x01\x1A\x1B8RPINM-2024-06-27-PNR-AIR-1&quot;\x9F\x02\x0A\x1A\x0A\x03CDG\x1A\x132025-04-18T07:30:00\x12\x1A\x0A\x03LHR\x1A\x132025-04-18T08:00:00&quot;Q\x0A\x0A\x0A\x026X\x12\x049806\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01M\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x027S\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x1A6X-9806-2025-04-18-CDG-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8RPINM-2024-06-27-PNR-BKG-1\x1A\x106004039200000804ZA\x0A\x0Bstakeholder\x12\x1A8RPINM-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01p\x0A\x07contact\x12\x1A8RPINM-2024-06-27-PNR-AP-3@\x01Z\x04\x0A\x02OKbA\x0A\x0Bstakeholder\x12\x1A8RPINM-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8RPINM-2024-06-27-PNR-TK-2\x18\x05&quot;\x132024-06-27T00:00:00*\x0B\x0A\x09CDG7S0002ZA\x0A\x0Bstakeholder\x12\x1A8RPINM-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8RPINM-2024-06-27-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068RPINM\x1A\x011&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="26" responseEndLine="259" responseBeginLine="253" endLine="251" beginLine="246" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:19.729238 - 27 Jun 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik5UYzFPVEkxTWpJd056VTRNelkxTVE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDYtMjdUMDY6MTk6MDguMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJqa3R5RW43Tm9jTGQ2dWxpckxvVEtVRWs2cEU9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4UlBJTk0tMjAyNC0wNi0yNxIDcG5yGgY4UlBJTk0iATE6VRoUMjAyNC0wNi0yN1QwNjoxOTowMFoiKgoPCglDREc3UzAwMDIaAjdTEhcKBDA0NDcSAllHGgJTVSoCRlIyA0NERyoRVEVTVC0xQS9ZT0FOTlRFU1RK3wIaFDIwMjQtMDYtMjdUMDY6MTk6MTRaIg0KCwoJQ0RHN1MwMDAyKgRURVNUOusBEg9lbnRpdHlDaGFuZ2VMb2dC1wF61AEKB3Byb2R1Y3QQAhobOFJQSU5NLTIwMjQtMDYtMjctUE5SLVNTUi00KigaBFZHTUwgASoECgI2WDICSEs6AggBYggKAUcSAzBBUoIBAggAkAEEOj0KB3Byb2R1Y3QSGzhSUElOTS0yMDI0LTA2LTI3LVBOUi1BSVItMRoVcHJvY2Vzc2VkUG5yLnByb2R1Y3RzQkEKC3N0YWtlaG9sZGVyEho4UlBJTk0tMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyczpEEhBoaXN0b3J5Q2hhbmdlTG9nGAIiGzhSUElOTS0yMDI0LTA2LTI3LVBOUi1TU1ItNCoHcHJvZHVjdDIIcHJvZHVjdHN6igEKC3N0YWtlaG9sZGVyEho4UlBJTk0tMjAyNC0wNi0yNy1QTlItTk0tMSIMEgRFTVBLGgRBWElGcjwKB2NvbnRhY3QSGjhSUElOTS0yMDI0LTA2LTI3LVBOUi1BUC0zGhVwcm9jZXNzZWRQbnIuY29udGFjdHOiARISEDYxMDM4MzkxMDAwMDk2M0SCAcoCCgdwcm9kdWN0EAEaGzhSUElOTS0yMDI0LTA2LTI3LVBOUi1BSVItMSKfAgoaCgNDREcaEzIwMjUtMDQtMThUMDc6MzA6MDASGgoDTEhSGhMyMDI1LTA0LTE4VDA4OjAwOjAwIlEKCgoCNlgSBDk4MDYSJwoBWRIDCgFNGhQKAggAEgwKBBoCN1MSBCoCRlIgASIHRUNPTk9NWTIaNlgtOTgwNi0yMDI1LTA0LTE4LUNERy1MSFJKAkhLYoQBChBzZWdtZW50LWRlbGl2ZXJ5Ehs4UlBJTk0tMjAyNC0wNi0yNy1QTlItQktHLTEaEDYwMDQwMzkyMDAwMDA4MDRaQQoLc3Rha2Vob2xkZXISGjhSUElOTS0yMDI0LTA2LTI3LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzigEBRZIBAggAsgFwCgdjb250YWN0Eho4UlBJTk0tMjAyNC0wNi0yNy1QTlItQVAtM0ABWgQKAk9LYkEKC3N0YWtlaG9sZGVyEho4UlBJTk0tMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEho4UlBJTk0tMjAyNC0wNi0yNy1QTlItVEstMhgFIhMyMDI0LTA2LTI3VDAwOjAwOjAwKgsKCUNERzdTMDAwMlpBCgtzdGFrZWhvbGRlchIaOFJQSU5NLTIwMjQtMDYtMjctUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbOFJQSU5NLTIwMjQtMDYtMjctUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="08:19:19.878023 - 27 Jun 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KUT4KFQ6W7]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2802]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8RPINM-2024-06-27&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8RPINM&quot;, &amp;
    &quot;version&quot;: &quot;1&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:19:00Z&quot;, &amp;
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
        &quot;comment&quot;: &quot;TEST-1A/YOANNTEST&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:19:14Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;CDG7S0002&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;TEST&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;entityChangeLog&quot;, &amp;
                &quot;oldEntity&quot;: \{&amp;
                    &quot;products&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;product&quot;, &amp;
                            &quot;subType&quot;: &quot;SERVICE&quot;, &amp;
                            &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-SSR-4&quot;, &amp;
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
                                    &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-AIR-1&quot;, &amp;
                                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                                \}&amp;
                            ], &amp;
                            &quot;travelers&quot;: [&amp;
                                \{&amp;
                                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                                    &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-NM-1&quot;, &amp;
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
                &quot;elementId&quot;: &quot;8RPINM-2024-06-27-PNR-SSR-4&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;EMPK&quot;, &amp;
                    &quot;lastName&quot;: &quot;AXIF&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-AP-3&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610383910000963D&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-AIR-1&quot;, &amp;
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
                        &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6004039200000804&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-AP-3&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;OK&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-TK-2&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-06-27T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;CDG7S0002&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8RPINM-2024-06-27-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="27" endLine="272" beginLine="271" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:19.879511 - 27 Jun 2024"><TEXT><![CDATA[RT]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RPINM]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:20.091345 - 27 Jun 2024" filename="">--- RLR ---&amp;
RP/CDG7S0002/CDG7S0002            AA/SU  27JUN24/0619Z   8RPINM&amp;
  1.AXIF/EMPK&amp;
  2  6X9806 Y 18APR 5 CDGLHR HK1  0730 0800  18APR  E  6X/8RPINM&amp;
  3 AP OK&amp;
  4 TK OK27JUN/CDG7S0002&amp;
  5 OPC-17APR:2300/1C8/6X CANCELLATION DUE TO NO TICKET CDG TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="28" endLine="273" beginLine="272" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:20.091843 - 27 Jun 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="08:19:20.800337 - 27 Jun 2024" filename="">--- RLR ---&amp;
RP/CDG7S0002/CDG7S0002            AA/SU  27JUN24/0619Z   8RPINM&amp;
  1.AXIF/EMPK&amp;
  2 AP OK&amp;
  3 TK OK27JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="29" endLine="274" beginLine="273" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:20.800885 - 27 Jun 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="08:19:21.710500 - 27 Jun 2024" filename="">END OF TRANSACTION COMPLETE - 8RPINM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="30" endLine="275" beginLine="274" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:21.711055 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:19:21.784853 - 27 Jun 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="31" endLine="279" beginLine="278" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:21.785422 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:19:21.909590 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="32" endLine="280" beginLine="279" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SSR_Feed.cry" loop="0" sentAt="08:19:21.910124 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:19:21.977856 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">33</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">16340</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">33</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">3291</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">33</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">32</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.969697</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">11990.4</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.539</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">5852.44</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">48</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">2</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>