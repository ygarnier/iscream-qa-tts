'''
Match functions for JSON messages extracted via TTS.
'''

import json
import re


# Match a word + [ + integer + ], as in the representation of an element of an array,
# and identify the field name and the index.
# E.g., 
# - from 'traveler' -> no match
# - from 'traveler[2]' -> field_name = 'traveler', index = '2'
FIND_INDEX = re.compile('(?P<field_name>[\w_]+)\[(?P<index>[0-9]+)\]')


def parse_json(input_json):
    '''Transform the input JSON to dict or raise a readable exception.'''
    try:
        to_replace = {'&\n': '\n', '\\{': '{', '\\}': '}'}
        for token, replacement in to_replace.items():
            input_json = input_json.replace(token, replacement)
        return json.loads(input_json)
    except Exception as e:
        #print('Raw json: {}'.format(input_json)) # Uncomment to log additional details
        raise RuntimeError('the input OpenPNR should be in valid JSON format, error: {}'.format(e))


def assert_direct_found(field, container):
    '''
    Rely on python assert to raise an exception with a clear message
    if the field is not found in the input container.
    E.g., for the container:
    {
        "travelers" [
            {
                "firstName": "JOHN"
            },
            {
                "firstName": "MARK"
            },
        ]
    }
    assert_found('travelers', container) is successful
    assert_found('firstName', container['travelers'][0]) is successful
    assert_found('products', container) raises an exception
    '''
    assert field in container, 'expected field {} not found in OpenPNR'.format(field)


def assert_equal(expected, actual, item_name):
    '''Rely on python assert to raise an exception with a clear message.'''
    assert expected == actual, 'expected value {} for {}, found {}'.format(expected, item_name, actual)


def assert_found(field, container):
    '''
    Rely on python assert to raise an exception with a clear message.
    If the field is a complex path, walk through the path.
    E.g., for the container:
    {
        "travelers" [
            {
                "firstName": "JOHN"
            },
            {
                "firstName": "MARK"
            },
        ]
    }
    assert_found('travelers', container) is successful
    assert_found('firstName', container['travelers'][0]) is successful
    assert_found('products', container) raises an exception
    assert_found('travelers[0]/firstName', container) is successful

    Split the field name by /, then for each token use the regexp to look for an index between [ ]
    '''
    keys = field.split('/')
    current_path = ''
    current_container = container
    for key in keys:
        index_found = FIND_INDEX.match(key)
        if index_found:
            field_name = index_found.group('field_name')
            index = int(index_found.group('index'))
            assert_direct_found(field_name, current_container)
            assert isinstance(current_container[field_name], list), 'field {} is not a list'.format(field_name)
            assert (len(current_container[field_name]) > index), \
                'repetition #{} not found in {}/{}, only {} occurrences found'.format(index, current_path, field_name, len(current_container[field_name]))
            current_path = '{}/{}[{}]'.format(current_path, field_name, index)
            current_container = current_container[field_name][index]
        else:
            field_name = key
            assert_direct_found(field_name, current_container)
            current_path = '{}/{}'.format(current_path, field_name)
            current_container = current_container[field_name]


def assert_not_found(field, container):
    exception_raised = False
    try:
        assert_found(field, container=container)
    except AssertionError:
        exception_raised = True
    assert exception_raised, '{} found while not expected'.format(field)
