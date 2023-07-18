// 我们可以使用time.Add()函数来进行时间的加减操作。
package main

import (
    "fmt"
    "time"
)

func main() {
    t := time.Now()
    fmt.Println(t) // 2021-10-10 10:42:53.21933 +0800 CST m=+0.000148564
    d := 2 * time.Hour
    t1 := t.Add(d)
    fmt.Println(t1) // 2021-10-10 12:42:53.21933 +0800 CST
}
// 上述代码中，我们首先使用time.Now()函数获取当前时间点t，然后定义一个时间增量d为2小时，使用t.Add()函数将d加到t上，得到时间点t1，最后输出t1的值。

// https://www.python100.com/html/91913.html
