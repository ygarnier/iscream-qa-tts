<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry"><SCRIPT type="Initialize">import json
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

        #Check hisotryChangeLog data for updated OSI element
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=2, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]

        #First changeLog section
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;keywords&apos;][0][&apos;type&apos;], expected=&apos;SERVICE&apos;, item_name=&apos;historyChangeLog service/type&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;keywords&apos;][0][&apos;id&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-OSI-5&quot;, item_name=&apos;historyChangeLog serviceid&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;keywords&apos;][0][&apos;code&apos;], expected=&quot;VIP&quot;, item_name=&apos;historyChangeLog code&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;keywords&apos;][0][&apos;subType&apos;], expected=&apos;OTHER_SERVICE_INFORMATION&apos;, item_name=&apos;historyChangeLog service/subType&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;keywords&apos;][0][&apos;serviceProvider&apos;][&apos;code&apos;], expected=&apos;6X&apos;, item_name=&apos;historyChangeLog serviceProvider/code&apos;)
        assert_equal(actual=changeLog_1[&apos;oldEntity&apos;][&apos;keywords&apos;][0][&apos;text&apos;], expected=&apos;VIP PRINCE&apos;, item_name=&apos;historyChangeLog serviceProvider/text&apos;)


        #Second changeLog section
        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;REPLACE&apos;, item_name=&apos;changeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-OSI-5&quot;, item_name=&apos;changeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;elementType&apos;], expected=&quot;SERVICE&quot;, item_name=&apos;changeLog elementType&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&quot;keywords&quot;, item_name=&apos;changeLog path&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="91" beginLine="90" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:34.768930 - 01 Jul 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="16:56:34.863044 - 01 Jul 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="92" beginLine="91" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:34.864512 - 01 Jul 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="16:56:34.961734 - 01 Jul 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="93" beginLine="92" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:34.961920 - 01 Jul 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="16:56:35.082305 - 01 Jul 2024" filename="">&amp;
09CC2B44         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="100" beginLine="99" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:35.083210 - 01 Jul 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="16:56:35.184394 - 01 Jul 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="102" beginLine="101" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:37.185981 - 01 Jul 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="16:56:37.286124 - 01 Jul 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="108" responseBeginLine="108" endLine="106" beginLine="105" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:37.286815 - 01 Jul 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="16:56:37.513372 - 01 Jul 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/01JUL/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="118" beginLine="117" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:37.514598 - 01 Jul 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1AKWM/WNID]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="16:56:37.673019 - 01 Jul 2024" filename="">RP/NCE6X0100/&amp;
  1.AKWM/WNID&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="119" beginLine="118" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:37.674180 - 01 Jul 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax2.book()}]]></EXPRESSION><VALUE><![CDATA[NM1ZCSQ/ZXNJ]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="16:56:37.826584 - 01 Jul 2024" filename="">RP/NCE6X0100/&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="120" beginLine="119" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:37.826893 - 01 Jul 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight3_6X.book(2)}]]></EXPRESSION><VALUE><![CDATA[SS6X402Y20AUGFRALHR2]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="16:56:38.230489 - 01 Jul 2024" filename="">RP/NCE6X0100/&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR DK2  1000 1100  20AUG  E  0 320&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="123" beginLine="122" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:38.230993 - 01 Jul 2024"><TEXT><![CDATA[AP +123456789AB]]></TEXT></QUERY><REPLY receiveAt="16:56:38.417383 - 01 Jul 2024" filename="">RP/NCE6X0100/&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR DK2  1000 1100  20AUG  E  0 320&amp;
  4 AP +123456789AB&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="124" beginLine="123" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:38.417546 - 01 Jul 2024"><TEXT><![CDATA[TKOK]]></TEXT></QUERY><REPLY receiveAt="16:56:38.588054 - 01 Jul 2024" filename="">RP/NCE6X0100/&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR DK2  1000 1100  20AUG  E  0 320&amp;
  4 AP +123456789AB&amp;
  5 TK OK01JUL/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" endLine="125" beginLine="124" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:38.588445 - 01 Jul 2024"><TEXT><![CDATA[RF YG]]></TEXT></QUERY><REPLY receiveAt="16:56:38.774246 - 01 Jul 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR DK2  1000 1100  20AUG  E  0 320&amp;
  4 AP +123456789AB&amp;
  5 TK OK01JUL/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" endLine="128" beginLine="127" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:38.775087 - 01 Jul 2024"><TEXT><![CDATA[OS 6X VIP PRINCE/P1]]></TEXT></QUERY><REPLY receiveAt="16:56:38.990447 - 01 Jul 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR DK2  1000 1100  20AUG  E  0 320&amp;
  4 AP +123456789AB&amp;
  5 TK OK01JUL/NCE6X0100&amp;
  6 OSI 6X VIP PRINCE/P1&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" responseEndLine="136" responseBeginLine="133" endLine="130" beginLine="129" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:38.991167 - 01 Jul 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="16:56:39.632571 - 01 Jul 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  1JUL24/1456]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[9HRY2W]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?OSI}]]></EXPRESSION><VALUE><![CDATA[  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR HK2  1000 1100  20AUG  E  6X/9HRY2W&amp;
  4 AP +123456789AB&amp;
  5 TK OK01JUL/NCE6X0100&amp;
  6 OSI]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ 6X VIP PRINCE/P1&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="15" endLine="142" beginLine="141" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:41.645048 - 01 Jul 2024"><TEXT><![CDATA[6/6X VIP TEST]]></TEXT></QUERY><REPLY receiveAt="16:56:42.202381 - 01 Jul 2024" filename="">PNR UPDATED BY PARALLEL PROCESS-PLEASE VERIFY PNR CONTENT&amp;
--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU   1JUL24/1456Z   9HRY2W&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR HK2  1000 1100  20AUG  E  6X/9HRY2W&amp;
  4 AP +123456789AB&amp;
  5 TK OK01JUL/NCE6X0100&amp;
  6 OSI 6X VIP TEST/P1&amp;
  7 OPC-19AUG:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S3/P1-2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="16" responseEndLine="150" responseBeginLine="147" endLine="144" beginLine="143" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:42.203008 - 01 Jul 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="16:56:42.778500 - 01 Jul 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  1JUL24/1456]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[9HRY2W]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?OSI}]]></EXPRESSION><VALUE><![CDATA[  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR HK2  1000 1100  20AUG  E  6X/9HRY2W&amp;
  4 AP +123456789AB&amp;
  5 TK OK01JUL/NCE6X0100&amp;
  6 OSI]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ 6X VIP TEST/P1&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[  7 OPC-19AUG:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S3/P1-2&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="17" responseEndLine="170" responseBeginLine="168" endLine="166" beginLine="162" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:44.881131 - 01 Jul 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9HRY2W]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="16:56:45.147361 - 01 Jul 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:9HRY2W::010724:1456&apos;&amp;
RSI+RP:YGSU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:0447YG:010724:00631002:1456&apos;&amp;
LFT+3:P12+--- RLR ---&apos;&amp;
STX+RLR&apos;&amp;
UID+00631002:NCE6X0100+A&apos;&amp;
SYS++6X:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+00631002:NCE6X0100+A&apos;&amp;
SYS++6X:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+00631002:NCE6X0100+A&apos;&amp;
SYS++6X:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:8:24&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+AKWM::1+WNID&apos;&amp;
ETI+:1+UN:Y:Y::AKWM:WNID&apos;&amp;
EMS++PT:2+NM+2&apos;&amp;
TIF+ZCSQ::1+ZXNJ&apos;&amp;
ETI+:1+UN:Y:Y::ZCSQ:ZXNJ&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+3&apos;&amp;
TVL+200824:1000:200824:1100+FRA+LHR+6X+402:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:9HRY2W&apos;&amp;
RPI+2+HK&apos;&amp;
APD+320:0:0200::2+++407:M&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+200824:1000:200824:1100+FRA+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:3+AP+4&apos;&amp;
LFT+3:5+\+123456789AB&apos;&amp;
EMS++OT:4+TK+5&apos;&amp;
TKE++OK:010724::NCE6X0100&apos;&amp;
EMS++OT:5+OS+6&apos;&amp;
LFT+3:28::6X+VIP TEST&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:9+OPC+7&apos;&amp;
OPE+NCE6X0100:190824:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::2300&apos;&amp;
REF+ST:1*PT:1*PT:2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="17"><QUERY filename="" loop="0" sentAt="16:56:45.148931 - 01 Jul 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="18" responseEndLine="202" responseBeginLine="189" endLine="187" beginLine="181" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:45.373107 - 01 Jul 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9HRY2W]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[01JUL24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="16:56:45.489971 - 01 Jul 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9HRY2W]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[01JUL24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9HRY2W]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240701\:14\:56\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:07:01:14:56:42]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4468631212]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:07:01:14:56:42]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="222" responseBeginLine="216" endLine="215" beginLine="211" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:45.584354 - 01 Jul 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4468631212]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:07:01:14:56:42]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="16:56:45.690185 - 01 Jul 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4468631212]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:07:01:14:56:42]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2152]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xC8\x10\x12\xEB\x0F\x0A\x119HRY2W-2024-07-01\x12\x03pnr\x1A\x069HRY2W&quot;\x012:e\x1A\x142024-07-01T14:56:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x0E -1A/YOANNTESTJ\xD1\x03\x1A\x142024-07-01T14:56:42Z&quot;\x0D\x0A\x0B\x0A\x09NCE6X0100*\x01 2\x03\x12\x011:\xDB\x02\x12\x0FentityChangeLogB\xC7\x02\x9A\x01\xC3\x02\x0A\x07SERVICE\x12\x1B9HRY2W-2024-07-01-PNR-OSI-5\x1A\x03VIP \x04*\x04\x0A\x026Xj\x0AVIP PRINCErA\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-1\x1A\x16processedPnr.travelersrB\x0A\x0Bstakeholder\x12\x1B9HRY2W-2024-07-01-PNR-SEG-0\x1A\x16processedPnr.travelersz&lt;\x0A\x07product\x12\x1A9HRY2W-2024-07-01-PNR-NM-1\x1A\x15processedPnr.productsz=\x0A\x07product\x12\x1B9HRY2W-2024-07-01-PNR-SEG-0\x1A\x15processedPnr.products:D\x12\x10historyChangeLog\x18\x03&quot;\x1B9HRY2W-2024-07-01-PNR-OSI-5*\x07SERVICE2\x08keywordsz\x8A\x01\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-1&quot;\x0C\x12\x04WNID\x1A\x04AKWMr&lt;\x0A\x07contact\x12\x1A9HRY2W-2024-07-01-PNR-AP-3\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x106106B395000181F5z\x8A\x01\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-2&quot;\x0C\x12\x04ZXNJ\x1A\x04ZCSQr&lt;\x0A\x07contact\x12\x1A9HRY2W-2024-07-01-PNR-AP-3\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x106106B395000181D1\x82\x01\xCF\x03\x0A\x07product\x10\x01\x1A\x1B9HRY2W-2024-07-01-PNR-AIR-1&quot;\xA4\x03\x0A\x1A\x0A\x03FRA\x1A\x132024-08-20T10:00:00\x12\x1A\x0A\x03LHR\x1A\x132024-08-20T11:00:00&quot;O\x0A\x09\x0A\x026X\x12\x03402\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01M\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-402-2024-08-20-FRA-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B9HRY2W-2024-07-01-PNR-BKG-1\x1A\x106007139600012D32ZA\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-1\x1A\x16processedPnr.travelersb\x84\x01\x0A\x10segment-delivery\x12\x1B9HRY2W-2024-07-01-PNR-BKG-2\x1A\x106007139600012D33ZA\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-2\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xA2\x01\xBF\x01\x0A\x07SERVICE\x12\x1B9HRY2W-2024-07-01-PNR-OSI-5\x1A\x03VIP \x04*\x04\x0A\x026Xj\x08VIP TESTrA\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-1\x1A\x16processedPnr.travelersz=\x0A\x07product\x12\x1B9HRY2W-2024-07-01-PNR-AIR-1\x1A\x15processedPnr.products\xB2\x01\xBD\x01\x0A\x07contact\x12\x1A9HRY2W-2024-07-01-PNR-AP-3@\x01Z\x0E\x0A\x0C+123456789ABbA\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-1\x1A\x16processedPnr.travelersbA\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-2\x1A\x16processedPnr.travelers\xBA\x01\x98\x02\x0A\x11automated-process\x12\x1A9HRY2W-2024-07-01-PNR-TK-4\x18\x05&quot;\x132024-07-01T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-1\x1A\x16processedPnr.travelersZA\x0A\x0Bstakeholder\x12\x1A9HRY2W-2024-07-01-PNR-NM-2\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B9HRY2W-2024-07-01-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x069HRY2W\x1A\x012&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="249" responseBeginLine="243" endLine="241" beginLine="236" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:45.692643 - 01 Jul 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik5EUTJNVEEwT0Rjd016VTBPVGN4TkE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDctMDFUMTQ6NTY6MjguMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJyYlMybXFkSTFhSnc0N2ZxZ0NnSFl1QXlVWDQ9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE5SFJZMlctMjAyNC0wNy0wMRIDcG5yGgY5SFJZMlciATI6ZRoUMjAyNC0wNy0wMVQxNDo1NjowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQwNDQ3EgJZRxoCU1UqAkZSMgNOQ0UqDiAtMUEvWU9BTk5URVNUStEDGhQyMDI0LTA3LTAxVDE0OjU2OjQyWiINCgsKCU5DRTZYMDEwMCoBIDIDEgExOtsCEg9lbnRpdHlDaGFuZ2VMb2dCxwKaAcMCCgdTRVJWSUNFEhs5SFJZMlctMjAyNC0wNy0wMS1QTlItT1NJLTUaA1ZJUCAEKgQKAjZYagpWSVAgUFJJTkNFckEKC3N0YWtlaG9sZGVyEho5SFJZMlctMjAyNC0wNy0wMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc3JCCgtzdGFrZWhvbGRlchIbOUhSWTJXLTIwMjQtMDctMDEtUE5SLVNFRy0wGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzejwKB3Byb2R1Y3QSGjlIUlkyVy0yMDI0LTA3LTAxLVBOUi1OTS0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHN6PQoHcHJvZHVjdBIbOUhSWTJXLTIwMjQtMDctMDEtUE5SLVNFRy0wGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM6RBIQaGlzdG9yeUNoYW5nZUxvZxgDIhs5SFJZMlctMjAyNC0wNy0wMS1QTlItT1NJLTUqB1NFUlZJQ0UyCGtleXdvcmRzeooBCgtzdGFrZWhvbGRlchIaOUhSWTJXLTIwMjQtMDctMDEtUE5SLU5NLTEiDBIEV05JRBoEQUtXTXI8Cgdjb250YWN0Eho5SFJZMlctMjAyNC0wNy0wMS1QTlItQVAtMxoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA2MTA2QjM5NTAwMDE4MUY1eooBCgtzdGFrZWhvbGRlchIaOUhSWTJXLTIwMjQtMDctMDEtUE5SLU5NLTIiDBIEWlhOShoEWkNTUXI8Cgdjb250YWN0Eho5SFJZMlctMjAyNC0wNy0wMS1QTlItQVAtMxoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA2MTA2QjM5NTAwMDE4MUQxggHPAwoHcHJvZHVjdBABGhs5SFJZMlctMjAyNC0wNy0wMS1QTlItQUlSLTEipAMKGgoDRlJBGhMyMDI0LTA4LTIwVDEwOjAwOjAwEhoKA0xIUhoTMjAyNC0wOC0yMFQxMTowMDowMCJPCgkKAjZYEgM0MDISJwoBWRIDCgFNGhQKAggAEgwKBBoCNlgSBCoCRlIgASIHRUNPTk9NWTIZNlgtNDAyLTIwMjQtMDgtMjAtRlJBLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzlIUlkyVy0yMDI0LTA3LTAxLVBOUi1CS0ctMRoQNjAwNzEzOTYwMDAxMkQzMlpBCgtzdGFrZWhvbGRlchIaOUhSWTJXLTIwMjQtMDctMDEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzlIUlkyVy0yMDI0LTA3LTAxLVBOUi1CS0ctMhoQNjAwNzEzOTYwMDAxMkQzM1pBCgtzdGFrZWhvbGRlchIaOUhSWTJXLTIwMjQtMDctMDEtUE5SLU5NLTIaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgECCACiAb8BCgdTRVJWSUNFEhs5SFJZMlctMjAyNC0wNy0wMS1QTlItT1NJLTUaA1ZJUCAEKgQKAjZYaghWSVAgVEVTVHJBCgtzdGFrZWhvbGRlchIaOUhSWTJXLTIwMjQtMDctMDEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnN6PQoHcHJvZHVjdBIbOUhSWTJXLTIwMjQtMDctMDEtUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHOyAb0BCgdjb250YWN0Eho5SFJZMlctMjAyNC0wNy0wMS1QTlItQVAtM0ABWg4KDCsxMjM0NTY3ODlBQmJBCgtzdGFrZWhvbGRlchIaOUhSWTJXLTIwMjQtMDctMDEtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiQQoLc3Rha2Vob2xkZXISGjlIUlkyVy0yMDI0LTA3LTAxLVBOUi1OTS0yGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzugGYAgoRYXV0b21hdGVkLXByb2Nlc3MSGjlIUlkyVy0yMDI0LTA3LTAxLVBOUi1USy00GAUiEzIwMjQtMDctMDFUMDA6MDA6MDAqCwoJTkNFNlgwMTAwWkEKC3N0YWtlaG9sZGVyEho5SFJZMlctMjAyNC0wNy0wMS1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc1pBCgtzdGFrZWhvbGRlchIaOUhSWTJXLTIwMjQtMDctMDEtUE5SLU5NLTIaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbOUhSWTJXLTIwMjQtMDctMDEtUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="16:56:45.939154 - 01 Jul 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001L91X7FY9IL]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[3937]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;9HRY2W-2024-07-01&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;9HRY2W&quot;, &amp;
    &quot;version&quot;: &quot;2&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-07-01T14:56:00Z&quot;, &amp;
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
        &quot;dateTime&quot;: &quot;2024-07-01T14:56:42Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot; &quot;, &amp;
        &quot;correlationReference&quot;: \{&amp;
            &quot;correlationId&quot;: &quot;1&quot;&amp;
        \}, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;entityChangeLog&quot;, &amp;
                &quot;oldEntity&quot;: \{&amp;
                    &quot;keywords&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;SERVICE&quot;, &amp;
                            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-OSI-5&quot;, &amp;
                            &quot;code&quot;: &quot;VIP&quot;, &amp;
                            &quot;subType&quot;: &quot;OTHER_SERVICE_INFORMATION&quot;, &amp;
                            &quot;serviceProvider&quot;: \{&amp;
                                &quot;code&quot;: &quot;6X&quot;&amp;
                            \}, &amp;
                            &quot;text&quot;: &quot;VIP PRINCE&quot;, &amp;
                            &quot;travelers&quot;: [&amp;
                                \{&amp;
                                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-1&quot;, &amp;
                                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                                \}, &amp;
                                \{&amp;
                                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-SEG-0&quot;, &amp;
                                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                                \}&amp;
                            ], &amp;
                            &quot;products&quot;: [&amp;
                                \{&amp;
                                    &quot;type&quot;: &quot;product&quot;, &amp;
                                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-1&quot;, &amp;
                                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                                \}, &amp;
                                \{&amp;
                                    &quot;type&quot;: &quot;product&quot;, &amp;
                                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-SEG-0&quot;, &amp;
                                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                                \}&amp;
                            ]&amp;
                        \}&amp;
                    ]&amp;
                \}&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;REPLACE&quot;, &amp;
                &quot;elementId&quot;: &quot;9HRY2W-2024-07-01-PNR-OSI-5&quot;, &amp;
                &quot;elementType&quot;: &quot;SERVICE&quot;, &amp;
                &quot;path&quot;: &quot;keywords&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;WNID&quot;, &amp;
                    &quot;lastName&quot;: &quot;AKWM&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-AP-3&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6106B395000181F5&quot;&amp;
            \}&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-2&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;ZXNJ&quot;, &amp;
                    &quot;lastName&quot;: &quot;ZCSQ&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-AP-3&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6106B395000181D1&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;FRA&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-08-20T10:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-08-20T11:00:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;402&quot;&amp;
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
                    &quot;id&quot;: &quot;6X-402-2024-08-20-FRA-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6007139600012D32&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-1&quot;, &amp;
                            &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                        \}&amp;
                    \}, &amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-BKG-2&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6007139600012D33&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-2&quot;, &amp;
                            &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                        \}&amp;
                    \}&amp;
                ], &amp;
                &quot;distributionMethod&quot;: &quot;E&quot;, &amp;
                &quot;notAcknowledged&quot;: false&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;keywords&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;SERVICE&quot;, &amp;
            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-OSI-5&quot;, &amp;
            &quot;code&quot;: &quot;VIP&quot;, &amp;
            &quot;subType&quot;: &quot;OTHER_SERVICE_INFORMATION&quot;, &amp;
            &quot;serviceProvider&quot;: \{&amp;
                &quot;code&quot;: &quot;6X&quot;&amp;
            \}, &amp;
            &quot;text&quot;: &quot;VIP TEST&quot;, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-AP-3&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;+123456789AB&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-TK-4&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-07-01T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-NM-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;9HRY2W-2024-07-01-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" endLine="263" beginLine="262" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:45.941255 - 01 Jul 2024"><TEXT><![CDATA[RT]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9HRY2W]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="16:56:46.215868 - 01 Jul 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU   1JUL24/1456Z   9HRY2W&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3  6X 402 Y 20AUG 2 FRALHR HK2  1000 1100  20AUG  E  6X/9HRY2W&amp;
  4 AP +123456789AB&amp;
  5 TK OK01JUL/NCE6X0100&amp;
  6 OSI 6X VIP TEST/P1&amp;
  7 OPC-19AUG:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S3/P1-2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="22" endLine="264" beginLine="263" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:46.216561 - 01 Jul 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="16:56:46.512492 - 01 Jul 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU   1JUL24/1456Z   9HRY2W&amp;
  1.AKWM/WNID   2.ZCSQ/ZXNJ&amp;
  3 AP +123456789AB&amp;
  4 TK OK01JUL/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="265" beginLine="264" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:46.512686 - 01 Jul 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="16:56:47.015201 - 01 Jul 2024" filename="">END OF TRANSACTION COMPLETE - 9HRY2W&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="266" beginLine="265" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:47.015663 - 01 Jul 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="16:56:47.138911 - 01 Jul 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="270" beginLine="269" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:47.139393 - 01 Jul 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="16:56:47.307916 - 01 Jul 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="271" beginLine="270" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/07_Update_OSI_Feed.cry" loop="0" sentAt="16:56:47.308420 - 01 Jul 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="16:56:47.423282 - 01 Jul 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">17246</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">4054</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">26</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.962963</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">12656.3</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.313</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">6239.3</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">49</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">2</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>