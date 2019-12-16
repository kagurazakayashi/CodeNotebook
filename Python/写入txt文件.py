fw = open("/exercise1/data/query_deal.txt", 'w')    #将要输出保存的文件地址
for line in open("/exercise1/data/query.txt"):    #读取的文件
    fw.write("\"poiName\":\"" + line.rstrip("\n") + "\"")    # 将字符串写入文件中
    # line.rstrip("\n")为去除行尾换行符
    fw.write("\n")    # 换行
# https://blog.csdn.net/xwd18280820053/article/details/53008448