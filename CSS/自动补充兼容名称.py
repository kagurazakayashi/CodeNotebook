#coding:utf-8
# 雅詩 CSS 相容性最佳化工具
# by 神楽坂雅詩
import sys
print("css-compatibility:")
def keyframes(fileLine):
    working = False
    nowLine = list()
    newFile = list()
    nowType = [
        "@-webkit-keyframes",
        "@-moz-keyframes",
        "@-ms-keyframes",
        "@-o-keyframes"
    ]
    nowJob = "@keyframes"
    for line in fileLine:
        if nowJob in line:
            print(line)
            working = True
        if working:
            nowLine.append(line)
        newFile.append(line)
        if len(line) > 0 and line[0:1] == "}":
            working = False
            for newType in nowType:
                if len(nowLine) > 0:
                    nowLine0 = nowLine[0]
                    nowLine[0] = nowLine[0].replace(nowJob, newType)
                    for newLine in nowLine:
                        newFile.append(newLine)
                    nowLine[0] = nowLine0
            nowLine = list()
    return newFile

def animation(fileLine):
    working = False
    nowLine = list()
    newFile = list()
    nowType = [
        "-webkit-animation",
        "-moz-animation",
        "-ms-animation",
        "-o-animation"
    ]
    nowJob = "animation"
    for line in fileLine:
        newFile.append(line)
        if nowJob in line:
            print(line)
            for newType in nowType:
                newFile.append(line.replace(nowJob, newType))
    return newFile

def transform(fileLine):
    working = False
    nowLine = list()
    newFile = list()
    nowType = [
        "-webkit-transform",
        "-moz-transform",
        "-ms-transform",
        "-o-transform"
    ]
    nowJob = "transform"
    for line in fileLine:
        newFile.append(line)
        if nowJob in line:
            print(line)
            newFile.append(line)
            for newType in nowType:
                newFile.append(line.replace(nowJob, newType))
    return newFile

if len(sys.argv) < 3 :
    print("help: css-compatibility.py <in.css> <out.css>")
    quit()
f = open(sys.argv[1], 'r')
fileLine = list()
for line in f.readlines():
    fileLine.append(line)
f.close()

fileLine = keyframes(fileLine)
fileLine = animation(fileLine)
fileLine = transform(fileLine)

fw = open(sys.argv[2], 'w')
for line in fileLine:
    line = line.replace("\r", "")
    line = line.replace("\n", "")
    fw.write(line)
    fw.write("\n")
fw.close()
print("OK")