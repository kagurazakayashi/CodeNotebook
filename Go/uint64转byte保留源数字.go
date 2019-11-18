// uint64转byte保留源数字

// 数字 2 LittleEndian
var buf = make([]byte, 8)
fmt.Println(buf) //[0 0 0 0 0 0 0 0]
binary.LittleEndian.PutUint64(buf, uint64(2))
fmt.Println(buf) //[2 0 0 0 0 0 0 0]
number = buf[0]
fmt.Println(number) //2

// 数字 2 BigEndian
var buf = make([]byte, 0)
binary.BigEndian.PutUint64(buf, uint64(2))
fmt.Println(buf) //[0 0 0 0 0 0 0 2]
number = buf[7]
fmt.Println(number) //2

// 转回数字
binary.BigEndian.Uint64(byte)