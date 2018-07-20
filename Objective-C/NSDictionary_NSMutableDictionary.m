// dictionary是由键-对象组成的数据集合。正如在词典中查找单词的定义一样，可通过对象的键从objective-c词典中获取所需的值。
// 词典中的键必须是单值的，尽管它们通常是字符串，但还可以是任何对象类型。和键关联的值可以是任何对象类型，但它们不能为nil。

#import <Foundation/NSDictionary.h>  
#import <Foundation/NSObject.h>  
#import <Foundation/NSString.h>  
#import <Foundation/NSAutoreleasePool.h>  
  
int main(int argc, const char *argv[])  
{  
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  
  
  
  
    //immutable dictionary  
    NSDictionary *tires = [NSDictionary  dictionaryWithObjectsAndKeys :  
                            @"front-left",@"t1" , @"front-right",@"t2" ,  
                            @"back-left",@"t3" , @"back-right",@"t4" ,nil];  
  
    //display immutable dictionary  
    NSLog(@"t1: %@",[tires objectForKey: @"t1"]);  
    NSLog(@"t2: %@",[tires objectForKey: @"t2"]);  
    NSLog(@"t3: %@",[tires objectForKey: @"t3"]);  
    NSLog(@"t4: %@",[tires objectForKey: @"t4"]);  
  
    //mutable dictionary  
    NSMutableDictionary *glossary = [NSMutableDictionary dictionary];  
  
    //Store three entries in the glossary  
    //use setObject:forKey: method to set key/value  
    [glossary setObject: @"A class defined so other classes can inherit from it"  
                 forKey: @"abstract class"];  
    [glossary setObject: @"To implment all the methods defined in a protocol"  
                 forKey: @"adopt"];  
    [glossary setObject: @"Storing an object for later use"  
                 forKey: @"archiving"];  
  
    //Retrieve and display them  
    //use objectForKey:key method to retrieve the value  
    NSLog(@"abstract class: %@",[glossary objectForKey: @"abstract class"]);  
    NSLog(@"adopt: %@",[glossary objectForKey: @"adopt"]);  
    NSLog(@"archiving: %@",[glossary objectForKey: @"archiving"]);  
  
    [pool drain];  
    return 0;  
  
}  
// NSDictionary 常用方法总结
+(id)dictionaryWithObjectsAndKeys:obj1,key1,obj2,key2,......nil //顺序添加对象和键值来创建一个字典，注意结尾是nil
-(id)initWithObjectsAndKeys::obj1,key1,obj2,key2,......nil //初始化一个新分配的字典，顺序添加对象和值，结尾是nil
-(unsigned int)count //返回字典中的记录数
-(NSEnumerator*)keyNSEnumerator //返回字典中的所有键到一个 NSEnumerator 对象
-(NSArray*)keysSortedByValueUsingSelector:(SEL)selector //将字典中所有键按照selector 指定的方法进行排序，并将结果返回
-(NSEnumerator*)objectEnumerator //返回字典中所有的值到一个 NSEnumetator 类型对象
-(id)objectForKey:key //返回指定key 值的对象


// NSMutableDictionary 常用方法总结
+(id)dictionaryWithCapacity:size //创建一个size大小的可变字典
-(id)initWithCapacity:size //初始化一个size 大小的可变字典
-(void)removeAllObjects //删除字典中所有元素
-(void)removeObjectForKey:key //删除字典中key位置的元素

-(void)setObject:obj forKey:key //添加 (key , obj)到字典中去；若key已经存在，则替换值为 obj

// 常用的NSDictionary方法：
+(id) dictionaryWithObjectsAndKeys:
// 使用键-对象{key1,obj1}、{key2,obj2}...创建词典obj1,key1,obj2,key2,...,nil;
-(id) initWithObjectsAndKeys:
// 将新分配的词典初始化为键-对象对{key1,obj1}{key2,obj2}...创建词典obj1,key1,obj2,key2...,nil;
-(unsigned int) count
// 返回词典中的记录数
-(NSEnumerator *) keyEnumerator
// 为词典中所有键返回一个NSEnumerator对象
-(NSArray *) keysSortedByVlaueUsingSelector:
// 返回词典中的键数组，它根据selector 指定的比较方法进行了排序(SEL) selector
-(id) objectForKey:key
// 返回指定key的对象

// 常用的NSMutableDictionary方法：
+(id) dictionaryWithCapacity:size
// 使用一个初始指定的size创建可变词典
-(id) initWithCapacity:size
// 将新分配的词典初始化为指定的size
-(void) removeAllObjects
// 删除词典中所有的记录
-(void) removeObjectForKey:key
// 删除词曲中指定key对应的记录
-(void) setObject: obj forKey: key
// 向词典为key 键添加obj,如果key已存丰，则替换该值

// 目前最细致清晰的NSDictionary以及NSMutableDictionary用法总结
// 做过Java语言 或者 C语言 开发的朋友应该很清楚 关键字map 吧，它可以将数据以键值对儿的形式储存起来，取值的时候通过KEY就可以直接拿到对应的值，非常方便。在Objective-C语言中 词典对象就是做这个事情的，不过在同一个词典对象中可以保存多个不同类型的数据，不像Java与C 只能保存声明的相同类型的数据，它的关键字为NSDictionary与NSMutableDictionary。阅读过我之前文章的朋友应该从关键字的 结构就可以看出这两个的区别。很明显前者为不可变词典，或者为可变词典。
NSDictionary *dict;
for(NSString * akey in dict)
{
　　//........
}
// 很好用
// 1.创建不可变词典
[NSDictionary dictionaryWithObjectsAndKeys:..];
//  : 使用键值对儿直接创建词典对象，结尾必需使用nil标志结束。
[NSDictionary initWithObjectsAndKeys:..];
//  :使用键值对儿初始化词典对象，结尾必需使用nil标志结束。
[dictionary count];
// : 得到词典的长度单位。
[dictionary keyEnumerator];
// : 将词典的所有KEY储存在NSEnumerator中，NSEnumerator很像Java语言 中的迭代器，使用快速枚举可以遍历词典中所有储存KEY值。
[dictionary  objectEnumerator];
// : 将词典的所有value储存在NSEnumerator中,用法和上面差不多可用来遍历KEY对应储存的Value值。
[dictionary objectForKey:key];
// : 通过传入KEY对象可以拿到当前KEY对应储存的值。
 
#import <UIKit/UIKit.h>
#import "MyClass.h"
int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
    //添加我们的测试代码
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"雨松MOMO",@"name",@"15810463139",@"number", nil];
    
    //得到词典的数量
    int count = [dictionary count];
    NSLog(@"词典的数量为： %d",count);
    
    //得到词典中所有KEY值
    NSEnumerator * enumeratorKey = [dictionary keyEnumerator];
    
    //快速枚举遍历所有KEY的值
    for (NSObject *object in enumeratorKey) {
        NSLog(@"遍历KEY的值: %@",object);
    }
    
    //得到词典中所有Value值
     NSEnumerator * enumeratorValue = [dictionary objectEnumerator];
    
    //快速枚举遍历所有Value的值
    for (NSObject *object in enumeratorValue) {
        NSLog(@"遍历Value的值: %@",object);
    }
    
    //通过KEY找到value
    NSObject *object = [dictionary objectForKey:@"name"];
    
    if (object != nil) {
        NSLog(@"通过KEY找到的value是: %@",object);
    }
    
    
    
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}

 
 
 
// 2.创建可变词典对象
NSMutableDictionary; //是NSDictionary的子类，所以继承了NSDictionary的方法。
[NSMutableDictionary dictionaryWithCapacity:10];
//  : 创建一个可变词典初始指定它的长度为10.，动态的添加数据如果超过10这个词典长度会自动增加，所以不用担心数组越界。推荐用这种方式
[NSMutableDictionary initWithCapacity:10];
// :只是初始化一个词典的长度为10。
[dictionary setObject:@"雨松MOMO" forKey:@"name"];
// :向可变的词典动态的添加数据 ，这里的key是name ，值是雨松MOMO。如果词典中存在这个KEY的数据则直接替换这个KEY的值。（易混的地方，慎重！）
[dictionary removeAllObjects..]; //: 删除掉词典中的所有数据。
[dictionary removeObjectForKey..]; //:删除掉词典中指定KEY的数据 。
 
#import <UIKit/UIKit.h>
#import "MyClass.h"
int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
    //添加我们的测试代码
    
    //创建词典对象，初始化长度为10
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
   
    //向词典中动态添加数据
    [dictionary setObject:@"雨松MOMO" forKey:@"name"];
    
    [dictionary setObject:@"15810463139" forKey:@"number"];
    
    
    //通过KEY找到value
    NSObject *object = [dictionary objectForKey:@"name"];
    
    if (object != nil) {
        NSLog(@"通过KEY找到的value是: %@",object);
    }
    
    
    
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
 
// 词典类的存在就是为了解决在大量数据中查找方便，因为它是通过key直接找到value所以速度很快，避免一个个的遍历寻找造成的效率低下，善用字典类会帮你的程序提速。