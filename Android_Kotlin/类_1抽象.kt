// 抽象的关键字 abstract —— 同Java
// 抽象类和方法不需要用 open 声明可以被继承/实现

// 抽象类 Device
// 定义抽象类，使用 abstract 修饰。包含成员变量name
abstract class Device (var name: String){
    // 定义抽象方法，使用 abstract 修饰
    abstract fun calc()
}

// 抽象类的子类Computer
class Computer(name: String) : Device(name) { // 继承自Device抽象类
    override fun calc() { // 必须重写抽象方法
        println("${name}是电脑计算快")
    }
}

// 调用子类
fun main(args: Array<String>) {
    var man = Computer("A")
    man.calc()
}

// https://www.jianshu.com/p/35f0c16242e4