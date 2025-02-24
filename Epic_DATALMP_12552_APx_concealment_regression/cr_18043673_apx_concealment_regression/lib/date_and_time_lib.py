#!/usr/bin/env python
#-*- coding: UTF-8 -*-
"""
==== PDF Generic Library version 4.2.45 ===="

Date and time module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

import datetime
import time

def get_date(input_date="", input_format="DDMMMYY", output_format="DDMMMYY", **kwargs):
    """Take the date provided in input as a reference and return a shifted date in given format.

    :Non-keyword arguments:
        - input_date -- the date of reference (default: current local date). "UTC" can also be used to get current UTC date.
        - input_format -- the format of the input date (default: DDMMMYY).
        - output_format -- the format of the shifted date (default: DDMMMYY).

    :Keyword arguments:
        - offset -- the number of days from which you want to shift the date (default: 0).
        - day -- the day in the week (default: today)"MONDAY" or "MON", "THURSDAY" or "THU")

    :Examples:

    >>> generic_lib.get_date("12MAY17", "DDMMMYY", "MM-DD-YYYY", offset=3)
    05-15-2017

    >>> generic_lib.get_date()
    26OCT16

    >>> generic_lib.get_date("UTC", output_format="MONTH")
    OCTOBER
    
    >>> generic_lib.get_date("12MAY18", "DDMMMYY", "DDMMMYYYY", day="MON")
    12MAY18 = SATURDAY ---> 14MAY18 MONDAY
    go to first Monday
    """

    # Convert input_format if valid
    if "mM" in input_format and "dD" in input_format:
        return input_date
    in_format = convert_format_to_python(input_format, "input_date")

    if input_date == "":
        input_date = datetime.datetime.today().strftime(in_format).upper()
    elif input_date.upper() == "UTC":
        input_date = datetime.datetime.utcnow().strftime(in_format).upper()

    # Transform arguments
    offset = 0
    day = 0
    for arg, val in kwargs.items():
        if arg == "offset":
            offset = val
        # Change day into a number
        elif arg == "day":
            day = {"MON":1, "TUE": 2, "WED":3, "THU":4, "FRI":5, "SAT":6, "SUN":7, "MONDAY":1, "TUESDAY": 2, "WEDNESDAY":3, "THURSDAY":4, "FRIDAY":5, "SATURDAY":6, "SUNDAY":7}[val.upper()]

    # Build datetime object based on input_date and shift
    date = datetime.datetime(*(time.strptime(input_date, in_format)[0:6])) + datetime.timedelta(offset)

    if day == 0:
        day = date.isoweekday()

    # Replace week day
    date = datetime.datetime.fromordinal(date.toordinal() - (date.isoweekday() - day))

    # Convert output_format
    out_format = convert_format_to_python(output_format, "output_date")

    # Convert date to a string
    output_date = split_format(date, out_format)

    # Sunday should be set as 7, not 0
    if (output_format == "D") and (output_date == "0"):
        output_date = "7"

    return output_date


def get_time(input_time="", input_format="HHMMSS", output_format="HHMMSS", offset=0):
    """Take the time provided in input as a reference and return a shifted time in given format.

    :Non-keyword arguments:
        - input_time -- the time of reference (default: current local time). "UTC" can also be used to get current UTC time.
        - input_format -- the format of the input time (default: HHMMSS).
        - output_format -- the format of the shifted time (default: HHMMSS).
        - offset -- the number of minutes from which you want to shift the time (default: 0). "UTC-LOCAL" and "LOCAL-UTC" can also be used to get difference between UTC and local times.

    :Examples: 

    >>> generic_lib.get_time(12:03:37, "HH:MM:SS", "HHMM", offset=30)
    1233

    >>> generic_lib.get_time()
    151035

    >>> generic_lib.get_time("UTC", output_format="HH")
    13

    """
    if input_format.endswith("_AP"):
        input_time += "M"
        input_format.replace("_AP", "_APM")

    # Convert input_format
    in_format = convert_format_to_python(input_format, "input_time")

    # Get real time as input time
    if input_time == "":
        input_time = datetime.datetime.today().strftime(in_format).upper()
    elif input_time.upper() == "UTC":
        input_time = datetime.datetime.utcnow().strftime(in_format).upper()

    # Handle timelap
    if str(offset) == "UTC-LOCAL":
        offset = int(datetime.datetime.utcnow().strftime("%H").upper())*60 + int(datetime.datetime.utcnow().strftime("%M").upper()) - int(datetime.datetime.today().strftime("%H").upper())*60 - int(datetime.datetime.today().strftime("%M").upper())
    elif str(offset) == "LOCAL-UTC":
        offset = int(datetime.datetime.today().strftime("%H").upper())*60 + int(datetime.datetime.today().strftime("%M").upper()) - int(datetime.datetime.utcnow().strftime("%H").upper())*60 - int(datetime.datetime.utcnow().strftime("%M").upper())

    # Build datetime object based on input_time and offset (08OCT14 is used to prevent issues with negative offset as 01JAN1900 is used by default)
    built_time = datetime.datetime(*(time.strptime("08OCT14" + input_time, "%d%b%y" + in_format)[0:6])) + datetime.timedelta(minutes=offset)

    # Convert output_format
    out_format = convert_format_to_python(output_format, "output_time")

    # Convert time to a string
    output_time = split_format(built_time, out_format)

    if output_format.endswith("_AP"):
        output_time = output_time.replace("M", "")
    elif output_format.endswith("_NOAP"):
        output_time = output_time.replace("AM", "").replace("PM", "")

    return output_time


def convert_format_to_python(format_, data_type):
    """Convert a user-friendly format to a python one."""
    # Define python formats used in strftime() (see python help for details)
    if data_type == "input_date":
        o_format = format_.replace("YYYY", "%Y").replace("YY", "%y")
        o_format = o_format.replace("MONTH", "%B").replace("MMM", "%b").replace("MM", "%m").replace("mM", "%m")
        o_format = o_format.replace("DAY", "%A").replace("DDD", "%a").replace("DD", "%d").replace("dD", "%d").replace("D", "%w")
    elif data_type == "output_date": # %q, %r, %s, %t and %u are personal formats
        o_format = format_.replace("YYYY", "%Y").replace("YY", "%y")
        o_format = o_format.replace("MONTH", "%B").replace("MMM", "%b").replace("MM", "%m").replace("mM", "%q")
        o_format = o_format.replace("DAY", "%A").replace("DDD", "%a").replace("DD", "%d").replace("dD", "%r").replace("D", "%w")
    elif data_type == "input_time":
        o_format = format_.replace("_NOAP", "")
        o_format = o_format.replace("HH", "%H").replace("hH", "%H")
        o_format = o_format.replace("MM", "%M").replace("mM", "%M")
        o_format = o_format.replace("SS", "%S").replace("sS", "%S")
        if o_format.endswith("_APM"):
            o_format = o_format.replace("_APM", "%p")
            o_format = o_format.replace("%H", "%I")
    elif data_type == "output_time": # %q, %r, %s, %t and %u are personal formats
        o_format = format_.replace("HH", "%H").replace("hH", "%s")
        o_format = o_format.replace("MM", "%M").replace("mM", "%t")
        o_format = o_format.replace("SS", "%S").replace("sS", "%u")
        if o_format.endswith("_APM") or o_format.endswith("_AP") or o_format.endswith("_NOAP"):
            o_format = o_format.replace("_APM", "%p").replace("_AP", "%p").replace("_NOAP", "%p")
            o_format = o_format.replace("%H", "%I")

    return o_format


def split_format(date_time, format_, index=0):
    """Split a date or time format."""
    dict_of_separators = {"%q":"%m", "%r":"%d", "%s":"%H", "%t":"%M", "%u":"%S"}
    if index < len(dict_of_separators):
        key = dict_of_separators.keys()[index]
        list_of_parts = format_.split(key)
        joiner = date_time.strftime(dict_of_separators[key]).upper()
        if joiner[0] == "0":
            joiner = joiner[1:]
        list_of_outputs = []
        for part in list_of_parts:
            list_of_outputs.append(split_format(date_time, part, index+1))
        return joiner.join([date_time.strftime(output).upper() for output in list_of_outputs])
    else:
        return format_
