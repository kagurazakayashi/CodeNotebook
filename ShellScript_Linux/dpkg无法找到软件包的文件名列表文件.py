#!/usr/bin/env python
# -*- coding: utf-8 -*-
# 先把错误输出行记录到 log.txt
import re
def main():
    fix = open('fix.sh', 'w+')
    for line in open("log.txt"):
        pkg = re.match(re.compile('''dpkg: 警告: 无法找到软件包 (.+) '''), line)
        if pkg:
            cmd = "sudo apt-get -y install --reinstall " + pkg.group(1)
            fix.write(cmd + '\n')
        print("OK")
if __name__ == "__main__":
    main()
# 创建出 fix.sh 执行。
# https://www.pythonf.cn/read/105362