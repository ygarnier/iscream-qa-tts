<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry"><SCRIPT type="Initialize">import json
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
        assert_equal(expected=OFFICE_6X_BKK, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        #Check hisotryChangeLog data for exempted service SSR SVC
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=2, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]


        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;products&apos;][0][&apos;type&apos;], expected=&apos;product&apos;, item_name=&apos;historyChangeLog service/type&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;products&apos;][0][&apos;subType&apos;], expected=&apos;SERVICE&apos;, item_name=&apos;historyChangeLog service/subType&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;products&apos;][0][&apos;id&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-SVX-2&quot;, item_name=&apos;historyChangeLog serviceid&apos;)

        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;REMOVE&apos;, item_name=&apos;changeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-SVX-2&quot;, item_name=&apos;changeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;elementType&apos;], expected=&quot;product&quot;, item_name=&apos;changeLog elementType&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&quot;products&quot;, item_name=&apos;changeLog path&apos;)

        #Check deadlinks are no more visible in &apos;products&apos; and &apos;travelers&apos; section
        # TO COMPLETE

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="88" beginLine="87" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:23.824971 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:19:23.877314 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="89" beginLine="88" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:23.877760 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:19:23.933371 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="90" beginLine="89" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:23.933565 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:19:24.001224 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="97" beginLine="96" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:24.001460 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:24.057239 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="99" beginLine="98" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:26.064217 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:26.122476 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="105" responseBeginLine="105" endLine="103" beginLine="102" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:26.123566 - 27 Jun 2024"><TEXT><![CDATA[Ji]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="OFFICE_6X_BKK"><VALUE><![CDATA[BKK6X08AA]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:19:26.298415 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="114" beginLine="113" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:26.300323 - 27 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1AVAB/IPYN]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="08:19:26.397546 - 27 Jun 2024" filename="">RP/BKK6X08AA/&amp;
  1.AVAB/IPYN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="115" beginLine="114" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:26.398590 - 27 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight_6X_daily.book(1)}]]></EXPRESSION><VALUE><![CDATA[SS6X562Y19AUGNCELHR1]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="08:19:26.728574 - 27 Jun 2024" filename="">RP/BKK6X08AA/&amp;
  1.AVAB/IPYN&amp;
  2  6X 562 Y 19AUG 1 NCELHR HK1          0600 0710   ERJ E 0 CM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="116" beginLine="115" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:26.729373 - 27 Jun 2024"><TEXT><![CDATA[TKOK; APOK; RFYG]]></TEXT></QUERY><REPLY receiveAt="08:19:26.900418 - 27 Jun 2024" filename="">RP/BKK6X08AA/&amp;
RF YG&amp;
  1.AVAB/IPYN&amp;
  2  6X 562 Y 19AUG 1 NCELHR HK1          0600 0710   ERJ E 0 CM&amp;
  3 AP OK&amp;
  4 TK OK27JUN/BKK6X08AA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="119" beginLine="118" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:26.900837 - 27 Jun 2024"><TEXT><![CDATA[IU 6X NN1 GIFT BDQ/13SEP]]></TEXT></QUERY><REPLY receiveAt="08:19:27.038720 - 27 Jun 2024" filename="">RP/BKK6X08AA/&amp;
RF YG&amp;
  1.AVAB/IPYN&amp;
  2  6X 562 Y 19AUG 1 NCELHR HK1          0600 0710   ERJ E 0 CM&amp;
  3 #SVC 6X HK1 GIFT BDQ 13SEP&amp;
  4 AP OK&amp;
  5 TK OK27JUN/BKK6X08AA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="126" responseBeginLine="123" endLine="121" beginLine="120" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:27.039149 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="08:19:27.549035 - 27 Jun 2024" match="OK"><TEXT><![CDATA[--- RLR ---&amp;
RP/]]></TEXT><VARIABLE name="OFFICE_6X_BKK"><VALUE><![CDATA[BKK6X08AA]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="OFFICE_6X_BKK"><VALUE><![CDATA[BKK6X08AA]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 27JUN24/0619]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8RQ37Q]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?#SVC}]]></EXPRESSION><VALUE><![CDATA[  1.AVAB/IPYN&amp;
  2  6X 562 Y 19AUG 1 NCELHR HK1          0600 0710   *1A/E*&amp;
  3 #SVC]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ 6X HK1 GIFT BDQ 13SEP&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  4 AP OK&amp;
  5 TK OK27JUN/BKK6X08AA&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="12" endLine="131" beginLine="130" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:27.551237 - 27 Jun 2024"><TEXT><![CDATA[XE3]]></TEXT></QUERY><REPLY receiveAt="08:19:27.733004 - 27 Jun 2024" filename="">--- RLR ---&amp;
RP/BKK6X08AA/BKK6X08AA            YG/SU  27JUN24/0619Z   8RQ37Q&amp;
  1.AVAB/IPYN&amp;
  2  6X 562 Y 19AUG 1 NCELHR HK1          0600 0710   *1A/E*&amp;
  3 AP OK&amp;
  4 TK OK27JUN/BKK6X08AA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" endLine="133" beginLine="132" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:27.733548 - 27 Jun 2024"><TEXT><![CDATA[RF OK]]></TEXT></QUERY><REPLY receiveAt="08:19:27.879002 - 27 Jun 2024" filename="">--- RLR ---&amp;
RP/BKK6X08AA/BKK6X08AA            YG/SU  27JUN24/0619Z   8RQ37Q&amp;
RF OK&amp;
  1.AVAB/IPYN&amp;
  2  6X 562 Y 19AUG 1 NCELHR HK1          0600 0710   *1A/E*&amp;
  3 AP OK&amp;
  4 TK OK27JUN/BKK6X08AA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="135" beginLine="134" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:27.879281 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="08:19:28.316460 - 27 Jun 2024" filename="">--- RLR ---&amp;
RP/BKK6X08AA/BKK6X08AA            YG/SU  27JUN24/0619Z   8RQ37Q&amp;
  1.AVAB/IPYN&amp;
  2  6X 562 Y 19AUG 1 NCELHR HK1          0600 0710   *1A/E*&amp;
  3 AP OK&amp;
  4 TK OK27JUN/BKK6X08AA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" endLine="137" beginLine="136" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:28.316962 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:19:28.388804 - 27 Jun 2024" filename="">IGNORED - 8RQ37Q&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="16" endLine="138" beginLine="137" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:28.389209 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:19:28.514160 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" endLine="139" beginLine="138" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:28.514913 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:19:28.588113 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18" endLine="145" beginLine="144" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><COMMENT> 3. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:28.588702 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:28.647281 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="19" endLine="147" beginLine="146" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:30.664310 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:19:30.723744 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="151" responseBeginLine="151" endLine="149" beginLine="148" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:30.724777 - 27 Jun 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:19:30.887362 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="169" responseBeginLine="167" endLine="165" beginLine="161" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:30.889071 - 27 Jun 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RQ37Q]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:19:31.096905 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8RQ37Q::270624:0619&apos;&amp;
RSI+RP:AASU:BKK6X08AA:00771002+BKK6X08AA+BKK+BKK6X08AA:0447YG:270624:00771002:0619&apos;&amp;
LFT+3:P12+--- RLR ---&apos;&amp;
STX+RLR&apos;&amp;
UID+00771002:BKK6X08AA+A&apos;&amp;
SYS++6X:BKK&apos;&amp;
PRE+TH&apos;&amp;
UID+00771002:BKK6X08AA+A&apos;&amp;
SYS++6X:BKK&apos;&amp;
PRE+TH&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:9:17&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+AVAB::1+IPYN&apos;&amp;
ETI+:1+UN:Y:Y::AVAB:IPYN&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+190824:0600:190824:0710+NCE+LHR+6X+562:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8RQ37Q&apos;&amp;
RPI+1+HK&apos;&amp;
APD+ERJ:0:0210::1+++648:M++M:CM&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+190824:0600:190824:0710+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:3+AP+3&apos;&amp;
LFT+3:5+OK&apos;&amp;
EMS++OT:2+TK+4&apos;&amp;
TKE++OK:270624::BKK6X08AA&apos;&amp;
EMS++OT:7+OPC+5&apos;&amp;
OPE+BKK6X08AA:180824:1:8:6X CANCELLATION DUE TO NO TICKET BKK TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="22" endLine="180" beginLine="179" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 1
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.098925 - 27 Jun 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="08:19:31.152083 - 27 Jun 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240627:0619+016O81V6LW0002+00LH27B9JE0002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+09CC2B44&apos;&amp;
UCI+00LH27B9JE0002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+016O81V6LW0002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="22"><QUERY filename="" loop="0" sentAt="08:19:31.152543 - 27 Jun 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="23" responseEndLine="210" responseBeginLine="197" endLine="195" beginLine="189" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.207357 - 27 Jun 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RQ37Q]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:19:31.277806 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RQ37Q]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RQ37Q]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240627\:06\:19\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:19:28]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4450623655]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:19:28]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="24" responseEndLine="230" responseBeginLine="224" endLine="223" beginLine="219" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.281479 - 27 Jun 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4450623655]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:06:27:06:19:28]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:19:31.326294 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4450623655]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:19:28]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1378]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xC2\x0A\x12\xE5\x09\x0A\x118RQ37Q-2024-06-27\x12\x03pnr\x1A\x068RQ37Q&quot;\x011:f\x1A\x142024-06-27T06:19:00Z&quot;=\x0A&quot;\x0A\x09BKK6X08AA\x12\x0800771002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02TH2\x03BKK*\x0FOK-1A/YOANNTESTJ\xB2\x02\x1A\x142024-06-27T06:19:27Z&quot;\x0D\x0A\x0B\x0A\x09BKK6X08AA*\x02OK:\xC0\x01\x12\x0FentityChangeLogB\xAC\x01z\xA9\x01\x0A\x07product\x10\x02\x1A\x1B8RQ37Q-2024-06-27-PNR-SVX-2*&lt;\x1A\x04GIFT \x02*\x04\x0A\x026X2\x02HK:\x02\x08\x01b\x08\x0A\x01F\x12\x03GFT\x82\x01\x02\x08\x00\x90\x01\x04\x9A\x01\x11\x0A\x0A2024-09-13\x12\x03BDQBA\x0A\x0Bstakeholder\x12\x1A8RQ37Q-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers:D\x12\x10historyChangeLog\x18\x02&quot;\x1B8RQ37Q-2024-06-27-PNR-SVX-2*\x07product2\x08productsz\x8A\x01\x0A\x0Bstakeholder\x12\x1A8RQ37Q-2024-06-27-PNR-NM-1&quot;\x0C\x12\x04IPYN\x1A\x04AVABr&lt;\x0A\x07contact\x12\x1A8RQ37Q-2024-06-27-PNR-AP-3\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x106103939100014556\x82\x01\xC8\x02\x0A\x07product\x10\x01\x1A\x1B8RQ37Q-2024-06-27-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-08-19T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132024-08-19T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03562\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02TH \x01&quot;\x07ECONOMY2\x196X-562-2024-08-19-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8RQ37Q-2024-06-27-PNR-BKG-1\x1A\x106003F3910006016DZA\x0A\x0Bstakeholder\x12\x1A8RQ37Q-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01p\x0A\x07contact\x12\x1A8RQ37Q-2024-06-27-PNR-AP-3@\x01Z\x04\x0A\x02OKbA\x0A\x0Bstakeholder\x12\x1A8RQ37Q-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8RQ37Q-2024-06-27-PNR-TK-2\x18\x05&quot;\x132024-06-27T00:00:00*\x0B\x0A\x09BKK6X08AAZA\x0A\x0Bstakeholder\x12\x1A8RQ37Q-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8RQ37Q-2024-06-27-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068RQ37Q\x1A\x011&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="25" responseEndLine="257" responseBeginLine="251" endLine="249" beginLine="244" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.327619 - 27 Jun 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik5ESTROekl3TnpNd01EazVNREkxTWc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDYtMjdUMDY6MTk6MjIuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJERGZ2aXhRNktNY2hpSC9xSVYyMHl1NTl2blk9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4UlEzN1EtMjAyNC0wNi0yNxIDcG5yGgY4UlEzN1EiATE6ZhoUMjAyNC0wNi0yN1QwNjoxOTowMFoiPQoiCglCS0s2WDA4QUESCDAwNzcxMDAyGgI2WCIHQUlSTElORRIXCgQwNDQ3EgJZRxoCU1UqAlRIMgNCS0sqD09LLTFBL1lPQU5OVEVTVEqyAhoUMjAyNC0wNi0yN1QwNjoxOToyN1oiDQoLCglCS0s2WDA4QUEqAk9LOsABEg9lbnRpdHlDaGFuZ2VMb2dCrAF6qQEKB3Byb2R1Y3QQAhobOFJRMzdRLTIwMjQtMDYtMjctUE5SLVNWWC0yKjwaBEdJRlQgAioECgI2WDICSEs6AggBYggKAUYSA0dGVIIBAggAkAEEmgERCgoyMDI0LTA5LTEzEgNCRFFCQQoLc3Rha2Vob2xkZXISGjhSUTM3US0yMDI0LTA2LTI3LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzOkQSEGhpc3RvcnlDaGFuZ2VMb2cYAiIbOFJRMzdRLTIwMjQtMDYtMjctUE5SLVNWWC0yKgdwcm9kdWN0Mghwcm9kdWN0c3qKAQoLc3Rha2Vob2xkZXISGjhSUTM3US0yMDI0LTA2LTI3LVBOUi1OTS0xIgwSBElQWU4aBEFWQUJyPAoHY29udGFjdBIaOFJRMzdRLTIwMjQtMDYtMjctUE5SLUFQLTMaFXByb2Nlc3NlZFBuci5jb250YWN0c6IBEhIQNjEwMzkzOTEwMDAxNDU1NoIByAIKB3Byb2R1Y3QQARobOFJRMzdRLTIwMjQtMDYtMjctUE5SLUFJUi0xIp0CChoKA05DRRoTMjAyNC0wOC0xOVQwNjowMDowMBIaCgNMSFIaEzIwMjQtMDgtMTlUMDc6MTA6MDAiTwoJCgI2WBIDNTYyEicKAVkSAwoBWRoUCgIIABIMCgQaAjZYEgQqAlRIIAEiB0VDT05PTVkyGTZYLTU2Mi0yMDI0LTA4LTE5LU5DRS1MSFJKAkhLYoQBChBzZWdtZW50LWRlbGl2ZXJ5Ehs4UlEzN1EtMjAyNC0wNi0yNy1QTlItQktHLTEaEDYwMDNGMzkxMDAwNjAxNkRaQQoLc3Rha2Vob2xkZXISGjhSUTM3US0yMDI0LTA2LTI3LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzigEBRZIBAggAsgFwCgdjb250YWN0Eho4UlEzN1EtMjAyNC0wNi0yNy1QTlItQVAtM0ABWgQKAk9LYkEKC3N0YWtlaG9sZGVyEho4UlEzN1EtMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEho4UlEzN1EtMjAyNC0wNi0yNy1QTlItVEstMhgFIhMyMDI0LTA2LTI3VDAwOjAwOjAwKgsKCUJLSzZYMDhBQVpBCgtzdGFrZWhvbGRlchIaOFJRMzdRLTIwMjQtMDYtMjctUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbOFJRMzdRLTIwMjQtMDYtMjctUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="08:19:31.477532 - 27 Jun 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KUT58FQ6WJ]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2812]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8RQ37Q-2024-06-27&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8RQ37Q&quot;, &amp;
    &quot;version&quot;: &quot;1&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:19:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;BKK6X08AA&quot;, &amp;
                &quot;iataNumber&quot;: &quot;00771002&quot;, &amp;
                &quot;systemCode&quot;: &quot;6X&quot;, &amp;
                &quot;agentType&quot;: &quot;AIRLINE&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;0447&quot;, &amp;
                &quot;initials&quot;: &quot;YG&quot;, &amp;
                &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                &quot;countryCode&quot;: &quot;TH&quot;, &amp;
                &quot;cityCode&quot;: &quot;BKK&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;OK-1A/YOANNTEST&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:19:27Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;BKK6X08AA&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;OK&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;entityChangeLog&quot;, &amp;
                &quot;oldEntity&quot;: \{&amp;
                    &quot;products&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;product&quot;, &amp;
                            &quot;subType&quot;: &quot;SERVICE&quot;, &amp;
                            &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-SVX-2&quot;, &amp;
                            &quot;service&quot;: \{&amp;
                                &quot;code&quot;: &quot;GIFT&quot;, &amp;
                                &quot;subType&quot;: &quot;MANUAL_AUXILIARY_SEGMENT&quot;, &amp;
                                &quot;serviceProvider&quot;: \{&amp;
                                    &quot;code&quot;: &quot;6X&quot;&amp;
                                \}, &amp;
                                &quot;status&quot;: &quot;HK&quot;, &amp;
                                &quot;nip&quot;: 1, &amp;
                                &quot;priceCategory&quot;: \{&amp;
                                    &quot;code&quot;: &quot;F&quot;, &amp;
                                    &quot;subCode&quot;: &quot;GFT&quot;&amp;
                                \}, &amp;
                                &quot;isChargeable&quot;: false, &amp;
                                &quot;paymentStatus&quot;: &quot;EXEMPTED&quot;, &amp;
                                &quot;serviceFulfillment&quot;: \{&amp;
                                    &quot;expiryDate&quot;: &quot;2024-09-13&quot;, &amp;
                                    &quot;location&quot;: &quot;BDQ&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;travelers&quot;: [&amp;
                                \{&amp;
                                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                                    &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-NM-1&quot;, &amp;
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
                &quot;elementId&quot;: &quot;8RQ37Q-2024-06-27-PNR-SVX-2&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;IPYN&quot;, &amp;
                    &quot;lastName&quot;: &quot;AVAB&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-AP-3&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6103939100014556&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-08-19T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-08-19T07:10:00&quot;&amp;
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
                                    &quot;countryCode&quot;: &quot;TH&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                        \}, &amp;
                        &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-562-2024-08-19-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6003F3910006016D&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-AP-3&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;OK&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-TK-2&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-06-27T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;BKK6X08AA&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8RQ37Q-2024-06-27-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="26" endLine="271" beginLine="270" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.479084 - 27 Jun 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="08:19:31.562933 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="272" beginLine="271" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.563524 - 27 Jun 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="08:19:31.645549 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="28" endLine="273" beginLine="272" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.646179 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:19:31.719324 - 27 Jun 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="29" endLine="277" beginLine="276" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.719771 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:19:31.844705 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="30" endLine="278" beginLine="277" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Remove_exempted_SVC_Feed.cry" loop="0" sentAt="08:19:31.845284 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:19:31.917728 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">31</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">14336</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">31</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">3253</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">31</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">30</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.967742</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">8094.9</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.459</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">3978.91</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">49</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>