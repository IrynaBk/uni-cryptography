from generators import LCGennerator
import sys
import json

script_name, a, m, c, x, n = sys.argv
generator = LCGennerator(int(x), int(n), int(a), int(m), int(c))
result = generator.generate_sequence()
period = generator.find_period()

output = {
    'result': result,
    'period': period
}

print(json.dumps(output))
