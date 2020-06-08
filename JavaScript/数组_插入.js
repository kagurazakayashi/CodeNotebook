// 1、push()、pop()和unshift()、shift()
//
// 　　这两组同为对数组的操作，并且会改变数组的本身的长度及内容。
//
// 　　不同的是 push()、pop() 是从数组的尾部进行增减，unshift()、shift() 是从数组的头部进行增减。
　var arr = [1, 2];

// 2、push()和unshift()
//
// 　　向数组的 尾部/头部 添加若干元素，并返回 数组的 新长度；
　　arr.push(3,4);         //返回 arr 的新长度 4
　　arr ;                        // arr = [1,2,3,4];
　　arr.unshift(0,0.5);    // 返回 arr 的新长度 6
　　arr ;                       // arr = [0,0.5,1,2,3,4];

// 3、pop()和shift()
//
// 　　从数组的 尾部/头部 删除1个元素(删且只删除1个)，并返回 被删除的元素；空数组是继续删除，不报错，但返回undefined；
　　arr.pop();　　　　　　//返回 4；
　　arr ;　　　　　　　　  // arr = [0,0.5,1,2,3];
　　arr.pop();　　　　　　//返回 3；
　　arr ;　　　　　　　　 // arr = [0,0.5,1,2];
　　arr.shift();　　　　  // 返回 0 ；
　　arr ;　　　　　　　　// arr = [0.5,1,2]
// 　　PS: pop()和shift() 不接受传参，即使传了参数也没什么卵用~~；
　　arr.pop(3) ;           // 返回 2；永远返回最后一个；
　　arr ; 　　　　　　　// arr = [0.5,1];
　　arr.shift(1);　　　　// 返回 0.5; 永远返回第一个；
　　arr ;　　　　　　　　// arr = [1];
　　arr.pop() ; 　　　　// 返回 1；
　　arr ;　　　　　　　　// arr = [];
　　arr.shift()　　　　　// 返回 undefined；
　　arr ;　　　　　　　　// arr = [];
