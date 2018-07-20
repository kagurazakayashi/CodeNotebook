
// iOS开发中，要想实现点击键盘上的return键隐藏键盘的效果的话，只需要以下几步。
// 我们先说UITextField return键隐藏键盘的实现，下次在说UITextView的。
// 首先，在@interface中声明要实现UITextField的delegate。

@interface MyViewController :UIViewController <UITextFieldDelegate> 
// 然后， 设置 TextField的delegate （假定叫做textField）：
textField.delegate =self; 

// 通常在viewDidLoad方法中设置此属性，也可以在nib（或storyboard）文件中设置。
// 最后，实现UITextField的textFieldShouldReturn:代理方法。

- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
   [textField resignFirstResponder]; 

   return YES; 

 } 
