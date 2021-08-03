
// NSDate类用于保存时间值，    
NSDate* nowDate = [ NSDate date ];
// 初始化为当前时间。类似date方法 

// 获得所有地区的名称，存放在array中
NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames]; 

// 获得每个地区的 timezone信息
NSTimeZone* timename = [ [ NSTimeZone alloc] initWithName:names ];



NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
NSDate* nowDate = [ NSDate date ];
for( NSString* names  in timeZoneNames )
{
    NSTimeZone* timename = [ [ NSTimeZone alloc] initWithName:names ];
     NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init ];
    [outputFormatter setDateFormat:@"dd/MM/YYYY HH:mm:ss "];
    [outputFormatter setTimeZone:timename ];
    NSString *newDateString = [outputFormatter stringFromDate:nowDate];
     NSLog( @"/nZone: %@,%@",[ timename name ] ,newDateString );
    //[ timename name ],[ nowDate descriptionWithCalendarFormat:@"%d/%m/%y, %H:%M:%S %z" 
    //     timeZone:timename 
    //     locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]]  );
    [ outputFormatter release ];
    [ timename release ];
}


NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
[formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
[formatter setTimeZone:timeZone];
NSString *loctime = [formatter stringFromDate:date];
[formatter release];


// 现在loctime就是指定时区的时间字符串了

// 无论用户设置的是12小时制还是24小时制，如何获得24小时制的时间？
NSDateFormatter * formatter =   [[NSDateFormatter alloc] init];
[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
NSString *loctime = [formatter stringFromDate:date];
[formatter release]


// 这里要注意的是formatter的格式，如果是小写的"hh"，那么时间将会跟着系统设置变成12小时或者24小时制。大写的"HH"，则强制为24小时制。


// http://blog.csdn.net/JHorn/article/details/4602568
// http://tr4work.blog.163.com/blog/static/13714931420104292208775/
