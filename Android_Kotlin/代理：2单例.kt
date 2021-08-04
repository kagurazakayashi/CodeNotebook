// 单例关键字：object
// 我们在定义一个类时，使用object 替换 class 来修饰这个类，就表示，这是一个单例类
// 单例类作为代理人时，不需要()

// 小头爸爸为了增进父子感情，想和小头儿子一起洗碗

// 大头儿子单例类
// 单例关键字object, 声明为单例类之后会立即在内存中创建单例对象，并一直存在
object BigHeadSon:IWashBow {
    override fun washBow() {
        println("我是大头儿子，每次洗碗赚1元钱")
    }
}

// 小头爸爸委托事件给单例的大头儿子
class SmallHeadFather:IWashBow by BigHeadSon{     
    // 被委托方(即代理方)是单例类，不需要通过（）构建对象
    override fun washBow() {
        println("我是小头爸爸，虽然我把洗碗事件委托给了小头儿子，但是我要和他一起洗碗")
        BigHeadSon.washBow()  // 委托方重写了事件之后，需要手动调用代理方的方法。由于 BigHeadSon是单例的，所以，这还是我们之前委托的那个儿子
        println("我是小头爸爸，我和小头儿子洗完碗之后，我赚了9元")
    }
}

// 外部调用
fun main(args: Array<String>) {
    var father=SmallHeadFather()
    father.washBow() // 小头爸爸已经将洗碗的操作委托为小头儿子了，但因为重写了洗完事件，所以，本子是调用的父亲的洗完事件，父亲的洗完事件中有一部分是自己做的，另一部分是儿子做的
}