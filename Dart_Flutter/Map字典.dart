// 声明
//直接赋值
var map1 = {'aa':'aaa','bb':22,'cc':true}; 
Map map2 = {'a':'a1','b':'b1'};  
//间接赋值
var map3 = new Map(); 
map3['aa'] = 'aaa'; 
Map map4 = new Map(); 
map4['a'] = 'aaa';

// 指定泛型
//直接赋值
var map1 = <String,String>{'aa':'aaa','bb':'22','cc':'333'};
Map map2 = <String,String>{'a':'a1','b':'b1','c':'c1'};
//间接赋值
var map3 = new Map<String,String>();
map3['aa'] = 'aaa';
Map map4 = new Map<String,String>();
map4['a'] = 'a1';

// 复制
// 不使用类型操作符,从另一个map中初始化新的map，此时新的map中含有另一个map中的资源
Map map1 = {'a':'a1','b':'b1','c':'c1'};
Map map2 = Map.castFrom(map1);
print(map2);
// 强制使用指定类型初始化map
// 下面的例子表示testMap1的类型为<num,String>,初始化Map时castFrom中map的类型为<int,String>
// 如果类型不匹配或者不兼容就会导致程序crash
Map<int,String> map3 = {1:'a',2:'b',3:'c'};
Map map6 = Map.castFrom<int,String>(map3); //正确

// 创建不可变的Map
Map map6 = const {'one':'Android','two':'IOS','three':'flutter'};
// 在目标的map6创建(复制)新的不可修改map7
Map map7 = Map.unmodifiable(map6);
print(map7);


// 属性
Map<String,int> map6 = {"a":1,"b":2};
print(map6.length);//2  长度
print(map6.isNotEmpty);//true  是否不为空
print(map6.isEmpty);//false   是否为空
print(map6.keys);//(a, b)   key的集合
print(map6.values);//(1, 2)  value的集合
print(map6.entries);//(MapEntry(a: 1), MapEntry(b: 2))   map迭代的键值对集合


// 方法

// 增

Map<String,int> map7 = {"a":1,"b":2,"c":3,"d":4,"e":5};
//新增一个key value
map7["f"] = 6;//新增一个不存在的key
print(map7);//{a: 1, b: 2, c: 3, d: 4, e: 5, f: 6}

// 改

// 修改一个key的value
Map<String,int> map8 = {"a":1,"b":2,"c":3,"d":4,"e":5};
map8["a"] = 11;
print(map8);//{a: 11, b: 2, c: 3, d: 4, e: 5}

// update() 对指定的key的value做出修改
Map<String,int> map23 = {"a":1,"b":2,"c":3};
int result3 = map23.update("a", (value)=>(value*2));//key存在  根据参数函数修改其值
print(result3);//2
print(map23);//{a: 2, b: 2, c: 3}
int result4 = map23.update("d", (value)=>(value*2));//key不存在  报错
int result4 = map23.update("d", (value)=>(value*2),ifAbsent: ()=>(10));//key不存在  但有ifAbsent参数 返回ifAbsent函数的值  并添加到map中
print(result4);//10
print(map23);//{a: 2, b: 2, c: 3, d: 10}

// updateAll() 根据参数函数的规则，批量修改map
Map<String,int> map24 = {"a":1,"b":2,"c":3};
map24.updateAll((String key,int value){
    return value*2;
});//
print(map24);//{a: 2, b: 4, c: 6}

Map<String,int> map25 = {"a":1,"b":2,"c":3};
map25.updateAll((String key,int value){
    if(key=="a"){return 10;}
    if(key=="b"){return 20;}
    return value*2;
});//
print(map25);//{a: 10, b: 20, c: 6}

// 删

// remove() 删除一个key
Map<String,int> map9 = {"a":1,"b":2,"c":3,"d":4,"e":5};
map9.remove("b");
print(map9);//{a: 11, c: 3, d: 4, e: 5}

// removeWhere() 根据条件批量删除
Map<String,int> map10 = {"a":1,"b":2,"c":3,"d":4,"e":5};
map10.removeWhere((key,value)=>(value>3));//删除掉 符合参数函数的keyvalue对
print(map10);//{a: 1, b: 2, c: 3}

// 查

// containsKey() 是否包含key
Map<String,int> map11 = {"a":1,"b":2,"c":3,"d":4,"e":5};
print(map11.containsKey("a"));//true   是否包含key
print(map11.containsKey("aa"));//false  是否包含key

// containsValue() 是否包含value值
Map<String,int> map17 = {"a":1,"b":2,"c":3};
print(map17.containsValue(1));//true
print(map17.containsValue(4));//false

// forEach() 遍历
Map<String,int> map12 = {"a":1,"b":2,"c":3,"d":4,"e":5};
map12.forEach((String key,int value){
    print("$key  $value");
    // a  1
    // b  2
    // c  3
    // d  4
    // e  5
});

// 遍历时修改value值
Map<String,int> map13 = {"a":1,"b":2,"c":3};
map13.forEach((String key,int value){
print("$key  $value");
map13["c"] = 4;
    // a  1
    // b  2
    // c  4
});

// 注意：遍历时，新增或删除key  都会报错

// 其它

// map() 遍历每个元素 根据参数函数，对keyvalue做出修改，可转换成其他泛型的Map
Map<String,int> map19 = {"a":1,"b":2,"c":3};
Map<int,String> map20 = map19.map((String key,int value){
    return new MapEntry(value, key);
});
print(map20);//{1: a, 2: b, 3: c}

// clear() 清空map
Map<String,int> map15 = {"a":1,"b":2,"c":3};
map15.clear();
print(map15);//{}

// addAll() 整体合并另一个map 泛型要一致
Map<String,int> map16 = {"a":1,"b":2,"c":3};
Map<String,int> other = {"a":1,"c":4,"d":7};
map16.addAll(other);//key相同时value值后者覆盖前者，前者不存在时则添加进来
print(map16);//{a: 1, b: 2, c: 4, d: 7}

// addEntries() 合并两个map 如果key有重复，被合并的map的value覆盖前者
Map<String,int> map26 = {"a":1,"b":2,"c":3};
Map<String,int> map27 = {"a":1,"b":4,"d":3,"e":5};
map26.addEntries(map27.entries);
print(map26);//{a: 1, b: 4, c: 3, d: 3, e: 5}

// putIfAbsent() 存在key就获取值，不存在则添加到map 然后返回值
Map<String,int> map18 = {"a":1,"b":2,"c":3};
int result = map18.putIfAbsent("a", ()=>(2));//存在
print(result);//1   获取key的值
print(map18);//{a: 1, b: 2, c: 3}   map不变
int result2 = map18.putIfAbsent("d", ()=>(2));//不存在
print(result2);//2   获取新的key的value
print(map18);//{a: 1, b: 2, c: 3, d: 2}   map改变

// cast() 泛型类型提升为其父祖类
Map<String,int> map21 = {"a":1,"b":2,"c":3};
Map<Object,Object> map22 = map21.cast();
map22["d"]=33;
print(map22);//{a: 1, b: 2, c: 3, d: 33}

// 通用方法
// List、Set和Map有一些通用的方法。其中的一些通用方法都是来自于类Iterable。List和Set是iterable类的实现。
// 虽然Map没有实现Iterable, 但是Map的属性keys和values都是Iterable对象。

// 通用属性 isEmpty和 isNotEmpty
var testSet = Set.from(["a", "b", "c"]);
var testList = [1, 2, 3, 4];
var testMap = Map();

print(testSet.isNotEmpty); // true
print(testList.isEmpty); // false
print(testMap.isEmpty); // true

testMap.addAll({
"zh": "china",
"us": "usa"
});

// forEach方法
testList.forEach((num) => print("I am num ${num}")); // I am num 1 等等
testMap.forEach((k, v) => print("${k} is ${v}")); // zh is china 等等

// iterable提供了 map 方法，来处理每一个集合中的对象，并返回一个结果
var setIter = testSet.map((v) => v.toUpperCase());
print(setIter); // (A, B, C)

// 可以用toList和toSet将结果转换成列表或者集合
var listIter = testSet.map((v) => v.toUpperCase()).toList();
print(listIter); // [A, B, C]

// iterable提供了where方法，来过滤集合中的值，并返回一个集合
var whereList = testList.where((num) => num > 2).toList();
print(whereList); // [3, 4]。如果不用toList()则返回(3, 4)

// iterable提供了any方法和every方法，来判断集合中的值是否符合条件，并返回bool
print(testList.any((num) => num > 2)); // true


// 当Map的Key没有指定类型时，Key类型不一致也不会报错。
// Map里面的key不能相同。但是value可以相同,value可以为空字符串或者为null。
// 创建Map有两种方式：通过构造器(new)和直接赋值。
// https://www.cnblogs.com/lxlx1798/p/11122881.html
