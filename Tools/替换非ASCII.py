#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# @Author: KagurazakaYashi (神楽坂雅詩)
# @Comment: 搜索文件中的所有非标准 ASCII 字符，
#           转换为哈希值（不含 0x ），
#           当每个连续的非标准 ASCII 字符以数字开头时加前缀。
# @Example: python3 "enc.py" "test.js" "test2.js" "n"
#           test.js: var 测试 = "test";
#           test2.js: var n6d4b8bd5 = "test"

import sys

if sys.version_info[0] < 3:
    raise Exception("Not Python 3")
pythonFileName = sys.argv[0]
inputFileName = ""
outputFileName = ""
prefix = "n"
if len(sys.argv) > 1:
    inputFileName = sys.argv[1]
if len(sys.argv) > 2:
    outputFileName = sys.argv[2]
if len(sys.argv) > 3:
    prefix = sys.argv[3]
if len(inputFileName) == 0:
    print("使用: " + pythonFileName + " <输入文件> <输出文件=stdout> <字串转码后以数字开头时加前缀='n'>")
    sys.exit(1)
# if len(outputFileName) == 0:
#     outputFileName = inputFileName
f = open(inputFileName, "r", encoding="UTF-8")
txt = f.read()
f.close()
if len(txt) == 0:
    print("[" + pythonFileName + "] " + inputFileName + " is empty")
    sys.exit(1)
newtxt = ""
cache = ""
txt = txt + " "
for t in txt:
    if t.isascii() == False:
        code = ord(t)  # 27979
        code = hex(code)  # 0x6d4b
        code = code[2:]  # 6d4b
        cache = cache + code
    else:
        if len(cache) > 0:
            fchar = cache[0]  # 6
            if fchar.isdigit() == True:
                newtxt = newtxt + prefix + cache
            else:
                newtxt = newtxt + cache
            cache = ""
        newtxt = newtxt + t
txt = txt[:-1]
newtxt = newtxt[:-1]
if len(outputFileName) > 0:
    f = open(outputFileName, "w", encoding="UTF-8")
    f.write(newtxt)
    f.close()
    print("[" + pythonFileName + "] " + inputFileName + " -> " + outputFileName)
    print(
        "["
        + pythonFileName
        + "] "
        + str(len(txt))
        + " -> "
        + str(len(newtxt))
        + " ( "
        + str(len(newtxt) - len(txt))
        + " ), "
        + prefix
        + "#"
    )
else:
    print(newtxt)
