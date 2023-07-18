/*
 * 时间转换工具 将ISO 8601时间转为当地时间戳（13位 毫秒）
 */
 func TransformTimestrToTimestamp(timestr string) int64 {
	result, err := time.ParseInLocation(TimeFormat, timestr, time.Local)
	if err != nil {
		return -1
	}
	//转为13位时间戳,13位毫秒时间戳单位
	return result.Unix() * 1000
}

// https://blog.csdn.net/qq_40374604/article/details/128450756