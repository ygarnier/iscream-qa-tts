<xml scenarioFilename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry"><SCRIPT type="Initialize">import json
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

</SCRIPT><TRANSACTION transactionCounter="1" endLine="136" beginLine="135" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:25.167232 - 28 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="17:51:25.218378 - 28 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" endLine="137" beginLine="136" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:25.218810 - 28 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="17:51:25.272490 - 28 Aug 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="3" endLine="138" beginLine="137" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:25.272708 - 28 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="17:51:25.366098 - 28 Aug 2024" filename="">&amp;
09CC2B44         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="145" beginLine="144" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:25.366445 - 28 Aug 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="17:51:25.423677 - 28 Aug 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="147" beginLine="146" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:27.432177 - 28 Aug 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[09CC2B44]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="17:51:27.490645 - 28 Aug 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="153" responseBeginLine="153" endLine="151" beginLine="150" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:27.491614 - 28 Aug 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[GVxyuXx77768bg+]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="17:51:27.652271 - 28 Aug 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/28AUG/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" endLine="162" beginLine="161" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><COMMENT> 2. Create a PNR</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:27.653901 - 28 Aug 2024"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{=Pax1.book()}]]></EXPRESSION><VALUE><![CDATA[NM1AFRG/JYFB]]></VALUE></REGULAR_EXPRESSION></QUERY><REPLY receiveAt="17:51:27.755515 - 28 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.AFRG/JYFB&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="8" endLine="163" beginLine="162" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:27.756156 - 28 Aug 2024"><TEXT><![CDATA[SS 6X 556 Y 24MAR  NCELHR 1]]></TEXT></QUERY><REPLY receiveAt="17:51:28.152401 - 28 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="9" endLine="164" beginLine="163" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:28.153100 - 28 Aug 2024"><TEXT><![CDATA[SS 6X1207 Y 26MAR  LHRCDG 1]]></TEXT></QUERY><REPLY receiveAt="17:51:28.721216 - 28 Aug 2024" filename="">  6X1207 Y 26MAR 3 LHRCDG FLIGHT DOES NOT OPERATE ON DATE REQUESTED&amp;
AD26MAR25-LHRCDG0000&amp;
** AMADEUS SIX - AD ** CDG CHARLES DE GAUL.FR                210 WE 26MAR 0000&amp;
 1   6X1207  C9 D9 I9 U9 Y9 B9 H9 /LHR   CDG    0615    0825  E0/320       1:10&amp;
             K9 M9 L9 V9 N9 O9 S9 Q9 G9 X9 E9&amp;
 2   6X3914  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 3   6X3915  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 4   6X3901  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 5   6X3903  Y9                   /LHR   CDG    0800    1100  E0/319       2:00&amp;
 6   6X3913  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 7   6X3912  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
 8   6X3902  C9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/320       2:00&amp;
 9   6X3900  J9 D9 I9 U9 Y9       /LHR   CDG    0800    1100  E0/738       2:00&amp;
10   6X7918  J9 D9 I9 U9 Y9       /LHR   CDG    0900    1030  E0/738       0:30&amp;
11   6X1177  C9 D9 I9 U9 Y9 B9 H9 /LHR   CDG    0915    1130  E0/319       1:15&amp;
             K9 M9 L9 V9 N9 O9 S9 Q9 G9 X9 E9&amp;
12   6X1171  C9 D9 I9 U9 Y9 B9 H9 /LHR   CDG    0915    1130  E0/319       1:15&amp;
             K9 M9 L9 V9 N9 O9 S9 Q9 G9 X9 E9&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="10" endLine="169" beginLine="168" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:28.721834 - 28 Aug 2024"><TEXT><![CDATA[AP NCE]]></TEXT></QUERY><REPLY receiveAt="17:51:28.844175 - 28 Aug 2024" filename="">RP/NCE6X0100/&amp;
  1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="11" endLine="170" beginLine="169" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:28.844679 - 28 Aug 2024"><TEXT><![CDATA[RF YG]]></TEXT></QUERY><REPLY receiveAt="17:51:28.987902 - 28 Aug 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="12" endLine="171" beginLine="170" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:28.988319 - 28 Aug 2024"><TEXT><![CDATA[TKOK]]></TEXT></QUERY><REPLY receiveAt="17:51:29.113460 - 28 Aug 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/NCE6X0100&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="13" endLine="175" beginLine="174" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:31.119070 - 28 Aug 2024"><TEXT><![CDATA[FPCASH]]></TEXT></QUERY><REPLY receiveAt="17:51:31.304149 - 28 Aug 2024" filename="">RP/NCE6X0100/&amp;
RF YG&amp;
  1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR DK1  0600 0710  24MAR  E  0 ERJ&amp;
     SEE RTSVC&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/NCE6X0100&amp;
  5 FP CASH&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="14" endLine="177" beginLine="176" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:34.306487 - 28 Aug 2024"><TEXT><![CDATA[FXB]]></TEXT></QUERY><REPLY receiveAt="17:51:34.993997 - 28 Aug 2024" filename="">FXB&amp;
&amp;
01 AFRG/JYFB&amp;
NO REBOOKING REQUIRED FOR LOWEST AVAILABLE FARE&amp;
&amp;
------------------------------------------------------------&amp;
     AL FLGT  BK T DATE  TIME  FARE BASIS      NVB  NVA   BG&amp;
 NCE&amp;
 LON 6X   556 Y  Y 24MAR 0600  YTSHOP                     3P&amp;
&amp;
EUR    10.00      24MAR25NCE 6X LON10.81NUC10.81END ROE&amp;
                  0.925058&amp;
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
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="15" responseEndLine="184" responseBeginLine="181" endLine="179" beginLine="178" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:37.007175 - 28 Aug 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><COMPARISON compareAt="17:51:37.599835 - 28 Aug 2024" match="OK"><TEXT><![CDATA[--- ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[TST]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[RLR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[28AUG24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1551Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[9VUBTB]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?FV}]]></EXPRESSION><VALUE><![CDATA[  1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR HK1  0600 0710  24MAR  E  6X/9VUBTB&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/NCE6X0100&amp;
  5 FP CASH&amp;
  6 FV]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ PAX 6X/S2&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="16" endLine="187" beginLine="186" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:37.600854 - 28 Aug 2024"><TEXT><![CDATA[TTP/ET/RT]]></TEXT></QUERY><REPLY receiveAt="17:51:42.378955 - 28 Aug 2024" filename="">OK ETICKET&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="17" endLine="190" beginLine="189" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:43.381345 - 28 Aug 2024"><TEXT><![CDATA[RFTEST]]></TEXT></QUERY><REPLY receiveAt="17:51:43.547939 - 28 Aug 2024" filename="">--- TST RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  28AUG24/1551Z   9VUBTB&amp;
RF TEST&amp;
  1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR HK1  0600 0710  24MAR  E  6X/9VUBTB&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/NCE6X0100//ET6X&amp;
  5 SSR BAGA 6X HN1 TTL3PC23KG/S2&amp;
  6 FA PAX 172-2400155459/ET6X/EUR36.58/28AUG24/NCE6X0100/006310&amp;
       02/S2&amp;
  7 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  8 FP CASH&amp;
  9 FV PAX 6X/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="18" endLine="191" beginLine="190" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:43.548383 - 28 Aug 2024"><TEXT><![CDATA[ER]]></TEXT></QUERY><REPLY receiveAt="17:51:44.049719 - 28 Aug 2024" filename="">--- TST RLR ---&amp;
RP/NCE6X0100/NCE6X0100            YG/SU  28AUG24/1551Z   9VUBTB&amp;
  1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR HK1  0600 0710  24MAR  E  6X/9VUBTB&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/NCE6X0100//ET6X&amp;
  5 SSR BAGA 6X HN1 TTL3PC23KG/S2&amp;
  6 FA PAX 172-2400155459/ET6X/EUR36.58/28AUG24/NCE6X0100/006310&amp;
       02/S2&amp;
  7 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  8 FP CASH&amp;
  9 FV PAX 6X/S2&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="19" responseEndLine="205" responseBeginLine="203" endLine="201" beginLine="200" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="OK"><SCRIPT type="Exec"># Compose the expected PNR ID used in OpenPNR, e.g. ABC123-2025-05-27
openpnr_id = recloc + &apos;-&apos; + today
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:44.050758 - 28 Aug 2024"><TEXT><![CDATA[RT]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9VUBTB]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="17:51:44.316090 - 28 Aug 2024" match="OK"><TEXT><![CDATA[--- ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[TST]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[RLR]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ ---&amp;
RP/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[/]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[            ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[YG]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[SU]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[28AUG24]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[/]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1551Z]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[   ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[9VUBTB]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
  ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?FA}]]></EXPRESSION><VALUE><![CDATA[1.AFRG/JYFB&amp;
  2  6X 556 Y 24MAR 1 NCELHR HK1  0600 0710  24MAR  E  6X/9VUBTB&amp;
  3 AP NCE&amp;
  4 TK OK28AUG/NCE6X0100//ET6X&amp;
  5 SSR BAGA 6X HN1 TTL3PC23KG/S2&amp;
  6 FA]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ PAX ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%PDN_start%=.{3}}]]></EXPRESSION><VALUE><![CDATA[172]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[-]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%PDN_end%=.{10}}]]></EXPRESSION><VALUE><![CDATA[2400155459]]></VALUE></REGULAR_EXPRESSION><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/ET6X/EUR36.58/28AUG24/NCE6X0100/006310&amp;
       02/S2&amp;
  7 FB PAX 0000000000 TTP/ET/RT OK ETICKET/S2&amp;
  8 FP CASH&amp;
  9 FV PAX 6X/S2&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="20" endLine="210" beginLine="209" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:44.319019 - 28 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="17:51:44.396601 - 28 Aug 2024" filename="">IGNORED - 9VUBTB&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="21" responseEndLine="225" responseBeginLine="223" endLine="221" beginLine="217" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:44.446384 - 28 Aug 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9VUBTB]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="17:51:44.726616 - 28 Aug 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:9VUBTB::280824:1551&apos;&amp;
RSI+RP:YGSU:NCE6X0100:00631002+NCE6X0100+NCE+NCE6X0100:1127YG:280824:00631002:1551&apos;&amp;
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
TIF+AFRG::1+JYFB&apos;&amp;
ETI+:1+UN:Y:Y::AFRG:JYFB&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+240325:0600:240325:0710+NCE+LHR+6X+556:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:9VUBTB&apos;&amp;
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
TKE++OK:280824::NCE6X0100:::ET:6X&apos;&amp;
EMS++OT:16+SSR+5&apos;&amp;
SSR+BAGA:HN:1:6X:::::TTL3PC23KG&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:14+FA+6&apos;&amp;
LFT+3:P06+PAX 172-2400155459/ET6X/EUR36.58/28AUG24/NCE6X0100/00631002&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:12+FB+7&apos;&amp;
LFT+3:P07+PAX 0000000000 TTP/ET/RT OK ETICKET&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:4+FP+8&apos;&amp;
LFT+3:16+CASH&apos;&amp;
EMS++OT:5+FV+9&apos;&amp;
LFT+3:P18+PAX 6X&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
GSI+1:280824&apos;&amp;
LFT+3:41+PAX&apos;&amp;
LFT+3:37+NCE 6X LON10.81NUC10.81END ROE0.925058&apos;&amp;
MFB+YTS::::3PC:HOP&apos;&amp;
KFL+F+F:10.00:EUR*T:36.58:EUR+X:EUR:5.05:FR:SE*X:EUR:10.40:FR:TI*X:EUR:1.13:IZ:EB*X:EUR:1.50:O4:VC*X:EUR:8.50:QX:AP&apos;&amp;
SDT+N*I&apos;&amp;
REF+PT:1*ST:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="21"><QUERY filename="" loop="0" sentAt="17:51:44.728336 - 28 Aug 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="22" responseEndLine="258" responseBeginLine="245" endLine="243" beginLine="237" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:44.848377 - 28 Aug 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE1A0900++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9VUBTB]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="17:51:45.839854 - 28 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9VUBTB]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[28AUG24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[9VUBTB]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240828\:15\:51\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK4]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+0&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:15:51:37]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[4666029427]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:15:51:37]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="23" responseEndLine="279" responseBeginLine="273" endLine="271" beginLine="267" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:45.898245 - 28 Aug 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[4666029427]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK4]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:08:28:15:51:37]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="17:51:45.958881 - 28 Aug 2024" match="OK"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4666029427]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK4&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:08:28:15:51:37]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2189]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xED\x10\x12\x90\x10\x0A\x119VUBTB-2024-08-28\x12\x03pnr\x1A\x069VUBTB&quot;\x010:e\x1A\x142024-08-28T15:51:00Z&quot;=\x0A&quot;\x0A\x09NCE6X0100\x12\x0800631002\x1A\x026X&quot;\x07AIRLINE\x12\x17\x0A\x041127\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x0EYG-1A/YGARNIERJ\xA3\x05\x1A\x142024-08-28T15:51:37Z&quot;\x0D\x0A\x0B\x0A\x09NCE6X0100*\x02YG:H\x12\x10historyChangeLog\x18\x01&quot;\x1A9VUBTB-2024-08-28-PNR-NM-1*\x0Bstakeholder2\x09travelers:D\x12\x10historyChangeLog\x18\x01&quot;\x1B9VUBTB-2024-08-28-PNR-AIR-1*\x07product2\x08products:c\x12\x10historyChangeLog\x18\x01&quot;\x1B9VUBTB-2024-08-28-PNR-BKG-1*\x10segment-delivery2\x1Eproducts/airSegment/deliveries:C\x12\x10historyChangeLog\x18\x01&quot;\x1A9VUBTB-2024-08-28-PNR-AP-2*\x07contact2\x08contacts:W\x12\x10historyChangeLog\x18\x01&quot;\x1A9VUBTB-2024-08-28-PNR-TK-3*\x11automated-process2\x12automatedProcesses:E\x12\x10historyChangeLog\x18\x01&quot;\x1B9VUBTB-2024-08-28-PNR-ECX-6*\x002\x10externalContexts:L\x12\x10historyChangeLog\x18\x01&quot;\x1A9VUBTB-2024-08-28-PNR-FV-5*\x0Cfare-element2\x0CfareElements:P\x12\x10historyChangeLog\x18\x01&quot;\x1A9VUBTB-2024-08-28-PNR-FP-4*\x0Epayment-method2\x0EpaymentMethodsz\x8A\x01\x0A\x0Bstakeholder\x12\x1A9VUBTB-2024-08-28-PNR-NM-1&quot;\x0C\x12\x04JYFB\x1A\x04AFRGr&lt;\x0A\x07contact\x12\x1A9VUBTB-2024-08-28-PNR-AP-2\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x106101C3CF000146E6\x82\x01\xC8\x02\x0A\x07product\x10\x01\x1A\x1B9VUBTB-2024-08-28-PNR-AIR-1&quot;\x9D\x02\x0A\x1A\x0A\x03NCE\x1A\x132025-03-24T06:00:00\x12\x1A\x0A\x03LHR\x1A\x132025-03-24T07:10:00&quot;O\x0A\x09\x0A\x026X\x12\x03556\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x026X\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x196X-556-2025-03-24-NCE-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1B9VUBTB-2024-08-28-PNR-BKG-1\x1A\x106002A3D00000DA29ZA\x0A\x0Bstakeholder\x12\x1A9VUBTB-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01q\x0A\x07contact\x12\x1A9VUBTB-2024-08-28-PNR-AP-2@\x01Z\x05\x0A\x03NCEbA\x0A\x0Bstakeholder\x12\x1A9VUBTB-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelers\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1A9VUBTB-2024-08-28-PNR-TK-3\x18\x05&quot;\x132024-08-28T00:00:00*\x0B\x0A\x09NCE6X0100ZA\x0A\x0Bstakeholder\x12\x1A9VUBTB-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1B9VUBTB-2024-08-28-PNR-AIR-1\x1A\x15processedPnr.products\xC2\x01\xC3\x01\x0A\x0Epayment-method\x12\x1A9VUBTB-2024-08-28-PNR-FP-4\x18\x032\x0D\x0A\x03STD\x10\x01\x1A\x04CASHB\x02\x08\x00JA\x0A\x0Bstakeholder\x12\x1A9VUBTB-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelersR=\x0A\x07product\x12\x1B9VUBTB-2024-08-28-PNR-AIR-1\x1A\x15processedPnr.products\xCA\x010\x0A\x0Cfare-element\x12\x1A9VUBTB-2024-08-28-PNR-FV-5\x18\x0E:\x026X\xEA\x01\xBC\x01\x12\x1B9VUBTB-2024-08-28-PNR-ECX-6\x1A\x04DAPI&quot;\x1FP20240828-7896350718277413412-1*\x0FPaxLinkOfferPNR2\x026XB\x12\x0A\x0APaxInOffer\x12\x04PAX1B\x0A\x0A\x03PTC\x12\x03ADTRA\x0A\x0Bstakeholder\x12\x1A9VUBTB-2024-08-28-PNR-NM-1\x1A\x16processedPnr.travelers\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x069VUBTB\x1A\x010&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="24" responseEndLine="306" responseBeginLine="300" endLine="298" beginLine="293" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:45.961399 - 28 Aug 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik1EazBNRGt3TkRrMU1ESXhPVEkyT1E9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDgtMjhUMTU6NTE6MjEuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJyWndMOHFHaHNhRm94RVlQTCtCRlpQaXNTbnM9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="global_regression.openpnr_payload"><VALUE><![CDATA[ChE5VlVCVEItMjAyNC0wOC0yOBIDcG5yGgY5VlVCVEIiATA6ZRoUMjAyNC0wOC0yOFQxNTo1MTowMFoiPQoiCglOQ0U2WDAxMDASCDAwNjMxMDAyGgI2WCIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0UqDllHLTFBL1lHQVJOSUVSSqMFGhQyMDI0LTA4LTI4VDE1OjUxOjM3WiINCgsKCU5DRTZYMDEwMCoCWUc6SBIQaGlzdG9yeUNoYW5nZUxvZxgBIho5VlVCVEItMjAyNC0wOC0yOC1QTlItTk0tMSoLc3Rha2Vob2xkZXIyCXRyYXZlbGVyczpEEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGzlWVUJUQi0yMDI0LTA4LTI4LVBOUi1BSVItMSoHcHJvZHVjdDIIcHJvZHVjdHM6YxIQaGlzdG9yeUNoYW5nZUxvZxgBIhs5VlVCVEItMjAyNC0wOC0yOC1QTlItQktHLTEqEHNlZ21lbnQtZGVsaXZlcnkyHnByb2R1Y3RzL2FpclNlZ21lbnQvZGVsaXZlcmllczpDEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGjlWVUJUQi0yMDI0LTA4LTI4LVBOUi1BUC0yKgdjb250YWN0Mghjb250YWN0czpXEhBoaXN0b3J5Q2hhbmdlTG9nGAEiGjlWVUJUQi0yMDI0LTA4LTI4LVBOUi1USy0zKhFhdXRvbWF0ZWQtcHJvY2VzczISYXV0b21hdGVkUHJvY2Vzc2VzOkUSEGhpc3RvcnlDaGFuZ2VMb2cYASIbOVZVQlRCLTIwMjQtMDgtMjgtUE5SLUVDWC02KgAyEGV4dGVybmFsQ29udGV4dHM6TBIQaGlzdG9yeUNoYW5nZUxvZxgBIho5VlVCVEItMjAyNC0wOC0yOC1QTlItRlYtNSoMZmFyZS1lbGVtZW50MgxmYXJlRWxlbWVudHM6UBIQaGlzdG9yeUNoYW5nZUxvZxgBIho5VlVCVEItMjAyNC0wOC0yOC1QTlItRlAtNCoOcGF5bWVudC1tZXRob2QyDnBheW1lbnRNZXRob2RzeooBCgtzdGFrZWhvbGRlchIaOVZVQlRCLTIwMjQtMDgtMjgtUE5SLU5NLTEiDBIESllGQhoEQUZSR3I8Cgdjb250YWN0Eho5VlVCVEItMjAyNC0wOC0yOC1QTlItQVAtMhoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA2MTAxQzNDRjAwMDE0NkU2ggHIAgoHcHJvZHVjdBABGhs5VlVCVEItMjAyNC0wOC0yOC1QTlItQUlSLTEinQIKGgoDTkNFGhMyMDI1LTAzLTI0VDA2OjAwOjAwEhoKA0xIUhoTMjAyNS0wMy0yNFQwNzoxMDowMCJPCgkKAjZYEgM1NTYSJwoBWRIDCgFZGhQKAggAEgwKBBoCNlgSBCoCRlIgASIHRUNPTk9NWTIZNlgtNTU2LTIwMjUtMDMtMjQtTkNFLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSGzlWVUJUQi0yMDI0LTA4LTI4LVBOUi1CS0ctMRoQNjAwMkEzRDAwMDAwREEyOVpBCgtzdGFrZWhvbGRlchIaOVZVQlRCLTIwMjQtMDgtMjgtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgECCACyAXEKB2NvbnRhY3QSGjlWVUJUQi0yMDI0LTA4LTI4LVBOUi1BUC0yQAFaBQoDTkNFYkEKC3N0YWtlaG9sZGVyEho5VlVCVEItMjAyNC0wOC0yOC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc7oB1QEKEWF1dG9tYXRlZC1wcm9jZXNzEho5VlVCVEItMjAyNC0wOC0yOC1QTlItVEstMxgFIhMyMDI0LTA4LTI4VDAwOjAwOjAwKgsKCU5DRTZYMDEwMFpBCgtzdGFrZWhvbGRlchIaOVZVQlRCLTIwMjQtMDgtMjgtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnNiPQoHcHJvZHVjdBIbOVZVQlRCLTIwMjQtMDgtMjgtUE5SLUFJUi0xGhVwcm9jZXNzZWRQbnIucHJvZHVjdHPCAcMBCg5wYXltZW50LW1ldGhvZBIaOVZVQlRCLTIwMjQtMDgtMjgtUE5SLUZQLTQYAzINCgNTVEQQARoEQ0FTSEICCABKQQoLc3Rha2Vob2xkZXISGjlWVUJUQi0yMDI0LTA4LTI4LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzUj0KB3Byb2R1Y3QSGzlWVUJUQi0yMDI0LTA4LTI4LVBOUi1BSVItMRoVcHJvY2Vzc2VkUG5yLnByb2R1Y3RzygEwCgxmYXJlLWVsZW1lbnQSGjlWVUJUQi0yMDI0LTA4LTI4LVBOUi1GVi01GA46AjZY6gG8ARIbOVZVQlRCLTIwMjQtMDgtMjgtUE5SLUVDWC02GgREQVBJIh9QMjAyNDA4MjgtNzg5NjM1MDcxODI3NzQxMzQxMi0xKg9QYXhMaW5rT2ZmZXJQTlIyAjZYQhIKClBheEluT2ZmZXISBFBBWDFCCgoDUFRDEgNBRFRSQQoLc3Rha2Vob2xkZXISGjlWVUJUQi0yMDI0LTA4LTI4LVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJz]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 130: A character does not match, expected &apos;\n&apos;, received &apos;c&apos;." compareAt="17:51:46.117812 - 28 Aug 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001J9ZUNIXQQA]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[4111]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[connection:close]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
\{&amp;
    &quot;id&quot;: &quot;9VUBTB-2024-08-28&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;9VUBTB&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-28T15:51:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;, &amp;
                &quot;iataNumber&quot;: &quot;00631002&quot;, &amp;
                &quot;systemCode&quot;: &quot;6X&quot;, &amp;
                &quot;agentType&quot;: &quot;AIRLINE&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;1127&quot;, &amp;
                &quot;initials&quot;: &quot;YG&quot;, &amp;
                &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                &quot;countryCode&quot;: &quot;FR&quot;, &amp;
                &quot;cityCode&quot;: &quot;NCE&quot;&amp;
            \}&amp;
        \}, &amp;
        &quot;comment&quot;: &quot;YG-1A/YGARNIER&quot;&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-08-28T15:51:37Z&quot;, &amp;
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
                &quot;elementId&quot;: &quot;9VUBTB-2024-08-28-PNR-NM-1&quot;, &amp;
                &quot;elementType&quot;: &quot;stakeholder&quot;, &amp;
                &quot;path&quot;: &quot;travelers&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VUBTB-2024-08-28-PNR-AIR-1&quot;, &amp;
                &quot;elementType&quot;: &quot;product&quot;, &amp;
                &quot;path&quot;: &quot;products&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VUBTB-2024-08-28-PNR-BKG-1&quot;, &amp;
                &quot;elementType&quot;: &quot;segment-delivery&quot;, &amp;
                &quot;path&quot;: &quot;products/airSegment/deliveries&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VUBTB-2024-08-28-PNR-AP-2&quot;, &amp;
                &quot;elementType&quot;: &quot;contact&quot;, &amp;
                &quot;path&quot;: &quot;contacts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VUBTB-2024-08-28-PNR-TK-3&quot;, &amp;
                &quot;elementType&quot;: &quot;automated-process&quot;, &amp;
                &quot;path&quot;: &quot;automatedProcesses&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VUBTB-2024-08-28-PNR-ECX-6&quot;, &amp;
                &quot;path&quot;: &quot;externalContexts&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VUBTB-2024-08-28-PNR-FV-5&quot;, &amp;
                &quot;elementType&quot;: &quot;fare-element&quot;, &amp;
                &quot;path&quot;: &quot;fareElements&quot;&amp;
            \}, &amp;
            \{&amp;
                &quot;logType&quot;: &quot;historyChangeLog&quot;, &amp;
                &quot;operation&quot;: &quot;ADD&quot;, &amp;
                &quot;elementId&quot;: &quot;9VUBTB-2024-08-28-PNR-FP-4&quot;, &amp;
                &quot;elementType&quot;: &quot;payment-method&quot;, &amp;
                &quot;path&quot;: &quot;paymentMethods&quot;&amp;
            \}&amp;
        ]&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;JYFB&quot;, &amp;
                    &quot;lastName&quot;: &quot;AFRG&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;6101C3CF000146E6&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-AIR-1&quot;, &amp;
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
                        &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;6002A3D00000DA29&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;NCE&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-TK-3&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-08-28T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE6X0100&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;paymentMethods&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;payment-method&quot;, &amp;
            &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-FP-4&quot;, &amp;
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
                    &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ], &amp;
    &quot;fareElements&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;fare-element&quot;, &amp;
            &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-FV-5&quot;, &amp;
            &quot;code&quot;: &quot;FV&quot;, &amp;
            &quot;text&quot;: &quot;6X&quot;&amp;
        \}&amp;
    ], &amp;
    &quot;externalContexts&quot;: [&amp;
        \{&amp;
            &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-ECX-6&quot;, &amp;
            &quot;source&quot;: &quot;DAPI&quot;, &amp;
            &quot;reference&quot;: &quot;P20240828-7896350718277413412-1&quot;, &amp;
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
                    &quot;id&quot;: &quot;9VUBTB-2024-08-28-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="25" endLine="320" beginLine="319" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:46.118981 - 28 Aug 2024"><TEXT><![CDATA[XI]]></TEXT></QUERY><REPLY receiveAt="17:51:46.220167 - 28 Aug 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="26" endLine="321" beginLine="320" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:46.220817 - 28 Aug 2024"><TEXT><![CDATA[ET]]></TEXT></QUERY><REPLY receiveAt="17:51:46.315828 - 28 Aug 2024" filename="">NO TRANSACTION PRESENT&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="27" endLine="322" beginLine="321" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:46.316922 - 28 Aug 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="17:51:46.403859 - 28 Aug 2024" filename="">IGNORED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="28" endLine="326" beginLine="325" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:46.404375 - 28 Aug 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><REPLY receiveAt="17:51:46.532688 - 28 Aug 2024" filename="">&amp;
09CC2B44         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="29" endLine="327" beginLine="326" filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/open_pnr_validation/ORDER_10053_EarlyBird/Epic_DATALMP_11405_Additional_OpenPNR_fields_for_Order_Codeshare/Scripts/Earlybird/Elements/01_Add_FA_Feed.cry" loop="0" sentAt="17:51:46.533225 - 28 Aug 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="17:51:46.603635 - 28 Aug 2024" filename="">&amp;
09CC2B44         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><STATISTIC><STATISTIC_ELEMENT name="Message in">30</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">18924</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">30</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">4111</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">6</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">30</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">29</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.966667</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">21445.7</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.641</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">11130.5</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">51</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">1</STATISTIC_ELEMENT></STATISTIC></xml>