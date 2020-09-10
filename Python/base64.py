import base64
s = "字符串"
a = base64.b64encode(s).decode() # 用于编码 json 时必须 decode()
print(a)
# ztLKx9fWt/u0rg==
print(base64.b64decode(a))