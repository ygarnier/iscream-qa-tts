<xml scenarioFilename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry"><SCRIPT type="Initialize">import json
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

        assert_equal(actual=len(openpnr[&apos;contacts&apos;]), expected=4, item_name=&apos;number of contacts&apos;)
        contacts_1 = openpnr[&apos;contacts&apos;][0]
        contacts_2 = openpnr[&apos;contacts&apos;][1]
        contacts_3 = openpnr[&apos;contacts&apos;][2]
        contacts_4 = openpnr[&apos;contacts&apos;][3]

        #Check service data for AP element + SSR CTCX element
        assert_equal(actual=contacts_1[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_1[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-AP-2&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_1[&apos;purpose&apos;], expected= [u&apos;STANDARD&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_1[&apos;freeFlowFormat&apos;], expected=&apos;+33600000666&apos;, item_name=&apos;contact freeFlowFormat&apos;)

        assert_equal(actual=contacts_2[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_2[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-SSR-3&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_2[&apos;email&apos;][&apos;address&apos;], expected=&quot;BART.SIMPSON//MAIL.COM/FR&quot;, item_name=&apos;contact email/address&apos;)
        assert_equal(actual=contacts_2[&apos;purpose&apos;], expected= [u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_2[&apos;security&apos;][&apos;allowedParties&apos;][0][&apos;party&apos;][&apos;company&apos;][&apos;code&apos;], expected=&apos;6X&apos;, item_name=&apos;contact security/code&apos;)
        assert_equal(actual=contacts_2[&apos;security&apos;][&apos;consentPermissions&apos;][0][&apos;validity&apos;][&apos;validityStatus&apos;], expected=&apos;GRANTED&apos;, item_name=&apos;contact security/validityStatus&apos;)

        assert_equal(actual=contacts_3[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_3[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-SSR-4&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_3[&apos;phone&apos;][&apos;number&apos;], expected=&quot;0123456789&quot;, item_name=&apos;contact email/address&apos;)
        assert_equal(actual=contacts_3[&apos;purpose&apos;], expected= [u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_3[&apos;security&apos;][&apos;allowedParties&apos;][0][&apos;party&apos;][&apos;company&apos;][&apos;code&apos;], expected=&apos;6X&apos;, item_name=&apos;contact security/code&apos;)
        assert_equal(actual=contacts_3[&apos;security&apos;][&apos;consentPermissions&apos;][0][&apos;validity&apos;][&apos;validityStatus&apos;], expected=&apos;GRANTED&apos;, item_name=&apos;contact security/validityStatus&apos;)

        assert_equal(actual=contacts_4[&apos;type&apos;], expected=&apos;contact&apos;, item_name=&apos;contact type&apos;)
        assert_equal(actual=contacts_4[&apos;id&apos;], expected= recloc+&quot;-&quot;+today+&quot;-PNR-SSR-5&quot;, item_name=&apos;contact id&apos;)
        assert_equal(actual=contacts_4[&apos;purpose&apos;], expected= [u&apos;NOTIFICATION&apos;], item_name=&apos;contact purpose&apos;)
        assert_equal(actual=contacts_4[&apos;isDeclined&apos;], expected= True, item_name=&apos;contact security/code&apos;)
        assert_equal(actual=contacts_4[&apos;security&apos;][&apos;allowedParties&apos;][0][&apos;party&apos;][&apos;company&apos;][&apos;code&apos;], expected=&apos;6X&apos;, item_name=&apos;contact security/code&apos;)

    except Exception as e:
        print(&apos;OpenPNR validation failed: {}&apos;.format(e))
        return TTS_KO

    print(&apos;OpenPNR validation successful&apos;)
    return TTS_OK

</SCRIPT><TRANSACTION transactionCounter="1" endLine="102" beginLine="101" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:56.045774 - 11 Sep 2024"><TEXT><![CDATA[IG]]></TEXT></QUERY><REPLY receiveAt="15:40:56.095498 - 11 Sep 2024" filename="">SIGN IN&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="2" responseEndLine="108" responseBeginLine="107" endLine="103" beginLine="102" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:56.095993 - 11 Sep 2024"><TEXT><![CDATA[JO]]></TEXT></QUERY><COMPARISON compareAt="15:40:56.188842 - 11 Sep 2024" match="OK"><TEXT><![CDATA[SIGN IN&amp;
&gt;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="3" endLine="110" beginLine="109" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:56.188975 - 11 Sep 2024"><TEXT><![CDATA[JD]]></TEXT></QUERY><REPLY receiveAt="15:40:56.256995 - 11 Sep 2024" filename="">&amp;
********         NCE1A0955&amp;
&amp;
AREA  TM  MOD SG/DT.LG TIME      ACT.Q   STATUS     NAME&amp;
A                       24             NOT SIGNED&amp;
B                                      NOT SIGNED&amp;
C                                      NOT SIGNED&amp;
D                                      NOT SIGNED&amp;
E                                      NOT SIGNED&amp;
F                                      NOT SIGNED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="4" endLine="117" beginLine="116" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="N/A"><COMMENT> 1. Sign in with test_user_1A_sign in office test_user_1A_office</COMMENT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:56.257195 - 11 Sep 2024"><TEXT><![CDATA[OK-WE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="15:40:56.309137 - 11 Sep 2024" filename="">  NETWORK 09 SUB-SYS FE DELETION LIST&amp;
     CC2B44    DELETED OK&amp;
  DELETION FINISHED&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="5" endLine="119" beginLine="118" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="N/A"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:58.313325 - 11 Sep 2024"><TEXT><![CDATA[OK-WY/C-C5AGY/W-AMAD/S-80X22/O-]]></TEXT><VARIABLE name="test_user_1A_office"><VALUE><![CDATA[NCE1A0955]]></VALUE></VARIABLE><TEXT><![CDATA[/T-NCE/A-NCE/L-]]></TEXT><VARIABLE name="ATID"><VALUE><![CDATA[********]]></VALUE></VARIABLE></QUERY><REPLY receiveAt="15:40:58.368883 - 11 Sep 2024" filename="">&amp;
LEIDS:   CC2B44&amp;
INITIALIZED FOR: NETWORK 09&amp;
&gt;</REPLY></TRANSACTION><TRANSACTION transactionCounter="6" responseEndLine="123" responseBeginLine="123" endLine="121" beginLine="120" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="OK"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:58.369301 - 11 Sep 2024"><TEXT><![CDATA[Jia]]></TEXT><VARIABLE name="test_user_1A_sign"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[/SU.]]></TEXT><VARIABLE name="test_user_1A_extended_office"><VALUE><![CDATA[NCE6X0100]]></VALUE></VARIABLE><TEXT><![CDATA[-]]></TEXT><VARIABLE name="test_user_1A_pwd"><VALUE><![CDATA[***************]]></VALUE></VARIABLE></QUERY><COMPARISON compareAt="15:40:58.533967 - 11 Sep 2024" match="OK"><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{.*}]]></EXPRESSION><VALUE><![CDATA[&amp;
]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[A-SIGN COMPLETE]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[/11SEP/SU&amp;
************  AMADEUS PRODUCT NEWS  ***********  SEE GGNEWS&amp;
AIR2 INSELAIR INTERNATIONAL (7I) ENJOYS ISM IASR GGNEWSAIR2&amp;
HTL  BALLADINS (BL) ENJOY HTL DYNAMIC ACCESS     GGNEWSHTL&amp;
AIR1 PULLMANTUR AIR (EB) ENJOYS AAS              GGNEWSAIR1&amp;
AIR  UTAIR UKRAINE (QU) ENJOYS AAS               GGNEWSAIR&amp;
&gt;]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="7" responseEndLine="148" responseBeginLine="139" endLine="137" beginLine="132" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:58.535342 - 11 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=json\&amp;output=protobufBase64 HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline"><VALUE><![CDATA[eyJub25jZSI6Ik5EVTBPRFF3TWpjMU5URTNNRGd5TVE9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMTM6NDA6NTEuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJMMG5WSGxYdTVhVk5yN2RPUXBjcHdMSDRPVFk9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
]]></TEXT><VARIABLE name="input_json_SSR_CTCx"><VALUE><![CDATA[\{&amp;
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
&quot;contacts&quot;: [\{&amp;
           &quot;type&quot;: &quot;contact&quot;,&amp;
           &quot;id&quot;: &quot;AP&quot;,&amp;
           &quot;phone&quot;: \{&amp;
               &quot;number&quot;: &quot;+33600000666&quot;&amp;
           \},&amp;
           &quot;purpose&quot;: [&quot;STANDARD&quot;]&amp;
       \}, \{&amp;
               &quot;type&quot;: &quot;contact&quot;,&amp;
               &quot;id&quot;: &quot;CTCE&quot;,&amp;
               &quot;email&quot;: \{&amp;
                   &quot;address&quot;: &quot;BART.SIMPSON//MAIL.COM/FR&quot;&amp;
               \},&amp;
               &quot;purpose&quot;: [&amp;
                   &quot;NOTIFICATION&quot;&amp;
               ],&amp;
               &quot;travelerRefs&quot;: [&amp;
                   \{&amp;
                       &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                       &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                       &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                   \}&amp;
               ],&amp;
               &quot;security&quot;: \{&amp;
                   &quot;allowedParties&quot;: [&amp;
                       \{&amp;
                           &quot;party&quot;: \{&amp;
                               &quot;company&quot;: \{&amp;
                                   &quot;code&quot;: &quot;6X&quot;&amp;
                               \}&amp;
                           \}&amp;
                       \}&amp;
                   ],&amp;
                   &quot;consentPermissions&quot;: [&amp;
                       \{&amp;
                           &quot;validity&quot;: \{&amp;
                               &quot;validityStatus&quot;: &quot;GRANTED&quot;&amp;
                           \}&amp;
                       \}&amp;
                   ]&amp;
               \}&amp;
           \},\{&amp;
               &quot;type&quot;: &quot;contact&quot;,&amp;
               &quot;id&quot;: &quot;CTCM&quot;,&amp;
               &quot;phone&quot;: \{&amp;
                   &quot;number&quot;: &quot;0123456789&quot;&amp;
               \},&amp;
               &quot;purpose&quot;: [&amp;
                   &quot;NOTIFICATION&quot;&amp;
               ],&amp;
               &quot;travelerRefs&quot;: [&amp;
                   \{&amp;
                       &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                       &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                       &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                   \}&amp;
               ],&amp;
               &quot;security&quot;: \{&amp;
                   &quot;allowedParties&quot;: [&amp;
                       \{&amp;
                           &quot;party&quot;: \{&amp;
                               &quot;company&quot;: \{&amp;
                                   &quot;code&quot;: &quot;6X&quot;&amp;
                               \}&amp;
                           \}&amp;
                       \}&amp;
                   ],&amp;
                   &quot;consentPermissions&quot;: [&amp;
                       \{&amp;
                           &quot;validity&quot;: \{&amp;
                               &quot;validityStatus&quot;: &quot;GRANTED&quot;&amp;
                           \}&amp;
                       \}&amp;
                   ]&amp;
               \}&amp;
           \},\{&amp;
               &quot;type&quot;: &quot;contact&quot;,&amp;
               &quot;id&quot;: &quot;CTCR&quot;,&amp;
               &quot;isDeclined&quot;: &quot;True&quot;,&amp;
               &quot;purpose&quot;: [&amp;
                   &quot;NOTIFICATION&quot;&amp;
               ],&amp;
               &quot;travelerRefs&quot;: [&amp;
                   \{&amp;
                       &quot;type&quot;: &quot;stakeholder&quot;,&amp;
                       &quot;id&quot;: &quot;PAX-1&quot;,&amp;
                       &quot;ref&quot;: &quot;processedPnr.travelers&quot;&amp;
                   \}&amp;
               ],&amp;
               &quot;security&quot;: \{&amp;
                   &quot;allowedParties&quot;: [&amp;
                       \{&amp;
                           &quot;party&quot;: \{&amp;
                               &quot;company&quot;: \{&amp;
                                   &quot;code&quot;: &quot;6X&quot;&amp;
                               \}&amp;
                           \}&amp;
                       \}&amp;
                   ],&amp;
                   &quot;consentPermissions&quot;: [&amp;
                       \{&amp;
                           &quot;validity&quot;: \{&amp;
                               &quot;validityStatus&quot;: &quot;GRANTED&quot;&amp;
                           \}&amp;
                       \}&amp;
                   ]&amp;
               \}&amp;
           \}&amp;
    ],&amp;
    &quot;automated_processes&quot;: [&amp;
        \{&amp;
            &quot;type&quot;: &quot;automated-process&quot;,&amp;
            &quot;code&quot;: &quot;OK&quot;&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="15:40:58.687345 - 11 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[401 Unauthorized]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DP8IPJNI0A]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
con]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[tent-length:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[content-]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[length:109]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    \{&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;status&quot;: 401, &amp;
            &quot;code&quot;: 701, &amp;
            &quot;title&quot;: &quot;Wrong authentication credentials.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="8" responseEndLine="177" responseBeginLine="166" endLine="164" beginLine="157" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:58.690104 - 11 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/ HTTP/1.1&amp;
Content-Type: application/json&amp;
Authorization: 1AAuth ]]></TEXT><VARIABLE name="auth_header_airline_2"><VALUE><![CDATA[eyJub25jZSI6Ik1URTBOemM0T0RjeU56QTJNamcyTmc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMTM6NDA6NTEuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiI4WjNOUXYvVmh1Q0tJN2pFN01hd0dEaHJ4SWs9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&amp;
    &quot;openPnr&quot;: &quot;]]></TEXT><VARIABLE name="received_protobuf"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;&amp;
\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="15:40:58.839607 - 11 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[201 Created]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[401 Unauthorized]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DP8ITJNI0A]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
con]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[tent-length:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[etag:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[content-]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[length:109]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\{]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    &quot;errors&quot;: []]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;reference&quot;: &quot;{%recloc%=.{6}}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[    \{&amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;version&quot;: &quot;{*}&quot;, &amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;status&quot;: 401, &amp;
]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[    ]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[&quot;openPnr&quot;: &quot;{%received_protobuf2%=.*}&quot;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[        &quot;code&quot;: 701, &amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[\}]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[            &quot;title&quot;: &quot;Wrong authentication credentials.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="9" responseEndLine="202" responseBeginLine="195" endLine="193" beginLine="187" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:58.842697 - 11 Sep 2024"><TEXT><![CDATA[POST /]]></TEXT><VARIABLE name="SAP"><VALUE><![CDATA[1ASIUTOPLEGU]]></VALUE></VARIABLE><TEXT><![CDATA[/v2/open-pnrs/conversion?input=protobufBase64\&amp;output=json HTTP/1.1&amp;
Debug-Format: debug&amp;
Content-Type: application/json&amp;
Authorization:1AAuth ]]></TEXT><VARIABLE name="auth_header_airline_3"><VALUE><![CDATA[eyJub25jZSI6Ik1URTVOamcxTVRVMU9USXlPRFEzTnc9PSIsInRpbWVzdGFtcCI6IjIwMjQtMDktMTFUMTM6NDA6NTEuMDAwWiIsInVzZXJJZCI6IkNPVEVTVFVTRVIiLCJvZmZpY2VJZCI6IlNZRDZYMDEwMiIsIm9yZ2FuaXphdGlvbiI6IjZYIiwicGFzc3dvcmQiOiJsYzNaK3hWK3lSVWhWWU9zSDJ1S2NwQnB1VGM9In0=]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
&amp;
\{&quot;openPnr&quot;:&quot;]]></TEXT><VARIABLE name="received_protobuf2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&quot;\}]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 9: A character does not match, expected &apos;2&apos;, received &apos;4&apos;." compareAt="15:40:59.020365 - 11 Sep 2024"><TEXT><![CDATA[HTTP/1.1 ]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[200 OK]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[401 Unauthorized]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
ama-request-id:]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION><VALUE><![CDATA[0001DP8IXJNI0A]]></VALUE></REGULAR_EXPRESSION><TEXT><![CDATA[&amp;
con]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[tent-length:{*}&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[nection:close&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[etag:1]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[content-type:application/vnd.amadeus+json]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
content-]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[type:application/vnd.amadeus+json; charset=utf-8]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[length:109]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[connection:close]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><UNMATCH validate="automatic"><EXPECTED></EXPECTED><RECEIVED><TEXT><![CDATA[\{]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
]]></TEXT><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{%received_json%=.*}]]></EXPRESSION><VALUE><![CDATA[    &quot;errors&quot;: [&amp;
        \{&amp;
            &quot;status&quot;: 401, &amp;
            &quot;code&quot;: 701, &amp;
            &quot;title&quot;: &quot;Wrong authentication credentials.&quot;, &amp;
            &quot;source&quot;: \{&amp;
                &quot;pointer&quot;: &quot;uri&quot;&amp;
            \}&amp;
        \}&amp;
    ]&amp;
\}]]></VALUE></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="10" responseEndLine="218" responseBeginLine="213" endLine="211" beginLine="210" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:59.022763 - 11 Sep 2024"><TEXT><![CDATA[RT ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;-&apos;, received &apos;I&apos;." compareAt="15:40:59.108492 - 11 Sep 2024"><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[--- RLR {*}---&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[INVALID&amp;
]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RP/SYD6X0102/SYD6X0102 {*}/{*} {*}Z   ]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[&gt;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{(local).*?SSR CTCE} 6X HK1 BART.SIMPSON//MAIL.COM/FR&amp;
]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[  6 SSR CTCM 6X HK1 0123456789]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&amp;
  7 SSR CTCR 6X HK1&amp;
]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{*}]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="11" responseEndLine="238" responseBeginLine="236" endLine="234" beginLine="230" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:59.153926 - 11 Sep 2024"><TEXT><![CDATA[UNH++PNRRET:]]></TEXT><VARIABLE name="PNRRET_Version"><VALUE><![CDATA[14]]></VALUE></VARIABLE><TEXT><![CDATA[:]]></TEXT><VARIABLE name="PNRRET_Release"><VALUE><![CDATA[2]]></VALUE></VARIABLE><TEXT><![CDATA[:1A&apos;&amp;
ORG+00+:]]></TEXT><VARIABLE name="DESTINATION_OFFICE"><VALUE><![CDATA[NCE1A0950]]></VALUE></VARIABLE><TEXT><![CDATA[+++++A]]></TEXT><VARIABLE name="MY_SIGN"><VALUE><![CDATA[1127YG]]></VALUE></VARIABLE><TEXT><![CDATA[SUCKS&apos;&amp;
RET+2&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: The global pattern match failed (3 patterns, RE result: -1)." compareAt="15:40:59.286964 - 11 Sep 2024"><TEXT><![CDATA[UNH++:::+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[{(multi).*}&apos;&amp;
PNH++{%env_num%=.{1}}&apos;&amp;
{(multi).*}&apos;&amp;
]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[MSG+:M&apos;&amp;
ERC+1:EC:1A&apos;&amp;
IFT+C:50:::EN+CHECK FORMAT&apos;]]></TEXT></RECEIVED></UNMATCH></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="12" endLine="247" beginLine="246" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="N/A"><SCRIPT type="Exec">env_num = int (env_num)
env_num = env_num - 0
</SCRIPT><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:59.289445 - 11 Sep 2024"><TEXT><![CDATA[UNH++::&apos;&amp;
print(env_num)]]></TEXT></QUERY><REPLY receiveAt="15:40:59.333337 - 11 Sep 2024" filename="">UNB+IATB:1+1AAPITES3+TESAPI3+240911:1340+00CNAF3XMJ0002+00LH2B8KQ30002++E&apos;&amp;
UNH+1+CONTRL:2:1:UN+********&apos;&amp;
UCI+00LH2B8KQ30002+TESAPI3+1AAPITES3+7&apos;&amp;
UCM+1+UNKMSG:XX:X:XX+4+17&apos;&amp;
UNT+4+1&apos;&amp;
UNZ+1+00CNAF3XMJ0002&apos;</REPLY></TRANSACTION><ERROR filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" line="246" severity="Error">Python Error in exec script</ERROR><TRANSACTION transactionCounter="12"><QUERY filename="" loop="0" sentAt="15:40:59.333502 - 11 Sep 2024"></QUERY></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="277" responseBeginLine="264" endLine="262" beginLine="256" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="looping"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:40:59.440905 - 11 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE6X0100++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="15:40:59.488183 - 11 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PURCRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+00D71CPHMI0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PURCRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[SPR+++2005:8:8+2100:12:12]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="13" responseEndLine="277" responseBeginLine="264" endLine="262" beginLine="256" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="1" sentAt="15:41:02.496091 - 11 Sep 2024"><TEXT><![CDATA[UNH++PURCRQ:14:1:1A&apos;&amp;
ORG+1A+:NCE6X0100++++FR:EUR:FR+A001SU&apos;&amp;
RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SPR+++2005:8:8+2100:12:12++&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="15:41:02.543703 - 11 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PURCRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[RCI+:]]></TEXT><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::]]></TEXT><VARIABLE name="today_ddmmyy"><VALUE><![CDATA[11SEP24]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+00DT8G83UL0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PURCRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[SPR+++2005:8:8+2100:12:12]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[&apos;&amp;
DUM&apos;&amp;
RCI+:]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><VARIABLE name="recloc"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[::{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+{%backend%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ENV+]]></TEXT><VARIABLE name="env_num"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[ATC++]]></TEXT><VARIABLE name="openpnr_publication"><VALUE><![CDATA[604]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{%message_id%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{%sdi_date2%=*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><REGULAR_EXPRESSION matchStatus="success"><EXPRESSION><![CDATA[{*}]]></EXPRESSION></REGULAR_EXPRESSION></COMPARISON></TRANSACTION><TRANSACTION transactionCounter="14" responseEndLine="297" responseBeginLine="291" endLine="290" beginLine="286" filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" match="KO"><QUERY filename="/mnt/c/Users/ygarnier/LAST_REPO/open_pnr_validation/ORDER_10052_Support_SB_Out_Contacts/ORDER_10052_Support_SB_Out_Contacts/Scripts/SSR_CTCx/SSR_CTCx_Create_Feed.cry" loop="0" sentAt="15:41:05.592896 - 11 Sep 2024"><TEXT><![CDATA[UNH++PUPIRQ:14:1:1A&apos;&amp;
IRV+ID+]]></TEXT><VARIABLE name="message_id"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
IRV+OBE+]]></TEXT><VARIABLE name="backend"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;&amp;
SDI+++]]></TEXT><VARIABLE name="sdi_date2"><VALUE><![CDATA[]]></VALUE></VARIABLE><TEXT><![CDATA[&apos;]]></TEXT></QUERY><COMPARISON KO="KO" matchMessage="Match failed in body at index 0: A character does not match, expected &apos;P&apos;, received &apos;C&apos;." compareAt="15:41:05.649305 - 11 Sep 2024"><TEXT><![CDATA[UNH++]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[PUPIRR]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[CONTRL]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[14]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[2]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[:1:]]></TEXT><UNMATCH validate="automatic"><EXPECTED><TEXT><![CDATA[1A]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UN]]></TEXT></RECEIVED></UNMATCH><TEXT><![CDATA[+&apos;&amp;
]]></TEXT><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+ID+{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCI+00E625GGOW0001+1ASI+NONE+7&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[IRV+OBE+SONPK{*}&apos;]]></TEXT></EXPECTED><RECEIVED><TEXT><![CDATA[UCM+1+PUPIRQ:14:1:1A+4+18&apos;]]></TEXT></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[SDI+++{*}&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><UNMATCH validate="manual"><EXPECTED><TEXT><![CDATA[BLB+{*}+E+UNH\x1D1\x1DDUMMYY\x1F01\x1F1\x1F1A\x1C{%raw_binary%=(multi).*}UNT\x1D2\x1D1\x1C&apos;]]></TEXT></EXPECTED><RECEIVED></RECEIVED></UNMATCH><TEXT><![CDATA[&amp;
UNT+6+1&apos;]]></TEXT></COMPARISON></TRANSACTION><TRANSACTION></TRANSACTION><ERROR filename="" line="311" severity="Fatal Error">The variable &apos;global_regression.openpnr_payload&apos; is not defined</ERROR><STATISTIC><STATISTIC_ELEMENT name="Message in">16</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes in">3093</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages out">16</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="bytes" name="Bytes out">7083</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Conversations">9</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions">16</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Transactions parsed">15</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Ratio">0.9375</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Total duration">9607.7</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Parse duration">1.264</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Parse percentage">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="ms" name="Wait duration">1405.34</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="%" name="Wait percentage">14</STATISTIC_ELEMENT><STATISTIC_ELEMENT unit="TPS" name="Transactions/s">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Number of Timeouts">0</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Messages compared">10</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Errors found">7</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="Python errors found">1</STATISTIC_ELEMENT><STATISTIC_ELEMENT name="No match counter">7</STATISTIC_ELEMENT></STATISTIC></xml>