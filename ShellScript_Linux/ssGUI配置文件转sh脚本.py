# encoding=utf8
# by KagurazakaYashi
# 和 gui-config.json 放在一起并执行
import sys
import json
reload(sys)
sys.setdefaultencoding('utf8')
with open("gui-config.json",'r') as load_f:
    load_dict = json.load(load_f)
    configs = load_dict['configs']
    for i in range(0, len(configs)):
        nowconf = configs[i]
        name = configs[i]["remarks"]
        name = "ss" + name.replace(" ", "")
        name1 = name + ".json"
        name2 = name + ".sh"
        shfile = "python shadowsocks/shadowsocks/local.py -c " + name + ".json"
        with open(name1,"w") as f:
            print(name1)
            json.dump(nowconf,f)
        with open(name2,"w") as f2:
            print(name2)
            f2.write(shfile)
# 执行：python gsspy.py && chmod +x *.sh
# 清除：rm -f ss*.sh ss*.json
