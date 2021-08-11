// 元组(purple)
let httpError = (404,"not found") // (anytype,antype)

// 元组内容可分解
let (statusCode,statusMessage) = httpError
print(httpError.statusCode)
print(httpError.statusMessage)

// 可选元组
let (justStatusCode, _ ) = httpError
print("\(justStatusCode)")

// 下标访问
print(httpError.0)
print(httpError.1)
