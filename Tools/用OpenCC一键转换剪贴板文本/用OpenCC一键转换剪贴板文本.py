#!coding=utf-8
# 神楽坂雅詩
import sys
# pip3 install opencc
import opencc
# pip3 install pyperclip
import pyperclip

clipin = pyperclip.paste()
if type(clipin) != str:
    print('E: 不支持的剪贴板数据格式')
    quit()
if len(clipin) == 0:
    print('E: 剪贴板中没有需要转换的内容')
    quit()
# https://github.com/BYVoid/OpenCC#%E9%A0%90%E8%A8%AD%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6
mode = 's2twp.json'
if len(sys.argv) > 1 :
    mode = sys.argv[1]+'.json'
converter = opencc.OpenCC(mode)
clipout = str(converter.convert(clipin))
print(clipin)
if clipin == clipout:
    print('W: 转换之后的内容和之前一致')
    quit()
print(str(len(clipin))+' -> '+mode+' -> '+str(len(clipout)))
print(clipout)
pyperclip.copy(clipout)