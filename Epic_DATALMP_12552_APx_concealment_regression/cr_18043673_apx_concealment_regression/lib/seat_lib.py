#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
==== PDF Generic Library version 4.2.45 ===="

Data management module: available functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

import re


def get_seat(seat_map, requested_seat="."):
    """Look for the first available seat of a given type and return it.

    :Non-keyword arguments:
        - seat_map -- vertical seat map display.
        - requested_seat -- type of seat to retrieve (default: ".").

    :Example: 

    .. image:: TTS_examples/get_seat.jpg

    """
    list_of_rows = seat_map.splitlines()
    columns_line = list_of_rows[2]
    for row_line in list_of_rows[3:]:
        is_row_line = re.match(r"^[A-Z ]{2}\D?(\d{1,2}).*", row_line)
        if is_row_line is not None:
            for seat, column in zip(row_line, columns_line):
                if re.match("[A-Z]", column) is not None and (seat == requested_seat):
                    return str(is_row_line.group(1)) + column
    return ""


def update_seat_occupation(air_segment, list_of_seats, status):
    """Update the seat occupation status for a list of seats..

    :Non-keyword arguments:
        - air_segment -- flight/date to update.
        - list_of_seats -- seats for which the status should be changed
        - status -- updated occupation status of the seats. Can be K for broken, F for free and so on.

    :Example: 

    >>>generic_lib.update_seat_occupation(f_sm, ["23A-24F", "26A-26B", "26D"], "K")
    (...)ROD+23++A:K+B:K+C:K+D:K+E:K+F:K'ROD+24++A:K+B:K+C:K+D:K+E:K+F:K'ROD+26++A:K+B:K+D:K'(...)

    """
    message = "DCX+134+<DCC VERS=\"1.0\"><MW><UKEY VAL=\"14TB93#1VZ0BEKYKNBF56\" TRXNB=\"17-1\"/><DYNR><PEAKTK TYPE=\"AIRIT\" VAL=\"" + air_segment.airline + "\" ACTION=\"O\"/></DYNR></MW></DCC>'" \
    + "ORG+00+12345675:NCE1A0955+'" \
    + "FDQ+" + air_segment.airline + "+" + air_segment.flight_nb + "+" + air_segment.edi_dep_date + "+" + air_segment.board_pt + "+" + air_segment.off_pt + "'" \
    + "ODI+" + air_segment.board_pt + "+" + air_segment.off_pt + "'"

    # Create dictionnary of seats impacted
    dict_of_seats = {}
    for seats in list_of_seats:
        if "-" in seats: # Range of seats
            row_1 = seats.split("-")[0][:-1]
            column_1 = seats.split("-")[0][-1]
            row_2 = seats.split("-")[1][:-1]
            column_2 = seats.split("-")[1][-1]
            for row in range(int(row_1), int(row_2) + 1):
                for column in range(ord(column_1), ord(column_2) + 1):
                    if str(row) in dict_of_seats:
                        if chr(column) not in dict_of_seats[str(row)]:
                            dict_of_seats[str(row)].append(chr(column))
                    else:
                        dict_of_seats[str(row)] = [chr(column)]
        else: # Single seat
            row = seats[:-1]
            column = seats[-1]
            if row in dict_of_seats:
                if column not in dict_of_seats[row]:
                    dict_of_seats[row].append(column)
            else:
                dict_of_seats[row] = [column]

    # Append ROD segments to the message
    list_of_rows = dict_of_seats.keys()
    list_of_rows.sort()
    for row in list_of_rows:
        message += "ROD+" + row + "+"
        for column in dict_of_seats[row]:
            message += "+" + column + ":" + status
        message += "'"

    return message[:-1] # To remove last "'"


def update_seat_characteristics(air_segment, list_of_seats, characteristics):
    """Update the seat characteristic for a list of seats..

    :Non-keyword arguments:
        - air_segment -- flight/date to update.
        - list_of_seats -- seats for which the status should be changed
        - characteristics -- added seat characteristics of the seats. Can be ES (Economy Seat), A (Aisle Seat), B (Seat with bassinet facility) and so on.

    :Example: 

    >>>generic_lib.update_seat_characteristics(f_sm, ["23A-24F", "26A-26B", "26D"], "C")
    (...)ROD+23++A:K+B:K+C:K+D:K+E:K+F:K'ROD+24++A:K+B:K+C:K+D:K+E:K+F:K'ROD+26++A:K+B:K+D:K'(...)

    """

    #message = "DCX+" + len(air_segment.dcx) + "+" + air_segment.dcx + "'"
    message = "DCX+134+<DCC VERS=\"1.0\"><MW><UKEY VAL=\"14TB93#1VZ0BEKYKNBF56\" TRXNB=\"17-1\"/><DYNR><PEAKTK TYPE=\"AIRIT\" VAL=\"" + air_segment.airline + "\" ACTION=\"O\"/></DYNR></MW></DCC>'" \
    + "ORG+00+12345675:NCE1A0955'" \
    + "FDQ+" + air_segment.airline + "+" + air_segment.flight_nb + "+" + air_segment.edi_dep_date + "+" + air_segment.board_pt + "+" + air_segment.off_pt + "'" \
    + "ODI+" + air_segment.board_pt + "+" + air_segment.off_pt + "'"

    # Create dictionnary of seats impacted
    dict_of_seats = {}
    for seats in list_of_seats:
        if "-" in seats: # Range of seats
            row_1 = seats.split("-")[0][:-1]
            column_1 = seats.split("-")[0][-1]
            row_2 = seats.split("-")[1][:-1]
            column_2 = seats.split("-")[1][-1]
            for row in range(int(row_1), int(row_2) + 1):
                for column in range(ord(column_1), ord(column_2) + 1):
                    if str(row) in dict_of_seats:
                        if chr(column) not in dict_of_seats[str(row)]:
                            dict_of_seats[str(row)].append(chr(column))
                    else:
                        dict_of_seats[str(row)] = [chr(column)]
        else: # Single seat
            row = seats[:-1]
            column = seats[-1]
            if row in dict_of_seats:
                if column not in dict_of_seats[row]:
                    dict_of_seats[row].append(column)
            else:
                dict_of_seats[row] = [column]

    # Append ROD segments to the message
    list_of_rows = dict_of_seats.keys()
    list_of_rows.sort()
    for row in list_of_rows:
        message += "ROD+" + row + "+"
        for column in dict_of_seats[row]:
            message += "+" + column + ":F::" + characteristics
        message += "'"

    return message[:-1] # To remove last "'"
