from threading import Thread
import time
aaa = ""
bbb = ""
def workt():
    global pubkey
    global privkey
    time.sleep(10)
    aaa = "22"
    bbb = "33"
t = Thread(None,workt)
t.start()
wtxti = 0
while 1:
    if (pubkey != ""):
        break
    wtxti += 1
    print("%s ( %i )" % ("work...", wtxti))
    time.sleep(1)
print("OK")