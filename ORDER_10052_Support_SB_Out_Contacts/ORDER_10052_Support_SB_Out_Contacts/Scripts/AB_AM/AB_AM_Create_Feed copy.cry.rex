<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry"><SCRIPT type="Initialize">import json
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

</SCRIPT><TRANSACTION transactionCounter="1" endLine="109" beginLine="108" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:29.668093 - 09 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="18:00:29.730048 - 09 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" responseEndLine="115" responseBeginLine="114" endLine="110" beginLine="109" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:29.731636 - 09 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><COMPARISON compareAt="18:00:29.814968 - 09 Sep 2024" match="OK"><TEXT><![CDATA[SIGN IN&amp;
&gt;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="3" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:29.815207 - 09 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="18:00:29.910926 - 09 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="124" beginLine="123" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:29.912337 - 09 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="18:00:29.982865 - 09 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="126" beginLine="125" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:31.985753 - 09 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="18:00:32.058347 - 09 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="130" responseBeginLine="130" endLine="128" beginLine="127" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:32.058934 - 09 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="18:00:32.268573 - 09 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/09SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" responseEndLine="261" responseBeginLine="252" endLine="250" beginLine="139" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:32.273683 - 09 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=json\&amp;output=protobufBase64 HTTP/1.1&amp;
Content-Type: application/json&amp;
Debug-Format: json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header"><VALUE><![CDATA[eyJub25jZSI6Ik1UTXlPRFkyT1RVek1qVXdOelU0T1E9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMDlUMTY6MDA6MjUuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoia2k4Z0ZtcGxHdm9razRZOEZWaTdUU1JuWkpNPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
&quot;&quot;&quot; \{&amp;
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
                &quot;departure&quot;:\{&amp;
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
\}&quot;&quot;&quot;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="18:00:32.492634 - 09 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[400 Bad Request]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001F5I6EJJZ4W]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[97]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json; charset=utf-8&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[con]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[tent-type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    \{&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;status&quot;: 400, &amp;
            &quot;detail&quot;: &quot;Missing request body&quot;, &amp;
            &quot;title&quot;: &quot;UNABLE TO PROCESS&quot;, &amp;
            &quot;code&quot;: 11&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="8" responseEndLine="290" responseBeginLine="279" endLine="277" beginLine="270" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:32.494742 - 09 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/ HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header2"><VALUE><![CDATA[eyJub25jZSI6Ik5UY3dNVGsxT1RneU56TTJORFl5TUE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMDlUMTY6MDA6MjUuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiNFZDYkJKVGtVcWdGeUZieWxWV0tScmpUTis0PSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;5&apos;." compareAt="18:00:32.721214 - 09 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[201 Created]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[500 Other Error]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001F5I6GJJZ4W]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[111]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json; charset=utf-8&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[con]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[tent-type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;reference&quot;: &quot;{%recloc%=.{6}}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    \{&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;version&quot;: &quot;{*}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;status&quot;: 500, &amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf2%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;detail&quot;: &quot;Error in Open PNR message handling&quot;, &amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;title&quot;: &quot;UNABLE TO PROCESS&quot;, &amp;
            &quot;code&quot;: 11&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="9" responseEndLine="315" responseBeginLine="308" endLine="306" beginLine="300" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:32.722631 - 09 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header3"><VALUE><![CDATA[eyJub25jZSI6Ik1qSTRNalV5TURFeE1qSXlNakkxTXc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMDlUMTY6MDA6MjUuMDAwWiIsInVzZXJJZCI6IllHQVJOSUVSIiwib2ZmaWNlSWQiOiJOQ0UxQTA5NTUiLCJvcmdhbml6YXRpb24iOiIxQSIsInBhc3N3b3JkIjoiL1gxeE9XN0ZGeFcxOTlZTlNKVTU5RlJUaTJFPSJ9]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" validate="manual" matchMessage="Match failed with error code 1: Callback rejected:Match function exits on unspecified Error." compareAt="18:00:32.887291 - 09 Sep 2024"><TEXT><![CDATA[HTTP/1.1 200 OK&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001F5I6IJJZ4W]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
content-length:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[2]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
etag:1&amp;
content-type:application/vnd.amadeus+json; charset=utf-8&amp;
connection:close&amp;
&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[\{\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="10" responseEndLine="332" responseBeginLine="326" endLine="324" beginLine="323" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:32.888184 - 09 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;-&apos;, received &apos;I&apos;." compareAt="18:00:32.974922 - 09 Sep 2024"><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[--- RLR {*}---&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[INVALID&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RP/SYD6X0102/SYD6X0102 {*}/{*} {*}Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[&gt;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{(local).*?AB} CY-GREAT COMPANY/NA-MR SIMPSON/A1-LONG STREET/PO-12344/&amp;
]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[       ZP-BS7890/CI-NEWTOWN/ST-NY/CO-US]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&amp;
  6 AM CY-GREAT COMPANY/NA-MR SIMPSON/A1-12 LONG STREET/&amp;
       PO-12344/ZP-BS7890/CI-NEWTOWN/ST-NY/CO-US&amp;
]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{*}]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="352" responseBeginLine="350" endLine="348" beginLine="344" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:33.035165 - 09 Sep 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: The global pattern match failed (3 patterns, RE result: -1)." compareAt="18:00:33.161124 - 09 Sep 2024"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{(multi).*}&apos;&amp;
PNH++{%env_num%=.{1}}&apos;&amp;
{(multi).*}&apos;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[MSG+:M&apos;&amp;
ERC+1:EC:1A&apos;&amp;
IFT+C:50:::EN+CHECK FORMAT&apos;]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11"><QUERY filename="" loop="0" sentAt="18:00:33.161781 - 09 Sep 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="385" responseBeginLine="372" endLine="370" beginLine="364" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="looping"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:33.304134 - 09 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE6X0100++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[09SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="18:00:33.361195 - 09 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PURCRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[09SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+001IIW2S6O0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PURCRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[SPR+++2005:8:8+2100:12:12]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="12" responseEndLine="385" responseBeginLine="372" endLine="370" beginLine="364" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="1" sentAt="18:00:36.366949 - 09 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE6X0100++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[09SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="18:00:36.432122 - 09 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PURCRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[09SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+01KSB4T5MC0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PURCRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[SPR+++2005:8:8+2100:12:12]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="405" responseBeginLine="399" endLine="398" beginLine="394" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/AB_AM/AB_AM_Create_Feed copy.cry" loop="0" sentAt="18:00:39.512961 - 09 Sep 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="18:00:39.572171 - 09 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PUPIRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+0023QH1DFA0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[IRV+OBE+SONPK4]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PUPIRQ:14:1:1A+4+18]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[BLB+{*}+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C{%raw_binary%=(multi).*}UNT\x1D2\x1D1\x1C&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION></TRANSACTION><ERROR filename="" line="419" severity="Fatal Error">The variable &apos;global_regression.openpnr_payload&apos; is not defined</ERROR><STATISTIC><STATISTIC_ELEMENT name="Message in">15</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">2634</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">15</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">4933</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">9</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">15</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">14</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.933333</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">9908.5</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">2.327</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">1631.55</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">16</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">7</STATISTIC_ELEMENT></STATISTIC></xml>