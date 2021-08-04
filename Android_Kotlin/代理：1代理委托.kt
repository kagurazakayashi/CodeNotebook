// 委托，把自己不干的事情交给别人做
// 代理，做别人委托的事情
// kotlin中接口代理关键字：by

// 围裙妈妈只负责做饭，不负责洗碗
// 小头爸爸洗一次碗可以赚到10元
// 大头儿子洗一次碗可以赚到1元
// 小头爸爸承揽了洗碗的活，最终交给大头儿子做，中间赚了9元差价

// 定义洗碗的接口
interface IWashBow {
    // 定义一个洗碗接口，包含一个洗碗方法
    fun washBow()
}

// 大头儿子实现接口
class BigHeadSon:IWashBow { // 被实现的接口后面不需要加()
    override fun washBow() {
        println("我是大头儿子，每次洗碗赚1元钱")
    }
}

// 小头爸爸实现接口并委托事件给小头儿子
class SmallHeadFather:IWashBow by BigHeadSon() {
    //委托关键字 by; 被委托方(即代理方)如果不是单例类，则后面需要跟()
}

// 程序调用及输出结果
fun main(args: Array<String>) {
    var father = SmallHeadFather()
    father.washBow() // 小头爸爸已经将洗碗的操作委托为小头儿子了，所以，此处本质是调用的小头儿子的洗碗操作
    // >我是大头儿子，每次洗碗赚1元钱
}