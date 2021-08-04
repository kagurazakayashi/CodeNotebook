// 一个对象直接使用另一个对象的属性或方法 —— 同Java
// 被继承的父类必须用 open 修饰，表示允许其他类继承该类
// 父类中的方法如果允许子类重写，也需要用 open 修饰
// 重写父类方法时需要用 overRide 修复重写后的方法
// 继承的格式：class 子类：父类()

// 父类
open class Father { // 用 open 修饰，允许被继承
    var character = "性格内向"
    open fun action() { // 用 open 修饰，允许被重写
        println("喜欢读书")
    }
}

// 子类
class Son : Father() { // 继承。 Son 继承自 Father
    override fun action() { // 重写父类方法
        //super.action()
        println("儿子的性格是$character")   
        println("儿子不喜欢看书，但是喜欢唱歌")
    }
}

// https://www.jianshu.com/p/35f0c16242e4