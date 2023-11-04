import sys
import json
from md5 import md5_to_bytes
from rc5 import RC5
from generators import LCGennerator
import base64
import os


with open(sys.argv[1], 'rb') as f:  
    data = f.read()

key = sys.argv[2]
script_directory = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_directory)
with open('config.json', 'r') as config_file:
    config_data = json.load(config_file)
w = config_data["rc5"]["w"]
r = config_data["rc5"]["r"]
key = bytearray(key.encode('utf-8'))
key = md5_to_bytes(key)
lc = LCGennerator(1, 8)
iv = lc.generate_sequence() 

ans = RC5(key, w=16, r=20)
l = ans.k_to_l()
s = ans.generate_s()
mix = ans.mixer(s, l)
enc = ans.encode(mix, data, s)
enc = base64.b64encode(enc).decode('utf-8')
print(enc)

