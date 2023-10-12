import sys
from md5 import md5

with open(sys.argv[1], 'rb') as f:  
    content = f.read()
byte_array_content = bytearray(content)

print(md5(byte_array_content))

