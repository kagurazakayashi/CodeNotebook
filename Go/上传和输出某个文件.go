package main

import (
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"

	cmap "github.com/orcaman/concurrent-map"
)

// 二进制输出某个文件
func showFile(w http.ResponseWriter, req *http.Request, c chan string) {
	req.ParseMultipartForm(32 << 20)
	formci, found0 := req.Form["i"]
	if !found0 {
		result := map[string]interface{}{"code": 2042, "msg": errcode["2042"]}
		bytes, _ := json.Marshal(result)
		c <- string(bytes)
		return
	}
	pix, err := ioutil.ReadFile(formci[0])
	if err != nil {
		panic(err)
	}
	w.Write(pix)
}

// 上傳某個檔案
func uploadFile(w http.ResponseWriter, req *http.Request, c chan string) bool {
	// 檢查是否為 POST 請求
	if req.Method != http.MethodPost {
		w.WriteHeader(http.StatusMethodNotAllowed)
		// 返回 不是POST請求 的錯誤
		c <- returnCodeMsg(3000)
		return false
	}
	filePathO, _ := confs.Get("uploaddir")
	var filePath string = filePathO.(string)
	// 設定記憶體大小
	req.ParseMultipartForm(32 << 20)
	// 檢查使用者是否登入
	var cToken string = chkToken(req)
	if len(cToken) > 0 {
		c <- cToken
		return false
	}
	// 傳送到目標資料夾
	dirO, idir := req.Form["dir"]
	var dir string = "public"
	if idir {
		dir = dirO[0]
		// 檢查前3個字母確定許可權
		if len(dir) >= 3 {
			var prefix string = string([]rune(dir)[0:2])
			if prefix == "sa" && loginInfo.Issuperadmin != "1" {
				// 需要超級管理員許可權
				c <- returnCodeMsg(4004)
				return false
			}
		}
	}
	// 獲取上傳的檔案組
	ulfiles := req.MultipartForm.File["file"]
	fmt.Println("接收到的文件信息： ", ulfiles)
	// 遍歷傳送過來的每個檔案
	var uploadok int = 0
	for i := 0; i < len(ulfiles); i++ {
		// 開啟上傳檔案
		file, err := ulfiles[i].Open()
		if err != nil {
			c <- returnCodeMsg(2911)
			return false
		}
		// 檢查檔案尺寸限制
		if ulfiles[i].Size > 10485760 {
			c <- returnCodeMsg(5000)
			return false
		}
		// 檢查有沒有提供檔名
		var fileNameStr string = ulfiles[i].Filename
		argName, iname := req.Form["name"]
		if iname {
			fileNameStr = argName[0]
		}
		// 建立上傳檔案
		var fileSizeStr string = strconv.FormatInt(ulfiles[i].Size, 10)
		filePath = filePath + "/" + dir + "/" + fileNameStr
		fmt.Println("正在上传文件 " + fileNameStr + " (" + fileSizeStr + ")" + " 到 " + filePath)
		cur, err := os.Create(filePath)
		if err != nil {
			fmt.Println("上传文件 " + fileNameStr + " 失败: " + err.Error())
			c <- returnCodeMsg(2912)
			return false
		}
		// 複製上傳檔案
		_, err = io.Copy(cur, file)
		if err != nil {
			c <- returnCodeMsg(2913)
			return false
		}
		cur.Close()
		file.Close()
		uploadok++
	}
	result := map[string]interface{}{"code": 1000, "msg": errcode["1000"], "uploadok": uploadok}
	bytes, _ := json.Marshal(result)
	c <- string(bytes)
	return true
}

func uploadFileFunc(w http.ResponseWriter, req *http.Request) {
	wg := sync.WaitGroup{}
	wg.Add(1)
	c := make(chan string)
	go uploadFile(w, req, c)
	re := <-c
	wg.Done()
	fmt.Fprint(w, re)
	wg.Wait()
}
