// 接口--数据有进有出的交互方式、
// 接口关键字：interface —— 同Java
// 接口是事物的能力（代表某种事物的特性），抽象类是事物的本质（代表的是一类事物的共性）
// 子类实现接口时，接口名后面不需要（）

// 定义抽象类，使用 abstract 修饰。包含成员变量name
abstract class Device(var name: String) {
    abstract fun calc() // 定义抽象方法，使用 abstract 修饰
    abstract fun weight() // 定义抽象方法，使用 abstract 修饰
}

// 定义接口IComputer
interface IComputer { //定义一个电脑的接口
    fun mouse()
}

// Computer类实现IComputer接口、
// 电脑属于设备，所以继承 Device ;电脑有鼠标，所以实现 IComputer 接口
class Computer(name: String) : Device(name) , IComputer{
    override fun mouse() {
        println("这是重写IComputer接口中的方法，鼠标")
    }

    override fun weight() {
        println("${name}是电脑比较重")
    }

    override fun calc() {
        println("${name}是电脑计算快")
    }
}

// 计算器不能实现 IComputer 接口
// 计算器属于设备，但是计算器没有鼠标，所以不能实现 IComputer 接口
class Calculator(name: String) : Device(name) {
    override fun weight() {
        println("计算器也有重量")
    }

    override fun calc() {
        println("计算器也能计算")
    }
}

// https://www.jianshu.com/p/35f0c16242e4