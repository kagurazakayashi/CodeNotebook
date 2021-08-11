// func 方法名字(参数名字1:参数类型，参数名字2:参数类型) -> 返回值类型/(返回值名字1:返回值类型，返回值名字2:返回值类型)
func sum(a : Int , b : Int) -> (c : Int , d : Int)?{
    // ?: 整个返回元组可以是 nil
}

// 忽略参数标签
func add(_ firstInta : Int , b secendIntB : Int) -> Int? {}
// 方法调用
add(1,secendIntB: 2)

// 默认参数
func add(firstPara : Int,SecendPara : Int = 12)
// 方法调用
add(firstPara : 1) // 此时第二个参数没有传入，默认第二个参数等于12
add(firstPara:1, SecendPara : 0)

// 可变参数
func sum(_ num : Double...) -> Double{}
// ... : 调用者无法知道传入的参数num有多少个，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入 ...
