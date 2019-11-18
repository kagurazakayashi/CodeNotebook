# -*- coding: utf-8 -*-
# pip3 install pyperclip

import sys
import time
import pyperclip
import base64

timer = 3
if len(sys.argv) == 2 :
    f = open(sys.argv[1], 'r')
    for line in f.readlines():
        line = line.strip()
        if not len(line) or line.startswith('#'):
            continue
        pyperclip.copy(base64.b64decode(line.encode()).decode())
        print("密码已复制到剪贴板，请在 "+str(timer)+" 秒内粘贴。")
        break
    time.sleep(timer)
    pyperclip.copy("")
    print("已清除剪贴板。")
else :
    print("雅诗密码临时复制工具")
    print("这个脚本将复制指定文本文件中的第一个有效行到剪贴板，并在 "+str(timer)+" 秒后清除剪贴板。")
    print("使用: python3 clipautoclear.py <文本文件名称>")