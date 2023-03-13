package main

import (
    "encoding/json"
    "fmt"
    "github.com/bitly/go-simplejson"
)

type personInfo struct {
    Name  string `json:"name"`
    Age   int    `json:"age"`
    Email string `json:"email" xml:"email"`
}

type personInfo1 struct {
    Name  string `json:"name"`
    Email string `json:"email" xml:"email"`
    C     string
}

func main() {
    // 创建数据
    p := personInfo{Name: "Piao", Age: 10, Email: "piaoyunsoft@163.com"}

    // 序列化
    data, _ := json.Marshal(&p)
    fmt.Println(string(data))

    // 反序列化1
    var p1 personInfo1
    err := json.Unmarshal([]byte(data), &p1) // 貌似这种解析方法需要提前知道 json 结构
    if err != nil {
        fmt.Println("err: ", err)
    } else {
        fmt.Printf("name=%s, c=%s, email=%s\n", p1.Name, p1.C, p1.Email)
    }
    fmt.Printf("%+v\n", p1)

    // 反序列化2
    var p2 map[string]string
    err := json.Unmarshal([]byte(data), &p2) // 貌似这种解析方法需要提前知道 json 结构
    if err != nil {
        fmt.Println("err: ", err)
    } else {
        fmt.Printf("name=%s, c=%s, email=%s\n", p2["Name"], p2["C"], p2["Email"])
    }
    fmt.Printf("%+v\n", p2)

    // 反序列化3
    res, err := simplejson.NewJson([]byte(data))
    if err != nil {
        fmt.Println("err: ", err)
    } else {
        fmt.Printf("%+v\n", res)
    }
}
/*
运行的结果

➜  test go run main.go
{"name":"Piao","age":10,"email":"piaoyunsoft@163.com"}
name=Piao, c=, email=piaoyunsoft@163.com
{Name:Piao Email:piaoyunsoft@163.com C:}
&{data:map[name:Piao age:10 email:piaoyunsoft@163.com]}

https://studygolang.com/articles/17292
*/