res := strings.TrimSpace(info)
//把字符串以空格分割成字符串数组
str_arr := strings.Split(res, " ")
//计算字符串数组的长度
count := len(str_arr)

// 把array/slice转成逗号分隔的字符串
array_or_slice := []int{1,2,3}
strings.Replace(strings.Trim(fmt.Sprint(array_or_slice), "[]"), " ", ",", -1)
// 结果："1,2,3"