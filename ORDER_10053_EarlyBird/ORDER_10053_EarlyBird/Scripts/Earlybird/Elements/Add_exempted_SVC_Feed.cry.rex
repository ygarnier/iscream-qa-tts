<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry"><SCRIPT type="Initialize">import json
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
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=4, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]
        changeLog_3 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][2]
        changeLog_4 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][3]

        #First changeLog section
        assert_equal(actual=changeLog_1[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_1[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_1[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-NM-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_1[&apos;path&apos;], expected=&quot;travelers&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Second changeLog section
        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&quot;contacts&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Third changeLog section
        assert_equal(actual=changeLog_3[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_3[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_3[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-TK-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_3[&apos;path&apos;], expected=&quot;automatedProcesses&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Fourth changeLog section
        assert_equal(actual=changeLog_4[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_4[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_4[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-SVX-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_4[&apos;path&apos;], expected=&quot;products&quot;, item_name=&apos;historyChangeLog path&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="100" beginLine="99" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:04.689818 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:17:04.743970 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="101" beginLine="100" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:04.744555 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:17:04.803217 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="102" beginLine="101" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:04.803545 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:17:04.872021 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="109" beginLine="108" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:04.872201 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:17:04.929327 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="111" beginLine="110" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:06.934388 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:17:06.994456 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="117" responseBeginLine="117" endLine="115" beginLine="114" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:06.995309 - 27 Jun 2024"><TEXT><![CDATA[Ji]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="OFFICE_6X_BKK"><VALUE><![CDATA[BKK6X08AA]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:17:07.178010 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="126" beginLine="125" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:07.179385 - 27 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1AANL/WUFS]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="08:17:07.281650 - 27 Jun 2024" filename="">RP/BKK6X08AA/&amp;
  1.AANL/WUFS&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="127" beginLine="126" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:07.282069 - 27 Jun 2024"><TEXT><![CDATA[TKOK; APOK; RFYG]]></TEXT></QUERY><REPLY receiveAt="08:17:07.456209 - 27 Jun 2024" filename="">RP/BKK6X08AA/&amp;
RF YG&amp;
  1.AANL/WUFS&amp;
  2 AP OK&amp;
  3 TK OK27JUN/BKK6X08AA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="130" beginLine="129" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:07.456676 - 27 Jun 2024"><TEXT><![CDATA[IU 6X NN1 GIFT BDQ/13SEP]]></TEXT></QUERY><REPLY receiveAt="08:17:07.576943 - 27 Jun 2024" filename="">RP/BKK6X08AA/&amp;
RF YG&amp;
  1.AANL/WUFS&amp;
  2 #SVC 6X HK1 GIFT BDQ 13SEP&amp;
  3 AP OK&amp;
  4 TK OK27JUN/BKK6X08AA&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" responseEndLine="136" responseBeginLine="134" endLine="132" beginLine="131" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:07.577100 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="08:17:08.065217 - 27 Jun 2024" match="OK"><TEXT><![CDATA[RP/]]></TEXT><VARIABLE name="OFFICE_6X_BKK"><VALUE><![CDATA[BKK6X08AA]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="OFFICE_6X_BKK"><VALUE><![CDATA[BKK6X08AA]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 27JUN24/0617]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8ROJPM]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?#SVC}]]></EXPRESSION><VALUE><![CDATA[  1.AANL/WUFS&amp;
  2 #SVC]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ 6X HK1 GIFT BDQ 13SEP&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  3 AP OK&amp;
  4 TK OK27JUN/BKK6X08AA&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11" endLine="140" beginLine="139" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:08.066484 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:17:08.139217 - 27 Jun 2024" filename="">IGNORED - 8ROJPM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" endLine="141" beginLine="140" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:08.139564 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:17:08.264376 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" endLine="142" beginLine="141" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:08.264671 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:17:08.340215 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="148" beginLine="147" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><COMMENT> 3. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:08.340398 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:17:08.397507 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" endLine="150" beginLine="149" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:10.414417 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:17:10.474450 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="16" responseEndLine="154" responseBeginLine="154" endLine="152" beginLine="151" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:10.475285 - 27 Jun 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:17:10.642740 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="17" responseEndLine="172" responseBeginLine="170" endLine="168" beginLine="164" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:10.644546 - 27 Jun 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROJPM]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:17:10.926528 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8ROJPM::270624:0617&apos;&amp;
RSI+RP:YGSU:BKK6X08AA:00771002+BKK6X08AA+BKK+BKK6X08AA:0447YG:270624:00771002:0617&apos;&amp;
UID+00771002:BKK6X08AA+A&apos;&amp;
SYS++6X:BKK&apos;&amp;
PRE+TH&apos;&amp;
UID+00771002:BKK6X08AA+A&apos;&amp;
SYS++6X:BKK&apos;&amp;
PRE+TH&apos;&amp;
UID+00771002:BKK6X08AA+A&apos;&amp;
SYS++6X:BKK&apos;&amp;
PRE+TH&apos;&amp;
SEQ++1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[0]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:9:17&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+AANL::1+WUFS&apos;&amp;
ETI+:1+UN:Y:Y::AANL:WUFS&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+IU+2&apos;&amp;
TVL+130924+BDQ++6X+GIFT&apos;&amp;
MSG+47&apos;&amp;
RPI+1+HK&apos;&amp;
DUM&apos;&amp;
REF+PT:1&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+OK&apos;&amp;
EMS++OT:1+TK+4&apos;&amp;
TKE++OK:270624::BKK6X08AA]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="18" endLine="177" beginLine="176" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><COMMENT>Retrieve</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:10.928004 - 27 Jun 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
RT]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROJPM]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:17:10.981707 - 27 Jun 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240627:0617+016DDDQVMW0002+00LH27B9I00002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+09CC2B44&apos;&amp;
UCI+00LH27B9I00002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+016DDDQVMW0002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18"><QUERY filename="" loop="0" sentAt="08:17:10.982175 - 27 Jun 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="207" responseBeginLine="194" endLine="192" beginLine="186" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:11.036746 - 27 Jun 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROJPM]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:17:11.104517 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROJPM]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8ROJPM]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240627\:06\:17\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[0]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:17:08]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4450611933]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:17:08]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="227" responseBeginLine="221" endLine="220" beginLine="216" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:11.106954 - 27 Jun 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4450611933]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:06:27:06:17:08]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:17:11.155834 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4450611933]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:17:08]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1193]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\x89\x09\x12\xAC\x08\x0A\x118ROJPM-2024-06-27\x12\x03pnr\x1A\x068ROJPM&quot;\x010:f\x1A\x142024-06-27T06:17:00Z&quot;=\x0A&quot;\x0A\x09BKK6X08AA\x12\x0800771002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02TH2\x03BKK*\x0FYG-1A/YOANNTESTJ\xD7\x02\x1A\x142024-06-27T06:17:07Z&quot;\x0D\x0A\x0B\x0A\x09BKK6X08AA*\x02YG:H\x12\x10historyChangeLog\x18\x01&quot;\x1A8ROJPM-2024-06-27-PNR-NM-1*\x0Bstakeholder2\x09travelers:C\x12\x10historyChangeLog\x18\x01&quot;\x1A8ROJPM-2024-06-27-PNR-AP-2*\x07contact2\x08contacts:W\x12\x10historyChangeLog\x18\x01&quot;\x1A8ROJPM-2024-06-27-PNR-TK-1*\x11automated-process2\x12automatedProcesses:D\x12\x10historyChangeLog\x18\x01&quot;\x1B8ROJPM-2024-06-27-PNR-SVX-1*\x07product2\x08productsz\x8A\x01\x0A\x0Bstakeholder\x12\x1A8ROJPM-2024-06-27-PNR-NM-1&quot;\x0C\x12\x04WUFS\x1A\x04AANLr&lt;\x0A\x07contact\x12\x1A8ROJPM-2024-06-27-PNR-AP-2\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x106103939100014537\x82\x01\xA9\x01\x0A\x07product\x10\x02\x1A\x1B8ROJPM-2024-06-27-PNR-SVX-1*&lt;\x1A\x04GIFT \x02*\x04\x0A\x026X2\x02HK:\x02\x08\x01b\x08\x0A\x01F\x12\x03GFT\x82\x01\x02\x08\x00\x90\x01\x04\x9A\x01\x11\x0A\x0A2024-09-13\x12\x03BDQBA\x0A\x0Bstakeholder\x12\x1A8ROJPM-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01p\x0A\x07contact\x12\x1A8ROJPM-2024-06-27-PNR-AP-2@\x01Z\x04\x0A\x02OKbA\x0A\x0Bstakeholder\x12\x1A8ROJPM-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\x96\x01\x0A\x11automated-process\x12\x1A8ROJPM-2024-06-27-PNR-TK-1\x18\x05&quot;\x132024-06-27T00:00:00*\x0B\x0A\x09BKK6X08AAZA\x0A\x0Bstakeholder\x12\x1A8ROJPM-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068ROJPM\x1A\x010&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="254" responseBeginLine="248" endLine="246" beginLine="241" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:11.157670 - 27 Jun 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik56azFOek0yT0Rrek5UUXdOalk1TVE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDYtMjdUMDY6MTc6MDMuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJveTRjbW9HbnY0UXJLR0ZYRzJMK1RScUQzYU09In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4Uk9KUE0tMjAyNC0wNi0yNxIDcG5yGgY4Uk9KUE0iATA6ZhoUMjAyNC0wNi0yN1QwNjoxNzowMFoiPQoiCglCS0s2WDA4QUESCDAwNzcxMDAyGgI2WCIHQUlSTElORRIXCgQwNDQ3EgJZRxoCU1UqAlRIMgNCS0sqD1lHLTFBL1lPQU5OVEVTVErXAhoUMjAyNC0wNi0yN1QwNjoxNzowN1oiDQoLCglCS0s2WDA4QUEqAllHOkgSEGhpc3RvcnlDaGFuZ2VMb2cYASIaOFJPSlBNLTIwMjQtMDYtMjctUE5SLU5NLTEqC3N0YWtlaG9sZGVyMgl0cmF2ZWxlcnM6QxIQaGlzdG9yeUNoYW5nZUxvZxgBIho4Uk9KUE0tMjAyNC0wNi0yNy1QTlItQVAtMioHY29udGFjdDIIY29udGFjdHM6VxIQaGlzdG9yeUNoYW5nZUxvZxgBIho4Uk9KUE0tMjAyNC0wNi0yNy1QTlItVEstMSoRYXV0b21hdGVkLXByb2Nlc3MyEmF1dG9tYXRlZFByb2Nlc3NlczpEEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGzhST0pQTS0yMDI0LTA2LTI3LVBOUi1TVlgtMSoHcHJvZHVjdDIIcHJvZHVjdHN6igEKC3N0YWtlaG9sZGVyEho4Uk9KUE0tMjAyNC0wNi0yNy1QTlItTk0tMSIMEgRXVUZTGgRBQU5McjwKB2NvbnRhY3QSGjhST0pQTS0yMDI0LTA2LTI3LVBOUi1BUC0yGhVwcm9jZXNzZWRQbnIuY29udGFjdHOiARISEDYxMDM5MzkxMDAwMTQ1MzeCAakBCgdwcm9kdWN0EAIaGzhST0pQTS0yMDI0LTA2LTI3LVBOUi1TVlgtMSo8GgRHSUZUIAIqBAoCNlgyAkhLOgIIAWIICgFGEgNHRlSCAQIIAJABBJoBEQoKMjAyNC0wOS0xMxIDQkRRQkEKC3N0YWtlaG9sZGVyEho4Uk9KUE0tMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7IBcAoHY29udGFjdBIaOFJPSlBNLTIwMjQtMDYtMjctUE5SLUFQLTJAAVoECgJPS2JBCgtzdGFrZWhvbGRlchIaOFJPSlBNLTIwMjQtMDYtMjctUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnO6AZYBChFhdXRvbWF0ZWQtcHJvY2VzcxIaOFJPSlBNLTIwMjQtMDYtMjctUE5SLVRLLTEYBSITMjAyNC0wNi0yN1QwMDowMDowMCoLCglCS0s2WDA4QUFaQQoLc3Rha2Vob2xkZXISGjhST0pQTS0yMDI0LTA2LTI3LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJz]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="08:17:11.299723 - 27 Jun 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KUT0NFQ6SN]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2248]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8ROJPM-2024-06-27&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8ROJPM&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:17:00Z&quot;, &amp;
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
        &quot;comment&quot;: &quot;YG-1A/YOANNTEST&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:17:07Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;BKK6X08AA&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;YG&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROJPM-2024-06-27-PNR-NM-1&quot;, &amp;
                &quot;elementType&quot;: &quot;stakeholder&quot;, &amp;
                &quot;path&quot;: &quot;travelers&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROJPM-2024-06-27-PNR-AP-2&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROJPM-2024-06-27-PNR-TK-1&quot;, &amp;
                &quot;elementType&quot;: &quot;automated-process&quot;, &amp;
                &quot;path&quot;: &quot;automatedProcesses&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8ROJPM-2024-06-27-PNR-SVX-1&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8ROJPM-2024-06-27-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;WUFS&quot;, &amp;
                    &quot;lastName&quot;: &quot;AANL&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8ROJPM-2024-06-27-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6103939100014537&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;SERVICE&quot;, &amp;
            &quot;id&quot;: &quot;8ROJPM-2024-06-27-PNR-SVX-1&quot;, &amp;
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
                    &quot;id&quot;: &quot;8ROJPM-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;8ROJPM-2024-06-27-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;OK&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ROJPM-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8ROJPM-2024-06-27-PNR-TK-1&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-06-27T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;BKK6X08AA&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8ROJPM-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="22" endLine="268" beginLine="267" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:11.301511 - 27 Jun 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="08:17:11.384377 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="269" beginLine="268" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:11.384687 - 27 Jun 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="08:17:11.468072 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="270" beginLine="269" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:11.468479 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:17:11.546124 - 27 Jun 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="274" beginLine="273" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:11.546524 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:17:11.670404 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="275" beginLine="274" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_exempted_SVC_Feed.cry" loop="0" sentAt="08:17:11.670901 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:17:11.741558 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">10721</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">2969</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.962963</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">7061.3</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.284</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">2974.66</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">42</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>