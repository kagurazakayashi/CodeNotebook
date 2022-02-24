package main
import (
	"fmt"
	"ColorOutput"
)
func main() {
	// darwin, windows, linux
	if runtime.GOOS == "windows" {
		windows()
	} else {
		linux()
	}
}
func linux() {
	fmt.Printf("\x1b[%dmhello world 30: 黑 \x1b[0m\n", 30)
	fmt.Printf("\x1b[%dmhello world 31: 红 \x1b[0m\n", 31)
	fmt.Printf("\x1b[%dmhello world 32: 绿 \x1b[0m\n", 32)
	fmt.Printf("\x1b[%dmhello world 33: 黄 \x1b[0m\n", 33)
	fmt.Printf("\x1b[%dmhello world 34: 蓝 \x1b[0m\n", 34)
	fmt.Printf("\x1b[%dmhello world 35: 紫 \x1b[0m\n", 35)
	fmt.Printf("\x1b[%dmhello world 36: 深绿 \x1b[0m\n", 36)
	fmt.Printf("\x1b[%dmhello world 37: 白色 \x1b[0m\n", 37)

	fmt.Printf("\x1b[%d;%dmhello world \x1b[0m 47: 白色 30: 黑 \n", 47, 30)
	fmt.Printf("\x1b[%d;%dmhello world \x1b[0m 46: 深绿 31: 红 \n", 46, 31)
	fmt.Printf("\x1b[%d;%dmhello world \x1b[0m 45: 紫   32: 绿 \n", 45, 32)
	fmt.Printf("\x1b[%d;%dmhello world \x1b[0m 44: 蓝   33: 黄 \n", 44, 33)
	fmt.Printf("\x1b[%d;%dmhello world \x1b[0m 43: 黄   34: 蓝 \n", 43, 34)
	fmt.Printf("\x1b[%d;%dmhello world \x1b[0m 42: 绿   35: 紫 \n", 42, 35)
	fmt.Printf("\x1b[%d;%dmhello world \x1b[0m 41: 红   36: 深绿 \n", 41, 36)
	fmt.Printf("\x1b[%d;%dmhello world \x1b[0m 40: 黑   37: 白色 \n", 40, 37)
}
/*
前景	背景	颜色
30	40	黑色
31	41	红色
32	42	绿色
33	43	黄色
34	44	蓝色
35	45	紫色
36	46	深绿
37	47	白色
*/

// https://blog.csdn.net/qq_18361349/article/details/107385022


func windows() {
	SetCmdPrint("\x1b[%dmhello world 30: 黑 \x1b[0m\n", 30)
	SetCmdPrint("\x1b[%dmhello world 31: 红 \x1b[0m\n", 31)
	SetCmdPrint("\x1b[%dmhello world 32: 绿 \x1b[0m\n", 32)
	SetCmdPrint("\x1b[%dmhello world 33: 黄 \x1b[0m\n", 33)
	SetCmdPrint("\x1b[%dmhello world 34: 蓝 \x1b[0m\n", 34)
	SetCmdPrint("\x1b[%dmhello world 35: 紫 \x1b[0m\n", 35)
	SetCmdPrint("\x1b[%dmhello world 36: 深绿 \x1b[0m\n", 36)
	SetCmdPrint("\x1b[%dmhello world 37: 白色 \x1b[0m\n", 37)

	SetCmdPrint("47: 白色\n", 47)
	SetCmdPrint("46: 深绿\n", 46)
	SetCmdPrint("45: 紫  \n", 45)
	SetCmdPrint("44: 蓝  \n", 44)
	SetCmdPrint("43: 黄  \n", 43)
	SetCmdPrint("42: 绿  \n", 42)
	SetCmdPrint("41: 红  \n", 41)
	SetCmdPrint("40: 黑  \n", 40)
	
	SetCmdPrint("30: 黑 \n", 30)
	SetCmdPrint("31: 红 \n", 31)
	SetCmdPrint("32: 绿 \n", 32)
	SetCmdPrint("33: 黄 \n", 33)
	SetCmdPrint("34: 蓝 \n", 34)
	SetCmdPrint("35: 紫 \n", 35)
	SetCmdPrint("36: 深绿 \n", 36)
	SetCmdPrint("37: 白色 \n", 37)
}

func SetCmdPrint(s interface{}, i int) {
	proc := kernel32.NewProc("SetConsoleTextAttribute")
	handle, _, _ := proc.Call(uintptr(syscall.Stdout), uintptr(i))
	fmt.Println(s)
	handle, _, _ = proc.Call(uintptr(syscall.Stdout), uintptr(7))
	CloseHandle := kernel32.NewProc("CloseHandle")
	CloseHandle.Call(handle)
}

/*
color /?
    0 = 黑色       8 = 灰色
    1 = 蓝色       9 = 淡蓝色
    2 = 绿色       A = 淡绿色
    3 = 浅绿色     B = 淡浅绿色
    4 = 红色       C = 淡红色
    5 = 紫色       D = 淡紫色
    6 = 黄色       E = 淡黄色
    7 = 白色       F = 亮白色
*/

// 包地址：github.com/phprao/ColorOutput
// 使用
ColorOutput.Colorful.WithFrontColor("green").WithBackColor("red").Println("ColorOutput test...")


// https://blog.csdn.net/raoxiaoya/article/details/108982708
