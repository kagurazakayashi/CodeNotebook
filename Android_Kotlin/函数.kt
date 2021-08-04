// fun 函数名(参数:参数类型):返回值类型 {
//     函数体
// }
// 如果没有返回值，使用 :Unit 标识，也可以省略不写
// 返回值也是使用 return 返回。


// 入口函数
fun main(args:Array<String>){
    println("Hello, World!")
}


// 为变量PI赋予了默认值 Pi,这样，调用该方法时可以不再传递PI。但，如果我们想传入的值和默认值不一致时还是需要传入的
val Pi = 3.1415926
fun getRoundArea(PI: Float = Pi, radius: Float): Float {
    return PI * radius * radius
}
// 因为我们相传入的PI和默认值不一致，所以，需要将3.14f传入
var a = getRoundArea(3.14f, 5.0f)
// 我们需要的PI值与默认值一致，此时不需要再传入PI值。只需要通过 radius=5.0f 声明我们传入了半径值
var a = getRoundArea(radius = 5.0f)
