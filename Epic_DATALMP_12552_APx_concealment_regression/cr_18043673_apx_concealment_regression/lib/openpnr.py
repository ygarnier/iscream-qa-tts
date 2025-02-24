'''
Parse the skube DocumentEnvelopes protobuf message from TTS raw binary
and convey the contained base64 OpenPNR through global_regression.

DocumentEnvelopes messages are structured as in the example:
{
    "envelopes": [
        {
        "binaryPayload": "ChFPRlhBNk0tMjAyNC0wMS0w...", 
            "metadata": {
                "grammarDomain": "com.amadeus.models.reservation.pnr.v2", 
                "ianaContentType": "application/vnd.google.protobuf", 
                "name": "OFXA6M", 
                "version": "0", 
                "grammarName": "Pnr"
            }
        }
    ]
}

The actual OpenPNR message is in the binaryPayload field.
'''

from google.protobuf.json_format import MessageToDict
import json
import TTServer

from lib import document_envelopes_pb2 as pb2


TTS_OK = TTServer.currentMessage.TTS_MATCH_COMPARISON_OK
TTS_KO = TTServer.currentMessage.TTS_MATCH_COMPARISON_FAILURE


def extract_binary_payload(global_regression, raw_binary):
    '''
    The function needs to return TTS OK or FAILURE to be usable in TTS Match entries.
    '''
    global_regression.openpnr_payload = ''

    # Transform back characters that TTS escaped
    to_replace = {'\\%': '%', '\'': '\\\'', '\\{': '{', '\\}': '}'}
    for token, r in to_replace.items():
        raw_binary = raw_binary.replace(token, r)
    try:
        # Interpret the input as escaped bytes, then encode back to ASCII as expected by protobuf
        raw_binary = raw_binary.decode('unicode-escape').encode('latin1')

        # Use protobuf generated code to parse the message into a dict, then extract the interesting field
        # When parsing into dict, the binary payload is returned directly in base64 format,
        # ready to be interpreted by the OpenPNR API.
        envelopes = pb2.DocumentEnvelopes()
        envelopes.ParseFromString(raw_binary)
        envelopes_dict = MessageToDict(envelopes)
        global_regression.openpnr_payload = envelopes_dict['envelopes'][0]['binaryPayload']
    except Exception as e:
        print('Unexpected protobuf error: {}'.format(e))
        return TTS_KO
    return TTS_OK

