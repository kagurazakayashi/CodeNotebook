package main

import (
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/websocket"
)

var clientMap map[int]*websocket.Conn

func init() {
	clientMap = make(map[int]*websocket.Conn)
	go readUdp()
}

func main() {

	http.HandleFunc("/chat", chat)

	err := http.ListenAndServe(":8866", nil)
	if err != nil {
		log.Fatal(err)
	}
}

func chat(w http.ResponseWriter, r *http.Request) {
	upgrader := websocket.Upgrader{
		CheckOrigin: func(r *http.Request) bool {
			h := r.Header.Get("Authorization")
			log.Println("New Client:", h)
			return true
		},
	}
	c, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println(err)
		return
	}
	defer c.Close()

	user_id := r.URL.Query().Get("user_id")
	uid, err := strconv.Atoi(user_id)
	if err != nil {
		log.Println(err)
	}
	clientMap[uid] = c
	log.Printf("clientMap:%v\n", clientMap)

	for {
		t, m, err := c.ReadMessage()
		if err != nil {
			log.Println(err)
			break
		}
		log.Println(c.LocalAddr().String(), " send ", t, " data: ", string(m))
		err = c.WriteMessage(t, m)
		if err != nil {
			log.Println(err)
			break
		}
		sendUdp(m)
	}
}
