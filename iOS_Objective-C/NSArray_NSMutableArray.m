        //NSArray 初始化
        NSArray *arr1 = [NSArray arrayWithObject:@"a" @"b" @"c"];
        //NSArray *arr1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", nil];
        NSLog(@"arr1: %@", arr1);
        
        //效率差
        for (int i=0; i<[arr1 count]; i++) {
            NSLog(@"arr1 index: %d, obj: %@", i, [arr1 objectAtIndex:i]);
        }
        
        //效率高(快速枚举)-官方推荐用
        for (NSObject *obj1 in arr1) {
            NSLog(@"arr1 index: %ld, obj: %@", [arr1 indexOfObject:obj1], obj1);
        }
        
        //NSMutableArray 初始化   arrayWithCapacity(初始化可变数组对象的长度, 后续添加数组会自动扩展)
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:2];  //NSMutableArray *arr2 = [[NSMutableArray alloc] initWithObjects:@"a", @"b", "c", nil];
        
        //NSMutableArray 添加对象, addObject
        [arr2 addObject:@"1"];
        [arr2 addObject:@"2"];
        [arr2 addObject:@"3"];
        [arr2 addObject:@"4"];
        NSLog(@"arr2: %@", arr2);
        
        //NSMutableArray插入对象, insertObjects:<#(NSArray *)#> atIndexes:<#(NSIndexSet *)#>], insertObjects:<#(NSArray *)#> atIndexes:<#(NSIndexSet *)#>
        id iObj = @"I am a new one";
        [arr2 insertObject:iObj atIndex:2];
        NSLog(@"arr2: %@", arr2);
        
        //NSMutableArray 删除对象,
        [arr2 removeObject:iObj];
        NSLog(@"arr2: %@", arr2);
        
        //NSMutableArray 其他删除方法
        //[arr2 removeObjectAtIndex:<#(NSUInteger)#>]
        //[arr2 removeObjectsAtIndexes:<#(NSIndexSet *)#>]
        //[arr2 removeObjectsInArray:<#(NSArray *)#>]
        //[arr2 removeObjectIdenticalTo:<#(id)#>]
        //[arr2 removeObjectIdenticalTo:<#(id)#> inRange:<#(NSRange)#>]
        
        //NSMutableArray 替换
        [arr2 replaceObjectAtIndex:1 withObject:@"rep one"];
        NSLog(@"arr2: %@", arr2);



// 枚举类型NSEnumerator
        NSArray * a1 = [NSArray arrayWithObjects:@"green", @"red", @"blue", nil];
        NSEnumerator *e1 = [a1 objectEnumerator];
        id obj1;
        while (obj1 = [e1 nextObject]) {
            NSLog(@"object: %@", obj1);
        }





// 1、创建数组
NSArray *array = [[NSArray alloc] initWithObjects:@"One",@"Two",@"Three",@"Four",nil];

 
// 2、数组所包含对象个数
[self.dataArray count]

 
 
// 3、获取指定索引处的对象
[self.dataArray objectAtIndex:2]

 
// 4、从一个数组拷贝数据到另一数组(可变数级)

    //arrayWithArray:
    //NSArray *array1 = [[NSArray alloc] init];
    NSMutableArray *MutableArray = [[NSMutableArray alloc] init];
    NSArray *array = [NSArray arrayWithObjects:
                      @"a",@"b",@"c",nil];
    NSLog(@"array:%@",array);
    MutableArray = [NSMutableArray arrayWithArray:array];
    NSLog(@"MutableArray:%@",MutableArray);

    array1 = [NSArray arrayWithArray:array];
    NSLog(@"array1:%@",array1);


 
// 5、COPY

    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSArray *oldArray = [NSArray arrayWithObjects:
                         @"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",nil];

    NSLog(@"oldArray:%@",oldArray);
    for(int i = 0; i < [oldArray count]; i++)
    {        
        obj = [[oldArray objectAtIndex:i] copy];
        [newArray addObject: obj];
    }
    //
    NSLog(@"newArray:%@", newArray);
    [newArray release];



// 6、深COPY

    //NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSArray *oldArray = [NSArray arrayWithObjects:
                         @"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",nil];    
    NSLog(@"oldArray:%@",oldArray);    
    newArray = (NSMutableArray*)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFPropertyListRef)oldArray, kCFPropertyListMutableContainers);
    NSLog(@"newArray:%@", newArray);
    [newArray release];    



// 7、快速枚举

//NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSArray *oldArray = [NSArray arrayWithObjects:
                         @"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",nil];    
    NSLog(@"oldArray:%@",oldArray);

    for(id obj in oldArray)
    {
        [newArray addObject: obj];
    }
    //
    NSLog(@"newArray:%@", newArray);
    [newArray release];  



// 8、切分数组
NSString *string = [[NSString alloc] initWithString:@"One,Two,Three,Four"];
NSLog(@"string:%@",string);    
NSArray *array = [string componentsSeparatedByString:@","];
NSLog(@"array:%@",array);
[string release];

 
// 9、从数组合并元素到字符串
    NSArray *array = [[NSArray alloc] initWithObjects:@"One",@"Two",@"Three",@"Four",nil];
    NSString *string = [array componentsJoinedByString:@","];
    NSLog(@"string:%@",string);

 
// 10、 给数组分配容量
 array = [NSMutableArray arrayWithCapacity:20];

 
// 11、 在数组末尾添加对象
NSMutableArray *array = [NSMutableArray arrayWithObjects:@"One",@"Two",@"Three",nil];
[array addObject:@"Four"];
NSLog(@"array:%@",array);


// 12、删除数组中指定索引处对象
NSMutableArray *array = [NSMutableArray arrayWithObjects:@"One",@"Two",@"Three",nil];
[array removeObjectAtIndex:1];
 NSLog(@"array:%@",array);





// http://www.cnblogs.com/shuaixf/archive/2012/03/01/2376272.html