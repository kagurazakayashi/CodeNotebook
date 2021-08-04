// 1、印章类的特点
// 子类类型有限的类成为 印章类/密封类
// 印章类使用 sealed 作为修饰符
// 印章类本身没有构造方法
// 2、印章类与枚举的区别
// 都是有限的数据
// 枚举更注重具体的数据
// 印章类更注重数据的类型

// 假设你家有一头公驴、一头母驴、一头公马。那么，
// 它们可能会生出一头小驴，
// 也可能会生出一头小骡子。

// 在上述场景中，由于他们能生出的类型是固定的，所以，我们可以使用印章类来标识。

// 声明印章类
sealed class Son {  //使用 sealed 声明 Son 为印章类/密封类

    class SmallMule() : Son()   //声明小骡子 SmallMule 为 Son的子类。
    class SmallDonkey() : Son() //声明小驴子 SmallDonkey 为 Son的子类

    fun sayHello(son: Son) {
        if (son is SmallMule) { //判断是不是XX的实例的关键字 is 
            println("小骡子对大家说大家好")
        } else if (son is SmallDonkey) {
            println("小驴子对大家说大家好")
        }
    }
}

// 调用印章类
fun main(args: Array<String>) {
    var mule = Son.SmallMule()
    var donkey = Son.SmallDonkey()

    var list = listOf<Son>(mule, donkey)
    for (son in list) {
        son.sayHello(son)
    }
}

// 输出
// 小骡子对大家说大家好
// 小驴子对大家说大家好


// https://www.jianshu.com/p/35f0c16242e4