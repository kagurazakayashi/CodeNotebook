#coding:utf-8
# 将关联数组JSON文件转换为Excel表（Key-Val表）。
# 如果JSON是多维关联数组将转换为一维关联数组。
# 使用 python json2xls.py <JSON文件名>
# by 神楽坂雅詩
import json
import xlwt
import sys
if len(sys.argv) == 1:
    print("缺少参数：JSON文件名")
    sys.exit()
fname = sys.argv[1]
keylv = []
workbook = xlwt.Workbook(encoding='utf-8')
booksheet = workbook.add_sheet('Sheet 1', cell_overwrite_ok=True)
xlsline = 0
booksheet.write(xlsline,0,"ID")
booksheet.write(xlsline,1,fname)
def loaddata(arr):
    global xlsline
    for key,value in arr.items():
        nowkey = ""
        if len(keylv) > 0:
            nowkey = '/'.join(keylv)
            nowkey += '/' + key
        else :
            nowkey = key
        if isinstance(value,dict):
            keylv.append(key)
            loaddata(value)
            if len(keylv) > 0:
                keylv.pop()
        elif isinstance(value,str):
            xlsline += 1
            booksheet.write(xlsline,0,nowkey)
            booksheet.write(xlsline,1,value)
            print(str(xlsline)+' | '+nowkey+' | '+value)
f = open(fname, 'r', encoding='UTF-8')
jsondata = f.read()
f.close()
jsonarr = json.loads(jsondata)
loaddata(jsonarr)
workbook.save(fname+'.xls')