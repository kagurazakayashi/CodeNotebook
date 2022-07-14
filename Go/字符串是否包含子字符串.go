package main

import (
	"fmt"
	"strings"
)

func main() {
	//使用 Strings.Contains() 函数，判断一个字符串是否包含在另一个字符串中
	str := "aaabbb"
	StrContainers := strings.Contains(str, "aaa") // true
	fmt.Println("StrContainers =", StrContainers)
}

// https://haicoder.net/golang/golang-string-contains.html