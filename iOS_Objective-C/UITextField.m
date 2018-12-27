// UITextField是我们经常用的之一但是常用的属性都很熟悉，有些不常用的我也总结下，例如下面的：
        UIImageView * myView = [[ UIImageView  alloc]initWithImage:[UIImage imageNamed:@"face.png"]];
UIImageView * myView2 = [[ UIImageView  alloc]initWithImage:[UIImage imageNamed:@"face.png"]];
UITextField *myTextField=[[UITextField alloc]initWithFrame:CGRectMake(40, 40, 240, 60)]; //初始化一个UITextField的frame
myTextField.textColor=[UIColor redColor];  //UITextField 的文字颜色
myTextField.delegate=self;//UITextField 代理方法设置
myTextField.placeholder=@"输入密码";//UITextField 的初始隐藏文字，当然这个文字的字体大小颜色都可以改，重写uitextfield，下次介绍
myTextField.textAlignment=UITextAlignmentCenter;//UITextField 的文字对齐格式
myTextField.font=[UIFont fontWithName:@"Times New Roman" size:30];//UITextField 的文字大小和字体
myTextField.adjustsFontSizeToFitWidth=YES;//UITextField 的文字自适应
myTextField.clearsOnBeginEditing=NO;//UITextField 的是否出现一件清除按钮
myTextField.borderStyle=UITextBorderStyleNone;//UITextField 的边框
myTextField.background=[UIImage imageNamed:@"my.png"];//UITextField 的背景，注意只有UITextBorderStyleNone的时候改属性有效
myTextField.clearButtonMode=UITextFieldViewModeNever;//UITextField 的一件清除按钮是否出现
myTextField.leftView=myView;//UITextField 的左边view
myTextField.leftViewMode=UITextFieldViewModeAlways;//UITextField 的左边view 出现模式
myTextField.rightView=myView2;//UITextField 的有边view
myTextField.rightViewMode=UITextFieldViewModeAlways;//UITextField 的右边view 出现模式
myTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//UITextField 的字的摆设方式
[myView release];
[myView2 release];
[self.view addSubview:myTextField];

// 当然myTextField的键盘的出现也隐藏也可以设置：

// 显示keyboard:
[myTextField becomeFirstResponder];

// 隐藏keyboard
[myTextField resignFirstResponder];


// myTextField.contentVerticalAlignment的值的种类：
typedef enum {    UIControlContentVerticalAlignmentCenter  = 0,    UIControlContentVerticalAlignmentTop     = 1,    UIControlContentVerticalAlignmentBottom  = 2,    UIControlContentVerticalAlignmentFill    = 3,} UIControlContentVerticalAlignment;