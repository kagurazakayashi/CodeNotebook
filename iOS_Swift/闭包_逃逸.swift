// 定义：当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
// 关键字：@escaping

// 1.定义一个闭包函数
func ccccc(closure:() -> void){
    // 闭包函数
}

// 2.定义一个逃逸闭包
var completionHandlers:[()->Void]=[]
func ddddd(completionHandler :@escaping () -> void){
    completionHandlers.append(completionHandler)
}
class mainClass{
    var x = 0
    func dosomething() {
        ccccc{ self.x = 100 }
        ddddd{ x = 200 }
    }
}
let Instance = mainClass()
Instance.dosomething()
print(Instance.x) //200
