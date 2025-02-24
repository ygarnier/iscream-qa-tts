#!/usr/bin/env python
#-*- coding: UTF-8 -*-
"""
Unit tests module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

import unittest
import generic_lib


def logger(function):
    """ Decorator """
    def wrapper(*args, **kwargs):
        """ Print the name of the function being run and return its result. """
        print "Testing " + function.__name__
        result = function(*args, **kwargs)
        return result
    return wrapper

def inhibitor(function):
    """ Decorator """
    def wrapper(*args, **kwargs):
        """ Make sure the function is not run. """
        return 0
    return wrapper

class LibTestCase(unittest.TestCase):
    """ Contain the component testing of generic_lib. """

    @logger
    def test_class_air_segment(self):
        """ Contain the component testing of class AirSegment. """
        air_seg = generic_lib.AirSegment("BA", "1", "C", "12FEB23", "NCE", "CDG", dep_time="0800", arr_time="1155", cabin="B", arr_date="13FEB23", ope_airline="AF", ope_flight_nb="1230", ope_class="Y", ope_cabin="E")
        air_seg = generic_lib.AirSegment(air_segment=air_seg)
        self.assertEqual(air_seg.airline, "BA")
        self.assertEqual(air_seg.flight_nb, "1")
        self.assertEqual(air_seg.full_flight_nb, "0001")
        self.assertEqual(air_seg._class, "C")
        self.assertEqual(air_seg.cabin, "B")
        self.assertEqual(air_seg.board_pt, "NCE")
        self.assertEqual(air_seg.off_pt, "CDG")
        self.assertEqual(air_seg.dep_time, "0800")
        self.assertEqual(air_seg.arr_time, "1155")
        self.assertEqual(air_seg.ope_airline, "AF")
        self.assertEqual(air_seg.ope_flight_nb, "1230")
        self.assertEqual(air_seg.ope_class, "Y")
        self.assertEqual(air_seg.ope_cabin, "E")
        self.assertEqual(air_seg.date, "12FEB23")
        self.assertEqual(air_seg.tty_date, "12FEB")
        self.assertEqual(air_seg.edi_date, "120223")
        self.assertEqual(air_seg.xml_date, "2023-02-12")
        self.assertEqual(air_seg.full_date, "12FEB2023")
        self.assertEqual(air_seg.day, "12")
        self.assertEqual(air_seg.month, "FEB")
        self.assertEqual(air_seg.num_month, "02")
        self.assertEqual(air_seg.full_month, "FEBRUARY")
        self.assertEqual(air_seg.year, "23")
        self.assertEqual(air_seg.full_year, "2023")

        self.assertEqual(air_seg.book(1), "SSBA1C12FEBNCECDG1")
        self.assertEqual(air_seg.book("SG2"), "SSBA1C12FEBNCECDGSG2")

        self.assertEqual(air_seg.edi_format(), "120223+NCE+CDG+BA+001:C")
        self.assertEqual(air_seg.edi_format("PASBCQ"), "120223:0800:130223:1155+NCE+CDG+BA+01:C")

        self.assertEqual(air_seg.tty_format("HK1"), "BA001C12FEB NCECDG HK1/0800 1155+1")
        self.assertEqual(air_seg.tty_format("US3", cs_option=1), "AF1230Y12FEB NCECDG US3/0800 1155+1-BA001C")

        self.assertEqual(air_seg.pnr_format(), "BA 001 C 12FEB 7 NCECDG ")
        self.assertEqual(air_seg.pnr_format("NN1"), "BA 001 C 12FEB 7 NCECDG NN1")

        self.assertEqual(air_seg.his_format(), "BA 001 C 12FEB 7 NCECDG ")
        self.assertEqual(air_seg.his_format("NN1"), "BA 001 C 12FEB 7 NCECDG NN1")

        self.assertEqual(air_seg.ssr_asso(), "NCECDG 0001C12FEB")

    @logger
    def test_class_htl_segment(self):
        """ Contain the component testing of class HtlSegment. """
        htl_seg = generic_lib.HtlSegment("HI", "PAR999", "10MAY23", "12MAY23")
        htl_seg = generic_lib.HtlSegment(htl_segment=htl_seg)
        self.assertEqual(htl_seg.provider, "HI")
        self.assertEqual(htl_seg._property, "PAR999")
        self.assertEqual(htl_seg.city, "PAR")
        self.assertEqual(htl_seg.code, "999")
        self.assertEqual(htl_seg.start_date, "10MAY23")
        self.assertEqual(htl_seg.tty_start_date, "10MAY")
        self.assertEqual(htl_seg.edi_start_date, "100523")
        self.assertEqual(htl_seg.xml_start_date, "2023-05-10")
        self.assertEqual(htl_seg.full_start_date, "10MAY2023")
        self.assertEqual(htl_seg.start_day, "10")
        self.assertEqual(htl_seg.start_month, "MAY")
        self.assertEqual(htl_seg.num_start_month, "05")
        self.assertEqual(htl_seg.full_start_month, "MAY")
        self.assertEqual(htl_seg.start_year, "23")
        self.assertEqual(htl_seg.full_start_year, "2023")
        self.assertEqual(htl_seg.end_date, "12MAY23")

        self.assertEqual(htl_seg.book(), "HIPAR99910MAY-12MAY")

        self.assertEqual(htl_seg.edi_format(), "100523::120523+PAR++HI")

        self.assertEqual(htl_seg.pnr_format("OO1"), "HTL HI OO1 PAR 10MAY 12MAY")

    @logger
    def test_class_hhl_segment(self):
        """ Contain the component testing of class HhlSegment. """
        hhl_seg = generic_lib.HhlSegment("HI", "PAR999", "10MAY23", "12MAY23")
        hhl_seg = generic_lib.HhlSegment(hhl_segment=hhl_seg)
        self.assertEqual(hhl_seg.provider, "HI")
        self.assertEqual(hhl_seg._property, "PAR999")
        self.assertEqual(hhl_seg.city, "PAR")
        self.assertEqual(hhl_seg.code, "999")
        self.assertEqual(hhl_seg.start_date, "10MAY23")
        self.assertEqual(hhl_seg.tty_start_date, "10MAY")
        self.assertEqual(hhl_seg.edi_start_date, "100523")
        self.assertEqual(hhl_seg.xml_start_date, "2023-05-10")
        self.assertEqual(hhl_seg.full_start_date, "10MAY2023")
        self.assertEqual(hhl_seg.start_day, "10")
        self.assertEqual(hhl_seg.start_month, "MAY")
        self.assertEqual(hhl_seg.num_start_month, "05")
        self.assertEqual(hhl_seg.full_start_month, "MAY")
        self.assertEqual(hhl_seg.start_year, "23")
        self.assertEqual(hhl_seg.full_start_year, "2023")
        self.assertEqual(hhl_seg.end_date, "12MAY23")

        self.assertEqual(hhl_seg.book(), "HIPAR99910MAY-12MAY")

        self.assertEqual(hhl_seg.edi_format(), "100523::120523+PAR++HI")

        self.assertEqual(hhl_seg.pnr_format("OO1"), "HHL HI OO1 PAR IN10MAY OUT12MAY")

    @logger
    def test_class_car_segment(self):
        """ Contain the component testing of class CarSegment. """
        car_seg = generic_lib.CarSegment("XX", "PAR", "10MAY23", "12MAY23", arr_time="0900", ret_time="1000", car_type="EMNR")
        car_seg = generic_lib.CarSegment(car_segment=car_seg)
        self.assertEqual(car_seg.provider, "XX")
        self.assertEqual(car_seg.city, "PAR")
        self.assertEqual(car_seg.start_date, "10MAY23")
        self.assertEqual(car_seg.tty_start_date, "10MAY")
        self.assertEqual(car_seg.edi_start_date, "100523")
        self.assertEqual(car_seg.xml_start_date, "2023-05-10")
        self.assertEqual(car_seg.full_start_date, "10MAY2023")
        self.assertEqual(car_seg.start_day, "10")
        self.assertEqual(car_seg.start_month, "MAY")
        self.assertEqual(car_seg.num_start_month, "05")
        self.assertEqual(car_seg.full_start_month, "MAY")
        self.assertEqual(car_seg.start_year, "23")
        self.assertEqual(car_seg.full_start_year, "2023")
        self.assertEqual(car_seg.end_date, "12MAY23")

        self.assertEqual(car_seg.book(), "CSXXPAR10MAY-12MAY/ARR-0900-1000/VT-EMNR")

        self.assertEqual(car_seg.edi_format(), "100523:0900:120523:1000+PAR++XX+EMNR")

        self.assertEqual(car_seg.pnr_format("OO1"), "CCR XX OO1 PAR 10MAY 12MAY EMNR")

    @logger
    def test_class_ccr_segment(self):
        """ Contain the component testing of class CcrSegment. """
        ccr_seg = generic_lib.CcrSegment("XX", "PAR", "10MAY23", "12MAY23", arr_time="0900", ret_time="1000", ccr_type="EMNR")
        ccr_seg = generic_lib.CcrSegment(ccr_segment=ccr_seg)
        self.assertEqual(ccr_seg.provider, "XX")
        self.assertEqual(ccr_seg.city, "PAR")
        self.assertEqual(ccr_seg.start_date, "10MAY23")
        self.assertEqual(ccr_seg.tty_start_date, "10MAY")
        self.assertEqual(ccr_seg.edi_start_date, "100523")
        self.assertEqual(ccr_seg.xml_start_date, "2023-05-10")
        self.assertEqual(ccr_seg.full_start_date, "10MAY2023")
        self.assertEqual(ccr_seg.start_day, "10")
        self.assertEqual(ccr_seg.start_month, "MAY")
        self.assertEqual(ccr_seg.num_start_month, "05")
        self.assertEqual(ccr_seg.full_start_month, "MAY")
        self.assertEqual(ccr_seg.start_year, "23")
        self.assertEqual(ccr_seg.full_start_year, "2023")
        self.assertEqual(ccr_seg.end_date, "12MAY23")

        self.assertEqual(ccr_seg.book(), "XXPAR10MAY-12MAY/ARR-0900-1000/VT-EMNR")

        self.assertEqual(ccr_seg.edi_format(), "100523:0900:120523:1000+PAR++XX+EMNR")

        self.assertEqual(ccr_seg.pnr_format("OO1"), "CCR XX OO1 PAR 10MAY 12MAY EMNR")

    @logger
    def test_class_mis_segment(self):
        """ Contain the component testing of class MisSegment. """
        mis_seg = generic_lib.MisSegment("XX", "PAR", "10MAY23", free_text="MISCELLANEOUS")
        mis_seg = generic_lib.MisSegment(mis_segment=mis_seg)
        self.assertEqual(mis_seg.provider, "XX")
        self.assertEqual(mis_seg.city, "PAR")
        self.assertEqual(mis_seg.date, "10MAY23")
        self.assertEqual(mis_seg.tty_date, "10MAY")
        self.assertEqual(mis_seg.edi_date, "100523")
        self.assertEqual(mis_seg.xml_date, "2023-05-10")
        self.assertEqual(mis_seg.full_date, "10MAY2023")
        self.assertEqual(mis_seg.day, "10")
        self.assertEqual(mis_seg.month, "MAY")
        self.assertEqual(mis_seg.num_month, "05")
        self.assertEqual(mis_seg.full_month, "MAY")
        self.assertEqual(mis_seg.year, "23")
        self.assertEqual(mis_seg.full_year, "2023")

        self.assertEqual(mis_seg.book("NN1"), "XXNN1PAR10MAY/MISCELLANEOUS")

        self.assertEqual(mis_seg.pnr_format("OO1"), "MIS XX OO1 PAR 10MAY-MISCELLANEOUS")

    @logger
    def test_class_atx_segment(self):
        """ Contain the component testing of class AtxSegment. """
        atx_seg = generic_lib.AtxSegment("XX", "PAR", "NCE", "10MAY23", free_text="AIR TAXI")
        atx_seg = generic_lib.AtxSegment(atx_segment=atx_seg)
        self.assertEqual(atx_seg.provider, "XX")
        self.assertEqual(atx_seg.board_pt, "PAR")
        self.assertEqual(atx_seg.off_pt, "NCE")
        self.assertEqual(atx_seg.date, "10MAY23")
        self.assertEqual(atx_seg.tty_date, "10MAY")
        self.assertEqual(atx_seg.edi_date, "100523")
        self.assertEqual(atx_seg.xml_date, "2023-05-10")
        self.assertEqual(atx_seg.full_date, "10MAY2023")
        self.assertEqual(atx_seg.day, "10")
        self.assertEqual(atx_seg.month, "MAY")
        self.assertEqual(atx_seg.num_month, "05")
        self.assertEqual(atx_seg.full_month, "MAY")
        self.assertEqual(atx_seg.year, "23")
        self.assertEqual(atx_seg.full_year, "2023")

        self.assertEqual(atx_seg.book(), "XXNN1PARNCE10MAY-AIR TAXI")

        self.assertEqual(atx_seg.pnr_format("OO1"), "ATX XX OO1 PARNCE 10MAY-AIR TAXI")

    @logger
    def test_class_tur_segment(self):
        """ Contain the component testing of class TurSegment. """
        tur_seg = generic_lib.TurSegment("XX", "PAR", "10MAY23", free_text="TOUR SEGMENT")
        tur_seg = generic_lib.TurSegment(tur_segment=tur_seg)
        self.assertEqual(tur_seg.provider, "XX")
        self.assertEqual(tur_seg.city, "PAR")
        self.assertEqual(tur_seg.date, "10MAY23")
        self.assertEqual(tur_seg.tty_date, "10MAY")
        self.assertEqual(tur_seg.edi_date, "100523")
        self.assertEqual(tur_seg.xml_date, "2023-05-10")
        self.assertEqual(tur_seg.full_date, "10MAY2023")
        self.assertEqual(tur_seg.day, "10")
        self.assertEqual(tur_seg.month, "MAY")
        self.assertEqual(tur_seg.num_month, "05")
        self.assertEqual(tur_seg.full_month, "MAY")
        self.assertEqual(tur_seg.year, "23")
        self.assertEqual(tur_seg.full_year, "2023")

        self.assertEqual(tur_seg.book("NN1"), "XXNN1PAR10MAY/TOUR SEGMENT")

        self.assertEqual(tur_seg.pnr_format("OO1"), "TUR XX OO1 PAR 10MAY-TOUR SEGMENT")

    @logger
    def test_class_svc_segment(self):
        """ Contain the component testing of class SvcSegment. """
        svc_seg = generic_lib.SvcSegment("BUST", "HK", "6X", "AMS", "CDG", "10MAY23")
        svc_seg = generic_lib.SvcSegment(svc_segment=svc_seg)
        self.assertEqual(svc_seg.code, "BUST")
        self.assertEqual(svc_seg.status, "HK")
        self.assertEqual(svc_seg.airline, "6X")
        self.assertEqual(svc_seg.board_pt, "AMS")
        self.assertEqual(svc_seg.off_pt, "CDG")
        self.assertEqual(svc_seg.date, "10MAY23")
        self.assertEqual(svc_seg.tty_date, "10MAY")
        self.assertEqual(svc_seg.edi_date, "100523")
        self.assertEqual(svc_seg.xml_date, "2023-05-10")
        self.assertEqual(svc_seg.full_date, "10MAY2023")
        self.assertEqual(svc_seg.day, "10")
        self.assertEqual(svc_seg.month, "MAY")
        self.assertEqual(svc_seg.num_month, "05")
        self.assertEqual(svc_seg.full_month, "MAY")
        self.assertEqual(svc_seg.year, "23")
        self.assertEqual(svc_seg.full_year, "2023")

        self.assertEqual(svc_seg.book(1, 2), "6XHK1BUSTCDG/10MAY")

        self.assertEqual(svc_seg.pnr_format(1, 2), "/SVC 6X HK1 BUST CDG 10MAY")

    @logger
    def test_class_ssr_segment(self):
        """ Contain the component testing of class SsrSegment. """
        ssr_seg = generic_lib.SsrSegment("PETC", "AF", free_text="DOG")
        ssr_seg = generic_lib.SsrSegment(ssr_segment=ssr_seg)
        self.assertEqual(ssr_seg.code, "PETC")
        self.assertEqual(ssr_seg.airline, "AF")
        self.assertEqual(ssr_seg.free_text, "DOG")

        self.assertEqual(ssr_seg.book(), "SRPETC AF -DOG")

        self.assertEqual(ssr_seg.pnr_format("HK1"), "SSR PETC AF HK1 DOG")

    @logger
    def test_class_pax_name(self):
        """ Contain the component testing of class PaxName. """
        pax = generic_lib.PaxName(last_name="PAYRE-FICOUT", first_name="CORALIE")
        pax = generic_lib.PaxName(pax_name=pax)
        self.assertEqual(pax.last_name, "PAYRE-FICOUT")
        self.assertEqual(pax.first_name, "CORALIE")

        self.assertEqual(pax.book(), "NM1PAYRE-FICOUT/CORALIE")

        self.assertEqual(pax.edi_format(), "PAYRE-FICOUT::1+CORALIE")

        self.assertEqual(pax.pnr_format(), "PAYRE-FICOUT/CORALIE")

        self.assertEqual(pax.tty_format(), "1PAYRE-FICOUT/CORALIE")

        self.assertEqual(pax.his_format(), "PAYRE-FICOUT/CORALIE")

        self.assertEqual(pax.ssr_asso(), "1PAYRE-FICOUT/CORALIE")

    @logger
    def test_class_pax_cluster(self):
        """ Contain the component testing of class PaxCluster. """
        pax = generic_lib.PaxCluster(3, last_name="SIMPSON", list_of_first_names=["BART", "LISA", "MARGE"])
        pax = generic_lib.PaxCluster(pax_cluster=pax)
        self.assertEqual(pax.last_name, "SIMPSON")
        self.assertEqual(pax.list_of_first_names, ["BART", "LISA", "MARGE"])

        self.assertEqual(pax.book(), "NM3SIMPSON/BART/LISA/MARGE")

        self.assertEqual(str(pax.retrieve_pax(2)), str(generic_lib.PaxName(last_name="SIMPSON", first_name="LISA")))

        self.assertEqual(pax.extract_pax(1), "SIMPSON/BART")

        self.assertEqual(pax.tty_format(), "3SIMPSON/BART/LISA/MARGE")

        self.assertEqual(pax.pnr_format(), "3SIMPSON/BART/LISA/MARGE")

        self.assertEqual(pax.his_format(), "SIMPSON/BART SIMPSON/LISA SIMPSON/MARGE")

        self.assertEqual(pax.ssr_asso(), "NM3SIMPSON/BART/LISA/MARGE")

    @logger
    def test_class_group(self):
        """ Contain the component testing of class Group. """
        group = generic_lib.Group(5, group_name="SIMPSONS FAMILY", list_of_individual_pax=[generic_lib.PaxName(last_name='SIMPSON', first_name='HOMER'), generic_lib.PaxName(last_name='SIMPSON', first_name='MARGE'), generic_lib.PaxName(last_name='SIMPSON', first_name='BART')])
        group = generic_lib.Group(group=group)
        self.assertEqual(group.group_name, "SIMPSONS FAMILY")
        self.assertEqual(len(group.list_of_individual_pax), 3)

        self.assertEqual(group.book(), "NG5SIMPSONS FAMILY;NM1SIMPSON/HOMER;NM1SIMPSON/MARGE;NM1SIMPSON/BART")

        group.add_pax(generic_lib.PaxName(last_name="SIMPSON", first_name="LISA"))
        self.assertEqual(len(group.list_of_individual_pax), 4)

        group.remove_pax(4)
        self.assertEqual(len(group.list_of_individual_pax), 3)

        self.assertEqual(str(group.retrieve_pax(2)), str(generic_lib.PaxName(last_name="SIMPSON", first_name="MARGE")))

        self.assertEqual(group.extract_pax(3), "SIMPSON/BART")

        self.assertEqual(group.tty_format(), "3SIMPSONS FAMILY")

        self.assertEqual(group.pnr_format(), "0.  2SIMPSONS FAMILY  NM: 3")

        self.assertEqual(group.his_format(), "05SIMPSONS FAMILY")

    @logger
    def test_class_agent_sign(self):
        """ Contain the component testing of class AgentSign. """
        sign = generic_lib.AgentSign("LONBA0100", "4634CP", "SU")
        sign = generic_lib.AgentSign(agent_sign=sign)
        self.assertEqual(sign.office, "LONBA0100")
        self.assertEqual(sign.city, "LON")
        self.assertEqual(sign.corporation, "BA")
        self.assertEqual(sign.qualifier, "0")
        self.assertEqual(sign.office_nb, "100")
        self.assertEqual(sign.sign, "4634CP")
        self.assertEqual(sign.duty_code, "SU")

        self.assertEqual(sign.edi_format(), "00+:LONBA0100+++++4634CPSU")

        self.assertEqual(sign.extended_sign("B"), "JIB4634CP/SU.LONBA0100")

        self.assertEqual(sign.remote_sign(), "JUI/O-LONBA0100/JI4634CP/SU")

        self.assertEqual(sign.remote_jump(), "JUM/O-LONBA0100/4634CP/SU")

    @logger
    def test_class_airline_profile(self):
        """ Contain the component testing of class AirlineProfile. """
        profile = generic_lib.AirlineProfile("6X", "265332745", name=generic_lib.PaxName("PAYRE-FICOUT", "CORALIE"), rloc="2YETZ8")
        profile = generic_lib.AirlineProfile(airline_profile=profile)
        self.assertEqual(profile.airline, "6X")
        self.assertEqual(profile.ff_nb, "265332745")
        self.assertEqual(profile.name.last_name + "/" + profile.name.first_name, "PAYRE-FICOUT/CORALIE")
        self.assertEqual(profile.rloc, "2YETZ8")

        self.assertEqual(profile.book("FFU"), "FFU6X-265332745")
        self.assertEqual(profile.book("FQTV"), "FQTV6X-6X265332745")

        self.assertEqual(profile.pnr_format("FQTV", "QF"), "SSR FQTV QF HK1 6X265332745")

        self.assertEqual(profile.tty_format("FQTV", free_text="2", option=1), "SSR FQTV 6X HK/6X265332745.2-PAYRE-FICOUT/CORALIE")
        self.assertEqual(profile.tty_format("FQTV", free_text="2", option=2, air_segment=generic_lib.AirSegment("6X", "700", "C", "11JAN07", "ARN", "HEL")), "SSR FQTV 6X HK1 ARNHEL 0700C11JAN-1PAYRE-FICOUT/CORALIE.6X265332745/2")

    @logger
    def test_class_point_of_sale(self):
        """ Contain the component testing of class PointOfSale. """
        pos = generic_lib.PointOfSale("13EG", "27213082", "ATH", "1S", "T", "GR", "EUR")
        pos = generic_lib.PointOfSale(point_of_sale=pos)
        self.assertEqual(pos.pseudo_city_code, "13EG")
        self.assertEqual(pos.full_iata_nb, "27213082")
        self.assertEqual(pos.iata_nb, "2721308")
        self.assertEqual(pos.city_code, "ATH")
        self.assertEqual(pos.gds, "1S")
        self.assertEqual(pos.user_type, "T")
        self.assertEqual(pos.country, "GR")
        self.assertEqual(pos.currency, "EUR")

        self.assertEqual(pos.pnr_format(), "13EG/2721308")

        self.assertEqual(pos.tty_format(), "13EG/27213082/ATH/1S/T/GR/EUR")

        self.assertEqual(pos.aka_format(), "13EG/27213082")

        self.assertEqual(pos.his_format(), "13EG/27213082/ATH/1S/T/GR/EUR")

        self.assertEqual(pos.edi_format(), "1S+27213082:SABRE:13EG+ATH++T+GR:EUR")

    @logger
    def test_get_date(self):
        """ Contain the component testing of function get_date(). """
        # Non-format stuff
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DAY DD MONTH YYYY"), "THURSDAY 02 APRIL 2015") # Full
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DD-MMM-YY"), "02-APR-15") # Separator 1
        self.assertEqual(generic_lib.get_date("02-APR-15", input_format="DD-MMM-YY"), "02APR15") # Separator 2
        self.assertEqual(generic_lib.get_date("02APR15", output_format="D"), "4") # Thursday
        self.assertEqual(generic_lib.get_date("02APR15", offset=3, output_format="DDMMMYY"), "05APR15") # Offset
        self.assertEqual(generic_lib.get_date("02APR15", day="SATURDAY", output_format="DDMMMYY"), "04APR15") # Day 1
        self.assertEqual(generic_lib.get_date("02APR15", day="SAT", output_format="DDMMMYY"), "04APR15") # Day 2

        # Input format
        self.assertEqual(generic_lib.get_date("2015", input_format="YYYY", output_format="YYYY"), "2015")
        self.assertEqual(generic_lib.get_date("15", input_format="YY", output_format="YYYY"), "2015")

        self.assertEqual(generic_lib.get_date("APR", input_format="MMM", output_format="MMM"), "APR")
        self.assertEqual(generic_lib.get_date("04", input_format="MM", output_format="MMM"), "APR")
        self.assertEqual(generic_lib.get_date("4", input_format="mM", output_format="MMM"), "APR")
        self.assertEqual(generic_lib.get_date("APRIL", input_format="MONTH", output_format="MMM"), "APR")

        self.assertEqual(generic_lib.get_date("02", input_format="DD", output_format="DD"), "02")
        self.assertEqual(generic_lib.get_date("2", input_format="dD", output_format="DD"), "02")

        # Output format
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMMMYY"), "02APR15")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMMMYYYY"), "02APR2015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMMM"), "02APR")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMMYY"), "020415")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMMYYYY"), "02042015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMM"), "0204")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDmMYY"), "02415")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDmMYYYY"), "0242015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDmM"), "024")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMONTHYY"), "02APRIL15")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMONTHYYYY"), "02APRIL2015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDMONTH"), "02APRIL")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDYY"), "0215")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DDYYYY"), "022015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="DD"), "02")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMMMYY"), "2APR15")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMMMYYYY"), "2APR2015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMMM"), "2APR")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMMYY"), "20415")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMMYYYY"), "2042015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMM"), "204")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDmMYY"), "2415")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDmMYYYY"), "242015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDmM"), "24")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMONTHYY"), "2APRIL15")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMONTHYYYY"), "2APRIL2015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDMONTH"), "2APRIL")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDYY"), "215")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dDYYYY"), "22015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="dD"), "2")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="MMMYY"), "APR15")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="MMMYYYY"), "APR2015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="MMM"), "APR")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="MMYY"), "0415")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="MMYYYY"), "042015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="MM"), "04")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="mMYY"), "415")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="mMYYYY"), "42015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="mM"), "4")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="MONTHYY"), "APRIL15")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="MONTHYYYY"), "APRIL2015")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="MONTH"), "APRIL")

        self.assertEqual(generic_lib.get_date("02APR15", output_format="YY"), "15")
        self.assertEqual(generic_lib.get_date("02APR15", output_format="YYYY"), "2015")

    @logger
    def test_get_time(self):
        """ Contain the component testing of function get_time(). """
        # Non-format stuff
        self.assertEqual(generic_lib.get_time("030502", output_format="HH-MM-SS"), "03-05-02") # Separator 1
        self.assertEqual(generic_lib.get_time("03-05 02", input_format="HH-MM SS"), "030502") # Separator 2
        self.assertEqual(generic_lib.get_time("030502", offset=13, output_format="HHMMSS"), "031802") # Offset
        self.assertEqual(generic_lib.get_time("180502", output_format="HH_AP"), "06P") # AP 1
        self.assertEqual(generic_lib.get_time("030502", output_format="HH_AP"), "03A") # AP 2
        self.assertEqual(generic_lib.get_time("180502", output_format="HH_APM"), "06PM") # APM 1
        self.assertEqual(generic_lib.get_time("030502", output_format="HH_APM"), "03AM") # APM 2
        self.assertEqual(generic_lib.get_time("180502", output_format="HH_NOAP"), "06") # NOAP 1
        self.assertEqual(generic_lib.get_time("030502", output_format="HH_NOAP"), "03") # NOAP 2

        # Input format
        self.assertEqual(generic_lib.get_time("03", input_format="HH", output_format="HH"), "03")
        self.assertEqual(generic_lib.get_time("03", input_format="hH", output_format="HH"), "03")

        self.assertEqual(generic_lib.get_time("05", input_format="MM", output_format="MM"), "05")
        self.assertEqual(generic_lib.get_time("05", input_format="mM", output_format="MM"), "05")

        self.assertEqual(generic_lib.get_time("02", input_format="SS", output_format="SS"), "02")
        self.assertEqual(generic_lib.get_time("02", input_format="sS", output_format="SS"), "02")

        # Output format
        self.assertEqual(generic_lib.get_time("030502", output_format="hHMMSS"), "30502")
        self.assertEqual(generic_lib.get_time("030502", output_format="HHMMSS"), "030502")
        self.assertEqual(generic_lib.get_time("030502", output_format="MMSS"), "0502")

        self.assertEqual(generic_lib.get_time("030502", output_format="hHmMSS"), "3502")
        self.assertEqual(generic_lib.get_time("030502", output_format="HHmMSS"), "03502")
        self.assertEqual(generic_lib.get_time("030502", output_format="mMSS"), "502")

        self.assertEqual(generic_lib.get_time("030502", output_format="hHSS"), "302")
        self.assertEqual(generic_lib.get_time("030502", output_format="HHSS"), "0302")
        self.assertEqual(generic_lib.get_time("030502", output_format="HH"), "03")

        self.assertEqual(generic_lib.get_time("030502", output_format="hHMMsS"), "3052")
        self.assertEqual(generic_lib.get_time("030502", output_format="HHMMsS"), "03052")
        self.assertEqual(generic_lib.get_time("030502", output_format="MMsS"), "052")

        self.assertEqual(generic_lib.get_time("030502", output_format="hHmMsS"), "352")
        self.assertEqual(generic_lib.get_time("030502", output_format="HHmMsS"), "0352")
        self.assertEqual(generic_lib.get_time("030502", output_format="mMsS"), "52")

        self.assertEqual(generic_lib.get_time("030502", output_format="hHsS"), "32")
        self.assertEqual(generic_lib.get_time("030502", output_format="HHsS"), "032")
        self.assertEqual(generic_lib.get_time("030502", output_format="sS"), "2")

        self.assertEqual(generic_lib.get_time("030502", output_format="hHMM"), "305")
        self.assertEqual(generic_lib.get_time("030502", output_format="HHMM"), "0305")
        self.assertEqual(generic_lib.get_time("030502", output_format="MM"), "05")

        self.assertEqual(generic_lib.get_time("030502", output_format="hHmM"), "35")
        self.assertEqual(generic_lib.get_time("030502", output_format="HHmM"), "035")
        self.assertEqual(generic_lib.get_time("030502", output_format="mM"), "5")

        self.assertEqual(generic_lib.get_time("030502", output_format="hH"), "3")
        self.assertEqual(generic_lib.get_time("030502", output_format="HH"), "03")

    @logger
    def test_generate_rloc(self):
        """ Contain the component testing of function generate_rloc(). """
        print generic_lib.generate_rloc()
        print generic_lib.generate_rloc()
        print generic_lib.generate_rloc(5)
    #    self.assertRegex(generic_lib.generate_rloc(), "[A-Z1-9]{5,6}")

    @logger
    def test_generate_ticket_nb(self):
        """ Contain the component testing of function generate_ticket_nb(). """
        ticket_nb = generic_lib.generate_ticket_nb()
        self.assertEqual(len(ticket_nb), 11)
        self.assertEqual(str(int(ticket_nb[:-1])%7), ticket_nb[-1])

    @logger
    def test_convert_rloc(self):
        """ Contain the component testing of function convert_rloc(). """
        self.assertEqual(generic_lib.convert_rloc("5Y67VI"), "053406073118")
        self.assertEqual(generic_lib.convert_rloc("053406073118"), "5Y67VI")

    @logger
    def test_random_int(self):
        """ Contain the component testing of function random_int(). """
        print generic_lib.random_int(3)
        print generic_lib.random_int(3)
        print generic_lib.random_int(3)
        print generic_lib.random_int(3, 5)
        print generic_lib.random_int(3, 5)
        print generic_lib.random_int(3, 5)

    @logger
    def test_random_nb(self):
        """ Contain the component testing of function random_nb(). """
        print generic_lib.random_nb(3)
        print generic_lib.random_nb(3)
        print generic_lib.random_nb(3)
        print generic_lib.random_nb(3)
        print generic_lib.random_nb(3)

    @logger
    def test_random_alpha(self):
        """ Contain the component testing of function random_alpha(). """
        print generic_lib.random_alpha(3)
        print generic_lib.random_alpha(3)
        print generic_lib.random_alpha(3)
        print generic_lib.random_alpha(10, ["#", "!"])
        print generic_lib.random_alpha(10, "#!")

    @logger
    def test_random_str(self):
        """ Contain the component testing of function random_str(). """
        print generic_lib.random_str(10)
        print generic_lib.random_str(10)
        print generic_lib.random_str(10)
        print generic_lib.random_str(10, "KOR")
        print generic_lib.random_str(10, "KOR")
        print generic_lib.random_str(10, "KOR")
        print generic_lib.random_str(10, "HIR")
        print generic_lib.random_str(10, "KAT")
        print generic_lib.random_str(10, "JPN")

    @logger
    def test_convert_str(self):
        """ Contain the component testing of function convert_str(). """
        self.assertEqual(generic_lib.convert_str("KYA", formats="LAT_LAT"), "KYA")
        self.assertEqual(generic_lib.convert_str("룽", formats="KOR_LAT"), "RUNG")
        self.assertEqual(generic_lib.convert_str("RUNG", formats="LAT_KOR"), "룽")
        self.assertEqual(generic_lib.convert_str("サトウイチロウゴトトモヒアキラヒアキラヒアキラヒアキララヒアキ", formats="JPN_LAT"), "SATOUICHIROUGOTOTOMOHIAKIRAHIAKIRAHIAKIRAHIAKIRARAHIAKI")
        self.assertEqual(generic_lib.convert_str("ゴトウトモヒロサトウイチロウタナカアキ", formats="JPN_LAT"), "GOTOUTOMOHIROSATOUICHIROUTANAKAAKI")
        self.assertEqual(generic_lib.convert_str("ICHIROU", formats="LAT_JPN"), "イチロウ")

    @logger
    def test_retrieve(self):
        """ Contain the component testing of function retrieve(). """
        self.assertEqual(generic_lib.retrieve(generic_lib.AirSegment("BA", "1", "C", "12FEB23", "NCE", "CDG"), generic_lib.PaxName(last_name="PAYRE-FICOUT", first_name="CORALIE")), "RTBA1/12FEB-PAYRE-FICOUT")

    @logger
    def test_format_float(self):
        """ Contain the component testing of function format_float(). """
        self.assertEqual(generic_lib.format_float([12.3, 3.7], 1), "16.0")
        self.assertEqual(generic_lib.format_float(["12.3", "3.75", "100.12"], 1), "116.1")

    @logger
    def test_compare(self):
        """ Contain the component testing of function compare(). """
        self.assertEqual(generic_lib.compare(["12345678", "00000000"]), 1)
        self.assertEqual(generic_lib.compare(["12345678", "12345678", "12345678"]), 0)

    @inhibitor
    @logger
    def test_get_seat(self):
        """ Contain the component testing of function get_seat(). """
        self.assertEqual(generic_lib.get_seat("SM BA 0303/Y/06SEPCDGLHR/V                               /S001/\nSM BA  0303  Y 06SEP CDGLHR        319\n         A  B  C     D  E  F\nM  8 <   /  /  /     /  /  /  > 8  M\n         A  B  C     D  E  F\n         A  B  C     D  E  F\nM  9 <   /  /  /     /  /  /   > 9  M\n  10 <E  /  /  /     /  /  /  E> 10\n  11 <   /  /  /     /  /  /   > 11\n  12 <   .  .  .     H  .  .   > 12\n  13 <   .  .  .     H  .  .   > 13\n  14 <   .  .  .     H  .  .   > 14\n  15     .  .  .     H  .  .     15\n  16     .  .  .     H  .  .     16\n         A  B  C     D  E  F\n        A  B  C     D  E  F\n. AVAILABLE   <> WING     F GEN FACI   K GALLEY   E EXIT    C COT\n+ OCCUPIED    - LAST OFF  H HANDICAP   Q QUIET    G GROUPS  P PET\n/ RESTRICTED  B BULKHEAD  V PREF.SEAT  X BLOCKED  L LEGROOM U UMNR\n() SMOKING    D DEPORTEE  UP UP-DECK   Z NO FILM  I INFANT  R REAR\n)>", "."), "12A")

if __name__ == "__main__":
    unittest.main()
