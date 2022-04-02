// 声明
var arr1 [5]int
fmt.Println(arr1) // 输出为：[0 0 0 0 0]
arr2 := [5]int{10,20,30,40,50}
arr3 := […]int{10,20,30,40,50}
arr4 := [5]int{1:20,3:40} // 用具体值初始化索引为 1 和 3 的元素

//数组初始化的各种方式
//创建数组(声明长度)
var array1 = [5]int{1, 2, 3}
fmt.Printf("array1--- type:%T \n", array1)
rangeIntPrint(array1[:])
//创建数组(不声明长度)
var array2 = [...]int{6, 7, 8}
fmt.Printf("array2--- type:%T \n", array2)
rangeIntPrint(array2[:])
//创建数组切片
var array3 = []int{9, 10, 11, 12}
fmt.Printf("array3--- type:%T \n", array3)
rangeIntPrint(array3)
//创建数组(声明长度)，并仅初始化其中的部分元素
var array4 = [5]string{3: "Chris", 4: "Ron"}
fmt.Printf("array4--- type:%T \n", array4)
rangeObjPrint(array4[:])
//创建数组(不声明长度)，并仅初始化其中的部分元素，数组的长度将根据初始化的元素确定
var array5 = [...]string{3: "Tom", 2: "Alice"}
fmt.Printf("array5--- type:%T \n", array5)
rangeObjPrint(array5[:])
//创建数组切片，并仅初始化其中的部分元素，数组切片的len将根据初始化的元素确定
var array6 = []string{4: "Smith", 2: "Alice"}
fmt.Printf("array6--- type:%T \n", array6)
rangeObjPrint(array6)
//输出整型数组切片
func rangeIntPrint(array []int) {
	for i, v := range array {
		fmt.Printf("index:%d  value:%d\n", i, v)
	}
}
//输出字符串数组切片
func rangeObjPrint(array []string) {
	for i, v := range array {
		fmt.Printf("index:%d  value:%s\n", i, v)
	}
}
// 通过长度变量创建指定长度数组
func makeArr(array []string) {
	dp := make([]int, length)
}

// 遍历
for i := 0; i < len(arr2); i++ {
	fmt.Printf("%d : %d\n", i, arr2[i])
}
for index,value := range arr2 {
    fmt.Printf("%d : %d\n", index, value)
}

// 修改
arr2[2] = 35

// 插入
a := []int{1, 2, 3}
a = append(a, 1) // 追加1个元素
a = append(a, 1, 2, 3) // 追加多个元素, 手写解包方式
a = append(a,[]int{11,11,11}...) // 追加一个切片, 切片需要解包
a = append([]int{22,22,22},a...) // 在开头添加1个切片
a = append(a[:0], append([]int{1,2,3}, a[0:]...)...) // 在第0个位置插入切片

// 删除

// 从开头位置删除
//删除开头的元素可以直接移动数据指针：
a := []int{1, 2, 3}
a = a[1:] // 删除开头1个元素
a = a[N:] // 删除开头N个元素
fmt.Println(a)
//也可以不移动数据指针，但是将后面的数据向开头移动，可以用 append 原地完成
//（所谓原地完成是指在原有的切片数据对应的内存区间内完成，不会导致内存空间结构的变化）：
a = []int{1, 2, 3}
a = append(a[:0], a[1:]...) // 删除开头1个元素
a = append(a[:0], a[N:]...) // 删除开头N个元素
//还可以用 copy() 函数来删除开头的元素：
a = []int{1, 2, 3, ...}
a = append(a[:i], a[i+1:]...) // 删除中间1个元素
a = append(a[:i], a[i+N:]...) // 删除中间N个元素
a = a[:i+copy(a[i:], a[i+1:])] // 删除中间1个元素
a = a[:i+copy(a[i:], a[i+N:])] // 删除中间N个元素

// 从中间位置删除
//对于删除中间的元素，需要对剩余的元素进行一次整体挪动，同样可以用 append 或 copy 原地完成：
a = []int{1, 2, 3, ...}
a = append(a[:i], a[i+1:]...) // 删除中间1个元素
a = append(a[:i], a[i+N:]...) // 删除中间N个元素
a = a[:i+copy(a[i:], a[i+1:])] // 删除中间1个元素
a = a[:i+copy(a[i:], a[i+N:])] // 删除中间N个元素

// 从尾部删除
a = []int{1, 2, 3}
a = a[:len(a)-1] // 删除尾部1个元素
a = a[:len(a)-N] // 删除尾部N个元素

// 指针数组
arr := [5]*int{0: new(int), 1: new(int)}
// 为索引为 0 和 1 的元素赋值
*arr[0] = 10
*arr[1] = 20
arr[2] = new(int)
arr[3] = new(int)
arr[4] = new(int)
*arr[2] = 30
for i := 0; i < len(arr); i++ {
    fmt.Printf("At index %d is %d\n", i, *arr[i])
}

// 数组是值类型: 复制完成后两个数组的值完全一样，但是彼此之间没有任何关系
var arr1 [3]string
arr2 := [3]string{"nick", "jack", "mark"}
// 把 arr2 的赋值(其实本质上是复制)到 arr1
arr1 = arr2

// 指针型的数组: 复制的将是指针，而不会复制指针所指向的对象。在赋值完成后，两个数组指向的是同一组字符串
// 声明第一个包含 4 个元素的字符串数组
var arr1 [3]*string
// 声明第二个包含 3 个元素的字符串数组，并初始化
arr2 := [3]*string{new(string), new(string), new(string)}
*arr2[0] = "nick"
*arr2[1] = "jack"
*arr2[2] = "mark"
// 将 arr2 赋值给 arr1
arr1 = arr2

// 把数组传递给函数
// 下面的 demo 中会声明一个包含 100 万个 int64 类型元素的数组，这会消耗掉 8MB 的内存：
func showArray(array [1e6]int64){
    // do something
}
var arr [1e6]int64
showArray(arr)
// 太耗费内存！合理且高效的方式是只传入指向数组的指针，这样只需复制 8 个字节的数据到函数的栈上就可以了：
func showArray(array *[1e6]int64){
    // do something
}
var arr [1e6]int64
showArray(&arr)

// 多维数组
// 声明一个二维整型数组，两个维度分别存储 4 个元素和 2 个元素
var arr [4][2]int
// 使用数组字面量来声明并初始化一个二维整型数组
arr1 := [4][2]int{{10, 11}, {20, 21}, {30, 31}, {40, 41}}
// 声明并初始化外层数组中索引为 1 和 3 的元素
arr2 := [4][2]int{1: {20, 21}, 3: {40, 41}}
// 声明并初始化外层数组和内层数组的单个元素
arr3 := [4][2]int{1: {0: 20}, 3: {1: 41}}
// 访问单个元素
arr1[0][0] = 666
// 因为每个数组都是一个值，所以可以独立复制某个维度：
// 将 arr1 的索引为 1 的维度复制到一个同类型的新数组里
var arr4 [2]int = arr1[1]
// 将外层数组的索引为 1、内层数组的索引为 0 的整型值复制到新的整型变量里
var value int = arr1[1][0]


// https://blog.csdn.net/dupeng0811/article/details/89876287
// https://www.jianshu.com/p/26ff6e9927e9
// https://blog.csdn.net/books1958/article/details/21460673