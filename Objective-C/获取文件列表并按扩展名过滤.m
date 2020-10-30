
NSArray *levelList = [[[[NSFileManager alloc] init]
contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
error:nil]
pathsMatchingExtensions:[NSArray arrayWithObject:@"plist"]];

// 这里只是Documents目录的
