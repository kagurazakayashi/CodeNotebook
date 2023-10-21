#!coding=utf-8
# 神楽坂雅詩
# 注：本文件文件名不能命名为 opencc.py
# 使用： .py 语言json名称，不含'.json'
import sys
# pip3 install opencc opencc-python-reimplemented pyperclip
import opencc
import pyperclip

mode = 's2twp.json' # https://github.com/BYVoid/OpenCC#%E9%A0%90%E8%A8%AD%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6
try:
    clipin = pyperclip.paste()
except pyperclip.PyperclipException:
    print('E: 读取剪贴板失败')
    quit()
if type(clipin) != str:
    print('E: 不支持的剪贴板数据格式')
    quit()
if len(clipin) == 0:
    print('E: 剪贴板中没有需要转换的内容')
    quit()
if len(sys.argv) > 1:
    mode = sys.argv[1]+'.json'
converter = opencc.OpenCC(mode)
clipout = str(converter.convert(clipin))
print(clipin)
if clipin == clipout:
    print('W: 转换之后的内容和之前一致')
    quit()
print(str(len(clipin))+' -> '+mode+' -> '+str(len(clipout)))
print(clipout)
try:
    pyperclip.copy(str(clipout))
except pyperclip.PyperclipException as e:
    print('E: 无法写入剪贴板', str(e))
    quit()
clipin = pyperclip.paste()
if clipin != clipout:
    print('E: 写入剪贴板失败')
    quit()
