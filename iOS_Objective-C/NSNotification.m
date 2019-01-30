// 1 手动广播者和监听者（Broadcaster and listeners）
// 2键-值观察 key Value Observing
// 3通知中心 notification center
// 4 上下文通知 context notification
// 5用于观察的weituo delegate

// 关于观察者观察者模式是维持两个模块之间抽象关系的最强大的方式之一。观察者模式包括一个发布已发生事件的模块以及响应该事件的另一模块的若干个的实例。它和直接调 用第二个模块的方法不同，因为第一个模块不需要关注有多少个观察者，从而实现观察者和被观察者之间更加完全的抽象关系。
// 手动广播者和监听者
// 手动的方式需要广播者保有一个监听者的数组（NSArray）或集合（NSSet）。在需要通知监听者一个事件的合适时机广播者直接调用各个监听者上相关方法。
// 在广播者类上你可能需要一个NSMutableArray、NSSet或NSMutableDictionary。NSMutableDictionary比较适合将事件标识符的类型作为每个监听者的键值。在广播者上你还需要有监听者注册和取消注册的方法。给NSArray或NSSet中的每个对象方式消息的方法很简单，如下：
[listenersCollection makeObjectsPerformSelector:@selector(methodSupportedByEveryListener)];
// 优点: 广播者对监听者列表有完全的控制。缺点: 在集合中手动添加或移除监听者（尤其是在由于其他原因已经不被维护的情况下）。如果需要发布不同消息的情况下就需要更多的手动工作。
// 键值观察键值观察协议时朝着自动化如上过程方向的一个很大进步。在很多情况下，广播者不需要做任何事情。每个Cocoa对象自动处理用于发布任何对象的addObserver:forKeyPath:options:context:。如果广播者的 “setter”方法遵循某些规则，“setter”方法就会自动触发任何监听者的 observeValueForKeyPath:ofObject:change:context:方法。例如如下代码就会在“source”对象上加入一个观察者：:
[source      addObserver:destination      forKeyPath:@"myValue"     options:NSKeyValueChangeNewKey      context:nil];
// 这样在每次调用setMyValue:方法的时候都会发送一个observeValueForKeyPath:ofObject:change:context:消息到destination。你所需要做的就是在被观察对象上注册监听者并让监听者实现observeValueForKeyPath:ofObject:change:context:。
// 优点: 内置的而且是自动的。可以观察任何键路径。支持依赖通知。缺点: 广播者无法知道谁在监听。方法必须符合命名规则以实现自动观察消息的运作。监听者必须在被删除之前被移除，否者接下来的通知就会导致崩溃和失效-不过这对于该文中指出的所有方法都是一样的。
// 通知中心NSNotificationCenter提供了一种更加解耦的方式。最典型的应用就是任何对象对可以发送通知到中心，同时任何对象可以监听中心的通知。发送通知的代码如下：
[[NSNotificationCenter defaultCenter]      postNotificationName:@”myNotificationName”     object:broadcasterObject];注册接收通知的代码如下：
[[NSNotificationCenter defaultCenter]      addObserver:listenerObject      selector:@selector(receivingMethodOnListener:)      name:@”myNotificationName”     object:nil];
// 注册通知的时候可以指定一个具体的广播者对象，但这不是必须的。你可能注意到了defaultCenter 。实际上这是你在应用中会使用到的唯一的中心。通知会向整个应用开放，因此只有一个中心。同时还有一个NSDistributedNotificationCenter。这是用来应用间通信的。在整个计算机上只有一个该类型的中心。优点: 通知的发送者和接受者都不需要知道对方。可以指定接收通知的具体方法。通知名可以是任何字符串。缺点: 较键值观察需要多点代码。在删掉前必须移除监听者。
// 上下文通知如果被观察属性是一个NSManagedOjbect的声明属性，就可以监听 NSManagedObjectContextObjectsDidChangeNotification。这仍然使用NSNotification方式 不过有点不同，因为NSManagedObject不会手动发送通知。这种方法的注册如下
[[NSNotificationCenter defaultCenter]      addObserver:listenerObejct      selector:@selector(receivingMethodOnListener:)      name:NSManagedObjectContextObjectsDidChangeNotification      object:observedManagedObjectContext];
// 在receivingMethodOnListener:中，通知的userinfo中NSInsertedObjectsKey、NSUpdatedObjectsKey和NSDeletedObjectsKey等键值会给出受影响的对象集合。
// 优点: 是在整个NSManagedObjectContext中跟踪变化的最简单的方式。缺点: 仅适用于Core Data并不能提供影响对象之外的具体信息。
// 用于观察的委托最后一个Cocoa简化的观察者模式是委托。广义上说委托可以不仅仅处理简单的观察，但不一定需要做更多。比如，NSApplication和NSWindow所有的通知都会同时传给委托并由其处理。有些类会传给它们的委托类似通知的消息，而不同时发送通知。比如NSMenu，发送menuWillOpen:给其委托但不会发送相应的NSNotification。为了连接一个委托，只需在支持委托的对象上调用如下代码：
[object setDelegate:delegateObject];
// 对象可以收到任何它想要的委托消息。
// 优点: 支持它的类有详尽和具体信息。
// 缺点: 该类必须支持委托。某一时间只能有一个委托连接到某一对象。