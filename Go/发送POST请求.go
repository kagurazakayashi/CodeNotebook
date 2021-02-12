package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strings"
)

func main() {
	httpDo()
}

func httpDo() {
	client := &http.Client{}

	req, err := http.NewRequest("POST", "http://baidu.com", strings.NewReader("name=cjb"))
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(0)
	}

	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Set("Cookie", "name=anny")

	resp, err := client.Do(req)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(0)
	} else {
		fmt.Println("OK")
		body, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			fmt.Println(err.Error())
		} else {
			fmt.Println(string(body))
		}
		resp.Body.Close()
	}
}
