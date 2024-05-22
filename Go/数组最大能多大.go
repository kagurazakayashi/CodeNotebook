// 为了确定你可以创建的最大数组，你可以逐渐增加数组的大小直到你的程序不能再成功分配空间。例如，通过尝试分配不同大小的数组并捕获可能的运行时错误来实际测试这个限制。
// 这里是一个简单的 Go 程序示例，用来测试你的系统上可以创建的最大字节数组：
package main

import (
	"fmt"
	"runtime"
)

func main() {
	var size int64 = 1 << 30 // 从 1GB 开始尝试
	for {
		arr := make([]byte, size)
		if arr != nil {
			fmt.Printf("Successfully allocated %d bytes\n", size)
			size += 1 << 30 // 每次增加 1GB
		} else {
			fmt.Println("Failed to allocate, max reached")
			break
		}
		// 强制垃圾回收，尝试释放内存
		runtime.GC()
	}
}

// 这个程序会尝试分配增加的内存块，直到分配失败为止。注意，这可能会使你的系统变得非常缓慢，甚至可能崩溃，因为它尝试使用所有可用的内存。
