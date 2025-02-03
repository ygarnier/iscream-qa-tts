<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry"><SCRIPT type="Initialize">import json
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

        #Check hisotryChangeLog data for SSR FQTV
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=5, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]
        changeLog_3 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][2]
        changeLog_4 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][3]
        changeLog_5 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][4]

        #First changeLog section
        assert_equal(actual=changeLog_1[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logtype&apos;)
        assert_equal(actual=changeLog_1[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_1[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-AIR-2&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_1[&apos;elementType&apos;], expected=&apos;product&apos;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_1[&apos;path&apos;], expected=&apos;products&apos;, item_name=&apos;historyChangeLog path&apos;)

        #Second changeLog section
        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logtype&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-BKG-10&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;elementType&apos;], expected=&apos;segment-delivery&apos;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&apos;products/airSegment/deliveries&apos;, item_name=&apos;historyChangeLog path&apos;)

        #Third changeLog section

        #Fourth changeLog section
        assert_equal(actual=changeLog_4[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logtype&apos;)
        assert_equal(actual=changeLog_4[&apos;operation&apos;], expected=&apos;REMOVE&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_4[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-AIR-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_4[&apos;elementType&apos;], expected=&apos;product&apos;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_4[&apos;path&apos;], expected=&apos;products&apos;, item_name=&apos;historyChangeLog path&apos;)

        #Fifth changeLog section
        assert_equal(actual=changeLog_5[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logtype&apos;)
        assert_equal(actual=changeLog_5[&apos;operation&apos;], expected=&apos;REMOVE&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_5[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-BKG-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_5[&apos;elementType&apos;], expected=&apos;segment-delivery&apos;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_5[&apos;path&apos;], expected=&apos;products/airSegment/deliveries&apos;, item_name=&apos;historyChangeLog path&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="109" beginLine="108" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:22.472194 - 28 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:45:22.519385 - 28 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="110" beginLine="109" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:22.519781 - 28 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:45:22.570103 - 28 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="111" beginLine="110" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:22.570213 - 28 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:45:22.634058 - 28 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="118" beginLine="117" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:22.634237 - 28 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:45:22.686520 - 28 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="120" beginLine="119" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:24.687380 - 28 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:45:24.740075 - 28 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="126" responseBeginLine="126" endLine="124" beginLine="123" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:24.740402 - 28 Jun 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="10:45:24.908126 - 28 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/28JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="135" beginLine="134" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:24.908713 - 28 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1APZL/APCH]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:45:25.018120 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.APZL/APCH&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="136" beginLine="135" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:25.018436 - 28 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight_6X_daily.book(1)}]]></EXPRESSION><VALUE><![CDATA[SS6X562Y20AUGNCELHR1]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:45:25.631646 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.APZL/APCH&amp;
  2  6X 562 Y 20AUG 2 NCELHR DK1  0600 0710  20AUG  E  0 ERJ CM&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="139" beginLine="138" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:25.631774 - 28 Jun 2024"><TEXT><![CDATA[TKOK;APNCE;RFYG]]></TEXT></QUERY><REPLY receiveAt="10:45:25.813151 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.APZL/APCH&amp;
  2  6X 562 Y 20AUG 2 NCELHR DK1  0600 0710  20AUG  E  0 ERJ CM&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="140" beginLine="139" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:25.813328 - 28 Jun 2024"><TEXT><![CDATA[sr fqtv 6x-6x1001234500/p1]]></TEXT></QUERY><REPLY receiveAt="10:45:26.007992 - 28 Jun 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.APZL/APCH&amp;
  2  6X 562 Y 20AUG 2 NCELHR DK1  0600 0710  20AUG  E  0 ERJ CM&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 SSR FQTV 6X HK/ 6X1001234500&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="149" responseBeginLine="146" endLine="143" beginLine="142" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:28.009999 - 28 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="10:45:28.554210 - 28 Jun 2024" match="OK"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[           YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[ 28JUN24/0845]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[Z   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8XTJ3T]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?SSR}]]></EXPRESSION><VALUE><![CDATA[  1.APZL/APCH&amp;
  2  6X 562 Y 20AUG 2 NCELHR HK1  0600 0710  20AUG  E  6X/8XTJ3T&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 SSR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ FQTV 6X HK/ 6X1001234500&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="12" endLine="154" beginLine="153" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:30.569266 - 28 Jun 2024"><TEXT><![CDATA[IR]]></TEXT></QUERY><REPLY receiveAt="10:45:30.785569 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  28JUN24/0845Z   8XTJ3T&amp;
  1.APZL/APCH&amp;
  2  6X 562 Y 20AUG 2 NCELHR HK1  0600 0710  20AUG  E  6X/8XTJ3T&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 SSR FQTV 6X HK/ 6X1001234500&amp;
  6 OPC-19AUG:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" endLine="155" beginLine="154" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:30.785724 - 28 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Flight5_CS.book(1)}]]></EXPRESSION><VALUE><![CDATA[SS6X650Y20AUGLHRSIN1]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="10:45:31.508882 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  28JUN24/0845Z   8XTJ3T&amp;
  1.APZL/APCH&amp;
  2  6X 562 Y 20AUG 2 NCELHR HK1  0600 0710  20AUG  E  6X/8XTJ3T&amp;
  3  6X 650 Y 20AUG 2 LHRSIN DK1  2200 1855  21AUG  E  0 744&amp;
     OPERATED BY AMADEUS SEVEN&amp;
     SEE RTSVC&amp;
  4 AP NCE&amp;
  5 TK OK28JUN/NCE6X0100&amp;
  6 SSR FQTV 6X HK/ 6X1001234500&amp;
  7 OPC-19AUG:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="156" beginLine="155" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:31.509117 - 28 Jun 2024"><TEXT><![CDATA[XE2]]></TEXT></QUERY><REPLY receiveAt="10:45:31.921759 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            AA/SU  28JUN24/0845Z   8XTJ3T&amp;
  1.APZL/APCH&amp;
  2  6X 650 Y 20AUG 2 LHRSIN DK1  2200 1855  21AUG  E  0 744&amp;
     OPERATED BY AMADEUS SEVEN&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 SSR FQTV 6X HK/ 6X1001234500&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" endLine="157" beginLine="156" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:31.922143 - 28 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="10:45:32.601946 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  28JUN24/0845Z   8XTJ3T&amp;
  1.APZL/APCH&amp;
  2  6X 650 Y 20AUG 2 LHRSIN HK1  2200 1855  21AUG  E  6X/8XTJ3T&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 SSR FQTV 6X HK/ 6X1001234500&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="16" endLine="165" beginLine="164" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><SCRIPT type="Exec"># Compose the expected PNR ID used in OpenPNR, e.g. ABC123-2025-05-27
openpnr_id = recloc + &apos;-&apos; + today
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:32.602957 - 28 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:45:32.680894 - 28 Jun 2024" filename="">IGNORED - 8XTJ3T&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" responseEndLine="181" responseBeginLine="179" endLine="177" beginLine="173" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:35.734822 - 28 Jun 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XTJ3T]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:45:36.470884 - 28 Jun 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8XTJ3T::280624:0845&apos;&amp;
RSI+RP:AASU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:0447YG:280624:00631002:0845&apos;&amp;
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
SEQ++4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[3]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:8:24&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+APZL::1+APCH&apos;&amp;
ETI+:1+UN:Y:Y::APZL:APCH&apos;&amp;
ODI&apos;&amp;
EMS++ST:2+AIR+2&apos;&amp;
TVL+200824:2200:210824:1855:1+LHR+SIN+6X+650:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8XTJ3T&apos;&amp;
RPI+1+HK&apos;&amp;
APD+744:0:1355::2+++6765:M&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
IFT+3+     OPERATED BY AMADEUS SEVEN&apos;&amp;
FSD&apos;&amp;
TVL+200824:2200:210824:1855+LHR+SIN+:7X+650&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
IFT+OPC+COMMERCIAL DUPLICATE - OPERATED BY /AMADEUS SEVEN&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:3+AP+3&apos;&amp;
LFT+3:5+NCE&apos;&amp;
EMS++OT:2+TK+4&apos;&amp;
TKE++OK:280624::NCE6X0100&apos;&amp;
EMS++OT:4+SSR+5&apos;&amp;
SSR+FQTV:HK:1:6X&apos;&amp;
FTI+6X:1001234500&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:13+OPC+6&apos;&amp;
OPE+NCE6X0100:190824:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::2300&apos;&amp;
REF+ST:2*PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="18" endLine="191" beginLine="190" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 1
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:36.472216 - 28 Jun 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="10:45:36.517113 - 28 Jun 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240628:0845+007FCQ58M50002+002SDFN48F0002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+09CC2B44&apos;&amp;
UCI+002SDFN48F0002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+42&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+007FCQ58M50002&apos;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18"><QUERY filename="" loop="0" sentAt="10:45:36.517770 - 28 Jun 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="221" responseBeginLine="208" endLine="206" beginLine="200" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:36.629210 - 28 Jun 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XTJ3T]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:45:37.053967 - 28 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XTJ3T]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XTJ3T]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240628\:08\:45\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:28:08:45:32]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4455796863]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:06:28:08:45:32]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" responseEndLine="241" responseBeginLine="235" endLine="234" beginLine="230" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:37.099262 - 28 Jun 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4455796863]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:06:28:08:45:32]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="10:45:37.158426 - 28 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4455796863]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:28:08:45:32]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2188]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xEC\x10\x12\x8F\x10\x0A\x118XTJ3T-2024-06-28\x12\x03pnr\x1A\x068XTJ3T&quot;\x012:e\x1A\x142024-06-28T08:45:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x0E -1A/YOANNTESTJ\xE6\x05\x1A\x142024-06-28T08:45:32Z&quot;\x0D\x0A\x0B\x0A\x09NCE6X0100*\x01 2\x03\x12\x011:D\x12\x10historyChangeLog\x18\x01&quot;\x1B8XTJ3T-2024-06-28-PNR-AIR-2*\x07product2\x08products:d\x12\x10historyChangeLog\x18\x01&quot;\x1C8XTJ3T-2024-06-28-PNR-BKG-10*\x10segment-delivery2\x1Eproducts/airSegment/deliveries:\xDF\x02\x12\x0FentityChangeLogB\xCB\x02z\xC8\x02\x0A\x07product\x10\x01\x1A\x1B8XTJ3T-2024-06-28-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132024-08-20T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132024-08-20T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03562\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-562-2024-08-20-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8XTJ3T-2024-06-28-PNR-BKG-1\x1A\x106004E3930000133BZA\x0A\x0Bstakeholder\x12\x1A8XTJ3T-2024-06-28-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00:D\x12\x10historyChangeLog\x18\x02&quot;\x1B8XTJ3T-2024-06-28-PNR-AIR-1*\x07product2\x08products:c\x12\x10historyChangeLog\x18\x02&quot;\x1B8XTJ3T-2024-06-28-PNR-BKG-1*\x10segment-delivery2\x1Eproducts/airSegment/deliveriesz\xD0\x01\x0A\x0Bstakeholder\x12\x1A8XTJ3T-2024-06-28-PNR-NM-1&quot;\x0C\x12\x04APCH\x1A\x04APZLr&lt;\x0A\x07contact\x12\x1A8XTJ3T-2024-06-28-PNR-AP-3\x1A\x15processedPnr.contactszD\x0A\x07service\x12\x1B8XTJ3T-2024-06-28-PNR-SSR-4\x1A\x1CprocessedPnr.loyaltyRequests\xA2\x01\x12\x12\x1061048392000091E8\x82\x01\x9C\x03\x0A\x07product\x10\x01\x1A\x1B8XTJ3T-2024-06-28-PNR-AIR-2&quot;\xF1\x02\x0A\x1A\x0A\x03LHR\x1A\x132024-08-20T22:00:00\x12\x1A\x0A\x03SIN\x1A\x132024-08-21T18:55:00&quot;O\x0A\x09\x0A\x026X\x12\x03650\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01M\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-650-2024-08-20-LHR-SIN*Q\x0A\x09\x0A\x027X\x12\x03650\x12&apos;&amp;
\x0A\x01V\x12\x03\x0A\x01M\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY(\x022\x197X-650-2024-08-20-LHR-SINJ\x02HKb\x85\x01\x0A\x10segment-delivery\x12\x1C8XTJ3T-2024-06-28-PNR-BKG-10\x1A\x106004E3930000133CZA\x0A\x0Bstakeholder\x12\x1A8XTJ3T-2024-06-28-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\x9A\x01\xD8\x01\x0A\x07service\x12\x1B8XTJ3T-2024-06-28-PNR-SSR-4\x1A\x04FQTV \x01*\x04\x0A\x026X2\x02HKZ\x1C\x0A\x0A1001234500\x10\x01\x1A\x04*\x026X&quot;\x04*\x02*O(\x00rA\x0A\x0Bstakeholder\x12\x1A8XTJ3T-2024-06-28-PNR-NM-1\x1A\x16processedPnr.travelersz=\x0A\x07product\x12\x1B8XTJ3T-2024-06-28-PNR-AIR-2\x1A\x15processedPnr.products\xB2\x01q\x0A\x07contact\x12\x1A8XTJ3T-2024-06-28-PNR-AP-3@\x01Z\x05\x0A\x03NCEbA\x0A\x0Bstakeholder\x12\x1A8XTJ3T-2024-06-28-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8XTJ3T-2024-06-28-PNR-TK-2\x18\x05&quot;\x132024-06-28T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A8XTJ3T-2024-06-28-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8XTJ3T-2024-06-28-PNR-AIR-2\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068XTJ3T\x1A\x012&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="268" responseBeginLine="262" endLine="260" beginLine="255" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:37.159893 - 28 Jun 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik5USTNNVEEzTnprd01EUXlORGt4TUE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDYtMjhUMDg6NDU6MTguMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJndjlUUDRzcXRjRXVzV0dFc25hdFI1Yk9xemM9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4WFRKM1QtMjAyNC0wNi0yOBIDcG5yGgY4WFRKM1QiATI6ZRoUMjAyNC0wNi0yOFQwODo0NTowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQwNDQ3EgJZRxoCU1UqAkZSMgNOQ0UqDiAtMUEvWU9BTk5URVNUSuYFGhQyMDI0LTA2LTI4VDA4OjQ1OjMyWiINCgsKCU5DRTZYMDEwMCoBIDIDEgExOkQSEGhpc3RvcnlDaGFuZ2VMb2cYASIbOFhUSjNULTIwMjQtMDYtMjgtUE5SLUFJUi0yKgdwcm9kdWN0Mghwcm9kdWN0czpkEhBoaXN0b3J5Q2hhbmdlTG9nGAEiHDhYVEozVC0yMDI0LTA2LTI4LVBOUi1CS0ctMTAqEHNlZ21lbnQtZGVsaXZlcnkyHnByb2R1Y3RzL2FpclNlZ21lbnQvZGVsaXZlcmllczrfAhIPZW50aXR5Q2hhbmdlTG9nQssCesgCCgdwcm9kdWN0EAEaGzhYVEozVC0yMDI0LTA2LTI4LVBOUi1BSVItMSKdAgoaCgNOQ0UaEzIwMjQtMDgtMjBUMDY6MDA6MDASGgoDTEhSGhMyMDI0LTA4LTIwVDA3OjEwOjAwIk8KCQoCNlgSAzU2MhInCgFZEgMKAVkaFAoCCAASDAoEGgI2WBIEKgJGUiABIgdFQ09OT01ZMhk2WC01NjItMjAyNC0wOC0yMC1OQ0UtTEhSSgJIS2KEAQoQc2VnbWVudC1kZWxpdmVyeRIbOFhUSjNULTIwMjQtMDYtMjgtUE5SLUJLRy0xGhA2MDA0RTM5MzAwMDAxMzNCWkEKC3N0YWtlaG9sZGVyEho4WFRKM1QtMjAyNC0wNi0yOC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc4oBAUWSAQIIADpEEhBoaXN0b3J5Q2hhbmdlTG9nGAIiGzhYVEozVC0yMDI0LTA2LTI4LVBOUi1BSVItMSoHcHJvZHVjdDIIcHJvZHVjdHM6YxIQaGlzdG9yeUNoYW5nZUxvZxgCIhs4WFRKM1QtMjAyNC0wNi0yOC1QTlItQktHLTEqEHNlZ21lbnQtZGVsaXZlcnkyHnByb2R1Y3RzL2FpclNlZ21lbnQvZGVsaXZlcmllc3rQAQoLc3Rha2Vob2xkZXISGjhYVEozVC0yMDI0LTA2LTI4LVBOUi1OTS0xIgwSBEFQQ0gaBEFQWkxyPAoHY29udGFjdBIaOFhUSjNULTIwMjQtMDYtMjgtUE5SLUFQLTMaFXByb2Nlc3NlZFBuci5jb250YWN0c3pECgdzZXJ2aWNlEhs4WFRKM1QtMjAyNC0wNi0yOC1QTlItU1NSLTQaHHByb2Nlc3NlZFBuci5sb3lhbHR5UmVxdWVzdHOiARISEDYxMDQ4MzkyMDAwMDkxRTiCAZwDCgdwcm9kdWN0EAEaGzhYVEozVC0yMDI0LTA2LTI4LVBOUi1BSVItMiLxAgoaCgNMSFIaEzIwMjQtMDgtMjBUMjI6MDA6MDASGgoDU0lOGhMyMDI0LTA4LTIxVDE4OjU1OjAwIk8KCQoCNlgSAzY1MBInCgFZEgMKAU0aFAoCCAASDAoEGgI2WBIEKgJGUiABIgdFQ09OT01ZMhk2WC02NTAtMjAyNC0wOC0yMC1MSFItU0lOKlEKCQoCN1gSAzY1MBInCgFWEgMKAU0aFAoCCAASDAoEGgI2WBIEKgJGUiABIgdFQ09OT01ZKAIyGTdYLTY1MC0yMDI0LTA4LTIwLUxIUi1TSU5KAkhLYoUBChBzZWdtZW50LWRlbGl2ZXJ5Ehw4WFRKM1QtMjAyNC0wNi0yOC1QTlItQktHLTEwGhA2MDA0RTM5MzAwMDAxMzNDWkEKC3N0YWtlaG9sZGVyEho4WFRKM1QtMjAyNC0wNi0yOC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc4oBAUWSAQIIAJoB2AEKB3NlcnZpY2USGzhYVEozVC0yMDI0LTA2LTI4LVBOUi1TU1ItNBoERlFUViABKgQKAjZYMgJIS1ocCgoxMDAxMjM0NTAwEAEaBCoCNlgiBCoCKk8oAHJBCgtzdGFrZWhvbGRlchIaOFhUSjNULTIwMjQtMDYtMjgtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnN6PQoHcHJvZHVjdBIbOFhUSjNULTIwMjQtMDYtMjgtUE5SLUFJUi0yGhVwcm9jZXNzZWRQbnIucHJvZHVjdHOyAXEKB2NvbnRhY3QSGjhYVEozVC0yMDI0LTA2LTI4LVBOUi1BUC0zQAFaBQoDTkNFYkEKC3N0YWtlaG9sZGVyEho4WFRKM1QtMjAyNC0wNi0yOC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEho4WFRKM1QtMjAyNC0wNi0yOC1QTlItVEstMhgFIhMyMDI0LTA2LTI4VDAwOjAwOjAwKgsKCU5DRTZYMDEwMFpBCgtzdGFrZWhvbGRlchIaOFhUSjNULTIwMjQtMDYtMjgtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbOFhUSjNULTIwMjQtMDYtMjgtUE5SLUFJUi0yGhVwcm9jZXNzZWRQbnIucHJvZHVjdHM=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="10:45:37.323719 - 28 Jun 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001L10YBFS8C1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4663]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8XTJ3T-2024-06-28&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8XTJ3T&quot;, &amp;
    &quot;version&quot;: &quot;2&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-28T08:45:00Z&quot;, &amp;
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
        &quot;dateTime&quot;: &quot;2024-06-28T08:45:32Z&quot;, &amp;
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
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8XTJ3T-2024-06-28-PNR-AIR-2&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8XTJ3T-2024-06-28-PNR-BKG-10&quot;, &amp;
                &quot;elementType&quot;: &quot;segment-delivery&quot;, &amp;
                &quot;path&quot;: &quot;products/airSegment/deliveries&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;entityChangeLog&quot;, &amp;
                &quot;oldEntity&quot;: \{&amp;
                    &quot;products&quot;: [&amp;
                        \{&amp;
                            &quot;type&quot;: &quot;product&quot;, &amp;
                            &quot;subType&quot;: &quot;AIR&quot;, &amp;
                            &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-AIR-1&quot;, &amp;
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
                                        &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-BKG-1&quot;, &amp;
                                        &quot;distributionId&quot;: &quot;6004E3930000133B&quot;, &amp;
                                        &quot;traveler&quot;: \{&amp;
                                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                                            &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-NM-1&quot;, &amp;
                                            &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                                        \}&amp;
                                    \}&amp;
                                ], &amp;
                                &quot;distributionMethod&quot;: &quot;E&quot;, &amp;
                                &quot;notAcknowledged&quot;: false&amp;
                            \}&amp;
                        \}&amp;
                    ]&amp;
                \}&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;REMOVE&quot;, &amp;
                &quot;elementId&quot;: &quot;8XTJ3T-2024-06-28-PNR-AIR-1&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;REMOVE&quot;, &amp;
                &quot;elementId&quot;: &quot;8XTJ3T-2024-06-28-PNR-BKG-1&quot;, &amp;
                &quot;elementType&quot;: &quot;segment-delivery&quot;, &amp;
                &quot;path&quot;: &quot;products/airSegment/deliveries&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;APCH&quot;, &amp;
                    &quot;lastName&quot;: &quot;APZL&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-AP-3&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;loyaltyAccruals&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;service&quot;, &amp;
                    &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-SSR-4&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.loyaltyRequests&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;61048392000091E8&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-AIR-2&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-08-20T22:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;SIN&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-08-21T18:55:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;650&quot;&amp;
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
                    &quot;id&quot;: &quot;6X-650-2024-08-20-LHR-SIN&quot;&amp;
                \}, &amp;
                &quot;operating&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;7X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;650&quot;&amp;
                    \}, &amp;
                    &quot;bookingClass&quot;: \{&amp;
                        &quot;code&quot;: &quot;V&quot;, &amp;
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
                    &quot;codeshareAgreement&quot;: &quot;FREEFLOW&quot;, &amp;
                    &quot;id&quot;: &quot;7X-650-2024-08-20-LHR-SIN&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-BKG-10&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6004E3930000133C&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-SSR-4&quot;, &amp;
            &quot;code&quot;: &quot;FQTV&quot;, &amp;
            &quot;subType&quot;: &quot;SPECIAL_SERVICE_REQUEST&quot;, &amp;
            &quot;serviceProvider&quot;: \{&amp;
                &quot;code&quot;: &quot;6X&quot;&amp;
            \}, &amp;
            &quot;status&quot;: &quot;HK&quot;, &amp;
            &quot;membership&quot;: \{&amp;
                &quot;id&quot;: &quot;1001234500&quot;, &amp;
                &quot;membershipType&quot;: &quot;INDIVIDUAL&quot;, &amp;
                &quot;activeTier&quot;: \{&amp;
                    &quot;companyCode&quot;: &quot;6X&quot;&amp;
                \}, &amp;
                &quot;allianceTier&quot;: \{&amp;
                    &quot;companyCode&quot;: &quot;*O&quot;&amp;
                \}&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-AIR-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-AP-3&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;NCE&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-TK-2&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-06-28T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8XTJ3T-2024-06-28-PNR-AIR-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="22" endLine="282" beginLine="281" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:37.324792 - 28 Jun 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8XTJ3T]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="10:45:37.721054 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            7X/CS  28JUN24/0845Z   8XTJ3T&amp;
  1.APZL/APCH&amp;
  2  6X 650 Y 20AUG 2 LHRSIN HK1  2200 1855  21AUG  E  6X/8XTJ3T&amp;
  3 AP NCE&amp;
  4 TK OK28JUN/NCE6X0100&amp;
  5 SSR FQTV 6X HK/ 6X1001234500&amp;
  6 SSR OTHS 1A MISSING SSR CTCM MOBILE OR SSR CTCE EMAIL OR SSR&amp;
       CTCR NON-CONSENT FOR 7X&amp;
  7 OPC-19AUG:2300/1C8/6X CANCELLATION DUE TO NO TICKET NCE TIME&amp;
        ZONE/TKT/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="23" endLine="283" beginLine="282" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:37.721672 - 28 Jun 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="10:45:37.978013 - 28 Jun 2024" filename="">--- RLR ---&amp;
RP/NCE6X0100/NCE6X0100            7X/CS  28JUN24/0845Z   8XTJ3T&amp;
  1.APZL/APCH&amp;
  2 AP NCE&amp;
  3 TK OK28JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="24" endLine="284" beginLine="283" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:37.978116 - 28 Jun 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="10:45:38.373726 - 28 Jun 2024" filename="">END OF TRANSACTION COMPLETE - 8XTJ3T&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="25" endLine="285" beginLine="284" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:38.373904 - 28 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="10:45:38.446775 - 28 Jun 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="289" beginLine="288" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:38.446984 - 28 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="10:45:38.568594 - 28 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="290" beginLine="289" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/03_Add_Remove_segment_SSR_FQTV_Feed.cry" loop="0" sentAt="10:45:38.568764 - 28 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="10:45:38.644234 - 28 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">20146</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">4242</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">28</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">27</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.964286</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">16172.9</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.124</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">6947.86</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">42</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>