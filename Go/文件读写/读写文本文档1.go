// 创建文本文件
f, err := os.Create(fileName)
defer f.Close()
if err != nil {
	fmt.Println(err.Error())
} else {
	_, err = f.Write([]byte("要写入的文本内容"))
	checkErr(err)
}

// 读取文本文件
f, err := os.OpenFile(fileName, os.O_RDONLY, 0600)
defer f.Close()
if err != nil {
	fmt.Println(err.Error())
} else {
	contentByte, err := ioutil.ReadAll(f)
	checkErr(err)
	fmt.Println(string(contentByte))
}

// 写入文本文件
f, err := os.OpenFile(fileName, os.O_WRONLY|os.O_TRUNC, 0600)
defer f.Close()
if err != nil {
	fmt.Println(err.Error())
} else {
	_, err = f.Write([]byte("要写入的文本内容"))
	checkErr(err)
}

// OpenFile用法：os.OpenFile(文件名，打开方式，打开模式）

/* 打开方式
const (
//只读模式
O_RDONLY int = syscall.O_RDONLY // open the file read-only.
//只写模式
O_WRONLY int = syscall.O_WRONLY // open the file write-only.
//可读可写
O_RDWR int = syscall.O_RDWR // open the file read-write.
//追加内容
O_APPEND int = syscall.O_APPEND // append data to the file when writing.
//创建文件,如果文件不存在
O_CREATE int = syscall.O_CREAT // create a new file if none exists.
//与创建文件一同使用,文件必须存在
O_EXCL int = syscall.O_EXCL // used with O_CREATE, file must not exist
//打开一个同步的文件流
O_SYNC int = syscall.O_SYNC // open for synchronous I/O.
//如果可能,打开时缩短文件
O_TRUNC int = syscall.O_TRUNC // if possible, truncate file when opened.
)
*/

/* 打开模式
const (
ModeDir FileMode = 1 << (32 - 1 - iota) // d: is a directory 文件夹模式
ModeAppend // a: append-only 追加模式
ModeExclusive // l: exclusive use 单独使用
ModeTemporary // T: temporary file (not backed up) 临时文件
ModeSymlink // L: symbolic link 象征性的关联
ModeDevice // D: device file 设备文件
ModeNamedPipe // p: named pipe (FIFO) 命名管道
ModeSocket // S: Unix domain socket Unix 主机 socket
ModeSetuid // u: setuid 设置uid
ModeSetgid // g: setgid 设置gid
ModeCharDevice // c: Unix character device, when ModeDevice is set Unix 字符设备,当设备模式是设置Unix
ModeSticky // t: sticky 粘性的
// Mask for the type bits. For regular files, none will be set. bit位遮盖.不变的文件设置为none
ModeType = ModeDir | ModeSymlink | ModeNamedPipe | ModeSocket | ModeDevice
ModePerm FileMode = 0777 // Unix permission bits 权限位.
)

*/