// go时间戳和时间转换
// 本地当期时间
fmt.Println(time.Now()) //2016-07-14 14:27:28.214512532 +0800 CST

// 本地当前时间戳(10位)
fmt.Println(time.Now().Unix()) //1468479251
// 本地当前时间戳(19位)
fmt.Println(time.Now().UnixNano()) //1468480006774460462
// 时间戳转时间
fmt.Println(time.Unix(1389058332, 0).Format("2006-01-02 15:04:05")) //2014-01-07 09:32:12
// 时间转时间戳
fmt.Println(time.Date(2014, 1, 7, 5, 50, 4, 0, time.Local).Unix())

// http://researchlab.github.io/2016/06/14/go-time-summary/


// 秒级时间戳转time
func UnixSecondToTime(second int64) time.Time {
	return time.Unix(second, 0)
}
// 毫秒级时间戳转time
func UnixMilliToTime(milli int64) time.Time {
	return time.Unix(milli/1000, (milli%1000)*(1000*1000))
}
// 纳秒级时间戳转time
func UnixNanoToTime(nano int64) time.Time {
	return time.Unix(nano/(1000*1000*1000), nano%(1000*1000*1000))
}
// https://blog.csdn.net/qq_40374604/article/details/128450756
