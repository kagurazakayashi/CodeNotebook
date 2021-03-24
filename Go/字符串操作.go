package main
import (
    "fmt"
    "strings"
)
func main() {
    // 字符串分割为数组
    s := "gwalker.cn,巩文,203"
    x := strings.Split(s,",")
    for i,n := range x {
        fmt.Println(i,"=>",n)
    }
    //输出如下
    //0 => gwalker.cn
    //1 => 巩文
    //2 => 203
    // strings标准库另一个有用的方法 Fields()
    spec := " */10    3 * * *"
    parseSpec := strings.Fields(spec)
    fmt.Printf("%T %v",parseSpec,parseSpec)
    // 输出如下
    // []string [*/10 3 * * *]
    // 数据拼接成字符串
    ns := strings.Join(x,"-++-")
    fmt.Println(ns)
    // 输出 gwalker.cn-++-巩文-++-203
    // 字符串查找替换
    ns = strings.Replace(ns,"+","#",-1)
    fmt.Println(ns)
    // 输出 gwalker.cn-##-巩文-##-203
    // 转小写
    ns = strings.ToLower("ABC汉字")
    fmt.Println(ns)
    // 输出 abc汉字
    // 转大写
    ns = strings.ToUpper("aBc汉字")
    fmt.Println(ns)
    // 输出 ABC汉字
    // 查找字符串是否包含某子串
    // 方法一
    alls := "i am 巩文，iham"
    n := strings.Index(alls,"m")
    if n == -1 {
        fmt.Println("不包含")
    }else{
        fmt.Println("包含，索引位置为",n)
    }
    // 输出 包含，索引位置为 8
    // 方法二
    alls = "i am 巩文，iham"
    b := strings.Contains(alls,"巩文，iham")
    if b {
        fmt.Println("包含")
    }else{
        fmt.Println("不包含")
    }
    // 输出 包含
    // 字符串截取
    s = "golang,你好.."
    s = string([]rune(s)[7:9]) // 这么看来因为slice,字符串截取还是挺灵活的
    fmt.Println(s)
    // 输出 你好
}

// ↑ https://www.gwalker.cn/article-b3f647bge5815e1dce2e6bf31027e8de.html
// ↓ https://blog.csdn.net/sanxiaxugang/article/details/60324012

// 判断字符串与子串关系
func EqualFold(s, t string) bool // 判断两个utf-8编码字符串，大小写不敏感
func HasPrefix(s, prefix string) bool // 判断s是否有前缀字符串prefix
func Contains(s, substr string) bool // 判断字符串s是否包含子串substr
func ContainsAny(s, chars string) bool // 判断字符串s是否包含字符串chars中的任一字符
func Count(s, sep string) int // 返回字符串s中有几个不重复的sep子串

// 获取字符串中子串位置
func Index(s, sep string) int // 子串sep在字符串s中第一次出现的位置，不存在则返回-1
func IndexByte(s string, c byte) int // 字符c在s中第一次出现的位置，不存在则返回-
func IndexAny(s, chars string) int // 字符串chars中的任一utf-8码值在s中第一次出现的位置，如果不存在或者chars为空字符串则返回-1
func IndexFunc(s string, f func(rune) bool) int // s中第一个满足函数f的位置i（该处的utf-8码值r满足f(r)==true），不存在则返回-1
func LastIndex(s, sep string) int // 子串sep在字符串s中最后一次出现的位置，不存在则返回-1

// 字符串中字符处理
func Title(s string) string // 返回s中每个单词的首字母都改为标题格式的字符串拷贝
func ToLower(s string) string // 返回将所有字母都转为对应的小写版本的拷贝
func ToUpper(s string) string // 返回将所有字母都转为对应的大写版本的拷贝
func Repeat(s string, count int) string // 返回count个s串联的字符串
func Replace(s, old, new string, n int) string // 返回将s中前n个不重叠old子串都替换为new的新字符串，如果n<0会替换所有old子串
func Map(mapping func(rune) rune, s string) string // 将s的每一个unicode码值r都替换为mapping(r)，返回这些新码值组成的字符串拷贝。如果mapping返回一个负值，将会丢弃该码值而不会被替换

// 字符串前后端处理
func Trim(s string, cutset string) string // 返回将s前后端所有cutset包含的utf-8码值都去掉的字符串
func TrimSpace(s string) string // 返回将s前后端所有空白（unicode.IsSpace指定）都去掉的字符串
func TrimFunc(s string, f func(rune) bool) string // 返回将s前后端所有满足f的unicode码值都去掉的字符串

// 字符串分割与合并
func Fields(s string) []string // 返回将字符串按照空白（通过unicode.IsSpace判断，可以是一到多个连续的空白字符）分割的多个字符串
func Split(s, sep string) []string // 用去掉s中出现的sep的方式进行分割，会分割到结尾，并返回生成的所有片段组成的切片
func Join(a []string, sep string) string // 将一系列字符串连接为一个字符串，之间用sep来分隔

// 判断两个utf-8编码字符串，大小写不敏感
s, t := "hello go", "hello Go"
is_equal := strings.EqualFold(s, t)
fmt.Println("EqualFold: ", is_equal) // EqualFold:  true
// 判断s是否有前缀字符串prefix
prefix := "hello"
has_prefix := strings.HasPrefix(s, prefix)
fmt.Println(has_prefix) // true
// 判断s是否有后缀字符串suffix
suffix := "go"
has_suffix := strings.HasSuffix(s, suffix)
fmt.Println(has_suffix) // true
// 判断字符串s是否包含子串substr
substr := "lo"
con := strings.Contains(s, substr)
fmt.Println(con) // true
// 判断字符串s是否包含utf-8码值r
r := rune(101)
ru := 'e'
con_run := strings.ContainsRune(s, r)
fmt.Println(con_run, r, ru) // true
// 子串sep在字符串s中第一次出现的位置，不存在则返回-1
sep := "o"
sep_idnex := strings.Index(s, sep)
fmt.Println(sep_idnex) // 4
// 子串sep在字符串s中最后一次出现的位置，不存在则返回-1
sep_lastindex := strings.LastIndex(s, sep)
fmt.Println(sep_lastindex) // 7
// 返回s中每个单词的首字母都改为标题格式的字符串拷贝
title := strings.Title(s)
fmt.Println(title) // Hello Go
// 返回将所有字母都转为对应的标题版本的拷贝
to_title := strings.ToTitle(s)
fmt.Println(to_title) // HELLO GO
// 返回将所有字母都转为对应的小写版本的拷贝
s_lower := strings.ToLower(s)
fmt.Println(s_lower) // hello go
// 返回count个s串联的字符串
s_repeat := strings.Repeat(s, 3)
fmt.Println(s_repeat) // hello gohello gohello go
// 返回将s中前n个不重叠old子串都替换为new的新字符串，如果n<0会替换所有old子串
s_old, s_new := "go", "world"
s_replace := strings.Replace(s, s_old, s_new, -1)
fmt.Println(s_replace) // hello world
// 返回将s前后端所有cutset包含的utf-8码值都去掉的字符串
s, cutset := "#abc!!!", "#!"
s_new = strings.Trim(s, cutset)
fmt.Println(s, s_new) // #abc!!! abc
// 返回将字符串按照空白（unicode.IsSpace确定，可以是一到多个连续的空白字符）分割的多个字符串
s = "hello world! go language"
s_fields := strings.Fields(s)
for k, v := range s_fields {
	fmt.Println(k, v)
}
// 0 hello
// 1 world!
// 2 go
// 3 language
// 用去掉s中出现的sep的方式进行分割，会分割到结尾，并返回生成的所有片段组成的切片
s_split := strings.Split(s, " ")
fmt.Println(s_split) // [hello world! go language]
// 将一系列字符串连接为一个字符串，之间用sep来分隔
s_join := strings.Join([]string{"a", "b", "c"}, "/")
fmt.Println(s_join) // a/b/c
// 将s的每一个unicode码值r都替换为mapping(r)，返回这些新码值组成的字符串拷贝。如果mapping返回一个负值，将会丢弃该码值而不会被替换
map_func := func(r rune) rune {
	switch {
	case r > 'A' && r < 'Z':
		return r + 32
	case r > 'a' && r < 'z':
		return r - 32
	}
	return r
}
s = "Hello World!"
s_map := strings.Map(map_func, s)
fmt.Println(s_map) // hELLO wORLD!