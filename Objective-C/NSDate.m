
// 当前时间创建NSDate
        NSDate *myDate = [NSDate date];
        NSLog(@"myDate = %@",myDate);
//从现在开始的24小时
        NSTimeInterval secondsPerDay = 24*60*60;
        NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSLog(@"myDate = %@",tomorrow);
//根据已有日期创建日期
        NSTimeInterval secondsPerDay1 = 24*60*60;
        NSDate *now = [NSDate date];
        NSDate *yesterDay = [now addTimeInterval:-secondsPerDay1];
        NSLog(@"yesterDay = %@",yesterDay);
 
//比较日期
        BOOL sameDate = [now isEqualToDate:yesterDay];
        NSLog(@"sameDate = %lu",sameDate);
        //获取较早的日期
        NSDate *earlierDate = [yesterDay earlierDate:now];
        NSLog(@"earlierDate  = %@",earlierDate);
        //较晚的日期
        NSDate *laterDate = [yesterDay laterDate:now];
        NSLog(@"laterDate  = %@",laterDate);
 
        //两个日期之间相隔多少秒
        NSTimeInterval secondsBetweenDates= [yesterDay timeIntervalSinceDate:now];
        NSLog(@"secondsBetweenDates=  %lf",secondsBetweenDates);
        //通过NSCALENDAR类来创建日期
        NSDateComponents *comp = [[NSDateComponentsalloc]init];
        [comp setMonth:06];
        [comp setDay:01];
        [comp setYear:2001];
        NSCalendar *myCal = [[NSCalendaralloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *myDate1 = [myCal dateFromComponents:comp];
        NSLog(@"myDate1 = %@",myDate1);
 
        //从已有日期获取日期
        unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit;
        NSDateComponents *comp1 = [myCal components:units fromDate:now];
        NSInteger month = [comp1 month];
        NSInteger year = [comp1 year];
        NSInteger day = [comp1 day];
        //NSDateFormatter实现日期的输出
        NSDateFormatter *formatter = [[NSDateFormatteralloc]init];
        [formatter setDateStyle:NSDateFormatterFullStyle];//直接输出的话是机器码
        //或者是手动设置样式[formatter setDateFormat:@"yyyy-mm-dd"];
        NSString *string = [formatter stringFromDate:now];
        NSLog(@"string = %@",string);
        NSLog(@"formater = %@",formatter);
 
 
//获取日期格式对象
- (NSDateFormatter *)dateFormatter {
if (dateFormatter == nil) {
dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
}
return dateFormatter;
}
