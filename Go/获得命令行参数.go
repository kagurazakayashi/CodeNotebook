// golang os库获取命令行参数
fmt.Println(os.Args)

// golang flag获取命令行参数
import (
    "flag"
)
func f() {
	// "name" 参数表示参数名称
	// "123" 参数表示默认值
	// "name" 说明和描述
	// 像 flag.Int、flag.Bool、flag.String 这样的函数格式都是一样的
	var name string
	flag.StringVar(&name, "name", "123", "your name")

	//直接获得指针的方式
	flag.String("name", "123", "your name")

	//必须写在最后，以上赋值才有效
	flag.Parse()
}

// 使用flag来操作命令行参数，支持的格式如下：
// -id=1
// --id=1
// -id 1
// --id 1
// 使用 -h 参数可以查看使用帮助


// 完整使用过程

var (
	confServer  string
	confvar     uint = 4
)

func init() {
	flag.StringVar(&confServer, "server", "http://127.0.0.1:8080", "服务器地址")
	flag.UintVar(&confvar, "var", 4, "对应版本")
}

func main() {
	flag.Parse()
	fmt.Println(confServer)
	fmt.Println(confvar)
}