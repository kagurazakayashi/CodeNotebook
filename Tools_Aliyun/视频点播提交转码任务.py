#!/usr/bin/env python
#coding=utf-8

# pip install aliyun-python-sdk-vod

from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.acs_exception.exceptions import ClientException
from aliyunsdkcore.acs_exception.exceptions import ServerException
from aliyunsdkvod.request.v20170321.SubmitTranscodeJobsRequest import SubmitTranscodeJobsRequest

client = AcsClient('<accessKeyId>', '<accessSecret>', 'cn-beijing')

request = SubmitTranscodeJobsRequest()
request.set_accept_format('json')

request.set_TemplateGroupId("<TemplateGroupId>")
request.set_VideoId("<VideoId>")

response = client.do_action_with_exception(request)
# python2:  print(response) 
print(str(response, encoding='utf-8'))