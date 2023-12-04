import os
import sys
from .md5 import md5_to_bytes
from .rc5 import RC5
import base64


with open(sys.argv[1], 'r') as file:
    base64_encoded_data = file.read()
enc = base64.b64decode(base64_encoded_data)
# print(enc)
key = sys.argv[2]

# print(base64_encoded_data)
key = bytearray(key.encode('utf-8'))
key = md5_to_bytes(key)
ans = RC5(key, w=16, r=20)
ans.set_key(key)
l = ans.k_to_l()
s = ans.generate_s()
mix = ans.mixer(s, l)

dec = ans.decode(mix, enc)
dec = base64.b64encode(dec).decode('utf-8')
print(dec)