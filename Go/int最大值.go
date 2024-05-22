// 对于整数类型，Go 语言的标准库中没有直接提供int最大值常量 INT_MAX，但你可以通过计算得到。例如，对于 int 类型的最大值，可以使用以下方法计算：
package main

import (
	"fmt"
)

func main() {
	// 对于 int 类型的最大值
	var maxInt = int(^uint(0) >> 1)
	// 对于 int32 类型的最大值
	var maxInt32 = int32(^uint32(0) >> 1)
	// 对于 int64 类型的最大值
	var maxInt64 = int64(^uint64(0) >> 1)

	fmt.Println("maxInt:", maxInt)
	fmt.Println("maxInt32:", maxInt32)
	fmt.Println("maxInt64:", maxInt64)
}

// 这个方法利用了 Go 语言的位操作。^uint(0) 生成一个所有位都是 1 的无符号整数，然后右移一位将最高位变为 0（因为 int 类型是有符号的，最高位是符号位），最终转换为对应的有符号整数类型得到最大值。
// 这种方法适用于获取任何整数基本类型的最大值。如果你需要经常使用这些值，可以在你的代码库中定义相应的常量，便于重用。
