// 可选类型 （Optional）
var E1 : Int? = 404 // 声明一个包含可选值Int 404
var E2 : String? // E2 自动设置为nil
// OC中nil代表指向空地址，但是swift中nil代表缺失值，它是一个值value

// 可选绑定 （Optional bingding）
// 如果Int(possibleNumber)返回的可选Int包含一个值，创建一个常量 actualNumber 并赋值给它
if let acutalNumber = Int(possibleNumber){
    print(prossibleNumber + actualNumber)
}else{
    print(possibale)
}

// 隐式解析可选类型
let S1 : String? = "An optional string"
let S2 : String = S1! //需要感叹号来强制解包

let S3 : String != "Another opitonal string"
let S4 : String = S3 //不需要感叹号来强解包。这被称为隐式解析隐式解析可选类型
