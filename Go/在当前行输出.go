import (
	"fmt"
	"time"
)

func spinner(delay time.Duration) {
    for {
        for _, r := range "-\\|/" {
            fmt.Printf("\r%c",  r)
            time.Sleep(delay)
        }
    }
}

// 上面的代码是spinner无限循环运行，直到主函数返回，所有的go routine都会被打断，然后程序退出。
// 以上代码在windows环境和mac环境（darwin）都可以正常运行。
// 但在mac环境下还可以使用以下语句打印字符（但在windows环境下不行）：
// fmt.Printf("\b%c",  r)

// 在命令行中打印字符， \r是回到当前行首，\n是换行，\b是删除前一个字符。

// 增加一个单向channel作为参数，done参数是只能接收的channel:
// blog.csdn.net/youngwhz1/article/details/80609178