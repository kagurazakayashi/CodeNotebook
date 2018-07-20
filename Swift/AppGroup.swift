@IBAction func loadgrouptest() {
    var 组数据存储URL:NSURL? = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.WPWatch")?
    if (组数据存储URL != nil) {
        组数据存储URL = 组数据存储URL!.URLByAppendingPathComponent("Library/caches/watchpet")
        var 组数据字符串:NSString? = NSString(contentsOfURL: 组数据存储URL!, encoding: NSUTF8StringEncoding, error: nil)
        if (组数据字符串 != nil) {
            infotxt.setText(组数据字符串)
        } else {
            NSLog("组数据字符串null")
        }
    }
}


@IBAction func savegrouptest() {
    let 当前时间戳:NSNumber = NSDate().timeIntervalSince1970 as NSNumber
    let 当前时间戳字符串:NSString = "时间戳 \(当前时间戳.integerValue)"
    var 组数据存储URL:NSURL? = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.WPWatch")?
    if (组数据存储URL != nil) {
        组数据存储URL = 组数据存储URL!.URLByAppendingPathComponent("Library/caches/watchpet")
        
        当前时间戳字符串.writeToURL(组数据存储URL!, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        infotxt.setText(当前时间戳字符串)
    }
}
