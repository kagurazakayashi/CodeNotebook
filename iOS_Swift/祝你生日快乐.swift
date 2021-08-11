/*
Happy Birthday to You!
This will display the Happy Birthday song to console, a simple use of map with a range and the ternary operator.
祝你生日快乐
这段代码会将“祝你生日快乐”这首歌的歌词输出到控制台中，它在一段区间内简单的使用了 map 函数，同时也用到了三元运算符。
*/

let name = "uraimo"
(1...4).forEach{print("Happy Birthday " + (($0 == 3) ? "dear \(name)":"to You"))}