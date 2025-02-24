#----------------------------------------------------------------
# PRODUCT: Reservation Platform Security - GDPR
# POINT(S) OF CONTACT: CSS-Q&T-RQE-PPT 
# SCRIPT: data.py
# DESCRIPTION: Data set declaration
#----------------------------------------------------------------

import sys
import os
sys.path.append(os.path.join(global_regression.TTS_RootDir, "lib"))

import generic_lib
from date_and_time_lib import get_date
from rest import generate_auth_key


#------------------------------------------------------------------
# Global variables (BE_DATE, ATID, TEST_SYSTEM)
#------------------------------------------------------------------

ATID = global_regression.ATID
MY_SIGN=global_regression.MY_SIGN
MY_OFFICE=global_regression.MY_OFFICE
MY_PASSWORD=global_regression.MY_PASSWORD
DESTINATION_OFFICE=global_regression.DESTINATION_OFFICE
MY_USER=global_regression.MY_USER
MY_EXTENDED_OFFICE=global_regression.MY_EXTENDED_OFFICE

#SAP = '1ASIUORMPSSD'

#------------------------------------------------------------------
# PNR details
#------------------------------------------------------------------

today = get_date(output_format='YYYY-MM-DD', offset=0)
today_ddmmm = get_date(output_format='DDMMM', offset=0)
today_ddmmyy = get_date(output_format='DDMMMYY', offset=0)
dateFuture = get_date(output_format='YYYY-MM-DD', offset=40)
dateFuture2 = get_date(output_format='DDMMM', offset=40)
dateFuture3 = get_date(output_format='DDMMM', offset=51)
several_days_ago_ddmmyy = get_date(output_format='DDMMYY', offset=-5)
several_days_ago_ddmmmyy = get_date(output_format='DDMMMYY', offset=-5)

openpnr_publication = '604'
openpnr_publication_TA = '60400'
SAP = '1ASIUTOPLEG{}'.format(global_regression.PHASE_LETTER)

#_________________________________________________________________________________________________________________
# Import ATID and credentials stored in a local uncommitted file

user_data_file = os.path.join(global_regression.TTS_RootDir, 'data', 'user_data.py')
assert os.path.exists(user_data_file), 'Create the data/user_data.py with test user credentials, based on the user_data.template example'

execfile(user_data_file)
ATID = global_regression.ATID

# Different "auth_header" for each call to the Open PNR API
auth_header = generate_auth_key(test_user_1A_user, test_user_1A_pwd, test_user_1A_office, test_user_1A_org)
auth_header2 = generate_auth_key(test_user_1A_user, test_user_1A_pwd, test_user_1A_office, test_user_1A_org)
auth_header3 = generate_auth_key(test_user_1A_user, test_user_1A_pwd, test_user_1A_office, test_user_1A_org)
auth_header4 = generate_auth_key(test_user_1A_user, test_user_1A_pwd, test_user_1A_office, test_user_1A_org)


# "auth_header" for 6X airline office
auth_header_airline = generate_auth_key("COTESTUSER", "QaOqy7MYUcngdTY", "SYD6X0102", "6X")
auth_header_airline_2 = generate_auth_key("COTESTUSER", "QaOqy7MYUcngdTY", "SYD6X0102", "6X")

# "auth_header" for T/A office
auth_header_TA = generate_auth_key("1306AA", "lyeKlGO9eKqjIBe*", "NCE6X21PS", "1A")
auth_header_TA_2 = generate_auth_key("1306AA", "lyeKlGO9eKqjIBe*", "NCE6X21PS", "1A")


#------------------------------------------------------------------
# Generic data
#------------------------------------------------------------------

test_user_1A_sign = MY_SIGN
test_user_1A_pwd = MY_PASSWORD
test_user_1A_office = MY_OFFICE
test_user_1A_user = MY_USER
test_user_1A_extended_office = MY_EXTENDED_OFFICE
test_user_1A_org = '1A'

# Sign
sign = '1234QA'
sign0_edi = '0327CC'
sign1 = '1110SP'
sign1_edi = '0000CO'
sign6X0 = '0000CO'
signR6X0 = '0002CO'
signY = '0002CO'
sign2 = '1234QA'
sign3 = '0581AA'
sign3_509 = '0001AB'
sign3_edi = '0327CC'
sign4 = '1236QA'
sign4_do = '0000CO'
sign4_edi = '0184CO'
sign5 = '1239QA'
sign5_edi = '0000AT'
sign6 = '0055AA'
sign7 = '1235QA'
sign7_edi = '0000AT'
sign8= '1237QA'
sign8_edi = '0001AB'
sign9 = '0056AA'
sign9_edi = '0000AT'
sign10 = '1240QA'
sign10_edi = '0002CO'
sign11 = '1235QA'
sign12= '1239QA'
sign13 = '1238QA'
sign1A0 = '0327CC'
signAX2 = '0002AT'
signL12 = '0001AB'
signL128 = '0000AT'
signAIDL_JL0 = '0002AT'
signAIDL_JL2 = '0002AT'
signAIDL_QR0 = '0000AT'
sign7S0 = '0000CO'
MYSIGN =''
# used for TTY
signAC_edi = '6441AT'

#ATID ='09AC1227'

import generic_lib
if global_regression.TEST_SYSTEM != 'DEV' :
    PASSWORD = generic_lib.pwd_lib.Aim("QA-RES-TKT_0103FR", context.global_regression).get_password() #AUTO CYBERARK
else :
    PASSWORD = generic_lib.pwd_lib.Aim("QA-RES-TKT_0103FR_DEV", context.global_regression).get_password() #AUTO CYBERARK

# CRY script 31 to 36, 50
DEFAULT_OFFICE_6X1= "BLR6X1123" 
# CRY script 1, script 20, 30, 41 as retriever
DEFAULT_OFFICE_L128 = "NUEL128BW" # not AIDL
# CRY script 2 + EDI, 10, 50, 60
# EDI script 2
RETRIEVER10 = "NCE7X0102"
RETRIEVER10_EDI = "NCE7X0102"
# CRY script 3 + EDI, 12, 22, 32, 43
RETRIEVER4 = "NCE2X4703"
RETRIEVER4_EDI = "NCE2X4703"
# CRY script 4, 13, 23, 33, 44
RETRIEVER5 = "NCEEP5100"
# CRY script 5, 14, 24, 34, 45
RETRIEVER7 = "LONOC7101"
# CRY script 6, 15, 25, 35, 46
RETRIEVER8 = "NCEAD86R6"
# CRY script 7, 16, 26, 36, 47, 36
RETRIEVER9 = "LONZI9100"
# CRY script 8, 27
OFFICE_JL2 = "HIJJL23AA" # not AIDL
RETRIEVER_AIDL00 = "NCE1A0P07"
# CRY script 9
OFFICE_AIDL_JL2 = "TYOJL2767"
# CRY script 10, script 17
DEFAULT_OFFICE2 = "NCE6X31RP"
# CRY script 1, 11
# EDI script 1
RETRIEVER1 = "BLR6X1123"
RETRIEVER1_EDI = "BLR6X1123"
# CRY script 18
RETRIEVER_AIDL2 = "NCE6X2300"
# CRY script 20
OFFICE_6X2 = "NCE6X27QA" # not AIDL
# CRY script 20, script 41, ( 60 )
DEFAULT_OFFICE3 = "SYD6X0102"
# CRY script 20, 48, EDI 07-04
DEFAULT_OFFICE4 = "NCE7S0980"
# CRY script 21, 42, 48
OFFICE_6X0 = "LON6X00QA"
RETRIEVER_6X3 = "NCE6X3001" # not AIDL
# CRY script 27
OFFICE_1A0 = "NCE1A0950" # not AIDL
# CRY script 28
DEFAULT_OFFICE = "TYOJL0510"
OFFICE_AIDL_JL = "TYOJL2500" # AIDL
# CRY script 31 + EDI
RETRIEVER3 = "NCE6X31RP" 
RETRIEVER3_EDI = "NCE6X31RP"
# CRY script 40
DEFAULT_OFFICE_7X0 = "NCE7X0102"    # same as RETRIEVER10 (script 2)
# CRY script 40, 58, EDI 07-04
RETRIEVER_6X0 = "SYD6X08AA" 
# CRY script 60
DEFAULT_OFFICE_Y= "SYD6X08AA"
#CRY script 51
SECOND_OFFICE_6X1 = "MAN6X1SBR"

# EDI script 1
DEFAULT_OFFICE_L12 = "NUEL121B4" # not AIDL
#EDI 07-04
# OFFICE_AIDL_SQ = "OSLSQ08DS"
# RETRIEVER_SQ = "HELSQ08SQ"
OFFICE_AIDL00 = "NCE1A0P07"
OFFICE_AIDL_6X0 = "PAR6X07QA"
# EDI 04_Office creator 0\office creator AIDL\creator 0 AIDL_ retriever 0_ APx visible
RETRIEVER0 = "LON6X00QA"
# EDI 01_Office creator 2\office creator AIDL\creator 2 AIDL_ retriever 0_ APx concealed.edi
OFFICE_AIDL_JL0 = "TYOJL0510" 
# EDI script 6, 15, 25, 35
RETRIEVER8_EDI = "NCE1A84RX"

# AIDL offices
OFFICE_AIDL_1A0 = "NCE1A0P05"
RETRIEVER_AIDL0 = "KGLQR05TA"
OFFICE_AIDL_AY = "LISAY05FG"
RETRIEVER_AIDL2 = "NCE6X2300"
OFFICE_AIDL2 = "NCE6X2300"
RETRIEVER_AIDL_AY0 = "AMSAY05FG"
sign_AIDL2 = "1234QA"
# TYOJL2767 is AIDL
# KGLQR05TA is AIDL

# used for TTY
OFFICE_KL = "MUCKL07MX"
RETRIEVER_TA = "GOAKK2100"
OFFICE_AC = "YMQAC095L" # company code 1A
OFFICE_AC = "YMQAC0829" # company code AC
OFFICE_AC = "YYCAC08AL" # company code AC
OFFICE_AC = "YULAC0111"

# unused Claire
OFFICE_AIDL_6X0 = "PAR6X07QA"  # AIDL, impossible to connect !
OFFICE_AIDL_S72 = "UUSS72021"

# used for pauline's offices test scripts only
DEFAULT_OFFICE_AX2 = "NCEAX21AR" # not AIDL
DEFAULT_OFFICE_Q= "SYD6X0102"    # same as DEFAULT_OFFICE3 (script 20, 41)

# unused Silvia
RETRIEVER_AX2 = "NCEAX21AR" # not AIDL
DEFAULT_OFFICE_SQ1= "FRASQ12WW"
PASSWORD='Amadeus1'
OFFICE_7X0 = "NCE7X07QD"
RETRIEVER0_EDI = "NCE1A0P07"
RETRIEVER2 = "LON6X27QA" # not AIDL
# RETRIEVER_6X3_EDI = "NCE6X3001" # not AIDL
OFFICE_6X21 = "NCE6X21PS" # not AIDL
sign_6X21 = "0581AA"
DEFAULT_OFFICE_QR0 = "ABJQR0700"
PASSWORD='Amadeus1'
LogMBSU = generic_lib.AgentSign('', '1234QA', 'SU', '', PASSWORD)
OFFICE_AIDL_QR0 = "LAXQR05TA"


#_________________________________________________________________________________________________________________
# User 
# User 
test_user_sign = '1127YG'
test_user_pwd = 'Cooperzlol0669*'
test_user_office = 'NCE1A0955'

aidl_test_user_sign = '1234QA'
aidl_test_user_pwd = 'Amadeus1'
aidl_test_user_office = 'NCE1A00QA'

dedicated_aidl_test_user_sign = '0327CC'
dedicated_aidl_test_user_pwd = 'COCCELLIT509'
dedicated_aidl_test_user_pwd = 'COCCELLIT511'
dedicated_aidl_test_user_office = 'NCE1A029P'

#________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________
# Passenger 
Pax1   = generic_lib.PaxName()
Pax2   = generic_lib.PaxName()

# Contacts
Email = "MBAUER@YKT.COM"
Email2 = "BAUE@YKT.COM"
Email3 = "BA@YKT.COM"
Email3_CTCE = "BA//YKT.COM"
Email_AIDL = "JOHN.SMITH@INTERNET.COM"
Email_TTY = "JOHN.SMITH//TRAVEL.COM"
Email_TTY_in = "JULIA..SMITH//GMAIL.COM"
Email_TTY_out = "JULIA_SMITH@GMAIL.COM"
HomeNumber = "FRA69686869"
SMS = "M+33661845678"
SMS_edi = "M\+33661845678"
SMS1 = "M+33661845333"  # 02_EDI\10_if the owner of element or of the PNR changed
SMS_AIDL = "M+33661843178"
SMS_AIDL_edi = "M\+33661843178"
SMS_TTY_in = "0033687654321"
SMS_TTY_out = "33687654321"

#Group PNR
GroupName="GROUP"+generic_lib.random_str(6)
GRPF="GROUP OR CORPORATE FARE"

#________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________
# AirSegment (airline, flight_nb, class_, date, board_pt, off_pt, dep_time, arr_time)
Flight1 = generic_lib.AirSegment("JL", "113", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "HND", "ITM", "", "")
Flight_1 = generic_lib.AirSegment('6X', '402', 'Y', get_date('', 'DDMMMYY', 'DDMMMYY', offset=50), 'FRA', 'LHR', '', '')
Flight11 = generic_lib.AirSegment("JL", "115", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "HND", "ITM", "", "")
Flight1a = generic_lib.AirSegment("7X", "9619", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=49), "FRA", "NCE", "", "")
Flight2 = generic_lib.AirSegment("7S", "248", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "FRA", "NCE", "", "")
Flight3_6X = generic_lib.AirSegment("6X", "402", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "FRA", "LHR", "", "")
Flight4_9S = generic_lib.AirSegment("9S","1283", "H", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=53), "NCE", "CDG", "", "")
Flight5_CS = generic_lib.AirSegment("6X","650", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=53), "LHR", "SIN", "", "")

Flight3_6X_Grp = generic_lib.AirSegment("6X", "402", "G", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "FRA", "LHR", "", "")		
Flight3_6X_2 = generic_lib.AirSegment("6X", "402", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=55), "FRA", "LHR", "", "")		

Flight3_6X_today = generic_lib.AirSegment("6X", "402", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=0), "FRA", "LHR", "", "")

#Claire
Flight_AY = generic_lib.AirSegment("AY", "433", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "HEL", "OUL", "", "")
Flight_LH = generic_lib.AirSegment("LH", "2271", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "NCE", "MUC", "", "")
Flight_6X = generic_lib.AirSegment("6X", "562", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "NCE", "LHR", "", "")
Flight_S7 = generic_lib.AirSegment("S7", "2145", "Y", generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), "DME", "VOG", "", "") # Moscow-DME to Volograd


# from Stratos
#Flight_QR = generic_lib.AirSegment('QR', '979', 'Y',generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), 'HKT', 'DOH', "", "")
Flight_QR = generic_lib.AirSegment('QR', '841', 'Y',generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=50), 'HKT', 'DOH', "", "")
#flightQR1 = generic_lib.AirSegment('QR', '979', 'Y',date0, 'HKT', 'DOH', dep_time='2355', arr_time='0255')

#_________________________________________________________________________________________________________________
# Dates

todayDDMMM = generic_lib.get_date("","DDMMMYY","DDMMM", offset=0)
date = generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=1)
current_date_yyyymmdd = generic_lib.get_date('', 'DDMMMYY', 'YYYYMMDD', offset=0)
date2 = generic_lib.get_date("", "DDMMMYY", "DDMMM", offset=60)
date2_TTY = generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=61)
date1_TTY = generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=69)
date3_TTY = generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=75)

SeveralDaysAgo_DDMMYY = generic_lib.get_date("", "DDMMMYY", "DDMMYY", offset=-5)
SeveralDaysAgo_DDMMMYY = generic_lib.get_date("", "DDMMMYY", "DDMMMYY", offset=-5)


DOB_ADL1=generic_lib.get_date('', 'DDMMMYY', 'DDMMMYY',offset=-15000);
DOB_ADL2=generic_lib.get_date('', 'DDMMMYY', 'DDMMMYY',offset=-15000);
DOB_INF=generic_lib.get_date('', 'DDMMMYY', 'DDMMMYY', offset=-300);
#_________________________________________________________________________________________________________________
RLOC1S=generic_lib.generate_rloc()

# Create an SSR for APIS passport information
DOCS_UNCONCEALED = "UDOCS"
DOCS_CONCEALED = "XXXXX"
SSR_DOCS = "HK1-P-GBR-012345678-GBR-30JUN73-M-14APR09-"+DOCS_UNCONCEALED+"-SIMPSON-H"
CONCEALED_SSR_DOCS = "HK1 X/XXX/XXXXXXXXX/XXX/XXXXXXX/X/XXXXXXX/"+DOCS_CONCEALED
CONCEALED_SSR_DOCS_EDI = 'X/XXX/XXXXXXXXX/XXX/XXXXXXX/X/XXXXXXX/XXXXX/XXXXXXX/X'
CONCEALED_SSR_DOCO_EDI = 'XXXXX XXX/X/XXXXXXXX/XXXXXX XXX/XXXXXXX/XXX'
CONCEALED_SSR_DOCA_EDI = 'X/XXX/XXX XXXXX/XXX XXXX/XX/XXXXX'

# Create an SSR for APIS visa/secondary travel document
DOCO_UNCONCEALED = "UDOCO"
DOCO_CONCEALED = "XXXXX"
SSR_DOCO = "HK1-"+DOCO_UNCONCEALED+" GBR-V-17317323-LONDON GBR-18JUN04-USA"
CONCEALED_SSR_DOCO = "HK1 "+DOCO_CONCEALED+" XXX/X/XXXXXXXX/XXXXXX XXX/XXXXXXX/XXX"

#Create an SSR for APIS address information
#DOCA_UNCONCEALED = "SSRDOCAUNCONCEALED"
DOCA_UNCONCEALED = "UDOCA"
DOCA_CONCEALED = "XXXXX"
SSR_DOCA = "HK1-D-USA-301 "+DOCA_UNCONCEALED+"-NEW YORK-NY-10022"
CONCEALED_SSR_DOCA = "HK1 X/XXX/XXX "+DOCA_CONCEALED+"/XXX XXXX/XX/XXXXX"
#SSR_DOCA_UPDATED = "ZZZ"
SSR_DOCA_UPDATED = "Z/ZZZ/777 SSR DOCA UPDATED"

CTCE_NUM_UNCONCEALED = "1111-22/333/444 555/666666/777777"
CONCEALED_CTCE_NUM = "XXXX-XX/XXX/XXX XXX/XXXXXX/XXXXXX"
CTCE_ALFA_UNCONCEALED = "QWER-TY/UIO/PAS DFG/HJK-LZX/CVBNMM"
CONCEALED_CTCE_ALFA = "XXXX-XX/XXX/XXX XXX/XXX-XXX/XXXXXX"
CTCE_ALFNUM_UNCONCEALED = "1A1B-2C/3B/4D4 5E5/F6-Z6-Q6/7W-7V7G"
CONCEALED_CTCE_ALFNUM = "XXXX-XX/XX/XXX XXX/XX-XX-XX/XX-XXXX"

SSR_FQT_TEXT = "UNCONSCEALED"
CONCEALED_SSR_FQT_TEXT = "XXXXXXXXXXXX"
FF_number = "3628356"
CONCEALED_FF_number = "XXXXXXX"
CONCEALED_SSR_FQT_TEXT = "XXXXXXXXXXXX"

#Create an SSR for emergency contact name and number
SSR_PCTC1 = "EDWARD LEWIS/US8000325234.FLOW TEXT"
CONCEALED_SSR_PCTC1 = "XXXXXX XXXXX/XXXXXXXXXXXX.XXXX XXXX"
#Create an SSR for emergency contact, free flow text
SSR_PCTC2 = "/.FREE PHRASE"
CONCEALED_SSR_PCTC2 = "/.XXXX XXXXXX"

#Create an SSR for non-APIS passport information 
SSR_PSPT1 = "123456-GB-24FEB45-LY/SIN-M-H.TEKST"
CONCEALED_SSR_PSPT1 = "XXXXXX-XX-XXXXXXX-XX/XXX-X-X.XXXXX"
#Create an SSR for non-APIS passport information for an infant
SSR_PSPT2 = "123456-US-17FEB05-LI/TOM-MI"
CONCEALED_SSR_PSPT2 = "XXXXXX-XX-XXXXXXX-XX/XXX-XX"

SSR_FOID1 = "IDTEXTHERE"
CONCEALED_SSR_FOID1 = "XXXXXXXXXX"
SSR_FOID2 = "DL12345678-NI-PP342X"
CONCEALED_SSR_FOID2 = "XXXXXXXXXX-XX-XXXXXX"
UNCONCEALED_SSR_FOID2 = "DL12345678/NI/PP342X"
CONCEALED_RES_SSR_FOID2 = "XXXXXXXXXX/XX/XXXXXX"


# Variables defining PNRADD version/release for PNRADD scripts
PNRADD_Version = "14";
PNRADD_Release = '2'
HSFREQ_Version = "07";
HSFREQ_Release = "2";
PNRRET_Version = "14";
PNRRET_Release = '2'
PNRSPL_Version="14"
PNRSPL_Release="1"

PHIDRQ_Version="16"		
PHIDRQ_Release="1"		
PAUSRQ_Version="16"		
PAUSRQ_Release="1"		
PAUSRR_Version="16"
PAUSRR_Release="1"

PAFNSQ_version = "09"		
PAFNSQ_release = "1"		
#>FFAREQ		
FFAREQVersion="04"		
FFAREQRelease="1"		
#>PAFFSQ		
PAFFSQVersion="09"		
PAFFSQRelease="1"		
###PATNSQ###		
PATNSQ_Version = "09"		
PATNSQ_Revision = "1"


PHISUQ_Version_19="19"		
PHISUQ_Revision_19="1"		
