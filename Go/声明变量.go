package main
 
//变量学习:变量的声明
 
import(
    "fmt"
)
//全局变量
var (
    a int //指明类型，不赋值，默认为改类型的零值
    b = 1 //也可以不指明类型，但是必须赋值，golang会默认匹配类型
    c string = "hello world" //也可指明类型同时赋值
)
 
//err := "error" 不可使用该方式声明全局变量
 
func main(){
    //全局变量
    fmt.Println("a =",a)
    fmt.Println("b =",b)
    fmt.Println("c =",c)
    //局部变量,除了上述声明变量的方法，也可以让golang默认匹配类型
    d := 2
    e := "hello,fly"
 
    fmt.Printf("val(d)=%v,type(d)=%T\n",d,d)
    fmt.Printf("val(e)=%v,type(e)=%T\n",e,e)
 
    //一次声明多个变量
    f, g := 10,"fly"
    fmt.Printf("val(f)=%v,type(f)=%T\n",f,f)
    fmt.Printf("val(g)=%v,type(g)=%T\n",g,g)   
 
    var p = &f
    arr := [5]int{1,2,3,4,5}
    fmt.Printf("val(p)=%v,type(p)=%T\n",p,p)
    fmt.Printf("val(arr)=%v,type(arr)=%T\n",arr,arr)
 
}

// https://www.cnblogs.com/flycc/p/12619088.html