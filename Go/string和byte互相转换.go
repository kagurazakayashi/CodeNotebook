// 1 string 转为 []byte
var str string = "test"
var data []byte = []byte(str)

// 2 byte 转为 string
var data [10]byte 
byte[0] = 'T'
byte[1] = 'E'
var str string = string(data[:])