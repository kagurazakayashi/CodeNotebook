# -*- coding:utf-8 -*-
import rsa

# 生成 pkcs1 密钥对
(pub, pri) = rsa.newkeys(4096)
# 在子线程中生成
pubkey = ""
privkey = ""
def workt():
    global pubkey
    global privkey
    (pub, pri) = rsa.newkeys(4096)
    pubkey = pub
    privkey = pri
t = Thread(None, workt)
t.start()
wtxti = 0
while 1:
    if (pubkey != ""):
        break
    wtxti += 1
    print("%s ( %i )" % (wtxt, wtxti))
    time.sleep(1)
publickey = pubkey.save_pkcs1()
privatekey = privkey.save_pkcs1()
print(publickey)
print(privatekey)