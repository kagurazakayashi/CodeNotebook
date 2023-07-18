// go时区转换

// 时间转换为UTC时间和本地时间( UTC:零时区 +0000， China: 东八区 +0800)
dateStr := "2016-07-14 14:24:51" 
timestamp1, _ := time.Parse("2006-01-02 15:04:05", dateStr)
timestamp2, _ := time.ParseInLocation("2006-01-02 15:04:05", dateStr, time.Local)
fmt.Println(timestamp1, timestamp2)               //2016-07-14 14:24:51 +0000 UTC 2016-07-14 14:24:51 +0800 CST 
fmt.Println(timestamp1.Unix(), timestamp2.Unix()) //1468506291 1468477491 

now := time.Now()                
year, mon, day := now.UTC().Date()
hour, min, sec := now.UTC().Clock()
zone, _ := now.UTC().Zone()     
fmt.Printf("UTC 时间是 %d-%d-%d %02d:%02d:%02d %s\n",         
    year, mon, day, hour, min, sec, zone) // UTC 时间是 2016-7-14 07:06:46 UTC
                                                           
year, mon, day = now.Date()
hour, min, sec = now.Clock()
zone, _ = now.Zone()
fmt.Printf("本地时间是 %d-%d-%d %02d:%02d:%02d %s\n",
    year, mon, day, hour, min, sec, zone) // 本地时间是 2016-7-14 15:06:46 CST

// http://researchlab.github.io/2016/06/14/go-time-summary/


// 我们可以使用time.LoadLocation()函数和time.In()方法进行时区的转换。
package main
import (
    "fmt"
    "time"
)
func main() {
    t := time.Now()
    fmt.Println(t) // 2021-10-10 12:57:38.367191 +0800 CST m=+0.000120773
    loc, _ := time.LoadLocation("Asia/Shanghai")
    t1 := t.In(loc)
    fmt.Println(t1) // 2021-10-10 12:57:38.367191 +0800 CST
}
// 上述代码中，我们首先使用time.Now()函数获取当前时间点t，然后使用time.LoadLocation()函数加载一个时区loc，最后使用t.In()方法将t转换成loc时区下的时间点t1，并输出两个变量的值。

// https://www.python100.com/html/91913.html
