package main

// 批量文件字符串替换
// 神楽坂雅詩

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
	"time"
)

var dir string
var find string
var replace string
var subdir bool
var extensions []string
var idir int = 0
var ifile int = 0
var ifileext int = 0
var ifilefind int = 0
var irepok int = 0
var irepng int = 0

//获取指定目录下的所有文件,包含子目录下的文件
func GetAllFiles(dirPth string) (files []string, err error) {
	idir++
	var dirs []string
	dir, err := ioutil.ReadDir(dirPth)
	if err != nil {
		fmt.Println("读取目录失败：" + dirPth)
		fmt.Println("　　遇到错误：" + err.Error())
		return dirs, nil
	}
	PthSep := string(os.PathSeparator)
	//suffix = strings.ToUpper(suffix) //忽略后缀匹配的大小写
	for _, fi := range dir {
		if fi.IsDir() { // 目录, 递归遍历
			dirs = append(dirs, dirPth+PthSep+fi.Name())
			GetAllFiles(dirPth + PthSep + fi.Name())
		} else {
			ifile++
			var ok bool = extensionfind(fi.Name())
			if ok {
				files = append(files, dirPth+PthSep+fi.Name())
			}
		}
	}
	// 读取子目录下文件
	if subdir == true {
		for _, table := range dirs {
			temp, _ := GetAllFiles(table)
			for _, temp1 := range temp {
				files = append(files, temp1)
			}
		}
	}
	return files, nil
}

//过滤指定格式
func extensionfind(filename string) bool {
	var isok bool = false
	if extensions == nil {
		return true
	}
	for _, extensionstr := range extensions {
		if strings.HasSuffix(filename, "."+extensionstr) {
			isok = true
			ifileext++
		}
	}
	return isok
}

func strfind(file string) bool {
	in, err := os.Open(file)
	if err != nil {
		fmt.Println("读取文件失败：" + file)
		fmt.Println("　　遇到错误：" + err.Error())
		return false
	}
	defer in.Close()

	br := bufio.NewReader(in)
	var lineindex int = 1
	for {
		line, _, err := br.ReadLine()
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println("读取文件失败：" + file)
			fmt.Println("　　遇到错误：" + err.Error())
			continue
		}
		var linestr = string(line)
		newLine := strings.Replace(linestr, find, replace, -1)
		if newLine != linestr {
			fmt.Println("正在处理文件：" + file)
			fmt.Println("　行" + strconv.Itoa(lineindex) + "原文：" + newLine)
			fmt.Println("　行" + strconv.Itoa(lineindex) + "改后：" + linestr)
			return true
		}
		lineindex++
	}
	return false
}

//处理文件
func strrep(file string) bool {
	in, err := os.Open(file)
	if err != nil {
		fmt.Println("读取文件失败：" + file)
		fmt.Println("　　遇到错误：" + err.Error())
		return false
	}
	defer in.Close()

	var tmpfile string = file + ".yashireplace"
	out, err := os.OpenFile(tmpfile, os.O_RDWR|os.O_CREATE, 0766)
	if err != nil {
		fmt.Println("创建临时文件失败：" + tmpfile)
		fmt.Println("　　　　遇到错误：" + err.Error())
		return false
	}
	defer out.Close()

	br := bufio.NewReader(in)
	var lineindex uint = 1
	for {
		line, _, err := br.ReadLine()
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println("读取文件失败：" + file)
			fmt.Println("　　遇到错误：" + err.Error())
			return false
		}
		newLine := strings.Replace(string(line), find, replace, -1)
		_, err = out.WriteString(newLine + "\n")
		if err != nil {
			fmt.Println("写入文件失败：" + tmpfile)
			fmt.Println("　　遇到错误：" + err.Error())
			return false
		}
		// fmt.Println("行处理完成：", lineindex)
		lineindex++
	}

	err = os.Rename(tmpfile, file)
	if err != nil {
		fmt.Println("应用临时文件失败：" + tmpfile)
		fmt.Println("　　　　目标文件：" + file)
		return false
	}

	return true
}

func main() {
	var extensionstr string
	flag.StringVar(&dir, "d", "./", "要扫描的文件夹路径")
	flag.StringVar(&find, "f", "", "要查找的字符串")
	flag.StringVar(&replace, "r", "", "要替换的字符串")
	flag.BoolVar(&subdir, "s", false, "扫描子目录")
	flag.StringVar(&extensionstr, "e", "", "扩展名列表，英文逗号分隔，不加 '.' ，例如 \"php,py\" ")
	flag.Parse()
	var fgstr = "==========="
	fmt.Println(fgstr + fgstr + fgstr)
	fmt.Println("雅诗批量文件字符串替换工具 v1.0")
	fmt.Println(fgstr + fgstr + fgstr)
	var subdirinfo string = "包含子文件夹"
	if subdir == false {
		subdirinfo = "不包含子文件夹"
	}
	fmt.Println("文件夹（" + subdirinfo + "）：" + dir)
	fmt.Println("查找：" + find)
	fmt.Println("替换：" + replace)
	fmt.Println("扩展名过滤：" + replace)
	fmt.Println("开始时间：" + time.Now().Format("2006-01-02 15:04:05"))
	fmt.Println(fgstr + " 处理日志 " + fgstr)
	if find == "" || replace == "" {
		fmt.Println("错误：必须指定 -f 和 -r 来决定要查找替换的内容。")
		fmt.Println("如果需要帮助，请使用 -h 参数。")
		os.Exit(2)
	}
	if extensionstr != "" {
		extensions = strings.Split(extensionstr, ",")
	}
	var files []string
	var err error
	files, err = GetAllFiles(dir)
	if err != nil {
		fmt.Println("操作完成，但有一些问题：" + err.Error())
	}
	if files != nil {
		for _, file := range files {
			if strfind(file) {
				if strrep(file) == false {
					irepng++
				} else {
					irepok++
				}
			}
		}
	}
	fmt.Println(fgstr + " 处理结果 " + fgstr)
	fmt.Println("结束时间：" + time.Now().Format("2006-01-02 15:04:05"))
	fmt.Println("已搜索文件夹：" + strconv.Itoa(idir))
	fmt.Println("已搜索文件：" + strconv.Itoa(ifile))
	if extensions != nil {
		fmt.Println("符合条件的扩展名：" + strconv.Itoa(ifileext))
	}
	fmt.Println("需要处理的文件：" + strconv.Itoa(irepok+irepng))
	fmt.Println("已处理成功文件：" + strconv.Itoa(irepok))
	fmt.Println("已处理失败文件：" + strconv.Itoa(irepng))
}
