func makeCatch (forCatch num : Int) -> () -> Int{
      var i = 0
      func catch() -> Int{
            i += num
            return i
      }
      return catch
}
// -> () 返回值类型是一个函数
// -> Int 该函数调用时不传入参数，返回Int
// 注意：可以看到嵌套函数catch捕获了外面的 i 和 num , 而且闭包函数也是一种类型可以赋值给变量和常量