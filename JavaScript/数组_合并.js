// 1、contact
var a = [1,2,3];
var b = [4,5,6];
var c = a.concat(b); //c=[1,2,3,4,5,6];

// 2、for循环
for(var i in b){
    a.push(b[i]);
}

// 3、apply
a.push.apply(a,b);

// 4、扩展运算符
var a = [1,2,3];
var b = [4,5,6];
var newA = [...a,...b];