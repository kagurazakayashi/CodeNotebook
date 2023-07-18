// 时间格式化 时间字符串转换
timestamp := int64(1591271169)
// 12小时制
time.Unix(timestamp, 0).Format("2006-01-02 03:04:05")
// 24小时制
time.Unix(timestamp, 0).Format("2006-01-02 15:04:05")

/* golang中time包对于时间的详细定义
月份 1,01,Jan,January
日　 2,02,_2
时　 3,03,15,PM,pm,AM,am
分　 4,04
秒　 5,05
年　 06,2006
时区 -07,-0700,Z0700,Z07:00,-07:00,MST
周几 Mon,Monday

比如小时的表示(原定义是下午3时，也就是15时)

3 用12小时制表示，去掉前导0
03 用12小时制表示，保留前导0
15 用24小时制表示，保留前导0
03pm 用24小时制am/pm表示上下午表示，保留前导0
3pm 用24小时制am/pm表示上下午表示，去掉前导0
又比如月份

1 数字表示月份，去掉前导0
01 数字表示月份，保留前导0
Jan 缩写单词表示月份
January 全单词表示月份
*/

// 本地当期时间
fmt.Println(time.Now()) //2016-07-14 14:27:28.214512532 +0800 CST
// 时间格式化
fmt.Println(time.Now().Format("3:04:05.000 PM Mon Jan"))            // 2:27:05.702 PM Thu Jul
fmt.Println(time.Now().Format("2006-01-_2 3:04:05.000 PM Mon Jan")) // 2016-07-14 2:54:11.442 PM Thu Jul
fmt.Println(time.Now().Format("2006-01-02 15:04:05"))  // 2016-07-14 14:54:11.442239513 +0800 CST

// http://researchlab.github.io/2016/06/14/go-time-summary/


//获取时间戳
timestamp := time.Now().Unix()
fmt.Println(timestamp) // 1423361979

//格式化为字符串,tm为Time类型
tm := time.Unix(timestamp, 0)
fmt.Println(tm.Format("2006-01-02 03:04:05 PM")) // 2015-02-08 10:19:39 AM
fmt.Println(tm.Format("02/01/2006 15:04:05 PM")) // 08/02/2015 10:19:39 AM

//从字符串转为时间戳，第一个参数是格式，第二个是要转换的时间字符串
tm2, _ := time.Parse("01/02/2006", "02/08/2015")
fmt.Println(tm2.Unix()) // 1423353600

/*
这些数字都是有特殊函义的，不是随便指定的数字，见下面列表：
月份 1,01,Jan,January
日　 2,02,_2
时　 3,03,15,PM,pm,AM,am
分　 4,04
秒　 5,05
年　 06,2006
周几 Mon,Monday
时区时差表示 -07,-0700,Z0700,Z07:00,-07:00,MST
时区字母缩写 MST
*/

// https://studygolang.com/articles/2634
