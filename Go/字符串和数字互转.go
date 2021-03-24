// string -> int
int, err := strconv.Atoi(string)
// string -> int64
int64, err := strconv.ParseInt(string, 10, 64)
// string -> int -> uint64
intNum, _ := strconv.Atoi(intStr)
int64Num = uint64(intNum)
// int -> string
string := strconv.Itoa(int)
// int64 -> string
string := strconv.FormatInt(int64,10)
// uint64 -> string
string := strconv.FormatUint(uint64, 10)