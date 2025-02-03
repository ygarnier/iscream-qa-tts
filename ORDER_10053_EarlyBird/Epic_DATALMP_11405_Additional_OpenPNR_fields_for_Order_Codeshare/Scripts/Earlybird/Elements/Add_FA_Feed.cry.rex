<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry"><SCRIPT type="Initialize">import json
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

        #Check hisotryChangeLog data for coupon number (FA)
        assert_equal(actual=len(openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;]), expected=8, item_name=&apos;number of changeLog&apos;)
        changeLog_1 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][0]
        changeLog_2 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][1]
        changeLog_3 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][2]
        changeLog_4 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][3]
        changeLog_5 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][4]
        changeLog_6 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][5]
        changeLog_7 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][6]
        changeLog_8 = openpnr[&apos;lastModification&apos;][&apos;changeLog&apos;][7]

        #First changeLog section
        assert_equal(actual=changeLog_1[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_1[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_1[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-NM-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_1[&apos;elementType&apos;], expected=&quot;stakeholder&quot;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_1[&apos;path&apos;], expected=&quot;travelers&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Second changeLog section
        assert_equal(actual=changeLog_2[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_2[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_2[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-AIR-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_2[&apos;elementType&apos;], expected=&quot;product&quot;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_2[&apos;path&apos;], expected=&quot;products&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Third changeLog section
        assert_equal(actual=changeLog_3[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_3[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_3[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-BKG-1&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_3[&apos;elementType&apos;], expected=&quot;segment-delivery&quot;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_3[&apos;path&apos;], expected=&quot;products/airSegment/deliveries&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Fourth changeLog section
        assert_equal(actual=changeLog_4[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_4[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_4[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_4[&apos;elementType&apos;], expected=&quot;contact&quot;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_4[&apos;path&apos;], expected=&quot;contacts&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Fifth changeLog section
        assert_equal(actual=changeLog_5[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_5[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_5[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-TK-3&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_5[&apos;elementType&apos;], expected=&quot;automated-process&quot;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_5[&apos;path&apos;], expected=&quot;automatedProcesses&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Sixth changeLog section
        assert_equal(actual=changeLog_6[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_6[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_6[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-ECX-6&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_6[&apos;path&apos;], expected=&quot;externalContexts&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Seventh changeLog section
        assert_equal(actual=changeLog_7[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_7[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_7[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-FV-5&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_7[&apos;elementType&apos;], expected=&quot;fare-element&quot;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_7[&apos;path&apos;], expected=&quot;fareElements&quot;, item_name=&apos;historyChangeLog path&apos;)

        #Eighth changeLog section
        assert_equal(actual=changeLog_8[&apos;logType&apos;], expected=&apos;historyChangeLog&apos;, item_name=&apos;historyChangeLog logType&apos;)
        assert_equal(actual=changeLog_8[&apos;operation&apos;], expected=&apos;ADD&apos;, item_name=&apos;historyChangeLog operation&apos;)
        assert_equal(actual=changeLog_8[&apos;elementId&apos;], expected=recloc+&quot;-&quot;+today+&quot;-PNR-FP-4&quot;, item_name=&apos;historyChangeLog elementId&apos;)
        assert_equal(actual=changeLog_8[&apos;elementType&apos;], expected=&quot;payment-method&quot;, item_name=&apos;historyChangeLog elementType&apos;)
        assert_equal(actual=changeLog_8[&apos;path&apos;], expected=&quot;paymentMethods&quot;, item_name=&apos;historyChangeLog path&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="136" beginLine="135" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:18.808256 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:16:18.862849 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="137" beginLine="136" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:18.863918 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:16:18.920497 - 27 Jun 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="138" beginLine="137" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:18.920669 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:16:18.989390 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="145" beginLine="144" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:18.989910 - 27 Jun 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:16:19.048312 - 27 Jun 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="147" beginLine="146" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:21.051709 - 27 Jun 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="08:16:21.110464 - 27 Jun 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="153" responseBeginLine="153" endLine="151" beginLine="150" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:21.111357 - 27 Jun 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[Yoanntesting123*]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:16:21.274679 - 27 Jun 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/27JUN/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="162" beginLine="161" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:21.275902 - 27 Jun 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1AQTS/VOXR]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="08:16:21.382959 - 27 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.AQTS/VOXR&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="163" beginLine="162" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:21.383378 - 27 Jun 2024"><TEXT><![CDATA[SS 6X 556 Y 24MAR  NCELHR 1]]></TEXT></QUERY><REPLY receiveAt="08:16:21.729930 - 27 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="164" beginLine="163" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:21.730062 - 27 Jun 2024"><TEXT><![CDATA[SS 6X1207 Y 26MAR  LHRCDG 1]]></TEXT></QUERY><REPLY receiveAt="08:16:22.311698 - 27 Jun 2024" filename="">  6X1207 Y 26MAR 3 LHRCDG FLIGHT DOES NOT OPERATE ON DATE REQUESTED&amp;
AD26MAR25-LHRCDG0000&amp;
** AMADEUS SIX - AD ** CDG CHARLES DE GAUL.FR                272 WE 26MAR 0000&amp;
 1   6X1207  C9 D9 I9 U9 Y9 B9 H9 /LHR   CDG    0615    0825  E0/320       1:10&amp;
             K9 M9 L9 V9 N9 O9 S9 Q9 G9 X9 E9&amp;
 2   6X3915  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 3   6X3901  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 4   6X3912  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 5   6X3913  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 6   6X3914  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 7   6X3902  C9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/320       2:00&amp;
 8   6X3900  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 9   6X3903  Y9                   /LHR   CDG    0800    1100  E0/319       2:00&amp;
10   6X7918  J9 D9 I9 U9 Y9       /LHR   CDG    0900    1030  E0/738       0:30&amp;
11   6X1174  C9 D9 I9 U9 Y9 B9 H9 /LHR   CDG    0915    1130  E0/319       1:15&amp;
             K9 M9 L9 V9 N9 O9 S9 Q9 G9 X9 E9&amp;
12   6X1173  C9 D9 I9 U9 Y9 B9 H9 /LHR   CDG    0915    1130  E0/319       1:15&amp;
             K9 M9 L9 V9 N9 O9 S9 Q9 G9 X9 E9&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="169" beginLine="168" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:22.312217 - 27 Jun 2024"><TEXT><![CDATA[AP NCE]]></TEXT></QUERY><REPLY receiveAt="08:16:22.436189 - 27 Jun 2024" filename="">RP/NCE6X0100/&amp;
  1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="170" beginLine="169" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:22.436576 - 27 Jun 2024"><TEXT><![CDATA[RF YG]]></TEXT></QUERY><REPLY receiveAt="08:16:22.572316 - 27 Jun 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" endLine="171" beginLine="170" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:22.572730 - 27 Jun 2024"><TEXT><![CDATA[TKOK]]></TEXT></QUERY><REPLY receiveAt="08:16:22.701861 - 27 Jun 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
  4 TK OK27JUN/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" endLine="175" beginLine="174" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:24.711611 - 27 Jun 2024"><TEXT><![CDATA[FPCASH]]></TEXT></QUERY><REPLY receiveAt="08:16:24.914762 - 27 Jun 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
  4 TK OK27JUN/NCE6X0100&amp;
  5 FP CASH&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="177" beginLine="176" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:27.922130 - 27 Jun 2024"><TEXT><![CDATA[FXB]]></TEXT></QUERY><REPLY receiveAt="08:16:28.574860 - 27 Jun 2024" filename="">FXB&amp;
&amp;
01 AQTS/VOXR&amp;
NO REBOOKING REQUIRED FOR LOWEST AVAILABLE FARE&amp;
&amp;
------------------------------------------------------------&amp;
     AL FLGT  BK T DATE  TIME  FARE BASIS      NVB  NVA   BG&amp;
 NCE&amp;
 LON 6X   556 Y  Y 24MAR 0600  YTSHOP                     3P&amp;
&amp;
EUR    10.00      24MAR25NCE 6X LON10.75NUC10.75END ROE&amp;
                  0.929425&amp;
EUR     5.05-FR   XT EUR 1.13-IZ EUR 1.50-O4 EUR 8.50-QX&amp;
EUR    10.40-FR&amp;
EUR    11.13-XT&amp;
EUR    36.58&amp;
EUR    62.00    AIRLINE FEES&amp;
EUR    98.58    TOTAL&amp;
AIRLINE FEES INCLUDED&amp;
BG CXR: 6X&amp;
PRICED WITH VALIDATING CARRIER 6X - REPRICE IF DIFFERENT VC&amp;
&gt;                                                 PAGE  2/ 2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="184" responseBeginLine="181" endLine="179" beginLine="178" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:30.582961 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="08:16:31.334763 - 27 Jun 2024" match="OK"><TEXT><![CDATA[--- ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[TST]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[RLR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[27JUN24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0616Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8RP387]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?FV}]]></EXPRESSION><VALUE><![CDATA[  1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR HK1  0600 0710  24MAR  E  6X/8RP387&amp;
  3 AP NCE&amp;
  4 TK OK27JUN/NCE6X0100&amp;
  5 FP CASH&amp;
  6 FV]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ PAX 6X/S2&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" endLine="187" beginLine="186" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:31.336557 - 27 Jun 2024"><TEXT><![CDATA[TTP/ET/RT]]></TEXT></QUERY><REPLY receiveAt="08:16:36.370670 - 27 Jun 2024" filename="">OK ETICKET&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" endLine="190" beginLine="189" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:37.381618 - 27 Jun 2024"><TEXT><![CDATA[RFTEST]]></TEXT></QUERY><REPLY receiveAt="08:16:37.525015 - 27 Jun 2024" filename="">--- TST RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  27JUN24/0616Z   8RP387&amp;
RF TEST&amp;
  1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR HK1  0600 0710  24MAR  E  6X/8RP387&amp;
  3 AP NCE&amp;
  4 TK OK27JUN/NCE6X0100//ET6X&amp;
  5 FA PAX 172-2400073763/ET6X/EUR36.58/27JUN24/NCE6X0100/006310&amp;
       02/S2&amp;
  6 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  7 FP CASH&amp;
  8 FV PAX 6X/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18" endLine="191" beginLine="190" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:37.525412 - 27 Jun 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="08:16:38.454042 - 27 Jun 2024" filename="">--- TST RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  27JUN24/0616Z   8RP387&amp;
  1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR HK1  0600 0710  24MAR  E  6X/8RP387&amp;
  3 AP NCE&amp;
  4 TK OK27JUN/NCE6X0100//ET6X&amp;
  5 FA PAX 172-2400073763/ET6X/EUR36.58/27JUN24/NCE6X0100/006310&amp;
       02/S2&amp;
  6 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  7 FP CASH&amp;
  8 FV PAX 6X/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="205" responseBeginLine="203" endLine="201" beginLine="200" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="OK"><SCRIPT type="Exec"># Compose the expected PNR ID used in OpenPNR, e.g. ABC123-2025-05-27
openpnr_id = recloc + &apos;-&apos; + today
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:38.455238 - 27 Jun 2024"><TEXT><![CDATA[RT]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RP387]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="08:16:38.680254 - 27 Jun 2024" match="OK"><TEXT><![CDATA[--- ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[TST]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[RLR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[27JUN24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0616Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[8RP387]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?FA}]]></EXPRESSION><VALUE><![CDATA[1.AQTS/VOXR&amp;
  2  6X 556 Y 24MAR 1 NCELHR HK1  0600 0710  24MAR  E  6X/8RP387&amp;
  3 AP NCE&amp;
  4 TK OK27JUN/NCE6X0100//ET6X&amp;
  5 FA]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ PAX ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%PDN_start%=.{3}}]]></EXPRESSION><VALUE><![CDATA[172]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[-]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%PDN_end%=.{10}}]]></EXPRESSION><VALUE><![CDATA[2400073763]]></VALUE></REGULAR_EXPRESSION><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/ET6X/EUR36.58/27JUN24/NCE6X0100/006310&amp;
       02/S2&amp;
  6 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  7 FP CASH&amp;
  8 FV PAX 6X/S2&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" endLine="210" beginLine="209" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:38.680606 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:16:38.751421 - 27 Jun 2024" filename="">IGNORED - 8RP387&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="225" responseBeginLine="223" endLine="221" beginLine="217" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:38.807230 - 27 Jun 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[0447YG]]></VALUE></VARIABLE><TEXT><![CDATA[SU&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RP387]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:16:39.095667 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:8RP387::270624:0616&apos;&amp;
RSI+RP:YGSU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:0447YG:270624:00631002:0616&apos;&amp;
LFT+3:P12+--- TST RLR ---&apos;&amp;
STX+TST*RLR&apos;&amp;
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
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2025:3:28&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+AQTS::1+VOXR&apos;&amp;
ETI+:1+UN:Y:Y::AQTS:VOXR&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+240325:0600:240325:0710+NCE+LHR+6X+556:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:8RP387&apos;&amp;
RPI+1+HK&apos;&amp;
APD+ERJ:0:0210::1+++648:M&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+240325:0600:240325:0710+NCE+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+NCE&apos;&amp;
EMS++OT:13+TK+4&apos;&amp;
TKE++OK:270624::NCE6X0100:::ET:6X&apos;&amp;
EMS++OT:14+FA+5&apos;&amp;
LFT+3:P06+PAX 172-2400073763/ET6X/EUR36.58/27JUN24/NCE6X0100/00631002&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:12+FB+6&apos;&amp;
LFT+3:P07+PAX 0000000000 TTP/ET/RT OK ETICKET&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:4+FP+7&apos;&amp;
LFT+3:16+CASH&apos;&amp;
EMS++OT:5+FV+8&apos;&amp;
LFT+3:P18+PAX 6X&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
GSI+1:270624&apos;&amp;
LFT+3:41+PAX&apos;&amp;
LFT+3:37+NCE 6X LON10.75NUC10.75END ROE0.929425&apos;&amp;
MFB+YTS::::3PC:HOP&apos;&amp;
KFL+F+F:10.00:EUR*T:36.58:EUR+X:EUR:5.05:FR:SE*X:EUR:10.40:FR:TI*X:EUR:1.13:IZ:EB*X:EUR:1.50:O4:VC*X:EUR:8.50:QX:AP&apos;&amp;
SDT+N*I&apos;&amp;
REF+PT:1*ST:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21"><QUERY filename="" loop="0" sentAt="08:16:39.096993 - 27 Jun 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="22" responseEndLine="258" responseBeginLine="245" endLine="243" beginLine="237" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:39.226613 - 27 Jun 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RP387]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:16:39.305077 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RP387]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[27JUN24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[8RP387]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240627\:06\:16\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:16:31]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4450609103]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:16:31]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="23" responseEndLine="279" responseBeginLine="273" endLine="271" beginLine="267" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:39.346508 - 27 Jun 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4450609103]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:06:27:06:16:31]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="08:16:39.397807 - 27 Jun 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4450609103]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:06:27:06:16:31]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2190]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xEE\x10\x12\x91\x10\x0A\x118RP387-2024-06-27\x12\x03pnr\x1A\x068RP387&quot;\x010:f\x1A\x142024-06-27T06:16:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x040447\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x0FYG-1A/YOANNTESTJ\xA3\x05\x1A\x142024-06-27T06:16:30Z&quot;\x0D\x0A\x0B\x0A\x09NCE6X0100*\x02YG:H\x12\x10historyChangeLog\x18\x01&quot;\x1A8RP387-2024-06-27-PNR-NM-1*\x0Bstakeholder2\x09travelers:D\x12\x10historyChangeLog\x18\x01&quot;\x1B8RP387-2024-06-27-PNR-AIR-1*\x07product2\x08products:c\x12\x10historyChangeLog\x18\x01&quot;\x1B8RP387-2024-06-27-PNR-BKG-1*\x10segment-delivery2\x1Eproducts/airSegment/deliveries:C\x12\x10historyChangeLog\x18\x01&quot;\x1A8RP387-2024-06-27-PNR-AP-2*\x07contact2\x08contacts:W\x12\x10historyChangeLog\x18\x01&quot;\x1A8RP387-2024-06-27-PNR-TK-3*\x11automated-process2\x12automatedProcesses:E\x12\x10historyChangeLog\x18\x01&quot;\x1B8RP387-2024-06-27-PNR-ECX-6*\x002\x10externalContexts:L\x12\x10historyChangeLog\x18\x01&quot;\x1A8RP387-2024-06-27-PNR-FV-5*\x0Cfare-element2\x0CfareElements:P\x12\x10historyChangeLog\x18\x01&quot;\x1A8RP387-2024-06-27-PNR-FP-4*\x0Epayment-method2\x0EpaymentMethodsz\x8A\x01\x0A\x0Bstakeholder\x12\x1A8RP387-2024-06-27-PNR-NM-1&quot;\x0C\x12\x04VOXR\x1A\x04AQTSr&lt;\x0A\x07contact\x12\x1A8RP387-2024-06-27-PNR-AP-2\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x106103839100009607\x82\x01\xC8\x02\x0A\x07product\x10\x01\x1A\x1B8RP387-2024-06-27-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132025-03-24T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132025-03-24T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03556\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-556-2025-03-24-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B8RP387-2024-06-27-PNR-BKG-1\x1A\x1060040392000007F4ZA\x0A\x0Bstakeholder\x12\x1A8RP387-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01q\x0A\x07contact\x12\x1A8RP387-2024-06-27-PNR-AP-2@\x01Z\x05\x0A\x03NCEbA\x0A\x0Bstakeholder\x12\x1A8RP387-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A8RP387-2024-06-27-PNR-TK-3\x18\x05&quot;\x132024-06-27T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A8RP387-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B8RP387-2024-06-27-PNR-AIR-1\x1A\x15processedPnr.products\xC2\x01\xC3\x01\x0A\x0Epayment-method\x12\x1A8RP387-2024-06-27-PNR-FP-4\x18\x032\x0D\x0A\x03STD\x10\x01\x1A\x04CASHB\x02\x08\x00JA\x0A\x0Bstakeholder\x12\x1A8RP387-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelersR=\x0A\x07product\x12\x1B8RP387-2024-06-27-PNR-AIR-1\x1A\x15processedPnr.products\xCA\x010\x0A\x0Cfare-element\x12\x1A8RP387-2024-06-27-PNR-FV-5\x18\x0E:\x026X\xEA\x01\xBC\x01\x12\x1B8RP387-2024-06-27-PNR-ECX-6\x1A\x04DAPI&quot;\x1FP20240627-2107117697948677947-1*\x0FPaxLinkOfferPNR2\x026XB\x12\x0A\x0APaxInOffer\x12\x04PAX1B\x0A\x0A\x03PTC\x12\x03ADTRA\x0A\x0Bstakeholder\x12\x1A8RP387-2024-06-27-PNR-NM-1\x1A\x16processedPnr.travelers\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x068RP387\x1A\x010&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="24" responseEndLine="306" responseBeginLine="300" endLine="298" beginLine="293" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:39.400085 - 27 Jun 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik56UXhNakF6TmpjME9UazBOVFV4TWc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDYtMjdUMDY6MTY6MTcuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiI5MGs5YkZQOEpWRmpHalZDTXZVTWJMaTJ2ZGs9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE4UlAzODctMjAyNC0wNi0yNxIDcG5yGgY4UlAzODciATA6ZhoUMjAyNC0wNi0yN1QwNjoxNjowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQwNDQ3EgJZRxoCU1UqAkZSMgNOQ0UqD1lHLTFBL1lPQU5OVEVTVEqjBRoUMjAyNC0wNi0yN1QwNjoxNjozMFoiDQoLCglOQ0U2WDAxMDAqAllHOkgSEGhpc3RvcnlDaGFuZ2VMb2cYASIaOFJQMzg3LTIwMjQtMDYtMjctUE5SLU5NLTEqC3N0YWtlaG9sZGVyMgl0cmF2ZWxlcnM6RBIQaGlzdG9yeUNoYW5nZUxvZxgBIhs4UlAzODctMjAyNC0wNi0yNy1QTlItQUlSLTEqB3Byb2R1Y3QyCHByb2R1Y3RzOmMSEGhpc3RvcnlDaGFuZ2VMb2cYASIbOFJQMzg3LTIwMjQtMDYtMjctUE5SLUJLRy0xKhBzZWdtZW50LWRlbGl2ZXJ5Mh5wcm9kdWN0cy9haXJTZWdtZW50L2RlbGl2ZXJpZXM6QxIQaGlzdG9yeUNoYW5nZUxvZxgBIho4UlAzODctMjAyNC0wNi0yNy1QTlItQVAtMioHY29udGFjdDIIY29udGFjdHM6VxIQaGlzdG9yeUNoYW5nZUxvZxgBIho4UlAzODctMjAyNC0wNi0yNy1QTlItVEstMyoRYXV0b21hdGVkLXByb2Nlc3MyEmF1dG9tYXRlZFByb2Nlc3NlczpFEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGzhSUDM4Ny0yMDI0LTA2LTI3LVBOUi1FQ1gtNioAMhBleHRlcm5hbENvbnRleHRzOkwSEGhpc3RvcnlDaGFuZ2VMb2cYASIaOFJQMzg3LTIwMjQtMDYtMjctUE5SLUZWLTUqDGZhcmUtZWxlbWVudDIMZmFyZUVsZW1lbnRzOlASEGhpc3RvcnlDaGFuZ2VMb2cYASIaOFJQMzg3LTIwMjQtMDYtMjctUE5SLUZQLTQqDnBheW1lbnQtbWV0aG9kMg5wYXltZW50TWV0aG9kc3qKAQoLc3Rha2Vob2xkZXISGjhSUDM4Ny0yMDI0LTA2LTI3LVBOUi1OTS0xIgwSBFZPWFIaBEFRVFNyPAoHY29udGFjdBIaOFJQMzg3LTIwMjQtMDYtMjctUE5SLUFQLTIaFXByb2Nlc3NlZFBuci5jb250YWN0c6IBEhIQNjEwMzgzOTEwMDAwOTYwN4IByAIKB3Byb2R1Y3QQARobOFJQMzg3LTIwMjQtMDYtMjctUE5SLUFJUi0xIp0CChoKA05DRRoTMjAyNS0wMy0yNFQwNjowMDowMBIaCgNMSFIaEzIwMjUtMDMtMjRUMDc6MTA6MDAiTwoJCgI2WBIDNTU2EicKAVkSAwoBWRoUCgIIABIMCgQaAjZYEgQqAkZSIAEiB0VDT05PTVkyGTZYLTU1Ni0yMDI1LTAzLTI0LU5DRS1MSFJKAkhLYoQBChBzZWdtZW50LWRlbGl2ZXJ5Ehs4UlAzODctMjAyNC0wNi0yNy1QTlItQktHLTEaEDYwMDQwMzkyMDAwMDA3RjRaQQoLc3Rha2Vob2xkZXISGjhSUDM4Ny0yMDI0LTA2LTI3LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzigEBRZIBAggAsgFxCgdjb250YWN0Eho4UlAzODctMjAyNC0wNi0yNy1QTlItQVAtMkABWgUKA05DRWJBCgtzdGFrZWhvbGRlchIaOFJQMzg3LTIwMjQtMDYtMjctUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnO6AdUBChFhdXRvbWF0ZWQtcHJvY2VzcxIaOFJQMzg3LTIwMjQtMDYtMjctUE5SLVRLLTMYBSITMjAyNC0wNi0yN1QwMDowMDowMCoLCglOQ0U2WDAxMDBaQQoLc3Rha2Vob2xkZXISGjhSUDM4Ny0yMDI0LTA2LTI3LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzYj0KB3Byb2R1Y3QSGzhSUDM4Ny0yMDI0LTA2LTI3LVBOUi1BSVItMRoVcHJvY2Vzc2VkUG5yLnByb2R1Y3RzwgHDAQoOcGF5bWVudC1tZXRob2QSGjhSUDM4Ny0yMDI0LTA2LTI3LVBOUi1GUC00GAMyDQoDU1REEAEaBENBU0hCAggASkEKC3N0YWtlaG9sZGVyEho4UlAzODctMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc1I9Cgdwcm9kdWN0Ehs4UlAzODctMjAyNC0wNi0yNy1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0c8oBMAoMZmFyZS1lbGVtZW50Eho4UlAzODctMjAyNC0wNi0yNy1QTlItRlYtNRgOOgI2WOoBvAESGzhSUDM4Ny0yMDI0LTA2LTI3LVBOUi1FQ1gtNhoEREFQSSIfUDIwMjQwNjI3LTIxMDcxMTc2OTc5NDg2Nzc5NDctMSoPUGF4TGlua09mZmVyUE5SMgI2WEISCgpQYXhJbk9mZmVyEgRQQVgxQgoKA1BUQxIDQURUUkEKC3N0YWtlaG9sZGVyEho4UlAzODctMjAyNC0wNi0yNy1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVycw==]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON compareAt="08:16:39.553832 - 27 Jun 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001KUSZ2FQ6RR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4112]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;8RP387-2024-06-27&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;8RP387&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:16:00Z&quot;, &amp;
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
        &quot;comment&quot;: &quot;YG-1A/YOANNTEST&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-06-27T06:16:30Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;YG&quot;, &amp;
        &quot;changeLog&quot;: [&amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8RP387-2024-06-27-PNR-NM-1&quot;, &amp;
                &quot;elementType&quot;: &quot;stakeholder&quot;, &amp;
                &quot;path&quot;: &quot;travelers&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8RP387-2024-06-27-PNR-AIR-1&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8RP387-2024-06-27-PNR-BKG-1&quot;, &amp;
                &quot;elementType&quot;: &quot;segment-delivery&quot;, &amp;
                &quot;path&quot;: &quot;products/airSegment/deliveries&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8RP387-2024-06-27-PNR-AP-2&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8RP387-2024-06-27-PNR-TK-3&quot;, &amp;
                &quot;elementType&quot;: &quot;automated-process&quot;, &amp;
                &quot;path&quot;: &quot;automatedProcesses&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8RP387-2024-06-27-PNR-ECX-6&quot;, &amp;
                &quot;path&quot;: &quot;externalContexts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8RP387-2024-06-27-PNR-FV-5&quot;, &amp;
                &quot;elementType&quot;: &quot;fare-element&quot;, &amp;
                &quot;path&quot;: &quot;fareElements&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;8RP387-2024-06-27-PNR-FP-4&quot;, &amp;
                &quot;elementType&quot;: &quot;payment-method&quot;, &amp;
                &quot;path&quot;: &quot;paymentMethods&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;VOXR&quot;, &amp;
                    &quot;lastName&quot;: &quot;AQTS&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6103839100009607&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;NCE&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2025-03-24T06:00:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2025-03-24T07:10:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;556&quot;&amp;
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
                    &quot;id&quot;: &quot;6X-556-2025-03-24-NCE-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;60040392000007F4&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;NCE&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-06-27T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;paymentMethods&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;payment-method&quot;, &amp;
            &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-FP-4&quot;, &amp;
            &quot;code&quot;: &quot;FP&quot;, &amp;
            &quot;formsOfPayment&quot;: [&amp;
                \{&amp;
                    &quot;code&quot;: &quot;STD&quot;, &amp;
                    &quot;fopIndicator&quot;: &quot;NEW&quot;, &amp;
                    &quot;freeText&quot;: &quot;CASH&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;isInfant&quot;: false, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;fareElements&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;fare-element&quot;, &amp;
            &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-FV-5&quot;, &amp;
            &quot;code&quot;: &quot;FV&quot;, &amp;
            &quot;text&quot;: &quot;6X&quot;&amp;
        \}&amp;
    ], &amp;
    &quot;externalContexts&quot;: [&amp;
        \{&amp;
            &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-ECX-6&quot;, &amp;
            &quot;source&quot;: &quot;DAPI&quot;, &amp;
            &quot;reference&quot;: &quot;P20240627-2107117697948677947-1&quot;, &amp;
            &quot;contextType&quot;: &quot;PaxLinkOfferPNR&quot;, &amp;
            &quot;owner&quot;: &quot;6X&quot;, &amp;
            &quot;datas&quot;: [&amp;
                \{&amp;
                    &quot;key&quot;: &quot;PaxInOffer&quot;, &amp;
                    &quot;value&quot;: &quot;PAX1&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;key&quot;: &quot;PTC&quot;, &amp;
                    &quot;value&quot;: &quot;ADT&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;8RP387-2024-06-27-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="25" endLine="320" beginLine="319" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:39.555583 - 27 Jun 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="08:16:39.639329 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="321" beginLine="320" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:39.640042 - 27 Jun 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="08:16:39.730376 - 27 Jun 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="322" beginLine="321" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:39.730517 - 27 Jun 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="08:16:39.805051 - 27 Jun 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="28" endLine="326" beginLine="325" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:39.805326 - 27 Jun 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="08:16:39.931115 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="29" endLine="327" beginLine="326" filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare(RM_concealment)/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/Add_FA_Feed.cry" loop="0" sentAt="08:16:39.931453 - 27 Jun 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="08:16:40.004211 - 27 Jun 2024" filename="">&amp;
09CC2B44         NCE1A0950&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">30</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">18744</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">30</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">4113</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">30</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">29</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.966667</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">21197.3</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.662</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">10923.3</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">51</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">0</STATISTIC_ELEMENT></STATISTIC></xml>