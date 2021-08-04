//定义一个类，包含两个成员变量 height和width.并定义一个成员方法
class Rect(var height: Int, var width: Int) {
    fun getArea(a: Int, b: Int): Int = a * b
}

fun main(args: Array<String>) {
    var rect = Rect(5, 10) //构建Rect对象，不需要new
    println("矩形的宽${rect.width}高${rect.height}") //引用Rect类中成员变量
    println("矩形的面积是${rect.getArea(rect.width, rect.height)}") //引用Rect类中成员变量
}