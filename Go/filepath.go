import "path/filepath"
// 获取当前目录
os.GetPWD()
filepath.Abs(path) // 绝对目录
filepath.Dir(path) // 相对目录
可以 filepath.Abs(filepath.Dir(path))
// 获取字符目录,前缀,后缀等方法
filepath.Split(path)
filepath.Base(path) // test.txt
filepath.Ext(path)  // .txt