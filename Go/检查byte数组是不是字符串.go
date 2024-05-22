// golang 检查 []byte 中是文本而不是二进制

/*
1. 检查是否全部是 UTF-8 编码的字符
由于 UTF-8 是现代文本文件常用的编码格式，你可以使用 utf8.Valid 函数来检查一个 []byte 切片是否完全由有效的 UTF-8 编码的字符组成。
*/

import (
	"fmt"
	"unicode/utf8"
)

func isUTF8Text(data []byte) bool {
	return utf8.Valid(data)
}

func main() {
	data := []byte("Hello, 世界")
	fmt.Println(isUTF8Text(data)) // 输出: true

	binaryData := []byte{0xff, 0xfe, 0xfd}
	fmt.Println(isUTF8Text(binaryData)) // 输出: false
}

/*
2. 检查控制字符的数量
文本数据通常不会包含很多控制字符（如 ASCII 0 到 31），而二进制数据可能包含大量这样的字符。你可以检查切片中非打印字符的比例来决定是否更可能是文本。
*/
package main

func isLikelyText(data []byte) bool {
	const controlLimit = 0.1  // 最多 10% 的控制字符
	var controlCount int
	for _, b := range data {
		if b <= 31 && b != 9 && b != 10 && b != 13 { // 排除 tab, LF, CR
			controlCount++
		}
	}
	return float64(controlCount)/float64(len(data)) < controlLimit
}

func main2() {
	data := []byte("Hello, world\n")
	fmt.Println(isLikelyText(data)) // 输出: true

	binaryData := []byte{0x00, 0x01, 0x02, 0x10, 0x20, 0x0a}
	fmt.Println(isLikelyText(binaryData)) // 输出: false
}

/*
3. MIME 类型检测
如果你需要更复杂的检测，可以使用 http.DetectContentType 函数来推断数据的 MIME 类型，然后判断是否是已知的文本类型。
*/

import (
	"net/http"
)

func isTextBasedOnMIME(data []byte) bool {
	mimeType := http.DetectContentType(data)
	return mimeType == "text/plain" || mimeType == "application/json" // 添加更多文本类型
}

func main3() {
	data := []byte("Just some text")
	fmt.Println(isTextBasedOnMIME(data)) // 输出: true

	binaryData := []byte{0x00, 0x01, 0x02, 0x03, 0x04}
	fmt.Println(isTextBasedOnMIME(binaryData)) // 输出: false
}
