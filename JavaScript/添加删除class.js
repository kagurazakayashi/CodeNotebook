// 1.比较传统的方法

var classVal = document.getElementById("id").getAttribute("class");

//删除的话
classVal = classVal.replace("someClassName","");
document.getElementById("id").setAttribute("class",classVal);

//添加的话
classVal = classVal.concat(" someClassName");
document.getElementById("id").setAttribute("class",classVal);

//替换的话
classVal = classVal.replace("someClassName","otherClassName");
document.getElementById("id").setAttribute("class",classVal);


// 2.html5增加了classList

// classList 属性返回元素的类名，作为 DOMTokenList 对象。
// 该属性用于在元素中添加，移除及切换 CSS 类。
// classList 属性是只读的，但你可以使用 add() 和 remove() 方法修改它。
// 增加：
document.getElementById("myDIV").classList.add("mystyle", "anotherClass", "thirdClass");
// 去除：
document.getElementById("myDIV").classList.remove("mystyle");


// https://blog.csdn.net/liuwengai/article/details/78795969


//JQ

// 1.获取class和设置class都可以使用attr()方法来完成。
var p_class = $("p").attr("class"); //获取p元素的class 
$("p").attr("class", "high"); //设置p元素的class为 "high"

// 2.addClass()方法来追加样式：
$("#nm_p").addClass("another"); // 追加样式

// 3.删除class的某个值，可以使用与addClass()方法相反的removeClass()方法来完成，它的 作用是从匹配的元素中删除全部或者指定的class
$("p").removeClass("high"); //移除p元素中值为"high"的class
$("p").removeClass("high").removeClass("another"); //两个class都删除
// 可以以空格的方式删除多个class名，代码如下： 
$("p").removeClass("high another");
$("p").removeClass(); //移除p元素的所有class 