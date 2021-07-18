#!/usr/bin/env python
#coding=utf-8

# pip install aliyun-python-sdk-vod

from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.acs_exception.exceptions import ClientException
from aliyunsdkcore.acs_exception.exceptions import ServerException
from aliyunsdkvod.request.v20170321.SubmitTranscodeJobsRequest import SubmitTranscodeJobsRequest

client = AcsClient('LTAIOsaayXMVjWU2', 'PmmViPe6yHlA1ZeLERODLiNKcCDvcF', 'cn-beijing')

request = SubmitTranscodeJobsRequest()
request.set_accept_format('json')

request.set_TemplateGroupId("673ca5975930dfc2a241b437c796c23b")
request.set_VideoId("f1396e983e014fb4a376e76e84b926bb")

response = client.do_action_with_exception(request)
# python2:  print(response) 
print(str(response, encoding='utf-8'))