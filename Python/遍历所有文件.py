# -*- coding: utf-8 -*-
#!/usr/bin/python3
# pip install PyMySQL
import os
import sys
import time
import datetime
import pymysql
db = pymysql.connect("127.0.0.1","fileuser","wPYIT0SL5lVjQjwS1Y7KwdkzuG3AxGcNtexkvxEUb3VEt5E2yYd7UpHthJwfqdwYjr8H6qEPtp2UjLkpJriR9HkSt64rWvS1lMfyOX0ml1uTd9Yc9sIGSxbrCP92vt0C","file" )
cursor = db.cursor()
def TimeStampToTime(timestamp):
    return time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(timestamp))
def getfilelist(filepath):
    try:
        files = os.listdir(filepath)
    except BaseException as e:
        print(format(e))
        return
    fId = 0
    for fName in files:
        fFullPath = os.path.join(filepath,fName)
        if os.path.isdir(fFullPath):
            getfilelist(fFullPath)
        else:
            fExtension = ""
            fNE = fName.split('.')
            if len(fNE) > 1:
                fExtension = fNE.pop(-1)
                fName = '.'.join(fNE)
            fAccessTime = ""
            try:
                fAccessTime = TimeStampToTime(os.path.getatime(fFullPath))
            except BaseException as e:
                print(format(e))
            fCreateTime = ""
            try:
                fCreateTime = TimeStampToTime(os.path.getctime(fFullPath))
            except BaseException as e:
                print(format(e))
            fModifyTime = ""
            try:
                fModifyTime = TimeStampToTime(os.path.getmtime(fFullPath))
            except BaseException as e:
                print(format(e))
            fSize = ""
            try:
                fSize = os.path.getsize(fFullPath)
            except BaseException as e:
                print(format(e))
            # print("文件所在路径: "+filepath+" 文件名: "+fName+" 扩展名: "+fExtension+" 访问时间: "+fAccessTime+" 创建时间: "+fCreateTime+" 修改时间: "+fModifyTime+" 文件尺寸: "+str(fSize))
            sqlk = ['id']
            sqlv = [str(fId)]
            if fName != "":
                sqlk.append('name')
                sqlv.append(fName)
            if fExtension != "":
                sqlk.append('extension')
                sqlv.append(fExtension)
            if filepath != "":
                sqlk.append('path')
                sqlv.append(filepath)
            if fAccessTime != "":
                sqlk.append('accesstime')
                sqlv.append(fAccessTime)
            if fCreateTime != "":
                sqlk.append('createtime')
                sqlv.append(fCreateTime)
            if fModifyTime != "":
                sqlk.append('modifytime')
                sqlv.append(fModifyTime)
            if fSize != "":
                sqlk.append('size')
                sqlv.append(str(fSize))
            sqlks = '`, `'.join(sqlk)
            sqlvs = "', '".join(sqlv)
            sqlcmd = "INSERT INTO `file`.`osx` (`"+sqlks+"`) VALUES ('"+sqlvs+"')"
            try:
                cursor.execute(sqlcmd)
                db.commit()
                fId += 1
            except BaseException as e:
                print(format(e))
                # db.rollback()
input = sys.argv
rootdir = input[1]
getfilelist(rootdir)
db.close()