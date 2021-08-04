// 同种功能，不同的表现形式 即为 多态

// 定义抽象类，使用 abstract 修饰。包含成员变量name
abstract class Device(var name: String) {
    abstract fun calc() // 定义抽象方法，使用 abstract 修饰
    abstract fun weight() // 定义抽象方法，使用 abstract 修饰
}

// 子类Computer
class Computer(name: String) : Device(name) {
    override fun weight() {
        println("${name}是电脑比较重")
    }

    override fun calc() {
        println("${name}是电脑计算快")
    }
}

// 子类Calculator
class Calculator(name: String) : Device(name) {
    override fun calc() {
        println("${name}是计算器计算慢")
    }

    override fun weight() {
        println("${name}是计算器比较轻")
    }
}

// 外部调用
fun main(args: Array<String>) {
    var computer = Computer("A")
    var calculator = Calculator("B")

    var list = listOf<Device>(computer,calculator) //定义集合
    for (device in list){ //遍历集合
        device.weight()
    }
}

// https://www.jianshu.com/p/35f0c16242e4