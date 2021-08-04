fun main(array: ArrayList<String>) {
    println("请输入第一个数值")
    // 读取键盘输入的字符串内容，并赋值给a
    var a = readLine()
    println("请输入第二个数值")
    var b = readLine()

    // readLine() 得到的可能是null，所以此处通过 !! 断言输入不为null
    var num1 = a!!.toInt()
    var num2 = b!!.toInt()

    println("${num1}+${num2}=${num1 + num2}")
}