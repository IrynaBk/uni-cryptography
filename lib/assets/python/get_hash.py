import sys
from md5 import md5

import sys
import base64

encoded_content = sys.argv[1]
decoded_content_bytes = base64.b64decode(encoded_content)

print(md5(decoded_content_bytes))

