# 美化curl返回的json  curl json
# 在curl命令后面加上 | python -m json.tool
curl -X POST "http://127.0.0.1:11451/api/" -d "k1=v1&k2=v2" | python -m json.tool