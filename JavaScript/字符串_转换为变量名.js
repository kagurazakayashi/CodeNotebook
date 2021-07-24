// 将一个字符串转换为变量名
function string_to_name(string) {
    let _name = 'var new_name=' + string;
    eval(_name);
    return _name;
}

//  将一个字符串转换为变量并赋值
var str = 'string';
var _script = 'var ' + string + ' =123;';
eval(_script);
console.log(typeof string);//number
console.log(string);//123
string = 456;
console.log(string);//456

// https://blog.csdn.net/weixin_36185028/article/details/75020728


// 解析对象时：
language = 'en';
div.innerText = eval('data.' + language);