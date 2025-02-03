<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry"><SCRIPT type="Initialize">import json
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

        #Check hisotryChangeLog data for RM
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

</SCRIPT><TRANSACTION transactionCounter="1" endLine="88" beginLine="87" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:53.715835 - 28 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:27:53.779262 - 28 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="89" beginLine="88" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:53.779631 - 28 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:27:53.844439 - 28 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="90" beginLine="89" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:53.845014 - 28 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:27:53.925478 - 28 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="97" beginLine="96" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:53.926116 - 28 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:27:53.992990 - 28 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="99" beginLine="98" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:56.002012 - 28 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:27:56.068406 - 28 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="105" responseBeginLine="105" endLine="103" beginLine="102" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:56.069009 - 28 Jun 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="10:27:56.234135 - 28 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/28JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="114" beginLine="113" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:56.234809 - 28 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1ATBL/MCWT]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:27:56.341341 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.ATBL/MCWT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="115" beginLine="114" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:56.341697 - 28 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight_6X_daily.book(1)}]]></EXPRESSION><VALUE><![CDATA[SS6X562Y20AUGNCELHR1]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:27:56.676856 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR DK1  0600 0710  20AUG  E  0 ERJ CM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="118" beginLine="117" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:56.677097 - 28 Jun 2024"><TEXT><![CDATA[AP NCE]]></TEXT></QUERY><REPLY receiveAt="10:27:56.789938 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR DK1  0600 0710  20AUG  E  0 ERJ CM&amp;
  3 AP NCE&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="119" beginLine="118" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:56.790164 - 28 Jun 2024"><TEXT><![CDATA[RF YG]]></TEXT></QUERY><REPLY receiveAt="10:27:56.916339 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR DK1  0600 0710  20AUG  E  0 ERJ CM&amp;
  3 AP NCE&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="120" beginLine="119" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:56.916504 - 28 Jun 2024"><TEXT><![CDATA[TKOK]]></TEXT></QUERY><REPLY receiveAt="10:27:57.025705 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR DK1  0600 0710  20AUG  E  0 ERJ CM&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" endLine="121" beginLine="120" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:57.025806 - 28 Jun 2024"><TEXT><![CDATA[RM TEST]]></TEXT></QUERY><REPLY receiveAt="10:27:57.149995 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR DK1  0600 0710  20AUG  E  0 ERJ CM&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 RM TEST&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="128" responseBeginLine="125" endLine="123" beginLine="122" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:57.150188 - 28 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="10:27:57.682628 - 28 Jun 2024" match="OK"><TEXT><![CDATA[--- ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[RLR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[28JUN24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0827Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8XRMZV]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?RM}]]></EXPRESSION><VALUE><![CDATA[1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR HK1  0600 0710  20AUG  E  6X/8XRMZV&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 RM]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ TEST&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="14" endLine="133" beginLine="132" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:57.685257 - 28 Jun 2024"><TEXT><![CDATA[XE5]]></TEXT></QUERY><REPLY receiveAt="10:27:57.852897 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  28JUN24/0827Z   8XRMZV&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR HK1  0600 0710  20AUG  E  6X/8XRMZV&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" endLine="134" beginLine="133" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:57.853082 - 28 Jun 2024"><TEXT><![CDATA[RT]]></TEXT></QUERY><REPLY receiveAt="10:27:57.949914 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  28JUN24/0827Z   8XRMZV&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR HK1  0600 0710  20AUG  E  6X/8XRMZV&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="16" endLine="135" beginLine="134" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:27:57.950093 - 28 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="10:27:58.427249 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  28JUN24/0827Z   8XRMZV&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR HK1  0600 0710  20AUG  E  6X/8XRMZV&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" endLine="138" beginLine="137" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:00.430970 - 28 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:28:00.513002 - 28 Jun 2024" filename="">IGNORED - 8XRMZV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18" responseEndLine="159" responseBeginLine="157" endLine="155" beginLine="151" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:00.514600 - 28 Jun 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XRMZV]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:28:00.751897 - 28 Jun 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8XRMZV::280624:0827&apos;&amp;
RSI+RP:AASU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:0447YG:280624:00631002:0827&apos;&amp;
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
SEQ++3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:8:24&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+ATBL::1+MCWT&apos;&amp;
ETI+:1+UN:Y:Y::ATBL:MCWT&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+200824:0600:200824:0710+NCE+LHR+6X+562:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8XRMZV&apos;&amp;
RPI+1+HK&apos;&amp;
APD+ERJ:0:0210::2+++648:M++M:CM&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+200824:0600:200824:0710+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+NCE&apos;&amp;
EMS++OT:3+TK+4&apos;&amp;
TKE++OK:280624::NCE6X0100&apos;&amp;
EMS++OT:8+OPC+5&apos;&amp;
OPE+NCE6X0100:190824:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="19" endLine="169" beginLine="168" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 1
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:00.753985 - 28 Jun 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="10:28:00.817411 - 28 Jun 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240628:0828+006V4NQNJY0002+00LH27DA5H0002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+09CC2B44&apos;&amp;
UCI+00LH27DA5H0002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+006V4NQNJY0002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="19"><QUERY filename="" loop="0" sentAt="10:28:00.817630 - 28 Jun 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="200" responseBeginLine="187" endLine="185" beginLine="179" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:00.877675 - 28 Jun 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XRMZV]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:28:00.968532 - 28 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XRMZV]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XRMZV]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240628\:08\:27\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:28:08:27:58]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4455758460]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:06:28:08:27:58]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="221" responseBeginLine="215" endLine="213" beginLine="209" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:00.971538 - 28 Jun 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4455758460]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:06:28:08:27:58]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:28:01.042068 - 28 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4455758460]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:28:08:27:58]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1249]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xC1\x09\x12\xE4\x08\x0A\x118XRMZV-2024-06-28\x12\x03pnr\x1A\x068XRMZV&quot;\x011:e\x1A\x142024-06-28T08:27:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x0E -1A/YOANNTESTJ\xB1\x01\x1A\x142024-06-28T08:27:58Z&quot;\x0D\x0A\x0B\x0A\x09NCE6X0100*\x01 :D\x12\x0FentityChangeLogB1\xA2\x01.\x0A\x06remark\x12\x1A8XRMZV-2024-06-28-PNR-RM-4\x1A\x02RM*\x04TEST:A\x12\x10historyChangeLog\x18\x02&quot;\x1A8XRMZV-2024-06-28-PNR-RM-4*\x06remark2\x07remarksz\x8A\x01\x0A\x0Bstakeholder\x12\x1A8XRMZV-2024-06-28-PNR-NM-1&quot;\x0C\x12\x04MCWT\x1A\x04ATBLr&lt;\x0A\x07contact\x12\x1A8XRMZV-2024-06-28-PNR-AP-2\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x106104839200008FF6\x82\x01\xC8\x02\x0A\x07product\x10\x01\x1A\x1B8XRMZV-2024-06-28-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-08-20T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132024-08-20T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03562\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-562-2024-08-20-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8XRMZV-2024-06-28-PNR-BKG-1\x1A\x106004E39300000F03ZA\x0A\x0Bstakeholder\x12\x1A8XRMZV-2024-06-28-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01q\x0A\x07contact\x12\x1A8XRMZV-2024-06-28-PNR-AP-2@\x01Z\x05\x0A\x03NCEbA\x0A\x0Bstakeholder\x12\x1A8XRMZV-2024-06-28-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8XRMZV-2024-06-28-PNR-TK-3\x18\x05&quot;\x132024-06-28T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A8XRMZV-2024-06-28-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8XRMZV-2024-06-28-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068XRMZV\x1A\x011&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="22" responseEndLine="248" responseBeginLine="242" endLine="240" beginLine="235" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:01.043418 - 28 Jun 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik1ESXdORGMzTlRRd05qRTFPRFl6TlE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDYtMjhUMDg6Mjc6NDkuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJBVnFIdlVjRUJabUtYbHB3RHdVaC9FbXpVYzg9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4WFJNWlYtMjAyNC0wNi0yOBIDcG5yGgY4WFJNWlYiATE6ZRoUMjAyNC0wNi0yOFQwODoyNzowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQwNDQ3EgJZRxoCU1UqAkZSMgNOQ0UqDiAtMUEvWU9BTk5URVNUSrEBGhQyMDI0LTA2LTI4VDA4OjI3OjU4WiINCgsKCU5DRTZYMDEwMCoBIDpEEg9lbnRpdHlDaGFuZ2VMb2dCMaIBLgoGcmVtYXJrEho4WFJNWlYtMjAyNC0wNi0yOC1QTlItUk0tNBoCUk0qBFRFU1Q6QRIQaGlzdG9yeUNoYW5nZUxvZxgCIho4WFJNWlYtMjAyNC0wNi0yOC1QTlItUk0tNCoGcmVtYXJrMgdyZW1hcmtzeooBCgtzdGFrZWhvbGRlchIaOFhSTVpWLTIwMjQtMDYtMjgtUE5SLU5NLTEiDBIETUNXVBoEQVRCTHI8Cgdjb250YWN0Eho4WFJNWlYtMjAyNC0wNi0yOC1QTlItQVAtMhoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA2MTA0ODM5MjAwMDA4RkY2ggHIAgoHcHJvZHVjdBABGhs4WFJNWlYtMjAyNC0wNi0yOC1QTlItQUlSLTEinQIKGgoDTkNFGhMyMDI0LTA4LTIwVDA2OjAwOjAwEhoKA0xIUhoTMjAyNC0wOC0yMFQwNzoxMDowMCJPCgkKAjZYEgM1NjISJwoBWRIDCgFZGhQKAggAEgwKBBoCNlgSBCoCRlIgASIHRUNPTk9NWTIZNlgtNTYyLTIwMjQtMDgtMjAtTkNFLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzhYUk1aVi0yMDI0LTA2LTI4LVBOUi1CS0ctMRoQNjAwNEUzOTMwMDAwMEYwM1pBCgtzdGFrZWhvbGRlchIaOFhSTVpWLTIwMjQtMDYtMjgtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgECCACyAXEKB2NvbnRhY3QSGjhYUk1aVi0yMDI0LTA2LTI4LVBOUi1BUC0yQAFaBQoDTkNFYkEKC3N0YWtlaG9sZGVyEho4WFJNWlYtMjAyNC0wNi0yOC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEho4WFJNWlYtMjAyNC0wNi0yOC1QTlItVEstMxgFIhMyMDI0LTA2LTI4VDAwOjAwOjAwKgsKCU5DRTZYMDEwMFpBCgtzdGFrZWhvbGRlchIaOFhSTVpWLTIwMjQtMDYtMjgtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbOFhSTVpWLTIwMjQtMDYtMjgtUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="10:28:01.244785 - 28 Jun 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001L0Z2XFS7IP]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2439]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8XRMZV-2024-06-28&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8XRMZV&quot;, &amp;
    &quot;version&quot;: &quot;1&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-28T08:27:00Z&quot;, &amp;
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
        &quot;comment&quot;: &quot; -1A/YOANNTEST&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-28T08:27:58Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot; &quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;entityChangeLog&quot;, &amp;
                &quot;oldEntity&quot;: \{&amp;
                    &quot;remarks&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;remark&quot;, &amp;
                            &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-RM-4&quot;, &amp;
                            &quot;subType&quot;: &quot;RM&quot;, &amp;
                            &quot;content&quot;: &quot;TEST&quot;&amp;
                        \}&amp;
                    ]&amp;
                \}&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;REMOVE&quot;, &amp;
                &quot;elementId&quot;: &quot;8XRMZV-2024-06-28-PNR-RM-4&quot;, &amp;
                &quot;elementType&quot;: &quot;remark&quot;, &amp;
                &quot;path&quot;: &quot;remarks&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;MCWT&quot;, &amp;
                    &quot;lastName&quot;: &quot;ATBL&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6104839200008FF6&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-08-20T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-08-20T07:10:00&quot;&amp;
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
                                    &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                        \}, &amp;
                        &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-562-2024-08-20-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6004E39300000F03&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;NCE&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-06-28T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8XRMZV-2024-06-28-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="23" endLine="262" beginLine="261" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:01.246217 - 28 Jun 2024"><TEXT><![CDATA[RT]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XRMZV]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:28:01.457684 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  28JUN24/0827Z   8XRMZV&amp;
  1.ATBL/MCWT&amp;
  2  6X 562 Y 20AUG 2 NCELHR HK1  0600 0710  20AUG  E  6X/8XRMZV&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 OPC-19AUG:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="263" beginLine="262" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:01.458428 - 28 Jun 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="10:28:01.702536 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  28JUN24/0827Z   8XRMZV&amp;
  1.ATBL/MCWT&amp;
  2 AP NCE&amp;
  3 TK OK28JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="264" beginLine="263" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:01.703077 - 28 Jun 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="10:28:02.118947 - 28 Jun 2024" filename="">END OF TRANSACTION COMPLETE - 8XRMZV&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="265" beginLine="264" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:02.119332 - 28 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:28:02.198429 - 28 Jun 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="269" beginLine="268" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:02.198970 - 28 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:28:02.334056 - 28 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="28" endLine="270" beginLine="269" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/05_Remove_RM_Feed.cry" loop="0" sentAt="10:28:02.334456 - 28 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:28:02.414655 - 28 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">29</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">12312</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">29</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">2947</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">29</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.965517</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">8700.1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.872</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">4611.25</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">53</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>