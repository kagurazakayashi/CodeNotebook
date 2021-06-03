package main

import (
	"bufio"
	"bytes"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"

	"go.bug.st/serial"
)

const MAXRWLEN = 8000

func main() {
	ports, err := serial.GetPortsList()
	if err != nil {
		log.Fatal(err)
	}
	if len(ports) == 0 {
		log.Fatal("没有找到串口")
	} else {
		// fmt.Printf("%#v", ports)
		for i, port := range ports {
			fmt.Printf("找到串口[%d]: %v\n", i, port)
		}
	}
	pi := -1
	for {
		fmt.Println("选择哪个串口？")
		reader := bufio.NewReader(os.Stdin)
		res, _ := reader.ReadBytes('\n')
		line := bytes.TrimRight(res, "\r\n")
		fmt.Printf("读取到内容%s\n", line)
		pi, err = strconv.Atoi(string(line))
		if err != nil {
			fmt.Println("输入的不是数字！", err)
		} else {
			break
		}
	}
	// fmt.Println()
	// reader := bufio.NewReader(os.Stdin)
	// res, _ := reader.ReadString('\n')
	// fmt.Printf("读取到内容%s\n", res)

	// fmt.Println("打开串口", ports[pi])
	// c := &seri.Config{Name: ports[pi], Baud: 115200}
	// s, err := seri.OpenPort(c)
	// if err != nil {
	// 	log.Fatal(err)
	// }

	// for {
	// 	buf := make([]byte, 128)
	// 	n, err := s.Read(buf)
	// 	if err != nil {
	// 		log.Fatal(err)
	// 	}
	// 	log.Printf("读取信息 %s\n", buf[:n])
	// }

	mode := &serial.Mode{
		BaudRate: 9600,
		Parity:   serial.NoParity,
		DataBits: 8,
		StopBits: serial.OneStopBit,
	}
	port, err := serial.Open(ports[pi], mode)
	if err != nil {
		log.Fatal(err)
	}
	// str := "DA030000000D96E4"
	// // b, _ := hex.DecodeString(str)
	// // ww := b
	// ww := []byte(str)
	// n, err := port.Write(ww)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Printf("Sent %v, %v bytes\n", ww, n)

	// Send the string "10,20,30\n\r" to the serial port
	// str := "DA030000000D96E4"
	// // b, _ := hex.DecodeString(str)

	// // // encodedStr := hex.EncodeToString(b)
	// // ww := b
	// ww := []byte(str)
	// fmt.Printf("Sent %v\n", ww)
	// n, err := port.Write(ww)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Printf("Sent %v bytes\n", n)

	// Read and print the response

	fmt.Println("start Read")
	buff := make([]byte, 100)
	for {
		// Reads up to 100 bytes
		n, err := port.Read(buff)
		if err != nil {
			fmt.Println("ERROR", err)
		}
		if n == 0 {
			fmt.Println("\nEOF")
			break
		}

		fmt.Printf("%s", string(buff[:n]))

		// If we receive a newline stop reading
		if strings.Contains(string(buff[:n]), "\n") {
			break
		}
	}
}
