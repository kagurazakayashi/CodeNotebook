// js获取对象的属性个数
var obj = {
    key1: 1,
    key2: 2,
    key3: 3
};

Object.getOwnPropertyNames(obj).length; // 3
Object.keys(obj).length; // 3