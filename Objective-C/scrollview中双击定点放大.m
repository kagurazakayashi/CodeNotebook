//  双击放大是 iPhone 的一个基本操作，第三方程序里引入这一功能的话，主要是在 scrollview 呈现一张图片或者 PDF 页面时，双击可以放大，主要代码如下

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"%s", _cmd);
    
    CGFloat zs = scrollView.zoomScale;
    zs = MAX(zs, 0.1);
    zs = MIN(zs, 5.0);    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];        
    scrollView.zoomScale = zs;    
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark === UITouch Delegate ===
#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%s", _cmd);
    
    UITouch *touch = [touches anyObject];
    
    if ([touch tapCount] == 2) 
    {
        //NSLog(@"double click");
        
        CGFloat zs = self.zoomScale;
        zs = (zs == 1.0) ? 2.0 : 1.0;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];            
        self.zoomScale = zs;    
        [UIView commitAnimations];
    }
}
