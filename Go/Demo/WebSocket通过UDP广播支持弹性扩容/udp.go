package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net"
)

//udp 广播实现
// 发送端：(将消息广播到局域网所有主机)
// 这里需用 ifconfig 查看网卡的广播地址，一般是 en0 的 broadcast 。
func sendUdp(data []byte) {
	con, err := net.DialUDP("udp", nil, &net.UDPAddr{
		IP:   net.IPv4(192, 168, 1, 255), //广播地址
		Port: 2222,
	})
	if err != nil {
		log.Println(err)
		return
	}
	defer con.Close()

	n, err := con.Write(data)
	if err != nil {
		log.Println(err)
	}
	fmt.Println("udp broadcast msg:", n, "bytes")
}

//接收端：(监听节点udp数据，处理数据)
func readUdp() {
	listen, err := net.ListenUDP("udp", &net.UDPAddr{
		IP:   net.IPv4zero, //代表本机所有网卡地址
		Port: 2222,
	})
	if err != nil {
		log.Println(err)
		return
	}
	defer listen.Close()

	for {
		var buf [1024]byte
		n, addr, err := listen.ReadFromUDP(buf[:])
		if err != nil {
			log.Println(err)
			break
		}
		if n > 0 {
			fmt.Println("udp receive msg:", string(buf[:n]), "地址：", addr.IP.String(), ":", addr.Port)
			handleUdpMsg(buf[:n]) //处理消息
		}
	}
}

// {"user_id":1,"data":"send data"}
func handleUdpMsg(msg []byte) {
	type UdpMsg struct {
		UserId int    `json:"user_id"`
		Data   string `json:"data"`
	}
	var data UdpMsg
	err := json.Unmarshal(msg, &data)
	if err != nil {
		log.Println(err)
		return
	}
	conn, exist := clientMap[data.UserId]
	if !exist {
		log.Println("当前节点没有该用户的连接", data.UserId) //没有就不处理，说明目标用户的连接不在本机
		return
	}
	err = conn.WriteMessage(1, []byte(data.Data)) //在本机就直接转发消息
	if err != nil {
		log.Println(err)
	}
	log.Println("成功发送消息到用户", data.UserId)
}
