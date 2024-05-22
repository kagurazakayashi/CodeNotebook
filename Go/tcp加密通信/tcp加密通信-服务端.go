// GO TCP 加密通信服务端

package main

import (
    "crypto/tls"
    "log"
    "net"
)

func main() {
    cer, err := tls.LoadX509KeyPair("cert.pem", "key.pem")
    if err != nil {
        log.Fatalf("Failed to load key pair: %s", err)
    }

    config := &tls.Config{Certificates: []tls.Certificate{cer}}
    ln, err := tls.Listen("tcp", "0.0.0.0:443", config)
    if err != nil {
        log.Fatalf("Failed to listen: %s", err)
    }
    defer ln.Close()

    for {
        conn, err := ln.Accept()
        if err != nil {
            log.Println(err)
            continue
        }
        go handleConnection(conn)
    }
}

func handleConnection(conn net.Conn) {
    defer conn.Close()
    // 处理连接
}
