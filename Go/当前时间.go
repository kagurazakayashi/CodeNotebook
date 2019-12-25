currentTime := time.Now()     //获取当前时间，类型是Go的时间类型Time

t1 := currentTime.Year()        //年
t2 := currentTime.Month()       //月
t3 := currentTime.Day()         //日
t4 := currentTime.Hour()        //小时
t5 := currentTime.Minute()      //分钟
t6 := currentTime.Second()      //秒
t7 := currentTime.Nanosecond()  //纳秒

currentTimeData := time.Date(t1,t2,t3,t4,t5,t6,t7,time.Local) //获取当前时间，返回当前时间Time

fmt.Println(currentTime) //打印结果：2017-04-11 12:52:52.794351777 +0800 CST
fmt.Println(t1,t2,t3,t4,t5,t6) //打印结果：2017 April 11 12 52 52
fmt.Println(currentTimeData) //打印结果：2017-04-11 12:52:52.794411287 +0800 CST

now := time.Now().Unix() //获取时间戳
time.Now().UTC() //转换为UTC时间
time.Sleep(10 * time.Millisecond) //time的sleep

// 获取当前时间戳
timeUnix:=time.Now().Unix()            //单位s,打印结果:1491888244
timeUnixNano:=time.Now().UnixNano()  //单位纳秒,打印结果：1491888244752784461

// 获取当前时间的字符串格式
timeStr:=time.Now().Format("2006-01-02 15:04:05")  //当前时间的字符串，2006-01-02 15:04:05据说是golang的诞生时间，固定写法
fmt.Println(timeStr)    //打印结果：2017-04-11 13:24:04

// 时间戳转时间字符串 (int64 —>  string)
timeUnix:=time.Now().Unix()   //已知的时间戳
formatTimeStr:=time.Unix(timeUnix,0).Format("2006-01-02 15:04:05")
fmt.Println(formatTimeStr)   //打印结果：2017-04-11 13:30:39

// 时间字符串转时间(string  —>  Time)
formatTimeStr=”2017-04-11 13:33:37”
formatTime,err:=time.Parse("2006-01-02 15:04:05",formatTimeStr)
if err==nil{
	fmt.Println(formatTime) //打印结果：2017-04-11 13:33:37 +0000 UTC
}

// 时间字符串转时间戳 (string —>  int64)
formatTime.Unix()