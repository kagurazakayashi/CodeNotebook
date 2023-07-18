// 字符串是否包含某个字符串
NSString *Str = @"aaa";
if ([Str containsString:"bbb"]) {
    NSLog(@"包含");
} else {
    NSLog(@"不包含");
}

// 2
if ([Str rangeOfString:@"bbb"].location == NSNotFound) {
    NSLog(@"不包含");
} else {
    NSLog(@"包含");
}

// 开头是否包含
if([Str hasPrefix:@"Hello"]){
    NSLog(@"包含");
}else {
    NSLog(@"不包含");
}

// 尾部是否包含
if([Str hasSuffix:@"bbb"){
    NSLog(@"包含");
}else{
    NSLog(@"不包含");
}
