#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# @Author: KagurazakaYashi (神楽坂雅詩)
# @Comment: 用于更新多个文件中的某一特定段落的值。
#           自动将 path.sh 中的 ##SHAREPATHSTART 到
#           ##SHAREPATHEND 的内容分别赋值到
#           .bashrc 和 .zshrc 的 ##SHAREPATHSTART 到 
#           ##SHAREPATHEND 中（如果没有则创建）。
# @Example: python3 "path.sh" "path.sh" ".bashrc,.zshrc" "##SHAREPATHSTART,##SHAREPATHEND"
#           path.sh: ##SHAREPATHSTART export PATH="$PATH:/usr/local/bin" ##SHAREPATHEND
#           .bashrc: ... more ... ##SHAREPATHSTART export PATH="$PATH:/usr/local/bin" ##SHAREPATHEND

import os
import sys

if sys.version_info[0] < 3:
    raise Exception("Not Python 3")
pf = ["##SHAREPATHSTART", "##SHAREPATHEND"]
inputFileName = "path.sh"
outputFileName = ".bashrc,.zshrc"

def cutStr(pstr, startstr, endstr, isDelete=False):
    start = pstr.find(startstr)
    if start >= 0:
        start += len(startstr)
        end = pstr.find(endstr, start)
        if end >= 0:
            if isDelete == True:
                return pstr[: start - len(startstr)] + pstr[end + len(endstr) :]
            else:
                return pstr[start:end]
    return pstr

pythonFileName = sys.argv[0]
if len(sys.argv) > 1:
    inputFileName = sys.argv[1]
if len(sys.argv) > 2:
    outputFileName = sys.argv[2]
if len(sys.argv) > 3:
    pf = sys.argv[3].split(",")
if len(inputFileName) == 0 or len(outputFileName) == 0:
    print("使用: " + pythonFileName + " <输入文件> <输出文件,分隔> <前缀,后缀>")
    sys.exit(1)
f = open(inputFileName, "r", encoding="UTF-8")
txt = f.read()
f.close()
newStr = pf[0] + "\n" + cutStr(txt, pf[0], pf[1], False) + "\n" + pf[1]

for outputFile in outputFileName.split(","):
    print("[" + pythonFileName + "] " + inputFileName + " -> " + outputFile)
    otxt = ""
    pline = ""
    flen = 0
    if os.path.exists(outputFile) == True:
        f = open(outputFile, "r", encoding="UTF-8")
        otxt = f.read()
        flen = len(otxt)
        otxt = cutStr(otxt, pf[0], pf[1], True)
        if len(otxt) > 0:
            if otxt[-1] != "\n":
                pline = "\n"
        f.close()
    else:
        print("[" + pythonFileName + "] " + outputFile + " not exists")
    otxt = otxt + pline + newStr
    f = open(outputFile, "w", encoding="UTF-8")
    f.write(otxt)
    f.close()
    print("[" + pythonFileName + "] " + str(flen) + " -> " + str(len(otxt)) + " (" + str(len(otxt) - flen) + ")")
