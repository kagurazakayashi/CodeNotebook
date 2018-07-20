/*
1，委托的说明
委托（delegate）是Cocoa的一个术语，表示将一个对象的部分功能转交给另一个对象。
比如对象A希望对象B知道将要发生或已经发生某件事情，对象A可以把对象B的引用存为一个实例变量。这个对象B称为委托。当事件发生时，它检查委托对象是否实现了与该事件相适应的方法。如果已经实现，则调用该方法。
由于松耦合的原因，一个对象能成为多个对象的委托。某些情况下，相较于通过继承让子类实现相关的处理方法，可以有效减少代码复杂度。所以iOS中也大量的使用了委托。
2，委托的使用样例
下面通过用户登录类，日志记录类来演示委托的用法。（其中日志记录类来充当用户登录类的委托）
*/
//定义一个协议
protocol LogManagerDelegate {
    func writeLog()
}
 
//用户登录类
class UserController {
    var delegate : LogManagerDelegate?
     
    func login() {
        //查看是否有委托，然后调用它
        delegate?.writeLog()
    }
}
 
//日志管理类
class SqliteLogManager : LogManagerDelegate {
    func writeLog() {
        print("将日志记录到sqlite数据库中")
    }
}
 
 
//使用
let userController = UserController()
userController.login()  //不做任何事
 
let sqliteLogManager = SqliteLogManager()
userController.delegate = sqliteLogManager
userController.login()  //输出“将日志记录到sqlite数据库中”
// 原文出自：www.hangge.com  转载请保留原文链接：http://www.hangge.com/blog/cache/detail_810.html