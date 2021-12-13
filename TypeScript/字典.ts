// 创建一个键的类型为string，值的类型为number的字典
let dic: { [key: string]: number } = {};

// 两种方式均可添加键值
dic["id"] = 1;
dic.id = 1;

// 删除
delete dic["id"];

// 查找
for (const key in dic) {
    // if (dic.hasOwnProperty(key)) {
        console.log(dic[key]);
    // }
}

// KEYS
const keys = Object.keys(dic);