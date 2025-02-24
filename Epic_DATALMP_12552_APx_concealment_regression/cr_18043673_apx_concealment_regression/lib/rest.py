import base64
from hashlib import sha1
import json
import random
import time

def generate_nonce(length=16):
  return ''.join([str(random.randint(0, 9)) for i in range(length)])

def get_sha_token(nonce, timestamp, pwd):
    sha_password = sha1()
    sha_password.update(pwd)
    result = sha1()
    result.update(base64.b64decode(nonce))
    result.update(timestamp)
    result.update(sha_password.digest())
    return base64.b64encode(result.digest())

def generate_auth_key(user_id, password, office_id, organization):
    nonce = base64.b64encode(generate_nonce())
    current_time_raw = time.gmtime()
    current_time = time.strftime('%Y-%m-%dT%H:%M:%S.000Z', current_time_raw)
    hashed_pwd = get_sha_token(nonce, current_time, password)
    lss_user = {
       "userId": user_id,
       "officeId": office_id,
       "organization": organization,
       "timestamp": current_time,
       "nonce": nonce,
       "password": hashed_pwd
    }
    return base64.b64encode(json.dumps(lss_user, separators = (',', ':')))
