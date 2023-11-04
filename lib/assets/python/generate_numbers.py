from generators import LCGennerator
import sys
import json
import os



script_name, x, n = sys.argv
script_directory = os.path.dirname(os.path.abspath(__file__))

os.chdir(script_directory)
with open('config.json', 'r') as config_file:
    config_data = json.load(config_file)
a = config_data["lc_generator"]["a"]
m = config_data["lc_generator"]["m"]
c = config_data["lc_generator"]["c"]

generator = LCGennerator(int(x), int(n), int(a), int(m), int(c))
result = generator.generate_sequence()
period = generator.find_period()

output = {
    'result': result,
    'period': period
}

print(json.dumps(output))
