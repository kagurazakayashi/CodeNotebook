package main

import (
	"fmt"
	"unicode/utf8"
)

func main() {
	// ASCII 字符串长度使用 len() 函数。
	fmt.Println(len("yashi")) // 5
	fmt.Println(len("雅诗")) // 6
	fmt.Println(len("yashi雅诗")) // 11

	// Unicode 字符串长度使用 utf8.RuneCountInString() 函数。
	fmt.Println(utf8.RuneCountInString("yashi")) // 5
	fmt.Println(utf8.RuneCountInString("雅诗")) // 2
	fmt.Println(utf8.RuneCountInString("yashi雅诗")) // 7
}