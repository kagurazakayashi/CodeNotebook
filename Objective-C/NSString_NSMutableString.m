// /--------操作字符串--NSString(静态字符串)---------------------
    NSString *Beijing= @"北京欢迎您";        //字符串的声明
    NSString *log=@"北京欢迎您a"; //[NSString stringWithFormat:@"I am '%@'",Beijing];     //字符串格式化
    NSString *zhui = [Beijing stringByAppendingString:@"哈哈哈"];        //字符串追加
    bool b=[Beijing isEqualToString:log];                               //字符串比较
    NSString *hh = @"http://www.sina.com.cn";
    if([hh hasPrefix:@"http"]){                                          //查找以http开头的字符串
        NSLog(@"含有http");
    }else{
        NSLog(@"没有http");
    }
    NSString *ss = @"123";
    int a = [ss intValue]+13;                                   //字符串转int型
    double dd = [ss doubleValue]+33.3;                          //字符串转double型
    NSLog(@"%g",dd);
//字符串转数组 
    NSString *zifuchuan =@"one,two,three,four";
    NSLog(@"string:%@",zifuchuan);
    NSArray *array = [zifuchuan componentsSeparatedByString:@","];
//    NSLog(@"array:%@",array);                             //输出整个数组中所有元素 
    NSString *value = [array objectAtIndex:0];          //取出第0个元素
    NSLog(@"value:%@",value);
//数组转字符串
    NSString * zifuchuan2 = [array componentsJoinedByString:@","];
    NSLog(@"zifuchuan2:%@",zifuchuan2);
       
//-substringToIndex: 从字符串的开头一直截取到指定的位置，但不包括该位置的字符
NSString *string1 = @"This is a string";
NSString *string2 = [string1 substringToIndex:3];
NSLog(@"string2:%@",string2);

//-substringFromIndex: 以指定位置开始（包括指定位置的字符），并包括之后的全部字符
NSString *string1 = @"This is a string";
NSString *string2 = [string1 substringFromIndex:3];
NSLog(@"string2:%@",string2);

//-substringWithRange: //按照所给出的位置，长度，任意地从字符串中截取子串
NSString *string1 = @"This is a string";
NSString *string2 = [string1 substringWithRange:NSMakeRange(0, 4)];
NSLog(@"string2:%@",string2);

//--------操作动态字符串--NSMutableString----------------------------------------------------
    NSMutableString *mstr = [[NSMutableString alloc] init];
    NSString *str1 = @"This is a example.";
    //创建可变字符串
    mstr = [NSMutableString stringWithString:str1];
    //插入字符
    [mstr insertString:@"very easy " atIndex:10];
    //删除一些字符
    [mstr deleteCharactersInRange:NSMakeRange(10,5)];
    //查找并删除
    NSRange substr = [mstr rangeOfString:@"example"];             //字符串查找,可以判断字符串中是否有
    if (substr.location != NSNotFound) {
        [mstr deleteCharactersInRange:substr];
    }
    //重新设置字符串
    [mstr setString:@"This is string AAA"];
    //替换字符串
    [mstr replaceCharactersInRange:NSMakeRange(15, 2) withString:@"BBB"];   //从第15个字符串处替换掉后2个字符串
   
    //查找第一个并替换
    NSString *search = @"This is";
    NSString *replace = @"An example of";
    substr = [mstr rangeOfString:search];
    if (substr.location != NSNotFound) {
        [mstr replaceCharactersInRange:substr withString:replace];      //把第1个遇到的substr替换为replace
        NSLog(@"%@",mstr);
    }
   
    //查找全部匹配的，并替换
    search = @"a";
    replace = @"X";
    substr = [mstr rangeOfString:search];
    while (substr.location != NSNotFound) {
        [mstr replaceCharactersInRange:substr withString:replace];
        substr = [mstr rangeOfString:search];
    }

    NSLog(@"%@",mstr);



// 常见的NSString方法
 +（id）stringWithContentsOfFile:path encoding:enc error:err
// 创建一个新字符串并将其设置为path指定的文件的内容，使用字符编码enc，如果非零，则返回err中的错误。
+（id）stringWithContentsOfURL:url encoding:enc error:err
// 床架一个新字符串，并将其设置为url的内容，使用字符编码enc，如果非零，则返回err中的错误。
+（id）string   //创建一个新的空字符串。
+（id）stringWithString:nsstring //创建一个新字符串，并将其设置为nsstring
-(id)initWithString:nsstring   //将新分配的字符串设置为nsstring
-（id）initWithContentsOfFile:path encoding:enc error:err
// 将字符串设置为path指定的文件的内容
-（id） initWithContentsOfURL:url encoding;enc error:err
// 将字符串设置为url(NSURL*)url的内容，使用字符编码enc,如果非零，则返回err中的错误。
-（UNSIgned int)lengtn  //返回字符串中字符数目
-（unichar) characterAtIndex:i  //返回索引i的Unicode字符
-（NSString*)substringFromIndex:i   //返回从i开始直到结尾的字符串
-（NSString*）substringToIndex:i //返回从该字符串开始位置到索引i的子字符串
 
-（NSComparator *)caseInsensitiveCompare:nsstring //比较两个字符串，忽略大小写
-（NSComparator *)compare:nsstring  //比较两个字符串
-（BOOL）hasPrefix:nsstring //测试字符串是否以nsstring开始
-（BOOL）isEqualToString:nsstring  //测试两个字符串是否相等。
-（NSString*）capitalizedString //返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
 
-（NSString *）lowercaseString //返回转换为小写的字符串
-（NSString *）uppercaseString //返回抓换为大写的字符串
-（const char *)UTF8String //返回转换为UTF8字符串的字符串
-（double) doubleValue //返回转换为NSInteger整数的字符串
-（int）intValue //返回转换为整数的字符串
// NSMutableString字符方法
+（id）stringWithCapacity:size //创建一个字符串，初始包含size的字符
-（id）initWithCapacity:size //使用初始容量为size的字符来初始化字符串
-(void)setString :nsstring //将字符串设置为nsstring
-(void) appendString:nsstring //在接受者的末尾附加nsstring
-(void)deleteCharactersInrange:range //删除指定range中的字符
-(void)insertString:nsstring atIndex:i //以索引i为起始位置插入nsstring
-(void) replaceCharactersInrange: range withString:nsstring //使用nsstring替换range指定的字符
-(void)replaceOccurrencesOf  String:nsstring withString:nsstring2 options:opts range:range
//根据选项opts，使用指定range中的nsstring2替换所有的nsstring。选项可以包括NSBackwardsSearch（从范围的结尾开始搜索），NSAn冲热点Search（nsstring必须匹配范围的开始），NSLiteralSearch