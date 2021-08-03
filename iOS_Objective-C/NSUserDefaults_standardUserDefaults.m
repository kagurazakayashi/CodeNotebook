/*
NSUserDefaults standardUserDefaults的使用
本地存储数据简单的说有三种方式：数据库、NSUserDefaults和文件。
NSUserDefaults用于存储数据量小的数据，例如用户配置。并不是所有的东西都能往里放的，只支持：NSString,NSNumber, NSDate, NSArray, NSDictionary，详细方法可以查看类文件。
NSUserDefaultsstandardUserDefaults用来记录一下永久保留的数据非常方便，不需要读写文件，而是保留到一个NSDictionary字典里，由系统保存到文件里，系统会保存到该应用下的/Library/Preferences/gongcheng.plist文件中。需要注意的是如果程序意外退出，NSUserDefaultsstandardUserDefaults数据不会被系统写入到该文件，不过可以使用［[NSUserDefaultsstandardUserDefaults] synchronize］命令直接同步到文件里，来避免数据的丢失。
*/
// 一、将数据存储到NSUserDefaults：
//UISwitch
- (IBAction)switchChanged:(id)sender{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:_theSwitch.on forKey:@"switchValue"];
}
 
//UITextField
- (IBAction)inputChanged:(id)sender{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_textField.text forKey:@"inputValue"];
}
 
// 二、读取NSUserDefaults中的数据：
UISwitchNSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];BOOL sw = [userDefaults boolForKey:@"switchValue"];[_theSwitch setOn:sw];
UITextFieldNSString *str = [userDefaults stringForKey:@"inputValue"];[_textField setText:str];
/*
registerDefaults:方法是注册偏好设置的子集，它是不写入到plist文件中的，但在ND中取确实能取到。
也就是说plist文件中看到的数据是你显示的设置进去的。
比如调用setxxx方法
*/