// 普通闭包：
var reverseName = name.sorted(by:{s1:String , s2:String -> BOOL in 
     return s1 > s2
})
// 尾随闭包：
var reverseName = name.sotred(){
    s1 > s2  //如果闭包函数是唯一的参数 ()可以省略
}