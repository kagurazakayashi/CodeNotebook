# coding:utf-8
import yaml # pip3 install PyYAML
f = open("test.yaml")
print(yaml.load(f)) # 已弃用
print(yaml.safe_load)
print(yaml.full_load)
print(yaml.unsafe_load)