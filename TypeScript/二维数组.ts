// 二维数组声明
let t1: string[][] = [];
let t2: Array<Array<string>> = new Array<Array<string>>();

// 由于是二维数组, 所以第二维还是undefined的, t1[0][1] = "a1"
t1[0] = ["a1", "a2", "a3"]  //直接赋值数组
t1.push([])  //先插入一个空的数组
t1[1][1] = "b2"  //再向刚插入的数组赋值

// https://www.jianshu.com/p/be871ff2fee4