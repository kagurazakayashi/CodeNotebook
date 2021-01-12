#!coding=utf-8
# 神楽坂雅詩
import sys
# pip3 install opencc
import opencc
# pip3 install pyperclip
import pyperclip

clipin = pyperclip.paste()
if type(clipin) != str or len(clipin)==0:
    print('E: '+str(type(clipin)))
    quit()
# https://github.com/BYVoid/OpenCC#%E9%A0%90%E8%A8%AD%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6
mode = 's2twp.json'
if len(sys.argv) > 1 :
    mode = sys.argv[1]+'.json'
converter = opencc.OpenCC(mode)
clipout = converter.convert(clipin)
print(clipin)
if clipin == clipout:
    print('W: '+str(len(clipin))+' ==')
    quit()
print(str(len(clipin))+' -> '+mode+' -> '+str(len(clipout)))
print(clipout)
pyperclip.copy(clipout)