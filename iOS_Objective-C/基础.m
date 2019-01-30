/*
类：同属性同特征 对象：具体实现
访问修饰符： @protected（受保护的） @public（公共的） @private（私有的）
访问控制：readwrite属性可读写 readonly只读只会生成访问器
线程安全：nonatomic 非原子性，不保证多线程安全
atomic 原子性，多线程访问时较安全
内存管理：copy副本，assign默认值直接赋值 retain 关心内存管理（带＊的对象类型）
面向对象的特点 封装 继承 多态 使用简单 变量安全 隐藏细节 开发速度
isMemberOfClass:精确判断对象是不是指定类型
isKindOfClass
多态好处：可以简化编程接口：
允许在多个类中定义同一消息接口、可以定义一个通用的调用方法，以简化调用
代理是协议的一种具体应用  

MVC
Modal 模型层/数据层 数据库中几张表就有几个模型 每个模型一个类
View 视图层 如table View
Controller 控制层
每一个类都是一个模型

 KVC是一种可以直接通过字符串的名字(key)来访问类属性的机制。
 当使用KVO时，KVC是关键技术。
 valueForKey:，传入NSString属性的名字。setValue:forKey:
 */
 NSString *_name; NSInteger NSUInteger _age; -(void)sayHi; #import
 Student *stu1 = [[Student alloc] init];  [stu1 sayHi];
 -(void)setName:(NSString *)newName //设置器  _name = newName;
 -(NSString *)name { return _name; } //访问器  return _name;
 [stu setName:@"zhangsan"]; [stu setAge:18];
 NSLog(@"%@,%d",[stu name],[stu age]);
 NSString *yearStr = [newIdCard substringWithRange:NSMakeRange(6, 4)];
 int yAge = 2012 - [yearStr intValue]; [sexStr intValue]%2==0 //奇偶
 @property (nonatomic, retain) NSString *name;
@property (nonatomic, readonly, assign) int age;
 @synthesize name = _name, age = _age, idCard = _idCard;
 - (void)setIdCard:(NSString *)idCard ;; stu.name = @"wuyu";
 + (id)studentWithName:(NSString *)newName Age:(int)newAge;
 - (id)initWithName:(NSString *)newName Age:(int)newAge
    self = [super init];  if (self) {self.name = newName;  self.age = newAge; self.idCard = newIdCard; } return self;
 Singleton *si = [Singleton instance]; //单例模式
 if (_idCard!=idCard) {[_idCard release]; _idCard=[idCard retain];}
 + (id)personWithName:(NSString *)newName IdCard:(NSString *)newIdCard Hobby:(NSString *)newHobby{ Person *person = [[Person alloc] initWithName:newName IdCard:newIdCard Hobby:newHobby]; return person; }
 Cat *cat = [[Cat alloc] initWithName:@"Cat-N-A" Variety:@"Cat-V-A"];
 //是不是另一个类的子类 
//  判断类实现了某个协议:
 BOOL result = [network conformsToProtocol:@protocol(NSURLConnectionDelegate)];
 + [stu autorelease]; return stu;
 NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
 [pool release]; [pool2 drain];
 //调用KVC赋值 [self setValue:newName forKey:@"name"];
 [self setValue:[NSNumber numberWithInt:newAge] forKey:@"age"];
 //添加KVO监听 [self addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
 //实现监听 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//  keyPath要监听到变量, object, change, context穿入值, __FUNCTION__

/*
类 → 创建、1对N → 对象
↓　　　　　　　　　　↓
+类方法 ←　方法　→ -实例方法 → 带参、不带参、有返回值、无返回值
　　↓　　　　↘初始化　　　　单例→static
便利构造器(+方法)
成员 ↗ KVC
变量 ↘ 设置器、访问器 → 属 ↗ KVO → 创建-实现-移除
　　　　　　　　　　　　 性 ↘ retain(*)、assign(数字)
类 （：唯一父类）<协议1,2>
　↘类目、延展(.m)、协议 → @protocol ↗ @requird  → 必须
　　　　　　　　　　 ↓    ↘ @end　　 ↘ @optional → 可选
　　　　　　　　　　代理
( . )语法 [对象 方法名];
有创建 → 有释放
　↗retainCount (NO: "0")
autorelease-NSautorealsepool
通知：注册；创建、发送；接收、移除。 NSNotitication，NSNotiticationCenter
NSString　　　↘
NSArray　　　 → （可变）增、删、改、查
NSDictionary　↗
NSFileManager → 创建、删除、移动、复制
NSData　 ↗同步 1《2》3：GET、POST
　　  网络→异步 12《3》：代理
 Json，XML  → 解析 → NSDictinary（常用，key-value）、NSArray
fans(Array→cont知道循环次数) = ( { name=""; sex=""; }, { name=""; sex=""; }…
*/