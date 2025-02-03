<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry"><SCRIPT type="Initialize">import json
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
        assert_equal(expected=&quot;SYD6X0102&quot;, actual=openpnr[&apos;creation&apos;][&apos;pointOfSale&apos;][&apos;office&apos;][&apos;id&apos;], item_name=&apos;creator office&apos;)

        assert_equal(actual=len(openpnr[&apos;contacts&apos;]), expected=3, item_name=&apos;number of contacts&apos;)
        contacts_1 = openpnr[&apos;contacts&apos;][0]
        contacts_2 = openpnr[&apos;contacts&apos;][1]
        contacts_3 = openpnr[&apos;contacts&apos;][2]

        #Check service data for AB and AM element
        assert_equal(actual=contacts_1[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_1[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_1[&apos;purpose&apos;], expected= [u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_1[&apos;freeFlowFormat&apos;], expected=&apos;+33600000666&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_2[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_2[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AB-3&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_2[&apos;addresseeName&apos;][&apos;fullName&apos;], expected=&quot;MR SIMPSON&quot;, item_name=&apos;contact addresseeName/fullName&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;category&apos;], expected= &quot;BUSINESS&quot;, item_name=&apos;contact address/category&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;lines&apos;][0], expected= &quot;LONG STREET&quot;, item_name=&apos;contact address/lines&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;postalCode&apos;], expected= &quot;BS7890&quot;, item_name=&apos;contact address/postalCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;countryCode&apos;], expected= &quot;US&quot;, item_name=&apos;contact address/countryCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;cityName&apos;], expected= &quot;NEWTOWN&quot;, item_name=&apos;contact address/cityName&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;stateCode&apos;], expected= &quot;NY&quot;, item_name=&apos;contact address/stateCode&apos;)
        assert_equal(actual=contacts_2[&apos;address&apos;][&apos;postalBox&apos;], expected= &quot;12344&quot;, item_name=&apos;contact address/postalBox&apos;)
        assert_equal(actual=contacts_2[&apos;purpose&apos;][0], expected= &quot;BILLING&quot;, item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_2[&apos;addresseeCompany&apos;][&apos;name&apos;], expected= &quot;GREAT COMPANY&quot;, item_name=&apos;contact addresseeCompany/name&apos;)


        assert_equal(actual=contacts_3[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_3[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AM-4&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_3[&apos;addresseeName&apos;][&apos;fullName&apos;], expected=&quot;MR SIMPSON&quot;, item_name=&apos;contact addresseeName/fullName&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;category&apos;], expected= &quot;BUSINESS&quot;, item_name=&apos;contact address/category&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;lines&apos;][0], expected= &quot;12 LONG STREET&quot;, item_name=&apos;contact address/lines&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;postalCode&apos;], expected= &quot;BS7890&quot;, item_name=&apos;contact address/postalCode&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;countryCode&apos;], expected= &quot;US&quot;, item_name=&apos;contact address/countryCode&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;cityName&apos;], expected= &quot;NEWTOWN&quot;, item_name=&apos;contact address/cityName&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;stateCode&apos;], expected= &quot;NY&quot;, item_name=&apos;contact address/stateCode&apos;)
        assert_equal(actual=contacts_3[&apos;address&apos;][&apos;postalBox&apos;], expected= &quot;12344&quot;, item_name=&apos;contact address/postalBox&apos;)
        assert_equal(actual=contacts_3[&apos;purpose&apos;][0], expected= &quot;MAILING&quot;, item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_3[&apos;addresseeCompany&apos;][&apos;name&apos;], expected= &quot;GREAT COMPANY&quot;, item_name=&apos;contact addresseeCompany/name&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="109" beginLine="108" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:25.804490 - 10 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="17:55:25.891987 - 10 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" responseEndLine="115" responseBeginLine="114" endLine="110" beginLine="109" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:25.893320 - 10 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><COMPARISON compareAt="17:55:25.988655 - 10 Sep 2024" match="OK"><TEXT><![CDATA[SIGN IN&amp;
&gt;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="3" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:25.988847 - 10 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="17:55:26.089876 - 10 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="124" beginLine="123" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:26.090035 - 10 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="17:55:26.954885 - 10 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="126" beginLine="125" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:28.956022 - 10 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="17:55:29.103646 - 10 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="130" responseBeginLine="130" endLine="128" beginLine="127" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:29.103978 - 10 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="17:55:29.435062 - 10 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/10SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" responseEndLine="155" responseBeginLine="146" endLine="144" beginLine="139" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:29.437910 - 10 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=json\&amp;output=protobufBase64 HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header"><VALUE><![CDATA[eyJub25jZSI6Ik56WXhPRGsyT0RReU9ESTBNRFEzT0E9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTBUMTU6NTU6MjEuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiaEVCMXhFaG1OcGZoaVJkajZxc2c2ODZLNHZRPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
]]></TEXT><VARIABLE name="input_json_AB_AM"><VALUE><![CDATA[ \{&amp;
    &quot;last_modification&quot;: \{&amp;
        &quot;comment&quot;: &quot;ORMS&quot;&amp;
    \},&amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;,&amp;
            &quot;id&quot;: &quot;PAX-1&quot;,&amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;first_name&quot;: &quot;BART&quot;,&amp;
                    &quot;last_name&quot;: &quot;SIMPSON&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ],&amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;,&amp;
            &quot;sub_type&quot;: &quot;AIR&quot;,&amp;
            &quot;id&quot;: &quot;AIR-1&quot;,&amp;
            &quot;air_segment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iata_code&quot;: &quot;FRA&quot;,&amp;
                    &quot;local_date_time&quot;: &quot;2024-12-13&quot;&amp;
                \},&amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iata_code&quot;: &quot;LHR&quot;&amp;
                \},&amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flight_designator&quot;: \{&amp;
                        &quot;carrier_code&quot;: &quot;6X&quot;,&amp;
                        &quot;flight_number&quot;: &quot;7040&quot;&amp;
                    \},&amp;
                    &quot;booking_class&quot;: \{&amp;
                        &quot;code&quot;: &quot;Y&quot;&amp;
                    \}&amp;
                \},&amp;
                &quot;booking_status_code&quot;: &quot;NN&quot;&amp;
            \},&amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ],&amp;
    &quot;contacts&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AB-11&quot;,&amp;
            &quot;addresseeName&quot;: \{&amp;
                &quot;fullName&quot;: &quot;MR SIMPSON&quot;&amp;
            \},&amp;
            &quot;address&quot;: \{&amp;
                &quot;category&quot;: &quot;BUSINESS&quot;,&amp;
                &quot;lines&quot;: [&amp;
                    &quot;LONG STREET&quot;&amp;
                ],&amp;
                &quot;postalCode&quot;: &quot;BS7890&quot;,&amp;
                &quot;countryCode&quot;: &quot;US&quot;,&amp;
                &quot;cityName&quot;: &quot;NEWTOWN&quot;,&amp;
                &quot;stateCode&quot;: &quot;NY&quot;,&amp;
                &quot;postalBox&quot;: &quot;12344&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;BILLING&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ],&amp;
            &quot;addresseeCompany&quot;: \{&amp;
                &quot;name&quot;: &quot;GREAT COMPANY&quot;&amp;
            \}&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AM-12&quot;,&amp;
            &quot;addresseeName&quot;: \{&amp;
                &quot;fullName&quot;: &quot;MR SIMPSON&quot;&amp;
            \},&amp;
            &quot;address&quot;: \{&amp;
                &quot;category&quot;: &quot;BUSINESS&quot;,&amp;
                &quot;lines&quot;: [&amp;
                    &quot;12 LONG STREET&quot;&amp;
                ],&amp;
                &quot;postalCode&quot;: &quot;BS7890&quot;,&amp;
                &quot;countryCode&quot;: &quot;US&quot;,&amp;
                &quot;cityName&quot;: &quot;NEWTOWN&quot;,&amp;
                &quot;stateCode&quot;: &quot;NY&quot;,&amp;
                &quot;postalBox&quot;: &quot;12344&quot;&amp;
            \},&amp;
            &quot;purpose&quot;: [&amp;
                &quot;MAILING&quot;&amp;
            ],&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ],&amp;
            &quot;addresseeCompany&quot;: \{&amp;
                &quot;name&quot;: &quot;GREAT COMPANY&quot;&amp;
            \}&amp;
        \},&amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;,&amp;
            &quot;id&quot;: &quot;AP-1&quot;,&amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ],&amp;
            &quot;phone&quot;: \{&amp;
                &quot;number&quot;: &quot;+33600000666&quot;&amp;
            \},&amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                    &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ],&amp;
    &quot;automated_processes&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;,&amp;
            &quot;code&quot;: &quot;OK&quot;&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="17:55:29.648904 - 10 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DERQFJLTKH]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[782]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_protobuf%=.*}]]></EXPRESSION><VALUE><![CDATA[SgYqBE9STVN6JQoLc3Rha2Vob2xkZXISBVBBWC0xIg8SBEJBUlQaB1NJTVBTT06CAXMKB3Byb2R1Y3QQARoFQUlSLTEiMQoRCgNGUkEaCjIwMjQtMTItMTMSBQoDTEhSIhEKCgoCNlgSBDcwNDASAwoBWUoCTk5CLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgGSAQoHY29udGFjdBIFQUItMTEaDAoKTVIgU0lNUFNPTiovCAMSC0xPTkcgU1RSRUVUGgZCUzc4OTAiAlVTKgdORVdUT1dOMgJOWToFMTIzNDRCAQViLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgEPCg1HUkVBVCBDT01QQU5ZsgGVAQoHY29udGFjdBIFQU0tMTIaDAoKTVIgU0lNUFNPTioyCAMSDjEyIExPTkcgU1RSRUVUGgZCUzc4OTAiAlVTKgdORVdUT1dOMgJOWToFMTIzNDRCAQZiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgEPCg1HUkVBVCBDT01QQU5ZsgFQCgdjb250YWN0EgRBUC0xIg4aDCszMzYwMDAwMDY2NkIBAWIsCgtzdGFrZWhvbGRlchIFUEFYLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnO6ARUKEWF1dG9tYXRlZC1wcm9jZXNzGAU=]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="8" responseEndLine="184" responseBeginLine="173" endLine="171" beginLine="164" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:29.651293 - 10 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/ HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header2"><VALUE><![CDATA[eyJub25jZSI6Ik1EWXlOemcyTURBMU9EZ3pNVFUwTUE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTBUMTU6NTU6MjEuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiRTU3bER4TU5HbUp0cmNzdkhCenZmTWRweHNBPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[SgYqBE9STVN6JQoLc3Rha2Vob2xkZXISBVBBWC0xIg8SBEJBUlQaB1NJTVBTT06CAXMKB3Byb2R1Y3QQARoFQUlSLTEiMQoRCgNGUkEaCjIwMjQtMTItMTMSBQoDTEhSIhEKCgoCNlgSBDcwNDASAwoBWUoCTk5CLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgGSAQoHY29udGFjdBIFQUItMTEaDAoKTVIgU0lNUFNPTiovCAMSC0xPTkcgU1RSRUVUGgZCUzc4OTAiAlVTKgdORVdUT1dOMgJOWToFMTIzNDRCAQViLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgEPCg1HUkVBVCBDT01QQU5ZsgGVAQoHY29udGFjdBIFQU0tMTIaDAoKTVIgU0lNUFNPTioyCAMSDjEyIExPTkcgU1RSRUVUGgZCUzc4OTAiAlVTKgdORVdUT1dOMgJOWToFMTIzNDRCAQZiLAoLc3Rha2Vob2xkZXISBVBBWC0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgEPCg1HUkVBVCBDT01QQU5ZsgFQCgdjb250YWN0EgRBUC0xIg4aDCszMzYwMDAwMDY2NkIBAWIsCgtzdGFrZWhvbGRlchIFUEFYLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnO6ARUKEWF1dG9tYXRlZC1wcm9jZXNzGAU=]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></QUERY><COMPARISON compareAt="17:55:30.702171 - 10 Sep 2024" match="OK"><TEXT><![CDATA[HTTP/1.1 201 Created&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DERQIJLTKH]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2017]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
\{&amp;
    &quot;reference&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%recloc%=.{6}}]]></EXPRESSION><VALUE><![CDATA[BYECBX]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;, &amp;
    &quot;version&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;, &amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_protobuf2%=.*}]]></EXPRESSION><VALUE><![CDATA[ChFCWUVDQlgtMjAyNC0wOS0xMBIDcG5yGgZCWUVDQlgiATA6VRoUMjAyNC0wOS0xMFQxNTo1NTowMFoiPQoiCglOQ0UxQTA5NTUSCDEyMzQ1Njc1GgIxQSIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOS0xMFQxNTo1NTozMFp6iQIKC3N0YWtlaG9sZGVyEhpCWUVDQlgtMjAyNC0wOS0xMC1QTlItTk0tMSIPEgRCQVJUGgdTSU1QU09OcjwKB2NvbnRhY3QSGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1BUC0yGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPAoHY29udGFjdBIaQllFQ0JYLTIwMjQtMDktMTAtUE5SLUFCLTMaFXByb2Nlc3NlZFBuci5jb250YWN0c3I8Cgdjb250YWN0EhpCWUVDQlgtMjAyNC0wOS0xMC1QTlItQU0tNBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA2MTA5NjNEQzAwMDBBOTk0ggHGAgoHcHJvZHVjdBABGhtCWUVDQlgtMjAyNC0wOS0xMC1QTlItQUlSLTEimwIKGgoDRlJBGhMyMDI0LTEyLTEzVDA3OjM1OjAwEhoKA0xIUhoTMjAyNC0xMi0xM1QwODozNTowMCJPCgoKAjZYEgQ3MDQwEiUKAVkSAwoBWRoSCgASDAoEGgIxQRIEKgJGUiABIgdFQ09OT01ZMho2WC03MDQwLTIwMjQtMTItMTMtRlJBLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSG0JZRUNCWC0yMDI0LTA5LTEwLVBOUi1CS0ctMRoQNjAwQTEzREQwMDAxM0MwM1pBCgtzdGFrZWhvbGRlchIaQllFQ0JYLTIwMjQtMDktMTAtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgEAsgF7Cgdjb250YWN0EhpCWUVDQlgtMjAyNC0wOS0xMC1QTlItQVAtMkIBAVoOCgwrMzM2MDAwMDA2NjZiQQoLc3Rha2Vob2xkZXISGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgG8AQoHY29udGFjdBIaQllFQ0JYLTIwMjQtMDktMTAtUE5SLUFCLTMaDAoKTVIgU0lNUFNPTiovCAMSC0xPTkcgU1RSRUVUGgZCUzc4OTAiAlVTKgdORVdUT1dOMgJOWToFMTIzNDRCAQViQQoLc3Rha2Vob2xkZXISGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgEPCg1HUkVBVCBDT01QQU5ZsgG/AQoHY29udGFjdBIaQllFQ0JYLTIwMjQtMDktMTAtUE5SLUFNLTQaDAoKTVIgU0lNUFNPTioyCAMSDjEyIExPTkcgU1RSRUVUGgZCUzc4OTAiAlVTKgdORVdUT1dOMgJOWToFMTIzNDRCAQZiQQoLc3Rha2Vob2xkZXISGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgEPCg1HUkVBVCBDT01QQU5ZugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1USy01GAUiEzIwMjQtMDktMTBUMDA6MDA6MDAqCwoJTkNFMUEwOTU1WkEKC3N0YWtlaG9sZGVyEhpCWUVDQlgtMjAyNC0wOS0xMC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0EhtCWUVDQlgtMjAyNC0wOS0xMC1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="9" responseEndLine="209" responseBeginLine="202" endLine="200" beginLine="194" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:30.705525 - 10 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header3"><VALUE><![CDATA[eyJub25jZSI6Ik9URTVNREU0TlRBMU1EQXdOakUyTnc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTBUMTU6NTU6MjEuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoibTRKNzVRSFRSS245UFpBNEIxRnRycDN4aDlBPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf2"><VALUE><![CDATA[ChFCWUVDQlgtMjAyNC0wOS0xMBIDcG5yGgZCWUVDQlgiATA6VRoUMjAyNC0wOS0xMFQxNTo1NTowMFoiPQoiCglOQ0UxQTA5NTUSCDEyMzQ1Njc1GgIxQSIHQUlSTElORRIXCgQxMTI3EgJZRxoCU1UqAkZSMgNOQ0VKFhoUMjAyNC0wOS0xMFQxNTo1NTozMFp6iQIKC3N0YWtlaG9sZGVyEhpCWUVDQlgtMjAyNC0wOS0xMC1QTlItTk0tMSIPEgRCQVJUGgdTSU1QU09OcjwKB2NvbnRhY3QSGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1BUC0yGhVwcm9jZXNzZWRQbnIuY29udGFjdHNyPAoHY29udGFjdBIaQllFQ0JYLTIwMjQtMDktMTAtUE5SLUFCLTMaFXByb2Nlc3NlZFBuci5jb250YWN0c3I8Cgdjb250YWN0EhpCWUVDQlgtMjAyNC0wOS0xMC1QTlItQU0tNBoVcHJvY2Vzc2VkUG5yLmNvbnRhY3RzogESEhA2MTA5NjNEQzAwMDBBOTk0ggHGAgoHcHJvZHVjdBABGhtCWUVDQlgtMjAyNC0wOS0xMC1QTlItQUlSLTEimwIKGgoDRlJBGhMyMDI0LTEyLTEzVDA3OjM1OjAwEhoKA0xIUhoTMjAyNC0xMi0xM1QwODozNTowMCJPCgoKAjZYEgQ3MDQwEiUKAVkSAwoBWRoSCgASDAoEGgIxQRIEKgJGUiABIgdFQ09OT01ZMho2WC03MDQwLTIwMjQtMTItMTMtRlJBLUxIUkoCSEtihAEKEHNlZ21lbnQtZGVsaXZlcnkSG0JZRUNCWC0yMDI0LTA5LTEwLVBOUi1CS0ctMRoQNjAwQTEzREQwMDAxM0MwM1pBCgtzdGFrZWhvbGRlchIaQllFQ0JYLTIwMjQtMDktMTAtUE5SLU5NLTEaFnByb2Nlc3NlZFBuci50cmF2ZWxlcnOKAQFFkgEAsgF7Cgdjb250YWN0EhpCWUVDQlgtMjAyNC0wOS0xMC1QTlItQVAtMkIBAVoOCgwrMzM2MDAwMDA2NjZiQQoLc3Rha2Vob2xkZXISGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgG8AQoHY29udGFjdBIaQllFQ0JYLTIwMjQtMDktMTAtUE5SLUFCLTMaDAoKTVIgU0lNUFNPTiovCAMSC0xPTkcgU1RSRUVUGgZCUzc4OTAiAlVTKgdORVdUT1dOMgJOWToFMTIzNDRCAQViQQoLc3Rha2Vob2xkZXISGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgEPCg1HUkVBVCBDT01QQU5ZsgG/AQoHY29udGFjdBIaQllFQ0JYLTIwMjQtMDktMTAtUE5SLUFNLTQaDAoKTVIgU0lNUFNPTioyCAMSDjEyIExPTkcgU1RSRUVUGgZCUzc4OTAiAlVTKgdORVdUT1dOMgJOWToFMTIzNDRCAQZiQQoLc3Rha2Vob2xkZXISGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1OTS0xGhZwcm9jZXNzZWRQbnIudHJhdmVsZXJzsgEPCg1HUkVBVCBDT01QQU5ZugHVAQoRYXV0b21hdGVkLXByb2Nlc3MSGkJZRUNCWC0yMDI0LTA5LTEwLVBOUi1USy01GAUiEzIwMjQtMDktMTBUMDA6MDA6MDAqCwoJTkNFMUEwOTU1WkEKC3N0YWtlaG9sZGVyEhpCWUVDQlgtMjAyNC0wOS0xMC1QTlItTk0tMRoWcHJvY2Vzc2VkUG5yLnRyYXZlbGVyc2I9Cgdwcm9kdWN0EhtCWUVDQlgtMjAyNC0wOS0xMC1QTlItQUlSLTEaFXByb2Nlc3NlZFBuci5wcm9kdWN0cw==]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" validate="manual" matchMessage="Match failed with error code 1: Callback rejected:Match function exits on unspecified Error." compareAt="17:55:30.910686 - 10 Sep 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DERQKJLTKI]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[3096]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{&amp;
    &quot;id&quot;: &quot;BYECBX-2024-09-10&quot;, &amp;
    &quot;type&quot;: &quot;pnr&quot;, &amp;
    &quot;reference&quot;: &quot;BYECBX&quot;, &amp;
    &quot;version&quot;: &quot;0&quot;, &amp;
    &quot;creation&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-10T15:55:00Z&quot;, &amp;
        &quot;pointOfSale&quot;: \{&amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0955&quot;, &amp;
                &quot;iataNumber&quot;: &quot;12345675&quot;, &amp;
                &quot;systemCode&quot;: &quot;1A&quot;, &amp;
                &quot;agentType&quot;: &quot;AIRLINE&quot;&amp;
            \}, &amp;
            &quot;login&quot;: \{&amp;
                &quot;numericSign&quot;: &quot;1127&quot;, &amp;
                &quot;initials&quot;: &quot;YG&quot;, &amp;
                &quot;dutyCode&quot;: &quot;SU&quot;, &amp;
                &quot;countryCode&quot;: &quot;FR&quot;, &amp;
                &quot;cityCode&quot;: &quot;NCE&quot;&amp;
            \}&amp;
        \}&amp;
    \}, &amp;
    &quot;lastModification&quot;: \{&amp;
        &quot;dateTime&quot;: &quot;2024-09-10T15:55:30Z&quot;&amp;
    \}, &amp;
    &quot;travelers&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
            &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-NM-1&quot;, &amp;
            &quot;names&quot;: [&amp;
                \{&amp;
                    &quot;firstName&quot;: &quot;BART&quot;, &amp;
                    &quot;lastName&quot;: &quot;SIMPSON&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;contacts&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-AP-2&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-AB-3&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}, &amp;
                \{&amp;
                    &quot;type&quot;: &quot;contact&quot;, &amp;
                    &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-AM-4&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.contacts&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;passenger&quot;: \{&amp;
                &quot;uniqueIdentifier&quot;: &quot;610963DC0000A994&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;products&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;product&quot;, &amp;
            &quot;subType&quot;: &quot;AIR&quot;, &amp;
            &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-AIR-1&quot;, &amp;
            &quot;airSegment&quot;: \{&amp;
                &quot;departure&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;FRA&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-12-13T07:35:00&quot;&amp;
                \}, &amp;
                &quot;arrival&quot;: \{&amp;
                    &quot;iataCode&quot;: &quot;LHR&quot;, &amp;
                    &quot;localDateTime&quot;: &quot;2024-12-13T08:35:00&quot;&amp;
                \}, &amp;
                &quot;marketing&quot;: \{&amp;
                    &quot;flightDesignator&quot;: \{&amp;
                        &quot;carrierCode&quot;: &quot;6X&quot;, &amp;
                        &quot;flightNumber&quot;: &quot;7040&quot;&amp;
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
                                    &quot;systemCode&quot;: &quot;1A&quot;&amp;
                                \}, &amp;
                                &quot;login&quot;: \{&amp;
                                    &quot;countryCode&quot;: &quot;FR&quot;&amp;
                                \}&amp;
                            \}, &amp;
                            &quot;sourceOfSubClassCode&quot;: &quot;SOURCE_COUNTRY&quot;&amp;
                        \}, &amp;
                        &quot;levelOfService&quot;: &quot;ECONOMY&quot;&amp;
                    \}, &amp;
                    &quot;id&quot;: &quot;6X-7040-2024-12-13-FRA-LHR&quot;&amp;
                \}, &amp;
                &quot;bookingStatusCode&quot;: &quot;HK&quot;, &amp;
                &quot;deliveries&quot;: [&amp;
                    \{&amp;
                        &quot;type&quot;: &quot;segment-delivery&quot;, &amp;
                        &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-BKG-1&quot;, &amp;
                        &quot;distributionId&quot;: &quot;600A13DD00013C03&quot;, &amp;
                        &quot;traveler&quot;: \{&amp;
                            &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                            &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-NM-1&quot;, &amp;
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
            &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-AP-2&quot;, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;STANDARD&quot;&amp;
            ], &amp;
            &quot;freeFlowFormat&quot;: &quot;+33600000666&quot;, &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ]&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-AB-3&quot;, &amp;
            &quot;addresseeName&quot;: \{&amp;
                &quot;fullName&quot;: &quot;MR SIMPSON&quot;&amp;
            \}, &amp;
            &quot;address&quot;: \{&amp;
                &quot;category&quot;: &quot;BUSINESS&quot;, &amp;
                &quot;lines&quot;: [&amp;
                    &quot;LONG STREET&quot;&amp;
                ], &amp;
                &quot;postalCode&quot;: &quot;BS7890&quot;, &amp;
                &quot;countryCode&quot;: &quot;US&quot;, &amp;
                &quot;cityName&quot;: &quot;NEWTOWN&quot;, &amp;
                &quot;stateCode&quot;: &quot;NY&quot;, &amp;
                &quot;postalBox&quot;: &quot;12344&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;BILLING&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;addresseeCompany&quot;: \{&amp;
                &quot;name&quot;: &quot;GREAT COMPANY&quot;&amp;
            \}&amp;
        \}, &amp;
        \{&amp;
            &quot;type&quot;: &quot;contact&quot;, &amp;
            &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-AM-4&quot;, &amp;
            &quot;addresseeName&quot;: \{&amp;
                &quot;fullName&quot;: &quot;MR SIMPSON&quot;&amp;
            \}, &amp;
            &quot;address&quot;: \{&amp;
                &quot;category&quot;: &quot;BUSINESS&quot;, &amp;
                &quot;lines&quot;: [&amp;
                    &quot;12 LONG STREET&quot;&amp;
                ], &amp;
                &quot;postalCode&quot;: &quot;BS7890&quot;, &amp;
                &quot;countryCode&quot;: &quot;US&quot;, &amp;
                &quot;cityName&quot;: &quot;NEWTOWN&quot;, &amp;
                &quot;stateCode&quot;: &quot;NY&quot;, &amp;
                &quot;postalBox&quot;: &quot;12344&quot;&amp;
            \}, &amp;
            &quot;purpose&quot;: [&amp;
                &quot;MAILING&quot;&amp;
            ], &amp;
            &quot;travelerRefs&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;addresseeCompany&quot;: \{&amp;
                &quot;name&quot;: &quot;GREAT COMPANY&quot;&amp;
            \}&amp;
        \}&amp;
    ], &amp;
    &quot;automatedProcesses&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;, &amp;
            &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-TK-5&quot;, &amp;
            &quot;code&quot;: &quot;OK&quot;, &amp;
            &quot;dateTime&quot;: &quot;2024-09-10T00:00:00&quot;, &amp;
            &quot;office&quot;: \{&amp;
                &quot;id&quot;: &quot;NCE1A0955&quot;&amp;
            \}, &amp;
            &quot;travelers&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;stakeholder&quot;, &amp;
                    &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-NM-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                \}&amp;
            ], &amp;
            &quot;products&quot;: [&amp;
                \{&amp;
                    &quot;type&quot;: &quot;product&quot;, &amp;
                    &quot;id&quot;: &quot;BYECBX-2024-09-10-PNR-AIR-1&quot;, &amp;
                    &quot;ref&quot;: &quot;processedPnr.products&quot;&amp;
                \}&amp;
            ]&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="10" responseEndLine="226" responseBeginLine="220" endLine="218" beginLine="217" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:30.911585 - 10 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[BYECBX]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 15: A character does not match, expected &apos;S&apos;, received &apos;N&apos;." compareAt="17:55:31.165108 - 10 Sep 2024"><TEXT><![CDATA[--- RLR ]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION><TEXT><![CDATA[---&amp;
RP/]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SYD6X0102/SYD6X0102 {*}/{*} {*}Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[BYECBX]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[NCE1A0955/NCE1A0955            YG/SU  10SEP24/1555Z   BYECBX&amp;
]]></TEXT></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(local).*?AB}]]></EXPRESSION><VALUE><![CDATA[  1.SIMPSON/BART&amp;
  2  6X7040 Y 13DEC 5 FRALHR HK1  0735 0835  13DEC  E  6X/BYECBX&amp;
  3 AP +33600000666&amp;
  4 TK OK10SEP/NCE1A0955&amp;
  5 AB]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[ CY-GREAT COMPANY/NA-MR SIMPSON/A1-LONG STREET/PO-12344/&amp;
       ZP-BS7890/CI-NEWTOWN/ST-NY/CO-US&amp;
  6 AM CY-GREAT COMPANY/NA-MR SIMPSON/A1-12 LONG STREET/&amp;
       PO-12344/ZP-BS7890/CI-NEWTOWN/ST-NY/CO-US&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="246" responseBeginLine="244" endLine="242" beginLine="238" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:31.234892 - 10 Sep 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[BYECBX]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON compareAt="17:55:31.510939 - 10 Sep 2024" match="OK"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[RCI+1A:BYECBX::100924:1555&apos;&amp;
RSI+RP:AASU:NCE1A0955:12345675+NCE1A0955+NCE+NCE1A0955:1127YG:100924:12345675:1555&apos;&amp;
LFT+3:P12+--- RLR ---&apos;&amp;
STX+RLR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
UID+12345675:NCE1A0955+A&apos;&amp;
SYS++1A:NCE&apos;&amp;
PRE+FR&apos;&amp;
SEQ++2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
PNH++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%env_num%=.{1}}]]></EXPRESSION><VALUE><![CDATA[1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{(multi).*}]]></EXPRESSION><VALUE><![CDATA[SDI+++2024:12:17&apos;&amp;
EMS++PT:1+NM+1&apos;&amp;
TIF+SIMPSON::1+BART&apos;&amp;
ETI+:1+UN:Y:Y::SIMPSON:BART&apos;&amp;
ODI&apos;&amp;
EMS++ST:1+AIR+2&apos;&amp;
TVL+131224:0735:131224:0835+FRA+LHR+6X+7040:Y+ET&apos;&amp;
MSG+1&apos;&amp;
RCI+6X:BYECBX&apos;&amp;
RPI+1+HK&apos;&amp;
APD+738:0:0200::5+++407:M++M:M&apos;&amp;
CBD+M&apos;&amp;
SDT+P2&apos;&amp;
FSD&apos;&amp;
TVL+131224:0735:131224:0835+FRA+LHR&apos;&amp;
IFT+ACO+AIRCRAFT OWNER AMADEUS SIX&apos;&amp;
DUM&apos;&amp;
REF+PT:1&apos;&amp;
DUM&apos;&amp;
EMS++OT:2+AP+3&apos;&amp;
LFT+3:5+\+33600000666&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:5+TK+4&apos;&amp;
TKE++OK:100924::NCE1A0955&apos;&amp;
EMS++OT:10+OPC+5&apos;&amp;
OPE+NCE1A0955:100924:1:8:6X CANCELLATION DUE TO NO TICKET NCE TIME ZONE::1757&apos;&amp;
REF+ST:1*PT:1&apos;&amp;
EMS++OT:3+AB/+6&apos;&amp;
SAD+2+CY:GREAT COMPANY*NA:MR SIMPSON*A1:LONG STREET*PO:12344*ZP:BS7890*CI:NEWTOWN*ST:NY*CO:US&apos;&amp;
REF+PT:1&apos;&amp;
EMS++OT:4+AM/+7&apos;&amp;
SAD+P08+CY:GREAT COMPANY*NA:MR SIMPSON*A1:12 LONG STREET*PO:12344*ZP:BS7890*CI:NEWTOWN*ST:NY*CO:US&apos;&amp;
REF+PT:1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11"><QUERY filename="" loop="0" sentAt="17:55:31.511406 - 10 Sep 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="279" responseBeginLine="266" endLine="264" beginLine="258" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:31.701792 - 10 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE6X0100++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[BYECBX]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[10SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON compareAt="17:55:32.744040 - 10 Sep 2024" match="OK"><TEXT><![CDATA[UNH++PURCRR:14:1:1A+&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[BYECBX]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[10SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[BYECBX]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[20240910\:15\:55\:00]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%backend%=*}]]></EXPRESSION><VALUE><![CDATA[SONPK1]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:09:10:15:55:31]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%message_id%=*}]]></EXPRESSION><VALUE><![CDATA[8220380332]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%sdi_date2%=*}]]></EXPRESSION><VALUE><![CDATA[2024:09:10:15:55:31]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="299" responseBeginLine="293" endLine="292" beginLine="288" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed.cry" loop="0" sentAt="17:55:32.823621 - 10 Sep 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[8220380332]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[SONPK1]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[2024:09:10:15:55:31]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 31: A character does not match, expected &apos;4&apos;, received &apos;1&apos;." compareAt="17:55:32.910565 - 10 Sep 2024"><TEXT><![CDATA[UNH++PUPIRR:14:1:1A+&apos;&amp;
IRV+ID+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[8220380332]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
IRV+OBE+SONPK]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[4]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[1]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2024:09:10:15:55:31]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&apos;&amp;
BLB+]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[1654]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%raw_binary%=(multi).*}]]></EXPRESSION><VALUE><![CDATA[\x0A\xD6\x0C\x12\xF9\x0B\x0A\x11BYECBX-2024-09-10\x12\x03pnr\x1A\x06BYECBX&quot;\x011:q\x1A\x142024-09-10T15:55:00Z&quot;=\x0A&quot;\x0A\x09NCE1A0955\x12\x0812345675\x1A\x021A&quot;\x07AIRLINE\x12\x17\x0A\x041127\x12\x02YG\x1A\x02SU*\x02FR2\x03NCE*\x1A1APUB/ATL-0001AA/NCE1A0955J0\x1A\x142024-09-10T15:55:31Z&quot;\x0D\x0A\x0B\x0A\x09NCE1A0238*\x091APUB/ATLz\x89\x02\x0A\x0Bstakeholder\x12\x1ABYECBX-2024-09-10-PNR-NM-1&quot;\x0F\x12\x04BART\x1A\x07SIMPSONr&lt;\x0A\x07contact\x12\x1ABYECBX-2024-09-10-PNR-AP-2\x1A\x15processedPnr.contactsr&lt;\x0A\x07contact\x12\x1ABYECBX-2024-09-10-PNR-AB-3\x1A\x15processedPnr.contactsr&lt;\x0A\x07contact\x12\x1ABYECBX-2024-09-10-PNR-AM-4\x1A\x15processedPnr.contacts\xA2\x01\x12\x12\x10610963DC0000A994\x82\x01\xCA\x02\x0A\x07product\x10\x01\x1A\x1BBYECBX-2024-09-10-PNR-AIR-1&quot;\x9F\x02\x0A\x1A\x0A\x03FRA\x1A\x132024-12-13T07:35:00\x12\x1A\x0A\x03LHR\x1A\x132024-12-13T08:35:00&quot;Q\x0A\x0A\x0A\x026X\x12\x047040\x12&apos;&amp;
\x0A\x01Y\x12\x03\x0A\x01Y\x1A\x14\x0A\x02\x08\x00\x12\x0C\x0A\x04\x1A\x021A\x12\x04*\x02FR \x01&quot;\x07ECONOMY2\x1A6X-7040-2024-12-13-FRA-LHRJ\x02HKb\x84\x01\x0A\x10segment-delivery\x12\x1BBYECBX-2024-09-10-PNR-BKG-1\x1A\x10600A13DD00013C03ZA\x0A\x0Bstakeholder\x12\x1ABYECBX-2024-09-10-PNR-NM-1\x1A\x16processedPnr.travelers\x8A\x01\x01E\x92\x01\x02\x08\x00\xB2\x01z\x0A\x07contact\x12\x1ABYECBX-2024-09-10-PNR-AP-2@\x01Z\x0E\x0A\x0C+33600000666bA\x0A\x0Bstakeholder\x12\x1ABYECBX-2024-09-10-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\xBB\x01\x0A\x07contact\x12\x1ABYECBX-2024-09-10-PNR-AB-3\x1A\x0C\x0A\x0AMR SIMPSON*/\x08\x03\x12\x0BLONG STREET\x1A\x06BS7890&quot;\x02US*\x07NEWTOWN2\x02NY:\x0512344@\x05bA\x0A\x0Bstakeholder\x12\x1ABYECBX-2024-09-10-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\x0F\x0A\x0DGREAT COMPANY\xB2\x01\xBE\x01\x0A\x07contact\x12\x1ABYECBX-2024-09-10-PNR-AM-4\x1A\x0C\x0A\x0AMR SIMPSON*2\x08\x03\x12\x0E12 LONG STREET\x1A\x06BS7890&quot;\x02US*\x07NEWTOWN2\x02NY:\x0512344@\x06bA\x0A\x0Bstakeholder\x12\x1ABYECBX-2024-09-10-PNR-NM-1\x1A\x16processedPnr.travelers\xB2\x01\x0F\x0A\x0DGREAT COMPANY\xBA\x01\xD5\x01\x0A\x11automated-process\x12\x1ABYECBX-2024-09-10-PNR-TK-5\x18\x05&quot;\x132024-09-10T00:00:00*\x0B\x0A\x09NCE1A0955ZA\x0A\x0Bstakeholder\x12\x1ABYECBX-2024-09-10-PNR-NM-1\x1A\x16processedPnr.travelersb=\x0A\x07product\x12\x1BBYECBX-2024-09-10-PNR-AIR-1\x1A\x15processedPnr.products\x1AX\x0A\x1Fapplication/vnd.google.protobuf\x12\x06BYECBX\x1A\x011&quot;\x03Pnr*\%com.amadeus.models.reservation.pnr.v2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[UNT\x1D2\x1D1\x1C&apos;&amp;
&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION></TRANSACTION><ERROR filename="" line="313" severity="Fatal Error">The variable &apos;global_regression.openpnr_payload&apos; is not defined</ERROR><STATISTIC><STATISTIC_ELEMENT name="Message in">14</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">15079</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">14</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">8363</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">9</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">14</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">14</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">7116.8</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.18</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">4806.99</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">67</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="CPS" name="Conversations/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">9</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">3</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">3</STATISTIC_ELEMENT></STATISTIC></xml>