#import "ViewController.h"
#import
@interface ViewController ()

@end

@implementation ViewController
@synthesize qiqiu;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.qiqiu=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50, 220, 300)];
    qiqiu.image=[UIImage imageNamed:@"气球.jpg"];//设置使用的图片
    [self.view addSubview:qiqiu];

    [qiqiu.layer setCornerRadius:30];//设置边角的弧度
//    self.qiqiu.layer.masksToBounds=YES;//设置遮掩边角
    [self.qiqiu.layer setShadowColor:[UIColor redColor].CGColor];//设置阴影
    [self.qiqiu.layer setShadowOffset:CGSizeMake(30, 20)];//设置阴影偏移
    [self.qiqiu.layer setShadowOpacity:0.05];//设置阴影透明
    
    
    NSArray *tittleArray=[NSArray arrayWithObjects:@"move",@"stranl",@"rotate",@"scale",@"invert",@"cuilUp",@"flip",@"opacity",@"expend",@"flay",@"lianxu", nil];//设置UIButton按钮的名称数组
    
    for (int i=0; i<11; i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:[tittleArray objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag=i+1;
        if (btn.tag>7) {
            btn.frame=CGRectMake(15+80*(i-7), 415, 60, 40);
        }
        else {
            btn.frame=CGRectMake(255, 20+i*60, 60, 40);
        }
        //在编译时设置变量为SEL变量最有效的方法就是@selector()指令。然而，在某些情况下，你可能需要在运行时转换一个字符串为一个selector。
        SEL sl=NSSelectorFromString([tittleArray objectAtIndex:i]);
        //给button按钮添加事件
        [btn addTarget:self action:sl forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];

    }
}
//该方法实现小图片在大图片（气球）上移动的效果
-(void)move
{
    NSLog(@"移动动画");
    UIImageView *bird=[[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
    bird.image=[UIImage imageNamed:@"鸟.png"];//
    [self.qiqiu addSubview:bird];//将小鸟图片添加到气球视图上
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];//设置动画时长
    CGPoint ct=bird.center;//取出小鸟图片的中心
    CGPoint end=CGPointMake(ct.x+150, ct.y+50);//改变图片的坐标
    bird.center=end;
    [UIView commitAnimations];//设置动画开始
//    bird.center=ct;
}
//该方法实现图片的位移（以移动中心实现）
-(void)stranl
{
    NSLog(@"动画偏移");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];//设置动画时长
    CGPoint ct=self.view.center;
    CGPoint end=CGPointMake(ct.x, ct.y+20);
    self.qiqiu.center=end;
    [UIView commitAnimations];
}
//该动画实现旋转90度（M_PI_2是个宏），代码中注释掉的代码不能实现连续旋转效果
-(void)rotate
{
    NSLog(@"动画旋转");
    [UIView beginAnimations:nil context:nil];
//    self.qiqiu.transform=CGAffineTransformMakeRotation(M_PI_2);//旋转90度
    self.qiqiu.transform=CGAffineTransformRotate(self.qiqiu.transform, M_PI_2);//与上面不同的是后者可以连续旋转，一般make。。。都是执行一次的方法
    [UIView setAnimationDuration:1];//设置动画时长
    [UIView commitAnimations];
}
-(void)scale
{
    NSLog(@"动画缩放");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];//设置动画时长
    self.qiqiu.transform=CGAffineTransformScale(self.qiqiu.transform, 0.9, 0.9);
    [UIView commitAnimations];
}
-(void)invert
{
    NSLog(@"动画反转");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];//设置动画时长
    [UIView setAnimationDelay:1];//设置动画动作的延迟
    self.qiqiu.transform=CGAffineTransformInvert(self.qiqiu.transform);
    [UIView commitAnimations];
}
-(void)cuilUp
{
    NSLog(@"动画翻页");
    [UIView beginAnimations:@"am01" context:nil];
    
    [UIView setAnimationDuration:3];//设置动画时长
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//指定动画曲线类型，该枚举是默认的，线性的是匀速的
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:qiqiu cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished: context:)];//这个方法名不是随意写的
    [UIView commitAnimations];
    
}

//这是针对UIView动画的代理方法
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
//    if (finished) {
//        [self flay];
//    }
    if (finished&&[animationID isEqualToString:@"am01"]) {
        [self flay];
    }
}

-(void)flip
{
    NSLog(@"动画块旋转");
    [UIView beginAnimations:nil context:nil];//标志着动画块的开始，前者是动画名称，后者是联系上下文
    [UIView setAnimationDuration:3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//设置动画曲线
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:qiqiu cache:YES];
    [UIView commitAnimations];
}
-(void)opacity
{
    NSLog(@"动画的不透明度");
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];//创建动画对象;opacity是补课代替的，客服
    [animation setFromValue:[NSNumber numberWithFloat:1.0]];//将OC中的的c数据转换成oc数据进行包装；设置动画的起始值
    [animation setToValue:[NSNumber numberWithFloat:0.0]];//设置动画的结束值
    [animation setDuration:3.0];//设置动画时长
    [animation setRepeatCount:1.0];//设置动画重复
    [animation setDelegate:self];//设置代理
    [animation setAutoreverses:YES];//默认的是NO，即透明完毕后立马恢复，YES是延迟恢复
    [qiqiu.layer  addAnimation:animation forKey:@"img-opacity"];//img-opacity是随意起的的名字
}
-(void)expend
{
    NSLog(@"%s",__FUNCTION__);
    CABasicAnimation *animation=[CABasicAnimation  animationWithKeyPath:@"bounds.size"];
    [animation setFromValue:[NSValue valueWithCGSize:CGSizeMake(1.0, qiqiu.bounds.size.width)]];
    [animation setToValue:[NSValue  valueWithCGSize:qiqiu.bounds.size]];
    [animation  setDuration:1.2];
    [animation setDelegate:self];
    [qiqiu.layer  addAnimation:animation forKey:@"image-bounds.size"];
}

//这是CA动画代理的方法
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self flip];
}

-(void)flay
{
    NSLog(@"动画移动");
//    CATransition
    CAKeyframeAnimation  *animation=[CAKeyframeAnimation  animationWithKeyPath:@"position"];
    NSArray *values=[NSArray arrayWithObjects:
                     [NSValue valueWithCGPoint:CGPointMake(100, 50)],
                     [NSValue valueWithCGPoint:CGPointMake(40, 110)],
                     [NSValue valueWithCGPoint:CGPointMake(30, 90)],
                     [NSValue valueWithCGPoint:CGPointMake(20, 70)],
                     [NSValue valueWithCGPoint:CGPointMake(0, 130)],
                     nil];//设置关键帧的位置
    [animation setValues:values];
    
    NSArray *times = [NSArray arrayWithObjects:
                      [NSNumber numberWithFloat:0.3],
                      [NSNumber numberWithFloat:0.5],
                      [NSNumber numberWithFloat:0.6],
                      [NSNumber numberWithFloat:0.7],
                      [NSNumber numberWithFloat:1.0],
                      nil];//从第一点到第二点0.3秒、0.5、0.6是个加值
    [animation setKeyTimes:times];
    [animation setDuration:5.0];//动画时长
    [animation setDelegate:self];
    [qiqiu.layer  addAnimation:animation forKey:@"img-position"];
    
    [UIView commitAnimations];
}
//动画块的应用
-(void)lianxu
{
    [UIView animateWithDuration:2 animations:
     ^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:qiqiu cache:YES];
    } completion:^(BOOL finished)
    {
        NSLog(@"翻页动画结束");
        [UIView animateWithDuration:2 animations:
         ^{
            self.qiqiu.transform=CGAffineTransformInvert(self.qiqiu.transform);
        } completion:^(BOOL finished)
         {
            NSLog(@"反转动画结束");
            [UIView animateWithDuration:2 animations:
             ^{
                qiqiu.alpha=0;
            } completion:^(BOOL finished) {
                qiqiu.alpha=1;
            }];
        }];
    }];
}
@end
