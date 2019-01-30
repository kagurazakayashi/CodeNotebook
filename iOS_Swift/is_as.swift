is 常用于对某变量类型的判断，就像ＯＣ中 isKindClass ，as 就有点像强制类型转换的意思了。
        for view : AnyObject in self.view.subviews
        {
            if view is UIButton
            {
                let btn = view as UIButton;
                println(btn)
            }
        }
OC的写法：
for (UIView *view  in self.view.subviews)
{
      if ([view isKindOfClass:[UIButton class]])         //is 操作
     {
             UIButton *btn =(UIButton *)view             //as 操作
      }
}
