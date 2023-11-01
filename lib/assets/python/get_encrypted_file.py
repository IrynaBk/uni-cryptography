import sys
from md5 import md5_to_bytes
from rc5 import RC5
from generators import LCGennerator
import base64


with open(sys.argv[1], 'rb') as f:  
    data = f.read()

key = sys.argv[2]
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

