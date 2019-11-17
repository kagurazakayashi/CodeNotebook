//获取时间戳
timestamp := time.Now().Unix()
fmt.Println(timestamp)

//格式化为字符串,tm为Time类型
tm := time.Unix(timestamp, 0)
fmt.Println(tm.Format("2006-01-02 03:04:05 PM"))
fmt.Println(tm.Format("02/01/2006 15:04:05 PM"))

//从字符串转为时间戳，第一个参数是格式，第二个是要转换的时间字符串
tm2, _ := time.Parse("01/02/2006", "02/08/2015")
fmt.Println(tm2.Unix())