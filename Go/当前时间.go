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