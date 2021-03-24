// 方法1（效率很高）：
func getKeys1(m map[int]int) []int {
	// 数组默认长度为map长度,后面append时,不需要重新申请内存和拷贝,效率很高
	j := 0
	keys := make([]int, len(m))
	for k := range m {
		keys[j] = k
		j++
	}
	return keys
}

// 方法2（效率很高）：
func getKeys2(m map[int]int) []int {
	// 数组默认长度为map长度,后面append时,不需要重新申请内存和拷贝,效率很高
	keys := make([]int, 0, len(m))
	for k := range m {
		keys = append(keys, k)
	}
	return keys
}

// https://blog.csdn.net/yzf279533105/article/details/94010954