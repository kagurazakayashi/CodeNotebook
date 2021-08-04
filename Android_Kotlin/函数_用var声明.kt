// 声明函数i,接收两个Int类型参数 x、y，返回 x+y 的值
var i = { x: Int, y: Int -> x + y }
i(3, 5) //调用使用 var 声明的函数 i

// 声明函数j,它接收的参数是两个Int， 返回一个Int，对应的表达式是 {x,y->x+y}
var j: (Int, Int) -> Int = { x, y -> x + y }
j(4, 4) //调用函数

// https://www.jianshu.com/p/da4a93a356d6