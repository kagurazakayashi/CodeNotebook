package main
 
import (
    "fmt"
    "sort"
)

// 升序排序
func sortf() {
    intList := [] int {2, 4, 3, 5, 7, 6, 9, 8, 1, 0}
    float8List := [] float64 {4.2, 5.9, 12.3, 10.0, 50.4, 99.9, 31.4, 27.81828, 3.14}
    stringList := [] string {"a", "c", "b", "d", "f", "i", "z", "x", "w", "y"}
   
    sort.Ints(intList)
    sort.Float64s(float8List)
    sort.Strings(stringList)
   
    fmt.Printf("%v\n%v\n%v\n", intList, float8List, stringList)
}

// 降序排序
// go 的 sort 包可以使用 sort.Reverse(slice) 来调换 slice.Interface.Less ，也就是比较函数
func reversef() {
    intList := [] int {2, 4, 3, 5, 7, 6, 9, 8, 1, 0}
    float8List := [] float64 {4.2, 5.9, 12.3, 10.0, 50.4, 99.9, 31.4, 27.81828, 3.14}
    stringList := [] string {"a", "c", "b", "d", "f", "i", "z", "x", "w", "y"}

    sort.Sort(sort.Reverse(sort.IntSlice(intList)))
    sort.Sort(sort.Reverse(sort.Float64Slice(float8List)))
    sort.Sort(sort.Reverse(sort.StringSlice(stringList)))

    fmt.Printf("%v\n%v\n%v\n", intList, float8List, stringList)
}

// https://itimetraveler.github.io/2016/09/07/%E3%80%90Go%E8%AF%AD%E8%A8%80%E3%80%91%E5%9F%BA%E6%9C%AC%E7%B1%BB%E5%9E%8B%E6%8E%92%E5%BA%8F%E5%92%8C%20slice%20%E6%8E%92%E5%BA%8F/

// uint64 排序
// sort模块提供了一个非常灵活的函数sort.Slice(slice interface{}, less func(i, j int) bool),第一个参数是要排序的切片.第二个参数是一个函数,函数接收两个index值,返回 slice[ I] < slice[j]这个bool值.
func uint64f() {
    a := []uint64{5, 9, 8, 3, 1, 100, 0}
    fmt.Println(a)
    sort.Slice(a, func(i, j int) bool { return a[i] < a[j] })
    fmt.Println(a)
	// [5 9 8 3 1 100 0]
	// [0 1 3 5 8 9 100]
}