// GO TCP 加密通信客户端

package main

import (
    "crypto/tls"
    "crypto/x509"
    "io/ioutil"
    "log"
)

func main() {
    cert, err := ioutil.ReadFile("cert.pem")
    if err != nil {
        log.Fatalf("Failed to read cert file: %s", err)
    }
    certPool := x509.NewCertPool()
    certPool.AppendCertsFromPEM(cert)

    conf := &tls.Config{
        RootCAs: certPool,
    }
    conn, err := tls.Dial("tcp", "server:443", conf)
    if err != nil {
        log.Fatalf("Failed to connect: %s", err)
    }
    defer conn.Close()

    // 使用 conn 进行数据通信
}
