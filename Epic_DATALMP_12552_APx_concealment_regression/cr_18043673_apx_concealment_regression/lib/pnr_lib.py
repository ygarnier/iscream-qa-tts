#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
==== PDF Generic Library version 4.2.45 ===="

PNR data management module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

import random
import generic_lib

JAMO_INITIAL_LIST = ["G", "GG", "N", "D", "DD", "R", "M", "B", "BB", "S", "SS", "", "J", "JJ", "CH", "K", "T", "P", "H"]
JAMO_VOWEL_LIST = ["A", "AE", "YA", "YAE", "EO", "E", "YEO", "YE", "O", "WA", "WAE", "OE", "YO", "U", "WEO", "WE", "WI", "YU", "EU", "EUI", "I"]
JAMO_TERMINAL_LIST = ["", "G", "GG", "GS", "N", "NJ", "NH", "D", "L", "LG", "LM", "LB", "LS", "LT", "LP", "LH", "M", "B", "BS", "S", "SS", "NG", "J", "CH", "K", "T", "P", "H"]
KOR_LAT_EXCEPTION_DICTIONARY = {u"\uAE40":"KIM", u"\uAC15":"KANG", u"\uAD8C":"KWON", u"\uAD81":"KUNG", u"\uACE0":"KOH", u"\uACF5":"KONG", u"\uACAC":"KYUN", u"\uACFD":"KWAK", u"\uAD6C":"KOO", u"\uB178":"NOH",\
u"\uBC15":"PARK", u"\uBC31":"BAEK", u"\uC11D":"SEOK", u"\uC2E0":"SHIN", u"\uC2EC":"SHIM", u"\uC120\uC6B0":"SUN WOO", u"\uC774":"LEE", u"\uC548":"AHN", u"\uC720":"YOO", u"\uC624":"OH", u"\uC625":"OK", u"\uC784":"LIM",\
u"\uC724":"YOON", u"\uC6B0":"WOO", u"\uC544":"AH", u"\uC5D0":"EH", u"\uC815":"CHUNG", u"\uC870":"CHO", u"\uCD5C":"CHOI", u"\uCD08":"CHOH"}
LAT_KOR_EXCEPTION_DICTIONARY = {"KIM":u"\uAE40", "KANG":u"\uAC15", "KWON":u"\uAD8C", "KUNG":u"\uAD81", "KOH":u"\uACE0", "KONG":u"\uACF5", "KYUN":u"\uACAC", "KWAK":u"\uACFD", "KOO":u"\uAD6C", "NOH":u"\uB178",\
"PARK":u"\uBC15", "BAEK":u"\uBC31", "SEOK":u"\uC11D", "SHIN":u"\uC2E0", "SHIM":u"\uC2EC", "SUN WOO":u"\uC120\uC6B0", "LEE":u"\uC774", "AHN":u"\uC548", "YOO":u"\uC720", "OH":u"\uC624",\
"OK":u"\uC625", "LIM":u"\uC784", "YOON":u"\uC724", "WOO":u"\uC6B0", "AH":u"\uC544", "EH":u"\uC5D0", "CHUNG":u"\uC815", "CHO":u"\uC870", "CHOI":u"\uCD5C", "CHOH":u"\uCD08"}


def generate_rloc(length=6, _type="ALPHA"):
    """Generate a random record locator and return it.

    :Non-keyword arguments:
        - length -- length of the record locator generated (default: 6).
        - _type --  type of the record locator generated "ALPHA" or "NUM" (default: "ALPHA").

    :Examples: 

    >>> generic_lib.generate_rloc()
    5Y67VI

    >>> generic_lib.generate_rloc(_type="NUM")
    0534060731

    """
    if _type.upper() == "ALPHA":
        rloc = random_alpha(length).replace("0", "O")
    elif _type.upper() == "NUM":
        rloc = convert_rloc(random_alpha(length).replace("0", "O"))
    else:
        rloc = ""
    return rloc


def convert_rloc(rloc):
    """Convert an alphanumeric record locator to a numeric one or the opposite and return the converted one.

    :Non-keyword argument:
        rloc -- rloc to convert.

    :Examples: 

    >>> generic_lib.convert_rloc("5Y67VI")
    053406073118

    >>> generic_lib.convert_rloc("053406073118")
    5Y67VI

    """
    alpha_num_dictionary = {"1":"01", "2":"02", "3":"03", "4":"04", "5":"05", "6":"06", "7":"07", "8":"08", "9":"09", "A":"10", "B":"11", "C":"12", "D":"13", "E":"14", "F":"15", "G":"16", "H":"17", "I":"18", "J":"19", "K":"20", "L":"21", "M":"22", "N":"23", "O":"24", "P":"25", "Q":"26", "R":"27", "S":"28", "T":"29", "U":"30", "V":"31", "W":"32", "X":"33", "Y":"34", "Z":"35"}
    num_alpha_dictionary = {"01":"1", "02":"2", "03":"3", "04":"4", "05":"5", "06":"6", "07":"7", "08":"8", "09":"9", "10":"A", "11":"B", "12":"C", "13":"D", "14":"E", "15":"F", "16":"G", "17":"H", "18":"I", "19":"J", "20":"K", "21":"L", "22":"M", "23":"N", "24":"O", "25":"P", "26":"Q", "27":"R", "28":"S", "29":"T", "30":"U", "31":"V", "32":"W", "33":"X", "34":"Y", "35":"Z"}

    converted_rloc = ""
    # Manage conversion from alphanumeric to numeric rloc
    if len(rloc) in [5, 6]:
        for i in rloc:
            converted_rloc += alpha_num_dictionary[i]
    # Manage conversion from alphanumeric to numeric rloc
    elif len(rloc) in [10, 12]:
        for i in range(len(rloc)/2):
            converted_rloc += num_alpha_dictionary[rloc[2*i] + rloc[2*i+1]]

    # Return converted rloc
    return converted_rloc


def generate_ticket_nb():
    """Generate a random ticket number (last digit is a check) and return it as a string.

    :Example: 

    >>> generic_lib.generate_ticket_nb()
    59300703976

    """
    ticket_nb = random_int(10)
    return str(ticket_nb) +  str(ticket_nb % 7)


def random_int(nb_of_digits_min, nb_of_digits_max=0):
    """Generate a number of a given length (no leading zero) and return it.

    :Non-keyword arguments:
        - nb_of_digits_min -- minimum number of digits.
        - nb_of_digits_max -- maximum number of digits (default: 0).

    :Examples: 

    >>> generic_lib.random_int(10)
    7658940312

    >>> generic_lib.random_int(3,5)
    92345

    """
    if nb_of_digits_max == 0:
        nb_of_digits_max = nb_of_digits_min
    return random.randint(10**(nb_of_digits_min-1)-1, 10**nb_of_digits_max-1)


def random_nb(length):
    """Generate a number of given length (may contain leading zeros) and return it as a string.

    :Non-keyword argument:
        - length -- length of the number generated.

    :Example: 

    >>> generic_lib.random_nb(5)
    05232

    """
    return str(random.randint(0, 10**length - 1)).rjust(length, "0").encode("utf-8")


def random_alpha(length, additional_chars=None):
    """Generate an alphanumeric of a given length and return it.

    :Non-keyword arguments:
        - length -- length of the alphanumeric generated.
        - additional_chars -- list of non-alphanumerical characters that can be present in the result (default: None).

    :Examples: 

    >>> generic_lib.random_alpha(6)
    05232

    >>> generic_lib.random_alpha(10, ["+", "-", "\", "*"])
    209+8767\5

    """
    # Fill list of characters
    list_of_chars = [chr(letter).encode("utf-8") for letter in range(ord("A"), ord("Z")+1)]
    list_of_chars.extend([str(nb) for nb in range(10)])
    if additional_chars is not None:
        list_of_chars.extend(additional_chars)

    return "".join(random.sample(list_of_chars, length))


def random_str(length, language="LAT", additional_chars=None):
    """Generate a string of a given length and return it.

    :Non-keyword arguments:
        - length -- length of the string generated.
        - language -- "LAT", "KOR", "HIR" (japanese hiragana), "KAT "or "JPN" (japanese katakana) (default: "LAT").
        - additional_chars -- list of non-alphanumerical characters that can be present in the result.

    :Examples: 

    >>> generic_lib.random_str(8)
    KJHGHFLA

    >>> generic_lib.random_str(7, "JPN", additional_chars=["-"])
    サトウイ-チロ

    """
    # Fill list of characters
    language_dict = {"LAT":[ord("A"), ord("Z")+1], "KOR":[ord(u"\uAC00"), ord(u"\uD7A3")+1], "HIR":[ord(u"\u3041"), ord(u"\u3093")+1], "KAT":[ord(u"\u30A0"), ord(u"\u30F3")+1], "JPN":[ord(u"\u30A1"), ord(u"\u30F3")+1]}
    list_of_chars = [unichr(char).encode("utf-8") for char in range(language_dict.get(language)[0], language_dict.get(language)[1])]
    if additional_chars is not None:
        list_of_chars.extend(additional_chars)

    return "".join(random.sample(list_of_chars, length))


def random_string_generate_pax_names(nb_of_characters=0, language='LAT', additional_characters=''):
    """
    Function used to generate a string of a given length. Language can be 'LAT', 'KOR', 'HIR' (japanese hiragana),
    'KAT 'or 'JPN' (japanese katakana). This function is used internally only in generate_pax_names function

    >>> generic_lib.random_string(8) returns KJHGHFLA

    """

    # initialize random string
    return_string = u''.encode('utf-8')
    if isinstance(nb_of_characters, list):
        nb_of_characters =\
        random.randint(nb_of_characters[0], nb_of_characters[1])
    elif isinstance(nb_of_characters, int):
        # Randomly choose number of digits
        if nb_of_characters == 0:
            nb_of_characters = random.randint(1, 10)
        elif nb_of_characters < 0:
            return -1
    else:
        return return_string

    # Fill list of characters
    language_dict = {'LAT':[ord('A'), ord('Z')+1], \
    'KOR':[ord(u'\uAC00'), ord(u'\uD7A3')+1], \
    'HIR':[ord(u'\u3040'), ord(u'\u309F')+1], \
    'KAT':[ord(u'\u30A1'), ord(u'\u30FA')+1], \
    'JPN':[ord(u'\u30A1'), ord(u'\u30FA')+1]}
    list_of_characters = []
    if language_dict.get(language) is not None:
        for character in range(language_dict.get(language)[0], \
            language_dict.get(language)[1]):
            list_of_characters.append(unichr(character).encode('utf-8'))
    else:
        return return_string
    # Append additional characters
    if additional_characters != '':
        for character in additional_characters:
            list_of_characters.append(character)

    # Randomly generate string
    for _ in range(nb_of_characters):
        return_string += random.choice(list_of_characters)

    # Return number
    return return_string


def convert_str(i_string, formats="KOR_LAT", in_type="FIRSTNAME"):
    """Convert a string from or to latine alphabet and return it.

    :Non-keyword arguments:
        - i_string -- string to convert.
        - formats -- any "XXX-YYY" value where XXX is the language of the input string and YYY the language to which the string has to be converted (default: "KOR_LAT"). Languages may be "LAT", "KOR", "HIR" (japanese hiragana), "KAT "or "JPN" (japanese katakana) and either XXX or YYY must be LAT.
        - in_type -- "FIRSTNAME" or "LASTNAME" (default: "FIRSTNAME"). Depending on the type of input, the conversion algorithm might be different.

    :Examples: 

    >>> generic_lib.convert_str("RUNG", "LAT_KOR")
    룽

    >>> generic_lib.convert_str("サトウイチロ", "JPN-LAT")
    SATOUICHIRO

    """
    [in_format, out_format] = formats.split("_")
    if in_format == out_format:
        return i_string

    if (in_format.upper() == "KOR") and (out_format.upper() == "LAT"):
        o_string = convert_kor_to_lat(i_string, in_type)
    elif (in_format.upper() == "LAT") and (out_format.upper() == "KOR"):
        o_string = convert_lat_to_kor(i_string, in_type)
    elif in_format.upper() in ["JPN", "HIR", "KAT"] and (out_format.upper() == "LAT"):
        o_string = convert_jpn_to_lat(i_string)
    elif (in_format.upper() == "LAT") and (out_format.upper() in ["KAT", "JPN"]):
        o_string = convert_lat_to_jpn(i_string, out_format.upper())
    elif (in_format.upper() == "LAT") and (out_format.upper() == "HIR"):
        o_string = convert_lat_to_jpn(i_string, "HIR")

    return o_string


def  convert_lat_to_jpn(i_string, i_format):
    """Convert a string from latine alphabet to japanese alphabet."""
    if i_format == "HIR":
        # Replace syllables
        o_string = i_string
        o_string = o_string.replace("KYA", u"\u304D" + u"\u3083").replace("KYO", u"\u304D" + u"\u3087").replace("KYU", u"\u304D" + u"\u3085")
        o_string = o_string.replace("BB", "tsuB").replace("CC", "tsuC").replace("DD", "tsuD").replace("FF", "tsuF").replace("GG", "tsuG").replace("HH", "tsuH").replace("JJ", "tsuJ").replace("KK", "tsuK").replace("LL", "tsuL").replace("MM", "tsuM")
        o_string = o_string.replace("PP", "tsuP").replace("RR", "tsuR").replace("SS", "tsuS").replace("TT", "tsuT").replace("VV", "tsuV").replace("WW", "tsuW").replace("XX", "tsuX").replace("ZZ", "tsuZ")
        o_string = o_string.replace("SHI", u"\u3057").replace("CHI", u"\u3061").replace("TSU", u"\u3064")
        o_string = o_string.replace("BA", u"\u3070").replace("BI", u"\u3073").replace("BU", u"\u3076").replace("BE", u"\u3079").replace("BO", u"\u307C").replace("DA", u"\u3060").replace("JI", u"\u3062").replace("ZU", u"\u3065").replace("DE", u"\u3067").replace("DO", u"\u3069")
        o_string = o_string.replace("GA", u"\u304C").replace("GI", u"\u304E").replace("GU", u"\u3050").replace("GE", u"\u3052").replace("GO", u"\u3054").replace("HA", u"\u306F").replace("HI", u"\u3072").replace("FU", u"\u3075").replace("HE", u"\u3078").replace("HO", u"\u307B")
        o_string = o_string.replace("KA", u"\u304B").replace("KI", u"\u304D").replace("KU", u"\u304F").replace("KE", u"\u3051").replace("KO", u"\u3053").replace("MA", u"\u307E").replace("MI", u"\u307F").replace("MU", u"\u3080").replace("ME", u"\u3081").replace("MO", u"\u3082")
        o_string = o_string.replace("NA", u"\u306A").replace("NI", u"\u306B").replace("NU", u"\u306C").replace("NE", u"\u306D").replace("NO", u"\u306E").replace("PA", u"\u3071").replace("PI", u"\u3074").replace("PU", u"\u3077").replace("PE", u"\u307A").replace("PO", u"\u307D")
        o_string = o_string.replace("RA", u"\u3089").replace("RI", u"\u308A").replace("RU", u"\u308B").replace("RE", u"\u308C").replace("RO", u"\u308D").replace("SA", u"\u3055").replace("SU", u"\u3059").replace("SE", u"\u305B").replace("SO", u"\u305D")
        o_string = o_string.replace("TA", u"\u305F").replace("TE", u"\u3066").replace("TO", u"\u3068").replace("WA", u"\u308F").replace("WI", u"\u3090").replace("WE", u"\u3091").replace("WO", u"\u3092").replace("VU", u"\u3094")
        o_string = o_string.replace("YA", u"\u3084").replace("YU", u"\u3086").replace("YO", u"\u3088").replace("ZA", u"\u3056").replace("ZU", u"\u305A").replace("ZE", u"\u305C").replace("ZO", u"\u305E").replace("tsu", u"\u3063")
        o_string = o_string.replace("A", u"\u3042").replace("I", u"\u3044").replace("U", u"\u3046").replace("E", u"\u3048").replace("O", u"\u304A").replace("N", u"\u3093")
    elif i_format in ["KAT", "JPN"]:
        # Replace syllables
        o_string = i_string.encode("utf-8")
        o_string = o_string.replace("KYA", u"\u304D" + u"\u3083").replace("KYO", u"\u304D" + u"\u3087").replace("KYU", u"\u304D" + u"\u3085")
        o_string = o_string.replace("BB", "tsuB").replace("CC", "tsuC").replace("DD", "tsuD").replace("FF", "tsuF").replace("GG", "tsuG").replace("HH", "tsuH").replace("JJ", "tsuJ").replace("KK", "tsuK").replace("LL", "tsuL").replace("MM", "tsuM")
        o_string = o_string.replace("PP", "tsuP").replace("RR", "tsuR").replace("SS", "tsuS").replace("TT", "tsuT").replace("VV", "tsuV").replace("WW", "tsuW").replace("XX", "tsuX").replace("ZZ", "tsuZ")
        o_string = o_string.replace("SHI", u"\u30B7").replace("CHI", u"\u30C1").replace("TSU", u"\u30C4")
        o_string = o_string.replace("BA", u"\u30D0").replace("BI", u"\u30D3").replace("BU", u"\u30D6").replace("BE", u"\u30D9").replace("BO", u"\u30DC").replace("DA", u"\u30C0").replace("JI", u"\u30C2").replace("ZU", u"\u30C5").replace("DE", u"\u30C7").replace("DO", u"\u30C9")
        o_string = o_string.replace("GA", u"\u30AC").replace("GI", u"\u30AE").replace("GU", u"\u30B0").replace("GE", u"\u30B2").replace("GO", u"\u30B4").replace("HA", u"\u30CF").replace("HI", u"\u30D2").replace("FU", u"\u30D5").replace("HE", u"\u30D8").replace("HO", u"\u30DB")
        o_string = o_string.replace("KA", u"\u30AB").replace("KI", u"\u30AD").replace("KU", u"\u30AF").replace("KE", u"\u30B1").replace("KO", u"\u30B3").replace("MA", u"\u30DE").replace("MI", u"\u30DF").replace("MU", u"\u30E0").replace("ME", u"\u30E1").replace("MO", u"\u30E2")
        o_string = o_string.replace("NA", u"\u30CA").replace("NI", u"\u30CB").replace("NU", u"\u30CC").replace("NE", u"\u30CD").replace("NO", u"\u30CE").replace("PA", u"\u30D1").replace("PI", u"\u30D4").replace("PU", u"\u30D7").replace("PE", u"\u30DA").replace("PO", u"\u30DD")
        o_string = o_string.replace("RA", u"\u30E9").replace("RI", u"\u30EA").replace("RU", u"\u30EB").replace("RE", u"\u30EC").replace("RO", u"\u30ED").replace("SA", u"\u30B5").replace("SU", u"\u30B9").replace("SE", u"\u30BB").replace("SO", u"\u30BD")
        o_string = o_string.replace("TA", u"\u30BF").replace("TE", u"\u30C6").replace("TO", u"\u30C8").replace("WA", u"\u30EF").replace("WI", u"\u30F0").replace("WE", u"\u30F1").replace("WO", u"\u30F2").replace("VU", u"\u30F4").replace("VA", u"\u30F7").replace("VI", u"\u30F8").replace("VE", u"\u30F9").replace("VO", u"\u30FA")
        o_string = o_string.replace("YA", u"\u30E4").replace("YU", u"\u30E6").replace("YO", u"\u30E8").replace("ZA", u"\u30B6").replace("ZU", u"\u30BA").replace("ZE", u"\u30BC").replace("ZO", u"\u30BE").replace("tsu", u"\u30C3")
        o_string = o_string.replace("A", u"\u30A2").replace("I", u"\u30A4").replace("U", u"\u30A6").replace("E", u"\u30A8").replace("O", u"\u30AA").replace("N", u"\u30F3")

    return o_string.encode("utf-8")


def  convert_jpn_to_lat(i_string):
    """Convert a string from japanese alphabet to latine alphabet."""
    jpn_lat_dictionary = {u"\u3041":"a", u"\u3042":"A", u"\u3043":"i", u"\u3044":"I", u"\u3045":"u", u"\u3046":"U", u"\u3047":"e", u"\u3048":"E", u"\u3049":"o", u"\u304A":"O",\
        u"\u304B":"KA", u"\u304C":"GA", u"\u304D":"KI", u"\u304E":"GI", u"\u304F":"KU", u"\u3050":"GU", u"\u3051":"KE", u"\u3052":"GE", u"\u3053":"KO", u"\u3054":"GO",\
        u"\u3055":"SA", u"\u3056":"ZA", u"\u3057":"SHI", u"\u3058":"JI", u"\u3059":"SU", u"\u305A":"ZU", u"\u305B":"SE", u"\u305C":"ZE", u"\u305D":"SO", u"\u305E":"ZO",\
        u"\u305F":"TA", u"\u3060":"DA", u"\u3061":"CHI", u"\u3062":"JI", u"\u3063":"tsu", u"\u3064":"TSU", u"\u3065":"ZU", u"\u3066":"TE", u"\u3067":"DE", u"\u3068":"TO", u"\u3069":"DO",\
        u"\u306A":"NA", u"\u306B":"NI", u"\u306C":"NU", u"\u306D":"NE", u"\u306E":"NO",\
        u"\u306F":"HA", u"\u3070":"BA", u"\u3071":"PA", u"\u3072":"HI", u"\u3073":"BI", u"\u3074":"PI", u"\u3075":"FU", u"\u3076":"BU", u"\u3077":"PU", u"\u3078":"HE", u"\u3079":"BE", u"\u307A":"PE", u"\u307B":"HO", u"\u307C":"BO", u"\u307D":"PO",\
        u"\u307E":"MA", u"\u307F":"MI", u"\u3080":"MU", u"\u3081":"ME", u"\u3082":"MO", u"\u3083":"ya", u"\u3084":"YA", u"\u3085":"yu", u"\u3086":"YU", u"\u3087":"yo", u"\u3088":"YO",\
        u"\u3089":"RA", u"\u308A":"RI", u"\u308B":"RU", u"\u308C":"RE", u"\u308D":"RO", u"\u308E":"wa", u"\u308F":"WA", u"\u3090":"WI", u"\u3091":"WE", u"\u3092":"WO", u"\u3093":"N", u"\u3094":"VU", u"\u3095":"ka", u"\u3096":"ke",\
        u"\u30A1":"a", u"\u30A2":"A", u"\u30A3":"i", u"\u30A4":"I", u"\u30A5":"u", u"\u30A6":"U", u"\u30A7":"e", u"\u30A8":"E", u"\u30A9":"o", u"\u30AA":"O",\
        u"\u30AB":"KA", u"\u30AC":"GA", u"\u30AD":"KI", u"\u30AE":"GI", u"\u30AF":"KU", u"\u30B0":"GU", u"\u30B1":"KE", u"\u30B2":"GE", u"\u30B3":"KO", u"\u30B4":"GO",\
        u"\u30B5":"SA", u"\u30B6":"ZA", u"\u30B7":"SHI", u"\u30B8":"JI", u"\u30B9":"SU", u"\u30BA":"ZU", u"\u30BB":"SE", u"\u30BC":"ZE", u"\u30BD":"SO", u"\u30BE":"ZO",\
        u"\u30BF":"TA", u"\u30C0":"DA", u"\u30C1":"CHI", u"\u30C2":"JI", u"\u30C3":"tsu", u"\u30C4":"TSU", u"\u30C5":"ZU", u"\u30C6":"TE", u"\u30C7":"DE", u"\u30C8":"TO", u"\u30C9":"DO",\
        u"\u30CA":"NA", u"\u30CB":"NI", u"\u30CC":"NU", u"\u30CD":"NE", u"\u30CE":"NO", u"\u30CF":"HA", u"\u30D0":"BA", u"\u30D1":"PA", u"\u30D2":"HI", u"\u30D3":"BI", u"\u30D4":"PI", u"\u30D5":"FU", u"\u30D6":"BU", u"\u30D7":"PU", u"\u30D8":"HE", u"\u30D9":"BE", u"\u30DA":"PE", u"\u30DB":"HO", u"\u30DC":"BO", u"\u30DD":"PO",\
        u"\u30DE":"MA", u"\u30DF":"MI", u"\u30E0":"MU", u"\u30E1":"ME", u"\u30E2":"MO", u"\u30E3":"ya", u"\u30E4":"YA", u"\u30E5":"yu", u"\u30E6":"YU", u"\u30E7":"yo", u"\u30E8":"YO",\
        u"\u30E9":"RA", u"\u30EA":"RI", u"\u30EB":"RU", u"\u30EC":"RE", u"\u30ED":"RO", u"\u30EE":"wa", u"\u30EF":"WA", u"\u30F0":"WI", u"\u30F1":"WE", u"\u30F2":"WO", u"\u30F3":"N", u"\u30F4":"VU", u"\u30F5":"ka", u"\u30F6":"ke", u"\u30F7":"VA", u"\u30F8":"VI", u"\u30F9":"VE", u"\u30FA":"VO"}

    # Translate syllable by syllable
    o_string = "".encode("utf-8")
    for syllable in i_string.decode("utf-8"):
        o_string += jpn_lat_dictionary[syllable]

    # Replace exceptions:
    o_string = o_string.replace("KIya", "KYA").replace("KIyo", "KYO").replace("KIyu", "KYU")
    o_string = o_string.replace("tsuB", "BB").replace("tsuC", "CC").replace("tsuD", "DD").replace("tsuF", "FF").replace("tsuG", "GG").replace("tsuH", "HH").replace("tsuJ", "JJ").replace("tsuK", "KK").replace("tsuL", "LL").replace("tsuM", "MM")
    o_string = o_string.replace("tsuN", "NN").replace("tsuP", "PP").replace("tsuR", "RR").replace("tsuS", "SS").replace("tsuT", "TT").replace("tsuV", "VV").replace("tsuW", "WW").replace("tsuX", "XX").replace("tsuZ", "ZZ")

    return o_string


def convert_kor_to_lat(string_, in_type):
    """Convert a string from korean alphabet to latine alphabet. Each hangul character is composed by the combination of 3 ordered parts:
    - initial part
    - vowel part
    - terminal part
    """
    converted_string = "".encode("utf-8")
    syllables_list = string_.decode("utf-8")
    blank = 0
    bypass = 0
    index = 0
    for syllable in syllables_list:
        if bypass == 0:
            # Manage blanks to separate syllables
            if blank == 1:
                converted_string += " ".encode("utf-8")

            if (in_type.upper() == "LASTNAME") and (syllable in KOR_LAT_EXCEPTION_DICTIONARY.keys()):
                converted_string += KOR_LAT_EXCEPTION_DICTIONARY[syllable]
            elif (in_type.upper() == "LASTNAME") and (syllable == u"\uC120") and (syllables_list[index+1] == u"\uC6B0"):
                converted_string += "SUN WOO"
                bypass = 1
            else:
                syllable_offset = ord(syllable) - ord(u"\uAC00")
                initial_index = syllable_offset//(len(JAMO_VOWEL_LIST)*len(JAMO_TERMINAL_LIST))
                vowel_index = (syllable_offset%(len(JAMO_VOWEL_LIST)*len(JAMO_TERMINAL_LIST)))//len(JAMO_TERMINAL_LIST)
                terminal_index = syllable_offset%len(JAMO_TERMINAL_LIST)
                converted_string += JAMO_INITIAL_LIST[initial_index] + JAMO_VOWEL_LIST[vowel_index] + JAMO_TERMINAL_LIST[terminal_index]
            blank = 1
        else:
            bypass = 0
        # Implement index
        index += 1
    return converted_string


def convert_lat_to_kor(string_, in_type):
    """Convert a string from latine alphabet to korean alphabet. Each hangul character is composed by the combination of 3 ordered parts:
    - initial part
    - vowel part
    - terminal part
    """
    converted_string = "".encode("utf-8")
    # Split roman string per space
    word_list = string_.split(" ")
    bypass = 0
    error_text = " IS NOT A ROMAN SYLLABLE CONVERTIBLE IN HANGUL"
    index = 0
    for original_word in word_list:
        # initialize variables
        initial_index = -1
        vowel_index = -1
        terminal_index = -1
        counter = 0
        word = original_word

        if bypass == 0:
            # Deal with exception table for last names
            if (original_word in LAT_KOR_EXCEPTION_DICTIONARY.keys()) and (in_type.upper() == "LASTNAME"):
                converted_string += unichr(ord(LAT_KOR_EXCEPTION_DICTIONARY.get(original_word))).encode("utf-8")
            elif (in_type.upper() == "LASTNAME") and (original_word == "SUN") and (word_list[index+1] == "WOO"):
                converted_string += unichr(ord(LAT_KOR_EXCEPTION_DICTIONARY.get("SUN WOO")[0])).encode("utf-8") + unichr(ord(LAT_KOR_EXCEPTION_DICTIONARY.get("SUN WOO")[1])).encode("utf-8")
                bypass = 1
            else:
                # Determine initial_index value
                if len(original_word) >= 2:
                    if word[:2] in JAMO_INITIAL_LIST:
                        counter += 2
                        initial_index = JAMO_INITIAL_LIST.index(word[:2])
                if initial_index == -1:
                    counter += 1
                    if word[0] in JAMO_INITIAL_LIST:
                        initial_index = JAMO_INITIAL_LIST.index(word[0])
                    else:
                        initial_index = JAMO_INITIAL_LIST.index("")

                if counter == len(word) - 1:
                    print original_word + error_text

                # initial_jamo = ord(u"\u1100") + initial_index
                word = original_word[counter:]

                # Determine vowel_index value
                if len(original_word) > counter + 3:
                    if word[:3] in JAMO_VOWEL_LIST:
                        counter += 3
                        vowel_index = JAMO_VOWEL_LIST.index(word[:3])
                if (len(original_word) > counter + 2) and (vowel_index == -1):
                    if word[:2] in JAMO_VOWEL_LIST:
                        counter += 2
                        vowel_index = JAMO_VOWEL_LIST.index(word[:2])
                if (len(original_word) > counter + 1) and (vowel_index == -1):
                    if word[0] in JAMO_VOWEL_LIST:
                        counter += 1
                        vowel_index = JAMO_VOWEL_LIST.index(word[0])

                if vowel_index == -1:
                    print original_word + error_text
                    return string_

                # vowel_jamo = ord(u"\u1161") + vowel_index
                word = original_word[counter:]

                # Determine terminal_index value
                if len(original_word) == counter:
                    terminal_index = 0
                else:
                    if word in JAMO_TERMINAL_LIST:
                        terminal_index = JAMO_TERMINAL_LIST.index(word)
                    else:
                        print original_word + error_text
                        return string_

                # terminal_jamo = ord(u"\u11A7") + terminal_index
                converted_string += unichr(ord(u"\uAC00") + (initial_index*len(JAMO_VOWEL_LIST) + vowel_index)*len(JAMO_TERMINAL_LIST) + terminal_index).encode("utf-8")
        else:
            bypass = 0
        # Increment index
        index += 1

    return converted_string


def retrieve(air_seg, name):
    """Return a RT entry format.

    :Non-keyword arguments:
        - air_seg -- object AirSegment() to retrieve.
        - name -- object PaxName() to retrieve.

    :Examples: 

    >>> air_segment = generic_lib.AirSegment("BA", "123", "C", "12FEB23", "NCE", "CDG")

    >>> name = generic_lib.PaxName(last_name="SIMPSON", first_name="BART")

    >>> generic_lib.retrieve(air_segment, name)
    RTBA123/12FEB-SIMPSON

    """
    return "RT" + air_seg.airline + air_seg.flight_nb + "/" + air_seg.tty_date + "-" + name.last_name


def generate_pax_names(nb_of_pax=0, max_length=40, language='LAT'):
    """
    Function used to generate passengers names for n passengers. \
Language can be 'LAT', 'KOR' or 'JPN' (name generated in japanese \
katakana)\n
    Examples::

    - generic_lib.generate_pax_names(1) returns GFDGFV/KNMIOUJ
    - generic_lib.generate_pax_names(4, 10, 'KOR') returns 멖복/꿄/넽/꿧/춿

    """
#     print("- Entering generate_pax_names(" + str(nb_of_pax) \
#         + ', ' + str(max_length) + ', ' + language + ")")

    # Errors handling
    if (nb_of_pax > 9) or (nb_of_pax < 0):
#         print("- Leaving generate_pax_names(): \
# ERROR PATH - invalid nb_of_pax")
        return ''
    elif max_length <= 2*nb_of_pax:
#         print("- Leaving generate_pax_names(): \
# ERROR PATH - invalid max_length")
        return ''
    elif language.upper() not in ['KOR', 'JPN', 'LAT', 'HIR', 'KAT']:
#         print("- Leaving generate_pax_names(): \
# ERROR PATH - invalid language")
        return ''

    # randomly choose number of slashes in group name
    if nb_of_pax == 0:
        nb_of_pax = random.randint(0, 1)
#         print('group slash : ' + str(nb_of_pax))

    # initialize data
    pax_name = u''.encode('utf-8')
    if (language.upper() == 'KOR') and (max_length == 30):
        max_length = 10
    pax_name_max_length = max_length -2*nb_of_pax

    # randomly generate family name (leave space for surname)
    if language.upper() == 'LAT':
        pax_length = random.randint(2, pax_name_max_length)
    else:
        pax_length = random.randint(1, pax_name_max_length)
#     print('pax_length = ' + str(pax_length))
    pax_name +=\
        generic_lib.random_string_generate_pax_names(pax_length, language)

    # randomly generate surnames
    surname_list = []
    nb_of_attempt = 0
    for i in range(nb_of_pax):
        pax_length += 1
        surname_length =\
            random.randint(1, max_length - pax_length - 2*(nb_of_pax -(i+1)))
#         print('surname_length = ' + str(surname_length))
        surname = generic_lib.random_string_generate_pax_names(surname_length, language)
        while (surname in surname_list) and (nb_of_attempt < 10):
            nb_of_attempt += 1
            surname = generic_lib.random_string_generate_pax_names(surname_length, language)
        surname_list.append(surname)
        pax_name += u'\u002F'.encode('utf-8') + surname
        pax_length += surname_length

    # Return passengers name
#     print("- Leaving generate_pax_names(): "\
#         + pax_name)
    return pax_name


def extract_pax(pax_names, pax_nb, separator='/'):
    """
    Function used to return a specific passenger name from a cluster. A negative pax_nb will return only
    corresponding first name.\n
    
    :Examples:

    >>> generic_lib.extract_pax('SIMPSON/BART/LISA', 1)
    SIMPSON/BART
    
    >>> generic_lib.extract_pax(-2)
    LISA

    """

    # Manage error cases
    if pax_names.count('/') < abs(pax_nb):
        return -1

    # Get only first name
    if pax_nb < 0:
        pax_name = pax_names.split('/')[abs(pax_nb)]
    # Get only last name
    elif pax_nb == 0:
        pax_name = pax_names.split('/')[0]
    # Get complete pax name
    else:
        pax_name = pax_names.split('/')[0] + separator + pax_names.split('/')[pax_nb]

    # Return ticket number
    return pax_name