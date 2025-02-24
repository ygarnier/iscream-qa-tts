"""
==== PDF Generic Library version 4.2.45 ===="

Classes module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""
#  path: \\blrstg01.blr.amadeus.net\LDrive\Cross-Projects\devsup\Images-NCE

import pnr_lib
import date_and_time_lib
import scripts_lib
# import settings_lib
import utilitaries_lib
import seat_lib
import pwd_lib
import re
import string
import os

class AirlineProfile(object):
    """Class describing a frequent flyer profile.

        :Non-keyword arguments:
            - airline -- airline owning the profile.
            - ff_nb -- frequent flyer number.

        :Keyword_arguments:
            - name -- name of the customer (default: random name)
            - airline_profile -- copy an AirlineProfile object.

        You can add any other argument you fancy.

        :Examples:

        >>> pr1 = generic_lib.AirlineProfile("6X", "265332745")

        >>> pr1_bis = generic_lib.AirlineProfile(pr1)

        >>> pr2 = generic_lib.AirlineProfile("6X", "265332745", name="HOLBROOK/KAREN")

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for an AirlineProfile."""
        if args != ():
            self.airline = args[0]
            self.ff_nb = args[1]
        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "airline_profile":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

        if not hasattr(self, "name"):
            self.name = PaxName(random_str(4), random_str(4))

    def __str__(self):
        return str(self.__dict__)

    def book(self, entry, airline=""):
        """Returns cryptic entry to book either the FFx or FQTx.

            :Examples:

            >>> pr1.book("FFU")
            6X-265332745

            >>> pr1.book("FQTV")
            FQTV6X-6X265332745

        """
        cryptic_entry = ""
        if airline == "":
            airline = self.airline
        if entry in ["FFU", "FFN", "FFA", "FFR"]:
            cryptic_entry += entry + self.airline + "-" + self.ff_nb
        elif entry in ["FQTV", "FQTU", "FQTR", "FQTS"]:
            cryptic_entry += entry + airline + "-" + self.airline + self.ff_nb
        return cryptic_entry

    def pnr_format(self, code, airline=""):
        """Returns cryptic entry to have the PNR display of the FQTx.

            :Example:

            >>> pr1.pnr_format("FQTU")
            SSR FQTU 6X HK1 6X265332745

        """
        if airline == "":
            airline = self.airline
        return "SSR " + code + " " + airline + " HK1 " + self.airline + self.ff_nb

    def tty_format(self, code, free_text="", option=1, airline="", air_segment="", status="HK"):
        """ Returns TTY display of the AirlineProfile.

        :Example:

        >>> pr1.tty_format("FQTV", free_text="2", option=1)
        SSR FQTV 6X HK/6X265332745.2-XYZJ/JTUP

        >>> pr1.tty_format("FQTV", free_text="2", option=2, air_segment=AirSegment("6X", "700", "C", "11JAN07", "ARN", "HEL"))
        SSR FQTV 6X HK1 ARNHEL 0700C11JAN-1XYZJ/JTUP.6X265332745/2
        """
        tty_seg = ""
        if airline == "":
            airline = self.airline
        if code in ["FQTU", "FQTV", "FQTR", "FQTS"]:
            if option == 1:
                status = status + "/"
                if free_text != "":
                    free_text = "." + free_text
                tty_seg += "SSR " + code + " " + airline + " " + status + self.airline + self.ff_nb + free_text + "-" + self.name.last_name + "/" + self.name.first_name
            elif option == 2 and isinstance(air_segment, AirSegment):
                status = status + "1"
                if free_text != "":
                    free_text = "/" + free_text
                tty_seg += "SSR " + code + " " + airline + " " + status + " " + air_segment.ssr_asso() + "-" + self.name.tty_format() + "." + self.airline + self.ff_nb + free_text

        return tty_seg


class PointOfSale(object):
    """Class describing a point of sale.

        :Non-keyword arguments:
            - pseudo_city_code -- pseudo city code of the POS.
            - full_iata_nb -- full iata number of the POS.
            - city_code -- city code of the POS.
            - gds -- GDS represented by the POS.
            - user_type -- user type of the POS.
            - country -- country of the POS.
            - currency -- currency in use.

        Following attribute is automatically defined:
            - iata_nb -- derived from full_iata_nb.

        :Keyword_argument:
            - point_of_sale -- copy a PointOfSale object.

        You can add any other argument you fancy.

        :Examples:

        >>> pos1 = generic_lib.PointOfSale("13EG", "27213082", "ATH", "1S", "T", "GR", "EUR")

        >>> pos1_bis = generic_lib.PointOfSale(pos1)

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for an AirlineProfile."""
        if args != ():
            self.pseudo_city_code = args[0]
            self.full_iata_nb = args[1]
            self.iata_nb = self.full_iata_nb[:-1]
            self.city_code = args[2]
            self.gds = args[3]
            self.user_type = args[4]
            self.country = args[5]
            self.currency = args[6]
        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "point_of_sale":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def __str__(self):
        return str(self.__dict__)

    def pnr_format(self):
        """Returns PNR display of the PoS.

            :Example:

            >>> pos1.pnr_format()
            13EG/2721308

        """
        return self.pseudo_city_code + "/" + self.iata_nb

    def tty_format(self):
        """Returns TTY display of the PoS.

            :Example:

            >>> pos1.tty_format()
            13EG/27213082/ATH/1S/T/GR/EUR

        """
        return "/".join([self.pseudo_city_code, self.full_iata_nb, self.city_code, self.gds, self.user_type, self.country, self.currency])

    def aka_format(self):
        """Returns AKA display of the PoS.

            :Example:

            >>> pos1.aka_format()
            13EG/27213082

        """
        return self.pseudo_city_code + "/" + self.full_iata_nb

    def his_format(self):
        """Returns history display of the PoS.

            :Example:

            >>> pos1.his_format()
            13EG/27213082/ATH/1S/T/GR/EUR

        """
        return self.tty_format() # Same format

    def edi_format(self):
        """Returns edifact display of the PoS.

            :Example:

            >>> pos1.edi_format()
            1S+27213082:SABRE:13EG+ATH++T+GR:EUR

        """
        gds_dict = {"1S":"SABRE", "1G":"GALILEO", "1B":"ABACUS", "1E":"TRAVELSKY", "1F":"1F1F", "1V":"APOREQ", "1J":"AXESS", "1P":"WORLDSPAN"}
        if self.gds in ["1G", "1V"]:
            return self.gds + ":SWI+" + self.full_iata_nb + ":" + gds_dict[self.gds] + ":" + self.pseudo_city_code + "+" + self.city_code + "+" + self.gds + "+" + self.user_type + "+" + self.country + ":" + self.currency
        else:
            return self.gds + "+" + self.full_iata_nb + ":" + gds_dict[self.gds] + ":" + self.pseudo_city_code + "+" + self.city_code + "++" + self.user_type + "+" + self.country + ":" + self.currency


class AgentSign(object):
    """Class describing an agent sign.

        :Non-keyword arguments:
            - office -- office of the agent..
            - sign -- sign of the agent.
            - duty_code -- duty code of the agent.
            - login_type -- define the login type. Default behavior is extended login.
                            Allowed values are jump (JMP) or remote (RMT)

        Following attributes are automatically defined:
            - city -- derived from office.
            - corporation -- derived from office.
            - qualifier -- derived from office.
            - office_nb -- derived from office.

        :Keyword_argument:
            - agent_sign -- copy a AgentSign object.

        You can add any other argument you fancy.

        :Examples:

        >>> log1 = generic_lib.AgentSign("LONBA0100", "8888AA", "SU")

        >>> log1_bis = generic_lib.AgentSign(log1)

        >>> log2 = generic_lib.AgentSign("6X", "265332745", name="HOLBROOK/KAREN")

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for an Agent Sign."""
        if args != ():
            self.office = args[0]
            self.city = self.office[:3]
            self.corporation = self.office[3:5]
            self.qualifier = self.office[5:6]
            self.office_nb = self.office[6:]
            self.sign = args[1]
            self.duty_code = args[2]
            try:
                self.login_type = args[3]
            except:
                self.login_type = ""
        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "agent_sign":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def __str__(self):
        return str(self.__dict__)

    def edi_format(self, message=""):
        """Defines a method to display an AgentSign in EDIFACT format.

            :Example:

            >>> log1.edi_format()
            00+:LONBA0100+++++0001AASU

        """
        if message != "":
            if message in ["IRBCDQ"]:
                return "00+:" + self.office + "+++++" + self.sign
            elif message in ["PSCREQ"]:
                return "00+:" + self.office + "+++++" + self.area_code + self.sign + self.duty_code
        return "00+:" + self.office + "+++++" + self.sign + self.duty_code

    def extended_sign(self, work_area):
        """Defines a method to perform an extended sign-in.

            :Example:

            >>> log1.extended_sign()
            JIA0001AA/SU.LONBA0100

        """

        if self.office == "":
            extended_sign = "JI" + work_area + self.sign + "/" + self.duty_code
        else:
            extended_sign = "JI" + work_area + self.sign + "/" + self.duty_code + "." + self.office

        if hasattr(self, "password"):
            extended_sign += "-" + getattr(self, "password")
        return extended_sign

    def remote_sign(self):
        """Defines a method to perform a remote sign-in.

            :Example:

            >>> log1.remote_sign()
            JUI/O-LONBA0100/JI0001AA/SU

        """
        remote_sign = "JUI/O-" + self.office + "/JI" + self.sign + "/" + self.duty_code
        if hasattr(self, "password"):
            remote_sign += "-" + getattr(self, "password")
        return remote_sign
    
    def remote_jump(self):
        """Defines a method to perform a remote jump.

            :Example:

            >>> log1.remote_jump()
            JUM/O-LONBA0100/0001AA/SU

        """
        remote_jump = "JUM/O-" + self.office + "/" + self.sign + "/" + self.duty_code
        if hasattr(self, "password"):
            remote_jump += "-" + getattr(self, "password")
        return remote_jump
    
    def sign_out_jump(self):
        """Defines a method to perform a sign out from a remote jump
        
            :Example:

            >>> log1.sign_out_jump()
            JO
            JUO
            <11,29>password
        """
        
        jmp_list = ["JUO"]
        if hasattr(self, "password"):
            jmp_pwd = "<11,29>" + getattr(self, "password")
            jmp_list.append(jmp_pwd)
        
        jmp_list.append("JO")
        jmp_list_iterator = iter(jmp_list)
        return jmp_list_iterator
    
    
    def sign_out_aidl(self):
        """Defines a method to perform a sign out from an AIDL office
        
            :Example:

            >>> log1.sign_out_aidl()
            JO
            JO
        """
        
        aidl_list = ["JO", "JO"]
        aidl_list_iterator = iter(aidl_list)
        return aidl_list_iterator
    
    def aidl_sign(self):
        """Defines a method to perform a login in an AIDL office.

            :Example:

            >>> log1.aidl_sign()
            JQ0103FR/SU.ALAPS2301
            <11,29>password

        """
        aidl_list = ["JQ" + self.sign + "/" + self.duty_code + "." + self.office]
        if hasattr(self, "password"):
            aidl_pwd = "<11,29>" + getattr(self, "password")
            aidl_list.append(aidl_pwd)
        aidl_list_iterator = iter(aidl_list)
        return aidl_list_iterator

    def sign_in(self, work_area=""):
        """
            This function calls the right login method using the login_type parameter defined during the declaration of AgentSign object
            
            :Example:
            
            >>> log1 = generic_lib.AgentSign("LONBA0100", "0001AA", "SU") --> extended sign
            >>> log1.sign_in()
            JIA0001AA/SU.LONBA0100
            >>> log1.sign_in(work_area="B")
            JIB0001AA/SU.LONBA0100
            
            >>> log2 = generic_lib.AgentSign("LONBA0100", "0001AA", "SU", "JMP") --> remote jump
            >>> log2.sign_in()
            JUM/O-LONBA0100/0001AA/SU
            
            >>> log3 = generic_lib.AgentSign("LONBA0100", "0001AA", "SU", "RMT") --> remote sign
            >>> log3.sign_in()
            JUI/O-LONBA0100/JI0001AA/SU
            
            >>> log4 = generic_lib.AgentSign("ALAPS2301", "0103FR", "SU", "AIDL") --> AIDL sign
            >>> log4_cmd_list = log4.sign_in()
            >>> {=log4_cmd_list.next()}
            >>> ''Response:
            >>> ''{.*}SIGN COMPLETE{.*}
            >>> ''Nomatch: TTServer.currentMessage.loop(0, 1, 0)
            JQ0103FR/SU.ALAPS2301
            <11,29>password
            
            >>>To login using a password, add the parameter "password during the declaration of AgentSign object"
            >>> log1 = generic_lib.AgentSign("LON6X0100", "0009NR", "SU", "RMT", password="XXXXXX")
        """
        if self.login_type == "JMP":
            login = self.remote_jump()
        elif self.login_type == "RMT":
            login = self.remote_sign()
        elif self.login_type == "AIDL":
            login = self.aidl_sign()
        else:
            login = self.extended_sign(work_area)
            
        if self.login_type == "AIDL":
            return login

        return str(login)
    
    def sign_out(self):
        """
            This function calls the right logout method using the login_type parameter defined during the declaration of AgentSign object
            
            :Example:
            
            >>> log2 = generic_lib.AgentSign("LONBA0100", "0001AA", "SU", "JMP") --> remote jump
            >>> log2_cmd_list = log2.sign_out()
            >>> {=log2_cmd_list.next()}
            >>> ''Response:
            >>> ''{.*}A                       {*}             NOT SIGNED{.*}
            >>> ''Nomatch: TTServer.currentMessage.loop(0, 3, 0)
            JUO
            <11,29>password
            JO
            
            >>> log4 = generic_lib.AgentSign("ALAPS2301", "0103FR", "SU", "AIDL") --> AIDL sign
            >>> log4_cmd_list = log4.sign_out()
            >>> {=log4_cmd_list.next()}
            >>> ''Response:
            >>> ''{.*}A                       {*}             NOT SIGNED{.*}
            >>> ''Nomatch: TTServer.currentMessage.loop(0, 3, 0)
            JO
            JO
        """
        if self.login_type == "JMP":
            logout = self.sign_out_jump()
        elif self.login_type == "AIDL":
            logout = self.sign_out_aidl()    

        return logout

class PaxName(object):
    """Class describing a passenger's name.

        :Non-keyword arguments:
            - last_name -- last name of the passenger (default: random name -  if only 1 character provided, random name starting with this character).
            - first_name -- first name of the passenger (default: random name -  if only 1 character provided, random name starting with this character).

        :Keyword_argument:
            - pax_name -- copy a PaxName object.

        You can add any other argument you fancy.

        :Examples:

        >>> pax1 = generic_lib.PaxName()

        >>> pax1_bis = generic_lib.PaxName(pax1)

        >>> pax2 = generic_lib.PaxName("A", "WILLY")
        
        >>> pax3 = generic_lib.PaxName(last_name = "A")
            It creates a pax name starting with A as lastname

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a passenger name."""
        self.language = "LAT"
        if len(args) == 1:
            self.last_name = args[0]
        elif len(args) == 2:
            self.last_name = args[0]
            self.first_name = args[1]
        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "pax_name":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

        if not hasattr(self, "last_name"):
            self.last_name = random_str(4, self.language)
        elif len(self.last_name) == 1 and self.last_name.isalpha():
            self.last_name = self.last_name + random_str(3, self.language)
        if not hasattr(self, "first_name"):
            self.first_name = random_str(4, self.language)
        elif len(self.first_name) == 1 and self.first_name.isalpha():
            self.first_name = self.first_name + random_str(3, self.language)
        self.rom_last_name = convert_str(self.last_name, self.language + "_LAT", "LASTNAME")
        self.rom_first_name = convert_str(self.first_name, self.language + "_LAT", "FIRSTNAME")

    def __str__(self):
        return str(self.__dict__)

    def book(self):
        """Returns cryptic entry to book a PaxName.

            :Example:

            >>> p1.book()
            NM1NBFGSDIK/OPKJPK

        """
        return "NM1" + self.last_name + "/" + self.first_name

    def xml_format(self, object_key=1, language="LAT"):
        """Defines a method to display a PaxName in XML format.

            :Example:

            >>> p1.xml_format(2)
            <Traveler><RecognizedTraveler ObjectKey="PAX2"><PTC Quantity="1">ADT</PTC><Name><Surname>NBFGSDIK</Surname><Given>OPKJPK</Given></Name></RecognizedTraveler></Traveler>

        """
        xml_seg = "<Traveler><RecognizedTraveler ObjectKey=\"PAX" + str(object_key) + "\"><PTC Quantity=\"1\">"
        if hasattr(self, "ptc"):
            xml_seg += getattr(self, "ptc")
        else:
            xml_seg += "ADT"
        if language == "LAT":
            return xml_seg + "</PTC><Name><Surname>" + self.rom_last_name + "</Surname><Given>" + self.rom_first_name + "</Given></Name></RecognizedTraveler></Traveler>"
        else:
            return xml_seg + "</PTC><Name><Surname>" + self.last_name + "</Surname><Given>" + self.first_name + "</Given></Name></RecognizedTraveler></Traveler>"

    def edi_format(self, language="LAT"):
        """Defines a method to display a PaxName in EDIFACT format.

            :Example:

            >>> p1.edi_format()
            NBFGSDIK::1+OPKJPK

        """
        if language == "LAT":
            return self.rom_last_name + "::1+" + self.rom_first_name
        else:
            return self.last_name + "::1+" + self.first_name

    def pnr_format(self, language="LAT"):
        """Defines a method to display a PaxName in PNR format.

            :Example:

            >>> p1.pnr_format()
            NBFGSDIK/OPKJPK

        """
        if language == "LAT":
            return self.rom_last_name + "/" + self.rom_first_name
        else:
            return self.last_name + "/" + self.first_name

    def tty_format(self, language="LAT"):
        """Defines a method to display a PaxName in TTY format.

            :Example:

            >>> p1.tty_format()
            1NBFGSDIK/OPKJPK

        """
        return "1" + self.pnr_format(language)

    def his_format(self, language="LAT"):
        """Defines a method to display a PaxName in history format.

            :Example:

            >>> p1.his_format()
            NBFGSDIK/OPKJPK

        """
        return self.pnr_format(language) # Same format

    def ssr_asso(self, language="LAT"):
        """Defines a method to return the passenger association as expected in a SSR.

            :Example:

            >>> p1.ssr_asso()
            1NBFGSDIK/OPKJPK

        """
        return "1" + self.pnr_format(language)


class PaxCluster(object):
    """Class describing a cluster of passengers.

        :Non-keyword argument:
            - nb_of_pax -- number of passengers in the cluster.

        :Keyword_arguments:
            - pax_cluster -- copy a PaxCluster object.
            - last_name -- last name of the passenger (default: random name -  if only 1 character provided, random name starting with this character).
            - list_of_first_names -- list of first names of the passengers.

        You can add any other argument you fancy.

        :Examples:

        >>> pc1 = generic_lib.PaxCluster(3, last_name="SIMPSON", list_of_first_names=["BART", "LISA"])

        >>> pc1_bis = generic_lib.PaxCluster(pc1)

        >>> pc2 = generic_lib.PaxCluster(2, last_name="B")

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a cluster of passengers."""
        if args != ():
            self.nb_of_pax = args[0]
        self.language = "LAT"
        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "pax_cluster":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

        if not hasattr(self, "last_name"):
            self.last_name = random_str(4, self.language)
        elif len(self.last_name) == 1 and self.last_name.isalpha():
            self.last_name = self.last_name + random_str(3, self.language)
        if not hasattr(self, "list_of_first_names"):
            self.list_of_first_names = [random_str(4, self.language) for _ in range(self.nb_of_pax)]
        elif len(self.list_of_first_names) < self.nb_of_pax:
            self.list_of_first_names = [random_str(4, self.language) for _ in range(self.nb_of_pax-len(self.list_of_first_names))]

    def __str__(self):
        return str(self.__dict__)

    def book(self):
        """Returns cryptic entry to book a PaxCluster.

            :Example:

            >>> pc2.book()
            NM3SIMPSON/BART/LISA/OIJG

        """
        return "NM" + str(self.nb_of_pax) + self.last_name + "/" + "/".join(self.list_of_first_names)

    def retrieve_pax(self, pax_nb):
        """Defines a method which returns a specific passenger as a PaxName.

            :Example:

            >>> pc2.retrieve_pax(2) returns PaxName("SIMPSON", "LISA")

        """
        return PaxName(last_name=self.last_name, first_name=self.list_of_first_names[pax_nb - 1])

    def extract_pax(self, pax_nb):
        """Defines a method which returns a specific passenger as a string. A negative pax_nb will return only corresponding first name.

            :Examples:

            >>> pc2.extract_pax(1)
            SIMPSON/BART

            >>> pc2.extract_pax(-2)
            LISA

        """
        if pax_nb < 0:
            return self.list_of_first_names[-1 - pax_nb]
        elif pax_nb == 0:
            return self.last_name
        else:
            return self.last_name + "/" + self.list_of_first_names[pax_nb - 1]

    def get_pax_list(self):
        """Defines a method which returns passengers as a list of PaxName.

            :Example:

            >>> pc2.get_pax_list() returns [PaxName("SIMPSON", "BART"), PaxName("SIMPSON", "LISA"), PaxName("SIMPSON", "OIJG")]

        """
        return [PaxName(self.last_name, self.list_of_first_names[index]) for index in range(self.nb_of_pax)]

    def tty_format(self):
        """Defines a method to display a PaxCluster in TTY format.

            :Example:

            >>> pc2.tty_format()
            3SIMPSON/BART/LISA/OIJG

        """
        return str(self.nb_of_pax) + self.last_name + "/" + "/".join(self.list_of_first_names)

    def pnr_format(self):
        """Defines a method to display a PaxCluster in PNR format.

            :Example:

            >>> pc2.pnr_format()
            3SIMPSON/BART/LISA/OIJG

        """
        return str(self.nb_of_pax) + self.last_name + "/" + "/".join(self.list_of_first_names)

    def his_format(self):
        """Defines a method to display a PaxCluster in history format.

            :Example:

            >>> pc2.his_format()
            SIMPSON/BART SIMPSON/LISA SIMPSON/OIJG

        """
        return " ".join([self.last_name + "/" + first_name for first_name in self.list_of_first_names])

    def ssr_asso(self):
        """Defines a method to return the passenger association as expected in a SSR.

            :Example:

            >>> pc2.ssr_asso()
            3SIMPSON/BART/LISA/OIJG

        """
        return self.book() # Same format
    

class Pnr(object):
    """ Defines a class describing a PNR.
    Example::

    - pnr1 = generic_lib.Pnr(PaxName('SIMPSON', 'HOMER'), \
             PaxName('SIMPSON', 'MARGE'), PaxName('SIMPSON', 'BART')], \
             [generic_lib.AirSegment('AF', '29', 'S', \
             '10MAY07', 'NCE', 'CDG', '', '', 'BA', '143', 'S'), ])

    """
    def __init__(self, pax_list=None, seg_list=None):
        """ Defines default attributes for an air segment """
        if isinstance(pax_list, Pnr):
            # Copy of a ContactElt
            self.pax_list = list(pax_list.pax_list)
            self.seg_list = list(pax_list.seg_list)
        else:
            if pax_list is None:
                pax_list = []
            self.pax_list = pax_list
            if seg_list is None:
                seg_list = []
            self.seg_list = seg_list
            # Add AP and TK element if not provided
            contact_elt_found = 0
            ticket_elt_found = 0
            for seg in seg_list:
                if isinstance(seg, ContactElt):
                    contact_elt_found = 1
                elif isinstance(seg, str) and seg.startswith('TK'):
                    ticket_elt_found = 1
            if contact_elt_found == 0:
                self.seg_list.append(ContactElt())
            if ticket_elt_found == 0:
                self.seg_list.append('TKOK')

    def __str__(self):
        return str(self.pax_list) + str(self.seg_list)


class Group(object):
    """Class describing a group of passengers.

        :Non-keyword argument:
            - nb_of_pax -- number of passengers in the group.

        :Keyword_arguments:
            - group -- copy a Group object.
            - group_name -- last name of the passenger (default: random name -  if only 1 character provided, random name starting with this character).
            - list_of_individual_pax -- list of PaxName objects.

        You can add any other argument you fancy.

        :Examples:

        >>> grp1 = generic_lib.Group(5, group_name="SIMPSONS FAMILY", list_of_individual_pax=[PaxName("SIMPSON", "HOMER"), PaxName("SIMPSON", "MARGE"), PaxName("SIMPSON", "BART")])

        >>> grp1_bis = generic_lib.Group(grp1)

        >>> grp2 = generic_lib.Group(8, group_name="B")

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a cluster of passengers."""
        if args != ():
            self.nb_of_pax = args[0]
        self.language = "LAT"
        self.list_of_individual_pax = []
        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "group":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

        if not hasattr(self, "group_name"):
            self.group_name = random_str(4, self.language)
        elif len(self.group_name) == 1 and self.group_name.isalpha():
            self.group_name = self.group_name + random_str(3, self.language)

    def __str__(self):
        return str(self.__dict__)

    def book(self):
        """Returns cryptic entry to book a Group.

            :Example:

            >>> g2.book()
            NG3SIMPSON;NM1SIMPSON/HOMER;NM1SIMPSON/MARGE;NM1SIMPSON/BART

        """
        seg = str(self.nb_of_pax) + self.group_name
        if len(self.list_of_individual_pax) > 0:
            seg += ";" + ";".join([individual_pax.book() for individual_pax in self.list_of_individual_pax])
        return "NG" + seg

    def add_pax(self, pax):
        """Defines a method to add an individual passenger to the group.

            :Example:

            >>> g2.add_pax(PaxName("SIMPSON", "LISA"))

        """
        if isinstance(pax, PaxName):
            self.list_of_individual_pax.append(pax)
        elif isinstance(pax, PaxCluster):
            self.list_of_individual_pax.extend([pax.extract_pax(index) for index in range(pax.nb_of_pax)])

    def remove_pax(self, pax_nb):
        """Defines a method to remove an individual passenger from the group.

            :Example:

            >>> g2.remove_pax(2)

        """
        self.list_of_individual_pax.pop(pax_nb-1)

    def retrieve_pax(self, pax_nb):
        """Defines a method which returns a specific passenger as a PaxName.

            :Example:

            >>> g2.retrieve_pax(2) returns PaxName("SIMPSON", "MARGE")

        """
        return PaxName(last_name=self.list_of_individual_pax[pax_nb - 1].last_name, first_name=self.list_of_individual_pax[pax_nb - 1].first_name)

    def extract_pax(self, pax_nb):
        """Defines a method which returns a specific passenger as a string. A negative pax_nb will return only corresponding first name.

            :Examples:

            >>> g2.extract_pax(1)
            SIMPSON/HOMER

            >>> g2.extract_pax(-4)
            LISA

        """
        if pax_nb < 0:
            return self.list_of_individual_pax[-1 - pax_nb].first_name
        elif pax_nb == 0:
            return self.group_name
        else:
            return self.list_of_individual_pax[pax_nb - 1].last_name + "/" + self.list_of_individual_pax[pax_nb - 1].first_name

    def tty_format(self):
        """Defines a method to display a Group in TTY format.

            :Example:

            >>> g2.tty_format()
            3SIMPSON

        """
        return str(len(self.list_of_individual_pax)) + self.group_name

    def pnr_format(self):
        """Defines a method to display a Group in PNR format.

            :Example:

            >>> g2.pnr_format()
            3SIMPSON

        """
        return "0." + str(self.nb_of_pax - len(self.list_of_individual_pax)).rjust(3, " ") + self.group_name + "  NM: " + str(len(self.list_of_individual_pax))

    def his_format(self):
        """Defines a method to display a Group in history format.

            :Example:

            >>> g2.his_format()
            03SIMPSON

        """
        return str(self.nb_of_pax).rjust(2, "0") + self.group_name


class Aircraft(object):
    """Class describing an aircraft.

        :Non-keyword arguments:
            - airline -- owning airline
            - acv -- Airline Configuration Version
            - equipment -- type of equipment
            - saleable_config -- dictionnary of possible saleable configurations

            : Examples:

            >>> aircraft_1 = generic_lib.AirCraft("AF", "2M6", "320", {"A02":"C8Y162"})

    """
    
    def __init__(self, *args, **kwargs):
        """Defines default attributes for an Aircraft."""
        if args != ():
            self.airline = args[0]
            self.acv = args[1]
            self.equipment = args[2] 
            self.saleable_config = args[3]

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "aircraft":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def get_edi_config(self, config):
        edi_config = ""
        for alpha in config:
            if alpha.isdigit():
                edi_config += alpha
            else:
                edi_config += "+" + alpha + ":"
        return edi_config

    def create_acv(self, message="SACVCQ"):
        """Returns EDIFACT content to create an Aircraft Configuration Version (ACV) for the aircraft."""
        saleable_code = self.saleable_config.keys()[0]
        edi_config = self.get_edi_config(self.saleable_config[saleable_code])
        eqi_seg = "EQI" + edi_config + "+"*(6-edi_config.count("+")) + self.equipment + "+1:XXX:" + self.airline + " FOR " + self.airline + ":" + self.acv + "+DO NOT MODIFY - automatic creation for seating tests'"
        eqd_seg = "EQD" + edi_config + "+"*(6-edi_config.count("+")) + saleable_code + "++DO NOT MODIFY - automatic creation for seating tests'"
        return eqi_seg + "SDT+DEF'" + eqd_seg

    def create_master_seatmap(self, compartment_details, master_seatmap, message="SMSTUQ"):
        """Returns EDIFACT content to create a master seat map for the aircraft."""
        saleable_code = self.saleable_config.keys()[0]
        edi_config = self.get_edi_config(self.saleable_config[saleable_code])
        eqi_seg = "EQI" + edi_config + "+"*(6-edi_config.count("+")) + self.equipment + "+1::" + self.airline + " FOR " + self.airline + ":" + self.acv + "+DO NOT MODIFY - automatic creation for seating tests'"
        return "IRV++++:0:0:0'TVL'" + eqi_seg + compartment_details + master_seatmap

    def create_saleable_config(self, master_seatmap, message="SSMTUQ"):
        """Returns EDIFACT content to create a saleable configuration for the aircraft."""
        for _ in range(len(master_seatmap.split("'"))):
            for letter in string.uppercase:
                seatmap_expr = re.match("(.*)\+" + letter + "([\d\w:]*)(.*)", master_seatmap)
                if seatmap_expr is not None:
                    master_seatmap = master_seatmap.replace(seatmap_expr.group(2),":::VER0:12")         
            for number in range(10):
                seatmap_expr = re.match("(.*)(\+" + str(number) + ":[\d\w:]*)(.*)", master_seatmap)
                if seatmap_expr is not None:
                    master_seatmap = master_seatmap.replace(seatmap_expr.group(2),"")   

        return "IRV++++:0:0:0'TVL'EQI+++++++:XXX:" + self.airline + ":" + self.acv + "'" + master_seatmap


class AirSegment(object):
    """Class describing an air segment.

        :Non-keyword arguments:
            - airline -- airline marketing the flight.
            - flight_nb -- flight number of the flight.
            - _class -- class of service.
            - date -- date of the flight (format should be DDMMMYY).
            - board_pt -- departure point of the flight.
            - off_pt -- arrival point of the flight.

        :Keyword_arguments:
            - air_segment -- copy an AirSegment object.
            - dep_time -- departure time of the flight.
            - arr_time -- arrival time of the flight.

        Following attributes are automatically defined:
            - full_flight_nb -- 4-digits flight number, derived from flight_nb
            - tty_dep_date -- ex: 10MAY, derived from dep_date.
            - edi_dep_date -- ex: 100607, derived from dep_date.
            - xml_dep_date -- ex: 2007-06-10, derived from dep_date.
            - wbs_dep_date -- ex: 10052007, derived from dep_date.
            - full_dep_date -- ex: 10MAY2007, derived from dep_date.
            - dep_day -- ex: 10, derived from dep_date.
            - dep_month -- ex: MAY, derived from dep_date.
            - num_dep_month -- ex: 06, derived from dep_date.
            - full_dep_month -- ex: MAY, derived from dep_date.
            - dep_year -- ex: 07, derived from dep_date.
            - full_dep_year - ex: 2007, derived from dep_date.

        The same attributes are also defined for arrival date (change dep_xxx into arr_xxx) and normal date (change dep_xxx or arr_xxx into xxx).

        You can add any other argument you fancy.

        :Examples:

        >>> air1 = generic_lib.AirSegment("AF", "29", "S", "10MAY07", "NCE", "CDG")

        >>> air1_bis = generic_lib.AirSegment(air1, ope_airline="BA", ope_flight_nb="123", ope_class="C")

    """
    def __init__(self, *args, **kwargs):
        """Defines default attributes for an AirSegment."""
        if args != ():
            self.airline = args[0]
            self.flight_nb = args[1]
            self.full_flight_nb = str(self.flight_nb).rjust(4, "0")
            self._class = args[2]
            self.date = args[3]
            define_dates(self, "date")
            self.board_pt = args[4]
            self.off_pt = args[5]

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "air_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            elif arg == "date":
                setattr(self, arg, val)
                define_dates(self, "date")
            # Fill other attributes
            else:
                setattr(self, arg, val)

        if not hasattr(self, "ope_airline"):
            setattr(self, "ope_airline", self.airline)
        if not hasattr(self, "dep_date"):
            setattr(self, "dep_date", self.date)
        if not hasattr(self, "arr_date"):
            setattr(self, "arr_date", self.date)
        define_dates(self, "dep_date")
        define_dates(self, "arr_date")

    def book(self, nip):
        """Returns cryptic entry to book an AirSegment.

            :Example:

            >>> air1.book(4)
            SSAF29S10MAYNCECDG4

        """
        return "SS" + self.airline + self.flight_nb + self._class + getattr(self, "tty_date") + self. board_pt + self.off_pt + str(nip)

    def __str__(self):
        return str(self.__dict__)

    def xml_format(self, seg_key=1, requested_class="ALL", xml_msg=""):
        """Defines a method to display an AirSegment in XML format.

            :Example:

            >>> air1.xml_format()
            <FlightSegment SegmentKey="SEG1"><Departure><AirportCode>NCE</AirportCode><Date>2007-06-07</Date></Departure><Arrival><AirportCode>CDG</AirportCode></Arrival>
            <MarketingCarrier><AirlineID>AF</AirlineID><FlightNumber>29</FlightNumber><ResBookDesigCode>Y</ResBookDesigCode></MarketingCarrier><ClassOfService><Code>S</Code></ClassOfService></FlightSegment>

        """
        xml_seg = "<FlightSegment SegmentKey=\"SEG" + str(seg_key) + "\"><Departure><AirportCode>" + self.board_pt + "</AirportCode><Date>" + self.xml_dep_date + "</Date></Departure><Arrival><AirportCode>"
        xml_seg += self.off_pt + "</AirportCode></Arrival><MarketingCarrier><AirlineID>" + self.airline + "</AirlineID><FlightNumber>" + self.flight_nb + "</FlightNumber>"
        if requested_class != "ALL":
            xml_seg += "<ResBookDesigCode>" + requested_class + "</ResBookDesigCode></MarketingCarrier><ClassOfService><Code>" + self._class + "</Code></ClassOfService>"
        else:
            xml_seg += "</MarketingCarrier>"
        xml_seg += "</FlightSegment>"

        return xml_seg

    def edi_format(self, edi_msg=""):
        """Defines a method to display an AirSegment in EDIFACT format.

            :Example:

            >>> air1.edi_format()
            100607:100607+NCE+CDG+AF+029:S

        """
        edi_seg = getattr(self, "edi_dep_date")
        if edi_msg not in ["SMPREQ", "SPAXAQ"] and edi_msg !="":
            if hasattr(self, "dep_time"):
                edi_seg += ":" + getattr(self, "dep_time")
            edi_seg += ":" + getattr(self, "edi_arr_date")
            if hasattr(self, "arr_time"):
                edi_seg += ":" + getattr(self, "arr_time")
        edi_seg += "+" + self.board_pt + "+" + self.off_pt + "+" + self.airline
        if edi_msg.upper() == "PASBCQ":
            edi_seg += "+" + self.flight_nb.rjust(2, "0")
        else:
            edi_seg += "+" + self.flight_nb.rjust(3, "0")
        edi_seg += ":" + self._class
        return edi_seg

    def tty_format(self, status, cs_option=0, timings="YES"):
        """Defines a method to display an AirSegment in TTY format depending on codeshare option.

            :Examples:

            >>> air1.tty_format("HK1", 0)
            AF029S10MAY NCECDG HK1

            >>> air1.tty_format("US3", 1)
            BA143S10MAY NCECDG US3-AF029S

        """
        if (cs_option == 0) or (cs_option == 2):
            tty_seg = self.airline + self.flight_nb.rjust(3, "0") + self._class + getattr(self, "tty_date") + " " + self.board_pt + self.off_pt + " " + status
            if (timings.upper() == "YES") and hasattr(self, "dep_time") and hasattr(self, "arr_time"):
                tty_seg += "/" + getattr(self, "dep_time") + " " + getattr(self, "arr_time")
        elif (cs_option == 1) or (cs_option == 3) or (cs_option == 4) or (cs_option == 5):
            tty_seg = getattr(self, "ope_airline") + getattr(self, "ope_flight_nb").rjust(3, "0") + getattr(self, "ope_class")
            if cs_option == 4:
                tty_seg += "/" + self.airline + self.flight_nb.rjust(3, "0") + self._class
            tty_seg += getattr(self, "tty_date") + " " + self.board_pt + self.off_pt + " " + status
            if (timings.upper() == "YES") and hasattr(self, "dep_time") and hasattr(self, "arr_time"):
                tty_seg += "/" + getattr(self, "dep_time") + " " + getattr(self, "arr_time")
        if (timings.upper() == "YES") and (getattr(self, "arr_date") != getattr(self, "dep_date")) and hasattr(self, "dep_time") and hasattr(self, "arr_time"):
            tty_seg += "+1"
        if (cs_option == 1) or (cs_option == 5):
            tty_seg += "-" + self.airline + self.flight_nb.rjust(3, "0") + self._class
        return tty_seg

    def pnr_format(self, status=""):
        """Defines a method to display an AirSegment in PNR format.

            :Example:

            >>> air1.pnr_format("NN1")
            AF 029 S 10MAY 6 NCECDG NN1

        """
        return self.airline + self.flight_nb.rjust(3, "0").rjust(4, " ") + " " + self._class + " " + getattr(self, "tty_date") + " " + get_date(self.date, "DDMMMYY", "D") + " " + self.board_pt + self.off_pt + " " + status

    def his_format(self, status=""):
        """Defines a method to display an AirSegment in PNR format.

            :Example:

            >>> air1.his_format("HK1")
            AF 029 S 10MAY 6 NCECDG HK1

        """
        return self.pnr_format(status) # Same format

    def ssr_asso(self):
        """Defines a method to return the segment association as expected in a SSR.

            :Example:

            >>> air1.ssr_asso()
            NCECDG 0029S10MAY

        """
        return self.board_pt + self.off_pt + " " + self.full_flight_nb + self._class + getattr(self, "tty_date")

    def get_seat_map(self):
        """Defines a method to return an AirSegment in the right format for a seat map query.

            :Example:

            >>> air1.get_seat_map()
            AF29/S/10MAYNCECDG

        """
        return self.airline + self.flight_nb + "/" + self._class + "/" + getattr(self, "tty_date") + self.board_pt + self.off_pt


    def pnr_format_marriage(self, status=''):
        """ Defines a method to display an AirSegment in PNR format

            :Example:

            >> air1.pnr_format_marriage('NN1')
            AF 029 S 10MAY 6*NCECDG NN1

        """
        return self.airline + pad(pad(self.flight_nb, 3, '0'), 4, ' ') + ' ' + self._class + ' ' + getattr(self, "tty_dep_date") + ' '\
                + get_date(self.date, 'DDMMMYY', 'D') + '*' + self.board_pt + self.off_pt + ' ' + status

class HhlSegment(object):
    """Class describing a hotel segment.

        :Non-keyword arguments:
            - provider -- hotel provider.
            - _property -- property code of the hotel.
            - start_date -- date of check-in (format should be DDMMMYY).
            - end_date -- date of check-out (format should be DDMMMYY).

        :Keyword_arguments:
            - hhl_segment -- copy a HhlSegment object.
            - city -- city of the hotel, derived from _property.
            - code -- code of the hotel, derived from _property.

        Following attributes are automatically defined:
            - tty_start_date -- ex: 10MAY, derived from start_date.
            - edi_start_date -- ex: 100607, derived from start_date.
            - full_start_date -- ex: 10MAY2007, derived from start_date.
            - start_day -- ex: 10, derived from start_date.
            - start_month -- ex: MAY, derived from start_date.
            - num_start_month -- ex: 06, derived from start_date.
            - full_start_month -- ex: MAY, derived from start_date.
            - start_year -- ex: 07, derived from start_date.
            - full_start_year - ex: 2007, derived from start_date.

        The same attributes are also defined for end date (change start_xxx into end_xxx).

        You can add any other argument you fancy.

        :Examples:

        >>> hhl1 = generic_lib.HhlSegment("HI", "PAR999", "10MAY07", "11MAY14")

        >>> hhl1_bis = generic_lib.HhlSegment(hhl1)

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for an HtlSegment."""
        if args != ():
            self.provider = args[0]
            self._property = args[1]
            self.city = self._property[:3]
            self.code = self._property[3:]
            self.start_date = args[2]
            define_dates(self, "start_date")
            self.end_date = args[3]
            define_dates(self, "end_date")

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "hhl_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def book(self):
        """Returns cryptic entry to book an HtlSegment.

            :Example:

            >>> hhl1.book()
            HIPAR99910MAY-11MAY

        """
        booking_entry = self.provider + self._property + getattr(self, "tty_start_date")
        if hasattr(self, "tty_start_date") and hasattr(self, "tty_end_date"):
            booking_entry += "-" + getattr(self, "tty_end_date")
        return booking_entry

    def __str__(self):
        return str(self.__dict__)

    def edi_format(self):
        """Defines a method to display a HtlSegment in EDIFACT format.

            :Example:

            >>> hhl1.edi_format()
            100514::110514+PAR++HI

        """
        return getattr(self, "edi_start_date") + "::" + getattr(self, "edi_end_date") + "+" + self.city + "++" + self.provider

    def pnr_format(self, status):
        """Defines a method to display a HtlSegment in PNR format.

            :Example:

            >>> hhl1.pnr_format(OO1)
            HHL CH OO1 POZ IN07JAN OUT12JAN

        """
        return " ".join(["HHL", self.provider, status, self.city, "IN" + getattr(self, "tty_start_date"), "OUT" + getattr(self, "tty_end_date")])


class HtlSegment(object):
    """Class describing a hotel segment.

        :Non-keyword arguments:
            - provider -- hotel provider.
            - _property -- property code of the hotel.
            - start_date -- date of check-in (format should be DDMMMYY).
            - end_date -- date of check-out (format should be DDMMMYY).

        :Keyword_arguments:
            - htl_segment -- copy a HtlSegment object.
            - city -- city of the hotel, derived from _property.
            - code -- code of the hotel, derived from _property.

        Following attributes are automatically defined:
            - tty_start_date -- ex: 10MAY, derived from start_date.
            - edi_start_date -- ex: 100607, derived from start_date.
            - full_start_date -- ex: 10MAY2007, derived from start_date.
            - start_day -- ex: 10, derived from start_date.
            - start_month -- ex: MAY, derived from start_date.
            - num_start_month -- ex: 06, derived from start_date.
            - full_start_month -- ex: MAY, derived from start_date.
            - start_year -- ex: 07, derived from start_date.
            - full_start_year - ex: 2007, derived from start_date.

        The same attributes are also defined for end date (change start_xxx into end_xxx).

        You can add any other argument you fancy.

        :Examples:

        >>> htl1 = generic_lib.HtlSegment("HI", "PAR999", "10MAY07", "11MAY14")

        >>> htl1_bis = generic_lib.HtlSegment(htl1)

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for an HtlSegment."""
        if args != ():
            self.provider = args[0]
            self._property = args[1]
            self.city = self._property[:3]
            self.code = self._property[3:]
            self.start_date = args[2]
            define_dates(self, "start_date")
            self.end_date = args[3]
            define_dates(self, "end_date")

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "htl_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def book(self, status=""):
        """Returns cryptic entry to book an HtlSegment.

            :Example:

            >>> htl1.book()
            HIPAR99910MAY-11MAY

        """
        booking_entry = self.provider + status + self._property + getattr(self, "tty_start_date")
        if hasattr(self, "tty_start_date") and hasattr(self, "tty_end_date"):
            booking_entry += "-" + getattr(self, "tty_end_date")
        return booking_entry

    def __str__(self):
        return str(self.__dict__)

    def edi_format(self):
        """Defines a method to display a HtlSegment in EDIFACT format.

            :Example:

            >>> htl1.edi_format()
            100514::110514+PAR++HI

        """
        return getattr(self, "edi_start_date") + "::" + getattr(self, "edi_end_date") + "+" + self.city + "++" + self.provider

    def pnr_format(self, status):
        """Defines a method to display a HtlSegment in PNR format.

            :Example:

            >>> htl1.pnr_format(OO1)
            HTL CH OO1 POZ 07JAN 12JAN

        """
        return " ".join(["HTL", self.provider, status, self.city, getattr(self, "tty_start_date"), getattr(self, "tty_end_date")])


class CarSegment(object):
    """Class describing a car segment.

        :Non-keyword arguments:
            - provider -- car provider.
            - city -- city of rental.
            - start_date -- date of check-in (format should be DDMMMYY).
            - end_date -- date of check-out (format should be DDMMMYY).

        :Keyword_argument:
            - car_segment -- copy a CarSegment object.

        Following attributes are automatically defined:
            - tty_start_date -- ex: 10MAY, derived from start_date.
            - edi_start_date -- ex: 100607, derived from start_date.
            - full_start_date -- ex: 10MAY2007, derived from start_date.
            - start_day -- ex: 10, derived from start_date.
            - start_month -- ex: MAY, derived from start_date.
            - num_start_month -- ex: 06, derived from start_date.
            - full_start_month -- ex: MAY, derived from start_date.
            - start_year -- ex: 07, derived from start_date.
            - full_start_year - ex: 2007, derived from start_date.

        The same attributes are also defined for end date (change start_xxx into end_xxx).

        You can add any other argument you fancy.

        :Examples:

        >>> car1 = generic_lib.CarSegment("XX", "PAR", "10MAY07", "11MAY14")

        >>> car1_bis = generic_lib.CarSegment(car1, car_type="EMNR")

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a CarSegment."""
        if args != ():
            self.provider = args[0]
            self.city = args[1]
            self.start_date = args[2]
            define_dates(self, "start_date")
            self.end_date = args[3]
            define_dates(self, "end_date")

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "car_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def book(self):
        """Returns cryptic entry to book a CarSegment.

            :Example:

            >>> car1.book()
            CSXXPAR10MAY-11MAY/ARR-0900-1100/VT-EMNR

        """
        booking_entry = "CS" + self.provider + self.city + getattr(self, "tty_start_date") + "-" + getattr(self, "tty_end_date")
        if hasattr(self, "arr_time"):
            booking_entry += "/ARR-" + getattr(self, "arr_time")
            if hasattr(self, "ret_time"):
                booking_entry += "-" + getattr(self, "ret_time")
        elif hasattr(self, "ret_time"):
            booking_entry += "/RT-" + getattr(self, "ret_time")
        if hasattr(self, "car_type"):
            booking_entry += "/VT-" + getattr(self, "car_type")
        return booking_entry

    def __str__(self):
        return str(self.__dict__)

    def edi_format(self):
        """Defines a method to display a CarSegment in EDIFACT format.

            :Example:

            >>> car1.edi_format()
            100514:0900:110514:1000+PAR++XX+EMNR

        """
        edi_seg = getattr(self, "edi_start_date")
        if hasattr(self, "arr_time"):
            edi_seg += ":" + getattr(self, "arr_time")
        edi_seg += ":" + getattr(self, "edi_end_date")
        if hasattr(self, "ret_time"):
            edi_seg += ":" + getattr(self, "ret_time")
        edi_seg += "+" + self.city + "++" + self.provider
        if hasattr(self, "car_type"):
            edi_seg += "+" + getattr(self, "car_type")
        return edi_seg

    def pnr_format(self, status):
        """Defines a method to display a HtlSegment in PNR format.

            :Example:

            >>> car1.pnr_format(OO1)
            CCR XX OO1 PAR 10MAY 11MAY EMNR

        """
        pnr_seg = " ".join(["CCR", self.provider, status, self.city, getattr(self, "tty_start_date"), getattr(self, "tty_end_date")])
        if hasattr(self, "car_type"):
            pnr_seg += " " + getattr(self, "car_type")
        return pnr_seg
    
    def get_availability(self):
        """ Defines a method to return availability request for a car segment
        
            :Example:
            
            >>> car1 = generic_lib.CarSegment("XX", "PAR", "10MAY07", "11MAY14")
            >>> car1.get_availability()
            CA XX PAR 10MAY-11MAY/ARR-0900-1000
        """
        
        availability = "CA" + self.provider + self.city + getattr(self, "tty_start_date") + "-" + getattr(self, "tty_end_date")
        if hasattr(self, "arr_time"):
            availability += "/ARR-" + getattr(self, "arr_time")
            if hasattr(self, "ret_time"):
                availability += "-" + getattr(self, "ret_time")
        elif hasattr(self, "ret_time"):
            availability += "/RT-" + getattr(self, "ret_time")
        if hasattr(self, "car_type"):
            availability += "/VT-" + getattr(self, "car_type")
            
        return availability


class CcrSegment(object):
    """Class describing a car segment.

        :Non-keyword arguments:
            - provider -- ccr provider.
            - city -- city of rental.
            - start_date -- date of check-in (format should be DDMMMYY).
            - end_date -- date of check-out (format should be DDMMMYY).

        :Keyword_argument:
            - ccr_segment -- copy a CcrSegment object.

        Following attributes are automatically defined:
            - tty_start_date -- ex: 10MAY, derived from start_date.
            - edi_start_date -- ex: 100607, derived from start_date.
            - full_start_date -- ex: 10MAY2007, derived from start_date.
            - start_day -- ex: 10, derived from start_date.
            - start_month -- ex: MAY, derived from start_date.
            - num_start_month -- ex: 06, derived from start_date.
            - full_start_month -- ex: MAY, derived from start_date.
            - start_year -- ex: 07, derived from start_date.
            - full_start_year - ex: 2007, derived from start_date.

        The same attributes are also defined for end date (change start_xxx into end_xxx).

        You can add any other argument you fancy.

        :Examples:

        >>> ccr1 = generic_lib.CcrSegment("XX", "PAR", "10MAY07", "11MAY14")

        >>> ccr1_bis = generic_lib.CcrSegment(ccr1, car_type="EMNR")

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a CcrSegment."""
        if args != ():
            self.provider = args[0]
            self.city = args[1]
            self.start_date = args[2]
            define_dates(self, "start_date")
            self.end_date = args[3]
            define_dates(self, "end_date")

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "ccr_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def book(self):
        """Returns cryptic entry to book a CarSegment.

            :Example:

            >>> ccr1.book()
            XXPAR10MAY-11MAY/ARR-0900-1100/VT-EMNR

        """
        booking_entry = self.provider + self.city + getattr(self, "tty_start_date") + "-" + getattr(self, "tty_end_date")
        if hasattr(self, "arr_time"):
            booking_entry += "/ARR-" + getattr(self, "arr_time")
            if hasattr(self, "ret_time"):
                booking_entry += "-" + getattr(self, "ret_time")
        elif hasattr(self, "ret_time"):
            booking_entry += "/RT-" + getattr(self, "ret_time")
        if hasattr(self, "ccr_type"):
            booking_entry += "/VT-" + getattr(self, "ccr_type")
        return booking_entry

    def __str__(self):
        return str(self.__dict__)

    def edi_format(self):
        """Defines a method to display a CarSegment in EDIFACT format.

            :Example:

            >>> ccr1.edi_format()
            100514:0900:110514:1000+PAR++XX+EMNR

        """
        edi_seg = getattr(self, "edi_start_date")
        if hasattr(self, "arr_time"):
            edi_seg += ":" + getattr(self, "arr_time")
        edi_seg += ":" + getattr(self, "edi_end_date")
        if hasattr(self, "ret_time"):
            edi_seg += ":" + getattr(self, "ret_time")
        edi_seg += "+" + self.city + "++" + self.provider
        if hasattr(self, "ccr_type"):
            edi_seg += "+" + getattr(self, "ccr_type")
        return edi_seg

    def pnr_format(self, status):
        """Defines a method to display a HtlSegment in PNR format.

            :Example:

            >>> ccr1.pnr_format("OO1")
            CCR XX OO1 PAR 10MAY 11MAY EMNR

        """
        pnr_seg = " ".join(["CCR", self.provider, status, self.city, getattr(self, "tty_start_date"), getattr(self, "tty_end_date")])
        if hasattr(self, "ccr_type"):
            pnr_seg += " " + getattr(self, "ccr_type")
        return pnr_seg


class MisSegment(object):
    """Class describing a miscellaneous segment.

        :Non-keyword arguments:
            - provider -- service provider.
            - city -- city of service.
            - date -- date of service (format should be DDMMMYY).

        :Keyword_argument:
            - mis_segment -- copy a MisSegment object.

        Following attributes are automatically defined:
            - edi_date -- ex: 100607, derived from date.
            - full_date -- ex: 10MAY2007, derived from date.
            - day -- ex: 10, derived from date.
            - month -- ex: MAY, derived from date.
            - num_month -- ex: 06, derived from date.
            - full_month -- ex: MAY, derived from date.
            - year -- ex: 07, derived from date.
            - full_year - ex: 2007, derived from date.

        You can add any other argument you fancy.

        :Examples:

        >>> mis1 = generic_lib.MisSegment("XX", "PAR", "10MAY07")

        >>> mis1_bis = generic_lib.MisSegment(mis1)

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a MisSegment."""
        if args != ():
            self.provider = args[0]
            self.city = args[1]
            self.date = args[2]
            define_dates(self, "date")

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "mis_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def book(self, status):
        """Returns cryptic entry to book a MisSegment.

            :Example:

            >>> mis1.book()
            1A HK1 MAD 20NOV/OPTIONAL FREETEXT

        """
        booking_entry = self.provider + status + self.city + getattr(self, "tty_date")
        if hasattr(self, "free_text"):
            booking_entry += "/" + getattr(self, "free_text")
        return booking_entry

    def __str__(self):
        return str(self.__dict__)

    def pnr_format(self, status):
        """Defines a method to display a MisSegment in PNR format.

            :Example:

            >>> mis1.pnr_format("OO1")
            MIS XX OO1 PAR 10MAY 11MAY EMNR

        """
        pnr_seg = " ".join(["MIS", self.provider, status, self.city, getattr(self, "tty_date")])
        if hasattr(self, "free_text"):
            pnr_seg += "-" + getattr(self, "free_text")
        return pnr_seg


class AtxSegment(object):
    """Class describing an air taxi segment.

        :Non-keyword arguments:
            - provider -- service provider.
            - board_pt -- departure point.
            - off_pt -- arrival point.
            - date -- date of service (format should be DDMMMYY).

        :Keyword_argument:
            - atx_segment -- copy an AtxSegment object.

        Following attributes are automatically defined:
            - edi_date -- ex: 100607, derived from date.
            - full_date -- ex: 10MAY2007, derived from date.
            - day -- ex: 10, derived from date.
            - month -- ex: MAY, derived from date.
            - num_month -- ex: 06, derived from date.
            - full_month -- ex: MAY, derived from date.
            - year -- ex: 07, derived from date.
            - full_year - ex: 2007, derived from date.

        You can add any other argument you fancy.

        :Examples:

        >>> atx1 = generic_lib.AtxSegment("YY", "PAR", "FRA", "10MAY07")

        >>> atx1_bis = generic_lib.AtxSegment(atx1, freetext="PRIVATE JET")

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for an AtxSegment."""
        if args != ():
            self.provider = args[0]
            self.board_pt = args[1]
            self.off_pt = args[2]
            self.date = args[3]
            define_dates(self, "date")

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "atx_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def book(self, status="NN1"):
        """Returns cryptic entry to book an AtxSegment.

            :Example:

            >>> atx1.book()
            IB NN1 SCQVGO 21JUL-OPTIONAL FREEFLOW

        """
        booking_entry = self.provider + status + self.board_pt + self.off_pt + getattr(self, "tty_date")
        if hasattr(self, "free_text"):
            booking_entry += "-" + getattr(self, "free_text")
        return booking_entry

    def __str__(self):
        return str(self.__dict__)

    def pnr_format(self, status):
        """Defines a method to display an AtxSegment in PNR format.

            :Example:

            >>> atx1.pnr_format("OO1")
            ATX IB HN1 SCQVGO 21JUL-OPTIONAL FREEFLOW

        """
        pnr_seg = " ".join(["ATX", self.provider, status, self.board_pt + self.off_pt, getattr(self, "tty_date")])
        if hasattr(self, "free_text"):
            pnr_seg += "-" + getattr(self, "free_text")
        return pnr_seg


class TurSegment(object):
    """Class describing a tour segment.

        :Non-keyword arguments:
            - provider -- tour provider.
            - city -- city of tour.
            - date -- date of service (format should be DDMMMYY).

        :Keyword_argument:
            - tur_segment -- copy a TurSegment object.

        Following attributes are automatically defined:
            - edi_date -- ex: 100607, derived from date.
            - full_date -- ex: 10MAY2007, derived from date.
            - day -- ex: 10, derived from date.
            - month -- ex: MAY, derived from date.
            - num_month -- ex: 06, derived from date.
            - full_month -- ex: MAY, derived from date.
            - year -- ex: 07, derived from date.
            - full_year - ex: 2007, derived from date.

        You can add any other argument you fancy.

        :Examples:

        >>> tur1 = generic_lib.TurSegment("ZZ", "PAR", "10MAY07")

        >>> tur1_bis = generic_lib.TurSegment(tur1)

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a TurSegment."""
        if args != ():
            self.provider = args[0]
            self.city = args[1]
            self.date = args[2]
            define_dates(self, "date")

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "tur_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def book(self, status):
        """Returns cryptic entry to book a TurSegment.

            :Example:

            >>> tur1.book()
            TU AF NN1 PAR 19JUL/OPTIONAL FREEFLOW

        """
        booking_entry = self.provider + status + self.city + getattr(self, "tty_date")
        if hasattr(self, "free_text"):
            booking_entry += "/" + getattr(self, "free_text")
        return booking_entry

    def __str__(self):
        return str(self.__dict__)

    def pnr_format(self, status):
        """Defines a method to display a TurSegment in PNR format.

            :Example:

            >>> tur1.pnr_format("OO1")
            TUR AF HN1 PAR 19JUL-OPTIONAL FREEFLOW

        """
        pnr_seg = " ".join(["TUR", self.provider, status, self.city, getattr(self, "tty_date")])
        if hasattr(self, "free_text"):
            pnr_seg += "-" + getattr(self, "free_text")
        return pnr_seg


class SsrSegment(object):
    """Class describing a SSR segment.

        :Non-keyword arguments:
            - code -- service type.
            - airline -- service provider.

        :Keyword_argument:
            - ssr_segment -- copy a SsrSegment object.

        You can add any other argument you fancy.

        :Examples:

        >>> ssr1 = generic_lib.SsrSegment("PETC", "AF", free_text="DOG")

        >>> ssr1_bis = generic_lib.SsrSegment(ssr1)

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a SsrSegment."""
        if args != ():
            self.code = args[0]
            self.airline = args[1]

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "ssr_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

    def __str__(self):
        return str(self.__dict__)

    def book(self):
        """Returns cryptic entry to book a SsrSegment.

            :Example:

            >>> ssr1.book()
            SRPETC AF -DOG

        """
        booking_entry = "SR" + self.code + " " + self.airline + " "
        if hasattr(self, "free_text"):
            booking_entry += "-" + getattr(self, "free_text")
        return booking_entry

    def pnr_format(self, status):
        """Defines a method to display a SsrSegment in PNR format.

            :Example:

            >>> ssr1.pnr_format("HK1")
            SSR PETC 6X HK1 DOG

        """
        pnr_format = "SSR " + self.code + " " + self.airline + " " + status
        if hasattr(self, "free_text"):
            pnr_format += " " + getattr(self, "free_text")
        return pnr_format

    def tty_format(self, status, seg_asso=None, pax_asso=None):
        """Defines a method to display a SsrSegment in TTY format. If provided, seg_asso should be an AirSegment object and pax_asso a PaxName object.

            :Example:

            >>> ssr1.tty_format("HK1")
            SSR SSR PETC 6X HK1

        """
        tty_format = "SSR " + self.code + " " + self.airline + " " + status
        if seg_asso is not None:
            tty_format += " " + seg_asso.ssr_asso()
        if pax_asso is not None:
            tty_format += "-" +  " ".join([pax.ssr_asso() for pax in pax_asso])
        if hasattr(self, "free_text"):
            tty_format += " " + getattr(self, "free_text")
        # Cut after 69 characters so that words are not cut
        if len(tty_format) > 69:
            line = "SSR " + self.code + " " + self.airline + " " + status
            list_of_words = tty_format.replace(line, "").strip().split(" ")
            tty_format = ""
            while list_of_words != []:
                word = list_of_words[0]
                list_of_words.pop(0)
                if len(line + " " + word) > 69:
                    list_of_subwords = word.split("/")
                    if len(list_of_subwords) > 1:
                        subwords = list_of_subwords[0]
                        list_of_subwords.pop(0)
                        if len(line + " " + subwords) > 69:
                            tty_format += line + "\n"
                            line = "SSR " + self.code + " " + self.airline + " ///  " + word
                        else:
                            remaining_subwords = list(list_of_subwords)
                            for subword in list_of_subwords:
                                if len(line + " " + subwords + "/" + subword) > 69:
                                    tty_format += line + " " + subwords + "\n"
                                    line = "SSR " + self.code + " " + self.airline + " //// " + "/".join(remaining_subwords)
                                else:
                                    subwords += "/" + subword
                                    remaining_subwords.remove(subword)
                    else:
                        tty_format += line + "\n"
                        line = "SSR " + self.code + " " + self.airline + " ///  " + word
                else:
                    line += " " + word
            tty_format += line
        return tty_format

    def his_format(self, status, seg_asso=None, pax_asso=None, qualifier=""):
        """Defines a method to display a SsrSegment in history format.

            :Example:

            >>> ssr1.his_format("HK1")
            SSR PETC6XHK1

        """
        his_format = "SA/" + qualifier + "SSR " + self.code + self.airline + status
        if hasattr(self, "free_text") != "":
            his_format += " " + getattr(self, "arr_time")
        if isinstance(seg_asso, AirSegment):
            his_format += "/" + seg_asso.airline + seg_asso.flight_nb.rjust(4, " ") + " " + seg_asso._class + " " + seg_asso.tty_date + " " + seg_asso.board_pt + seg_asso.off_pt
        if isinstance(pax_asso, PaxName):
            his_format += "/" + pax_asso.last_name + "/" + pax_asso.first_name
        elif isinstance(pax_asso, list):
            asso_list = []
            for asso in pax_asso:
                asso_list.append(asso.last_name + "/" + asso.first_name)
            his_format += "/" + " ".join(asso_list)
        # Cuts after 54 characters so that words are not cut
        # (54 because max length is 62 and envelop number is 8:"    001 ")
        if len(his_format) > 54:
            line = qualifier + "SSR " + self.code + self.airline + status
            # No space if seg asso after, space if freetext
            list_of_words = his_format.replace("SA/" + line, "").strip().split(" ")
            his_format = ""
            # Counter used to distinguish the first word between freetext and pax asso
            counter = 0
            while list_of_words != []:
                counter += 1
                word = list_of_words[0]
                list_of_words.pop(0)
                if ((counter == 1) and (len("/" + line + word) > 54)) or ((counter != 1) and (len("/" + line + " " + word) > 54)):
                    list_of_subwords = word.split("/")
                    if len(list_of_subwords) > 1:
                        subwords = list_of_subwords[0]
                        list_of_subwords.pop(0)
                        if len("/" + line + " " + subwords) > 54:
                            his_format += line + "\n"
                            line = "        " + word
                        else:
                            remaining_subwords = list(list_of_subwords)
                            for subword in list_of_subwords:
                                if len("/" + line + " " + subwords + "/" + subword) > 54:
                                    his_format += line + " " + subwords + "/\n"
                                    line = "        " + "/".join(remaining_subwords)
                                else:
                                    subwords += "/" + subword
                                    remaining_subwords.remove(subword)
                    else:
                        his_format += line + "\n"
                        line = "        " + word
                else:
                    if counter == 1:
                        line += word
                    else:
                        line += " " + word
            his_format += line
        else:
            # Remove SA/
            his_format = his_format[3:]
        return his_format


class SvcSegment(object):
    """Class describing a SSR segment.

        :Non-keyword arguments:
            - code -- service type.
            - status -- status of the service.
            - airline -- service provider.
            - board_pt -- departure point of the service.
            - off_pt -- arrival point of the service.
            - date -- date of the service.

        :Keyword_argument:
            - ssr_segment -- copy a SsrSegment object.

        Following attributes are automatically defined:
            - edi_date -- ex: 100607, derived from date.
            - full_date -- ex: 10MAY2007, derived from date.
            - day -- ex: 10, derived from date.
            - month -- ex: MAY, derived from date.
            - num_month -- ex: 06, derived from date.
            - full_month -- ex: MAY, derived from date.
            - year -- ex: 07, derived from date.
            - full_year - ex: 2007, derived from date.

        You can add any other argument you fancy.

        :Examples:

        >>> svc1 = generic_lib.SvcSegment("BUST", "HK", "6X", "AMS", "CDG", "12MAY14")

        >>> svc1_bis = generic_lib.SvcSegment(svc1)

    """

    def __init__(self, *args, **kwargs):
        """Defines default attributes for a SvcSegment."""
        if args != ():
            self.code = args[0]
            self.status = args[1]
            self.airline = args[2]
            self.board_pt = args[3]
            self.off_pt = args[4]
            self.date = args[5]
            define_dates(self, "date")

        for arg, val in kwargs.items():
            # Copy constructor
            if arg == "svc_segment":
                for attribute, value in val.__dict__.items():
                    setattr(self, attribute, value)
            # Fill other attributes
            else:
                setattr(self, arg, val)

        if not hasattr(self, "dep_date"):
            setattr(self, "dep_date", self.date)
        if not hasattr(self, "arr_date"):
            setattr(self, "arr_date", self.date)
        define_dates(self, "dep_date")
        define_dates(self, "arr_date")

    def __str__(self):
        return str(self.__dict__)

    def book(self, nb_of_services=1, location_nb=0):
        """Returns cryptic entry to book a SvcSegment.

            :Example:

            >>> svc1.book(1, 2)
            6XHK1BUSTCDG/12MAY

        """
        booking_entry = self.airline + self.status + str(nb_of_services) + self.code
        if location_nb == 0:
            booking_entry += self.board_pt + self.off_pt + "/" + getattr(self, "tty_date")
        elif location_nb == 1:
            booking_entry += self.board_pt + "/" + getattr(self, "tty_dep_date")
        elif location_nb == 2:
            booking_entry += self.off_pt + "/" + getattr(self, "tty_arr_date")
        return booking_entry

    def pnr_format(self, nb_of_services=1, location_nb=0):
        """Defines a method to display a SvcSegment in PNR format.

            :Example:

            >>> svc1.pnr_format(1, 2)
            /SVC 6X HK1 BUST CDG 12NOV

        """
        pnr_format = "/SVC " + self.airline + " " + self.status + str(nb_of_services) + " " + self.code + " "
        if location_nb == 0:
            pnr_format += self.board_pt + self.off_pt + " " + getattr(self, "tty_date")
        elif location_nb == 1:
            pnr_format += self.board_pt + " " + getattr(self, "tty_dep_date")
        elif location_nb == 2:
            pnr_format += self.off_pt + " " + getattr(self, "tty_arr_date")
        return pnr_format


class ContactElt(object):
    """ Defines a class describing a contact element.
    Example::

    - ap1 = generic_lib.ContactElt()
    - ap2 = generic_lib.ContactElt('AP', 'NRG - PNRADD option 20')

    """
    def __init__(self, type_='AP', free_text='', pax_asso=None):
        """ Defines default attributes for a contact element """
        if isinstance(type_, ContactElt):
            # Copy of a ContactElt
            self.type_ = type_.type_
            self.free_text = type_.free_text
            self.pax_asso = type_.pax_asso
        else:
            self.type_ = type_
            self.free_text = free_text
            self.pax_asso = pax_asso

    def __str__(self):
        contact = self.type_ + self.free_text
        if self.pax_asso is not None:
            contact += '/P' + str(self.pax_asso)
        return contact

    def book(self):
        """ Returns cryptic entry to book a ContactElt.
        Example::

        - ap2.book() returns AP NRG - PNRADD option 20

        """
        booking_entry = self.type_ + self.free_text
        if self.pax_asso is not None:
            booking_entry += '/P'
            if isinstance(self.pax_asso, int):
                booking_entry += str(self.pax_asso)
            elif isinstance(self.pax_asso, list):
                for pax in self.pax_asso:
                    if pax == self.pax_asso[-1]:
                        booking_entry += str(pax)
                    else:
                        booking_entry += str(pax) + ','
        return booking_entry


def define_dates(object_, attr):
    """Define classical variations of date format."""
    setattr(object_, "tty_" + attr, get_date(getattr(object_, attr), "DDMMMYY", "DDMMM"))
    setattr(object_, "edi_" + attr, get_date(getattr(object_, attr), "DDMMMYY", "DDMMYY"))
    setattr(object_, "xml_" + attr, get_date(getattr(object_, attr), "DDMMMYY", "YYYY-MM-DD"))
    setattr(object_, "wbs_" + attr, get_date(getattr(object_, attr), "DDMMMYY", "DDMMYYYY"))
    setattr(object_, "full_" + attr, get_date(getattr(object_, attr), "DDMMMYY", "DDMMMYYYY"))
    setattr(object_, attr.replace("date", "day"), get_date(getattr(object_, attr), "DDMMMYY", "DD"))
    setattr(object_, attr.replace("date", "month"), get_date(getattr(object_, attr), "DDMMMYY", "MMM"))
    setattr(object_, "num_" + attr.replace("date", "month"), get_date(getattr(object_, attr), "DDMMMYY", "MM"))
    setattr(object_, "full_" + attr.replace("date", "month"), get_date(getattr(object_, attr), "DDMMMYY", "MONTH"))
    setattr(object_, attr.replace("date", "year"), get_date(getattr(object_, attr), "DDMMMYY", "YY"))
    setattr(object_, "full_" + attr.replace("date", "year"), get_date(getattr(object_, attr), "DDMMMYY", "YYYY"))

def get_date(*args, **kwargs):
    """See date_and_time_lib."""
    return date_and_time_lib.get_date(*args, **kwargs)

def get_time(*args, **kwargs):
    """See date_and_time_lib."""
    return date_and_time_lib.get_time(*args, **kwargs)

#
# def get_offices(*args, **kwargs):
# """See settings_lib."""
#     return settings_lib.get_offices(*args, **kwargs)
#
# def get_airlines(*args, **kwargs):
# """See settings_lib."""
#     return settings_lib.get_airlines(*args, **kwargs)
#
# def check_apt_on_obe(*args, **kwargs):
# """See settings_lib."""
#     return settings_lib.check_apt_on_obe(*args, **kwargs)
#
# def check_ogi_table_on_obe(*args, **kwargs):
# """See settings_lib."""
#     return settings_lib.check_ogi_table_on_obe(*args, **kwargs)
#
# def check_cia_table_on_obe(*args, **kwargs):
# """See settings_lib."""
#     return settings_lib.check_cia_table_on_obe(*args, **kwargs)

def generate_rloc(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.generate_rloc(*args, **kwargs)

def convert_rloc(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.convert_rloc(*args, **kwargs)

def generate_ticket_nb(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.generate_ticket_nb(*args, **kwargs)

def set_flight_flown(*args, **kwargs):
    """See scripts_lib."""
    return scripts_lib.set_flight_flown(*args, **kwargs)

def unboard_pnrs(*args, **kwargs):
    """See scripts_lib."""
    return scripts_lib.unboard_pnrs(*args, **kwargs)

def get_rlocs(*args, **kwargs):
    """See scripts_lib."""
    return scripts_lib.get_rlocs(*args, **kwargs)

def clean_flight(*args, **kwargs):
    """See scripts_lib."""
    return scripts_lib.clean_flight(*args, **kwargs)

def clean_pnrs(*args, **kwargs):
    """See scripts_lib."""
    return scripts_lib.clean_pnrs(*args, **kwargs)

# def create_pnr(*args, **kwargs):
# """See scripts_lib."""
#     return scripts_lib.create_pnr(*args, **kwargs)

def clean_profiles(*args, **kwargs):
    """See scripts_lib."""
    return scripts_lib.clean_profiles(*args, **kwargs)

def run_tts_script(*args, **kwargs):
    """See scripts_lib."""
    return scripts_lib.run_tts_script(*args, **kwargs)

def random_int(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.random_int(*args, **kwargs)

def random_nb(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.random_nb(*args, **kwargs)

def random_str(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.random_str(*args, **kwargs)

def random_alpha(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.random_alpha(*args, **kwargs)

def convert_str(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.convert_str(*args, **kwargs)

def format_float(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.format_float(*args, **kwargs)

def compare(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.compare(*args, **kwargs)

# def convert_parameter(*args, **kwargs):
# """See utilitaries_lib."""
#     return utilitaries_lib.convert_parameter(*args, **kwargs)

def check_tty_messages(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.check_tty_messages(*args, **kwargs)

def match(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.match(*args, **kwargs)

def retrieve(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.retrieve(*args, **kwargs)

def get_seat(*args, **kwargs):
    """See seat_lib."""
    return seat_lib.get_seat(*args, **kwargs)

def update_seat_occupation(*args, **kwargs):
    """See seat_lib."""
    return seat_lib.update_seat_occupation(*args, **kwargs)

def update_seat_characteristics(*args, **kwargs):
    """See seat_lib."""
    return seat_lib.update_seat_characteristics(*args, **kwargs)

#DEPRECATED 
# def start_alf_logs(*args, **kwargs):
#     """See utilitaries_lib."""
#     return utilitaries_lib.start_alf_logs(*args, **kwargs)
 
#DEPRECATED
# def stop_alf_logs(*args, **kwargs):
#     """See utilitaries_lib."""
#     return utilitaries_lib.stop_alf_logs(*args, **kwargs)

#DEPRECATED 
# def search_alf_logs(*args, **kwargs):
#     """See utilitaries_lib."""
#     return utilitaries_lib.search_alf_logs(*args, **kwargs)

def get_alf_logs(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.get_alf_logs(*args, **kwargs)

def search_in_alf_logs(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.search_in_alf_logs(*args, **kwargs)

def loop_or_abort(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.loop_or_abort(*args, **kwargs)

# def create_ptr(*args, **kwargs):
# """See utilitaries_lib"""
#     return utilitaries_lib.create_ptr(*args, **kwargs)

def check_xml(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.check_xml(*args, **kwargs)

def check_json(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.check_json(*args, **kwargs)

def compare_json_as_string(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.compare_json_as_string(*args, **kwargs)

def display_paths(list_of_xpaths):
    """Displays list of x path for TTS comparison."""
    return "\n".join(list_of_xpaths)

# def start_debug(*args, **kwargs):
#     """Start debug facility."""
#     return debug.start_debug(*args, **kwargs)
# 
# def stop_debug(*args, **kwargs):
#     """Stop debug facility."""
#     return debug.stop_debug(*args, **kwargs)

def abort(*args, **kwargs):
    """See utilitaries_lib."""
    return utilitaries_lib.abort(*args, **kwargs)

def hide_password(*args, **kwargs):
    """See password_management_library"""
    return pwd_lib.hide_password(*args, **kwargs)

def clean_password(*args, **kwargs):
    """See password_management_library"""
    return pwd_lib.clean_password(*args, **kwargs)

def redefine_terminal(*args, **kwargs):
    """See utilitaries_lib"""
    return utilitaries_lib.redefine_terminal(*args, **kwargs)

def get_library_version(*args, **kwargs):
    print "==== PDF Generic Library version 4.2.45 ===="
    
def generate_pax_names(nb_of_pax=0, max_length=40, language='LAT'):
    '''    See pnr_lib    '''
    return pnr_lib.generate_pax_names(nb_of_pax, max_length, language)

def attempt_transactions(transaction_list):
    '''    See utilitaries_lib    '''
    return utilitaries_lib.attempt_transactions(transaction_list)

def reset_globals():
    '''    See utilitaries_lib    '''
    return utilitaries_lib.reset_globals()

def pad(chain_of_characters, output_length, padding_character='0', side='LEFT'):
    '''    See utilitaries_lib    '''
    return utilitaries_lib.pad(chain_of_characters, output_length, padding_character, side)

def extract_pax(pax_names, pax_nb, separator='/'):
    '''    See pnr_lib    '''
    return pnr_lib.extract_pax(pax_names, pax_nb, separator)

def random_string_generate_pax_names(*args, **kwargs):
    """See pnr_lib."""
    return pnr_lib.random_string_generate_pax_names(*args, **kwargs)

def add_asso(asso_list, type_, list_of_elts):
    '''    See utilitaries_lib    '''
    return utilitaries_lib.add_asso(asso_list, type_, list_of_elts)