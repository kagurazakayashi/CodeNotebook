package main
 
import (
	"fmt"
	"sort"
)
 
// 字符串是否在某个数组中
func in(target string, str_array []string) bool {
	sort.Strings(str_array)
	index := sort.SearchStrings(str_array, target)
	//index的取值：[0,len(str_array)]
	if index < len(str_array) && str_array[index] == target { //需要注意此处的判断，先判断 &&左侧的条件，如果不满足则结束此处判断，不会再进行右侧的判断
		return true
	}
	return false
}
 
func main(){
	name_list := []string{"Go", "Golang", "Gin框架"}
	target1 := "Gin框架"
	result := in(target1, name_list)
	fmt.Println("Gin框架 是否在 name_list 中：", result)
}

// https://blog.csdn.net/weixin_42117918/article/details/110850732