# coding:utf-8
# Author: 神楽坂雅詩
# Date: 2022-9-30
# Description: 轉換 ifly 的黑名單檔案 blacklist.bin
# Version: 1.0.1
# Usage: python3 iflyblacklist.py "blacklist.bin" "blacklist.txt"
#          blacklist.bin: 匯出的黑名單檔案
#          blacklist.txt: 儲存的黑名單檔案(可選，預設 json 直接輸出。支援 txt/json/csv )
# License: WTFPL
import json
import sys
binfile: str = "blacklist.bin"
if len(sys.argv) > 1:
    binfile = sys.argv[1]
f = open(binfile, 'r', encoding='utf-16le')
line: str = f.readline()
ech: list[bytes] = [b'\x00\x00', b'\x01\x00', b'\x02\x00', b'\x03\x00',
                    b'\x04\x00', b'\x06\x00', b'\x07\x00', b'\x08\x00', b'\x09\x00', b'\x0c\x00']
cach: str = ""
i: int = 0
dic: list[str] = []
while line:
    line = line.strip()
    if len(line) == 0:
        continue
    for ch in line:
        if ch.encode('utf-16le') in ech:
            if len(cach) > 0:
                dic.append(cach)
                cach = ""
        else:
            cach += ch
    line = f.readline()
    i += 1
f.close()
if len(dic) > 4:
    for num in range(4):
        del(dic[0])
jsonstr: str = json.dumps(dic, ensure_ascii=False)
if len(sys.argv) > 2:
    tofile: str = sys.argv[2]
    tofileArr: list[str] = tofile.split('.')
    extname: str = tofileArr[len(tofileArr) - 1]
    f = open(tofile, 'w+', encoding='UTF-8')
    if extname == 'json':
        f.write(jsonstr)
    elif extname == 'csv':
        f.write(",".join(dic))
    else:
        firstline = True
        for item in dic:
            if firstline:
                firstline = False
            else:
                f.write("\n")
            f.write(item)
    f.close()
    print(binfile, "->", len(dic), "->", tofile)
else:
    print(jsonstr)
