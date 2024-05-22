// go 几秒后执行某个代码

// 同步

package main

import (
	"fmt"
	"time"
)

func main() {
	// 打印当前时间
	fmt.Println("现在时间:", time.Now())

	// 等待一秒钟
	time.Sleep(1 * time.Second)

	// 执行某些操作
	fmt.Println("这是一秒后的操作，当前时间:", time.Now())
}

// 异步

package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("现在时间:", time.Now())

	// 在1秒后在新的goroutine中执行函数
	timer := time.AfterFunc(1 * time.Second, func() {
		fmt.Println("这是一秒后的操作，当前时间:", time.Now())
	})

	// 等待足够的时间以确保函数可以执行
	time.Sleep(2 * time.Second) // 等待两秒以确保看到输出

	// 停止定时器，如果不再需要的话
	timer.Stop()
}

// 这个例子中，time.AfterFunc 创建了一个定时器，它将在指定时间后自动执行一个函数。这个函数会在它自己的 goroutine 中执行，不会干扰主 goroutine 的执行。这是实现非阻塞延迟执行的一种常用方法。
