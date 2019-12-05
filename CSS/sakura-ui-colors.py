# https://github.com/Firenzia/sakura-ui/

import json

f = open("sakura-ui-colors.json",encoding="utf8")
lines = f.read()
f.close()

units = json.loads(lines)
for unit in units:
    for item in unit:
        color = item["color"]
        cnName = item["cnName"]
        jpName = item["jpName"]
        print(color+"  "+cnName+"  "+jpName)