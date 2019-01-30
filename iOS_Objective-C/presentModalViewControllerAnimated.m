//presentModalViewControllerAnimated
//dismissModalViewControllerAnimated

// 使用presentModalViewControllerAnimated方法从A->B->C，若想在C中直接返回A，则可这样实现：
// C中返回事件：

void back  
{  
      [self dismissModalViewControllerAnimated:NO];//注意一定是NO！！  
      [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil];
}

// 然后在B中，
//在viewdidload中：

[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"backback" object:nil];

-(void)back  
{  
    [self dismissModalViewControllerAnimated:YES];  
}