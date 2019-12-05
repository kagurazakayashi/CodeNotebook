#!/usr/bin/env python
#coding=utf-8

# pip install aliyun-python-sdk-core
# pip install aliyun-python-sdk-core-v3  #PY3
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.acs_exception.exceptions import ClientException
from aliyunsdkcore.acs_exception.exceptions import ServerException
from aliyunsdkcdn.request.v20180510.DescribeCdnDomainLogsRequest import DescribeCdnDomainLogsRequest
import json

client = AcsClient('<accessKeyId>', '<accessSecret>', 'cn-hangzhou')

request = DescribeCdnDomainLogsRequest()
request.set_accept_format('json')

# 域名，只支持单个查询。
request.set_DomainName(".yoooooooooo.com")
# 分页大小，默认300，最大1000，取值：1~1000。
request.set_PageSize(1000)
# 取得第几页，取值范围为：大于1的任意整数。
request.set_PageNumber(0)
# 获取日志起始时间点。日期格式按照ISO8601表示法，并使用UTC时间。
request.set_StartTime("2019-12-20T00:00:00Z")
# 获取日志结束时间。结束时间需大于起始时间，起止时间和结束时间，间隔不超过一年。获取日期格式按照ISO8601表示法，并使用UTC时间。
request.set_EndTime("2019-12-20T23:59:59Z")

response = client.do_action_with_exception(request)
# print(str(response, encoding='utf-8'))

jsonarr = json.loads(response)
logsarr = jsonarr["DomainLogDetails"]["DomainLogDetail"][0]["LogInfos"]["LogInfoDetail"]
for loginfo in logsarr:
    name = loginfo["LogName"]
    path = loginfo["LogPath"]
    if name[0] == '.':
        name = "_"+name
    print("curl \""+path+"\" -o \""+name+"\"")