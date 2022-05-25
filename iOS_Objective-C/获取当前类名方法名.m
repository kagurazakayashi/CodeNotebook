// OC 中获取类名
NSLog(@"class name: %@",NSStringFromClass([self class]));

// OC 中获取方法名
// _cmd 在 Objective-C 的方法中表示当前方法的 selector
NSLog(@"Current method: %@",NSStringFromSelector(_cmd));

// 合并
NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));