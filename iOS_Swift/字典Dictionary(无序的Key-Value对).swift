// Dictionary字典(无序的Key-Value对)

// 空字典
var A1 = [Int,String]()
A1 = [:]

// 字面量创建
var plant : [String:String] = ["T1":"厦门","T0":"广州"]

// 同样字典也遵循基本属性count,append,[index]等

// 如果你需要使用某个字典的键集合或者值集合来作为某个接受 Array 实例的 API 的参数，可以直接使用 keys 或者 values 属性构造一个新数组：
let a = [String](plant.value)
let b = [String](plant.key)