// 普通闭包：闭包表达式可以捕获上下文中的变量和常量
// 攥写一个符合其类型要求的函数
func background(_ s1 : String , _ s2 : String ) -> BOOL {
    return s1 > s2
}
// 并作为参数传入到另外一个函数当中去
// 作为sorted(by:)参数传入
var reverseName = name.sorted(by:backround)
// 那么闭包表达式为 : 
var reverseName = name.sorted(by:{s1:String , s2:String -> BOOL in 
    return s1 > s2
})

// 闭包的一般表达式： 
// { (入参的函数) -> 返回类型 in
//     闭包体
// }
// 像这样的内联闭包表达式中，函数和返回值都在大括号内，函数体由 in 引入