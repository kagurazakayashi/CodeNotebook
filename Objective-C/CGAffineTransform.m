
// CoreGraphics.h
CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI_2);
[xxx setTransform:rotation];
// 呵呵就这么简单的两行代码就可以实现了！
// 顺便记录一些常量，以后用的着！
#define M_E         2.71828182845904523536028747135266250   e#define M_LOG2E     1.44269504088896340735992468100189214   log 2e#define M_LOG10E    0.434294481903251827651128918916605082  log 10e#define M_LN2       0.693147180559945309417232121458176568  log e2#define M_LN10      2.30258509299404568401799145468436421   log e10#define M_PI        3.14159265358979323846264338327950288   pi#define M_PI_2      1.57079632679489661923132169163975144   pi/2#define M_PI_4      0.785398163397448309615660845819875721  pi/4#define M_1_PI      0.318309886183790671537767526745028724  1/pi#define M_2_PI      0.636619772367581343075535053490057448  2/pi#define M_2_SQRTPI  1.12837916709551257389615890312154517   2/sqrt(pi)#define M_SQRT2     1.41421356237309504880168872420969808   sqrt(2)#define M_SQRT1_2   0.707106781186547524400844362104849039  1/sqrt(2)
 
 
// from:http://donbe.blog.163.com/blog/static/138048021201061054243442/

CGAffineTransformMakeTranslation(width, 0.0);//是改变位置的，
CGAffineTransformRotate(transform, M_PI);//是旋转的。
CGAffineTransformMakeRotation(-M_PI);//也是旋转的
transform = CGAffineTransformScale(transform, -1.0, 1.0);//是缩放的。
view.transform = CGAffineTransformIdentity;//线性代数里面讲的矩阵变换，这个是恒等变换当 你改变过一个view.transform属性或者view.layer.transform的时候需要恢复默认状态的话，记得先把他们重置可以使用
view.transform = CGAffineTransformIdentity;
//或者
view.layer.transform = CATransform3DIdentity;
//假设你一直不断的改变一个view.transform的属性，而每次改变之前没有重置的话，你会发现后来 的改变和你想要的发生变化了，不是你真正想要的结果
// Quartz转换实现的原理:Quartz把绘图分成两个部分，
//     用户空间，即和设备无关，
//     设备空间，
// 用户空间和设备空间中间存在一个转换矩阵 ： CTM
// 本章实质是讲解CTM
 
// Quartz提供的3大功能
// 移动，旋转，缩放
 
// 演示如下，首先加载一张图片
void CGContextDrawImage (
   CGContextRef c,
   CGRect rect,
   CGImageRef image
);
 
 
 
 
 
// 移动函数
CGContextTranslateCTM (myContext, 100, 50);
 
 
 
// 旋转函数
include <math.h>
static inline double radians (double degrees) {return degrees * M_PI/180;}
CGContextRotateCTM (myContext, radians(–45.));
 
 
 
// 缩放
CGContextScaleCTM (myContext, .5, .75);
 
 
 
// 翻转， 两种转换合成后的效果，先把图片移动到右上角，然后旋转180度
CGContextTranslateCTM (myContext, w,h);
CGContextRotateCTM (myContext, radians(-180.));
 
 
 
// 组合几个动作
CGContextTranslateCTM (myContext, w/4, 0);
CGContextScaleCTM (myContext, .25,  .5);
CGContextRotateCTM (myContext, radians ( 22.));
 
 
 
 
 
CGContextRotateCTM (myContext, radians ( 22.));
CGContextScaleCTM (myContext, .25,  .5);
CGContextTranslateCTM (myContext, w/4, 0);
 
 
 
 
// 上面是通过直接修改当前的ctm实现3大效果，下面是通过创建Affine Transforms，然后连接ctm实现同样的3种效果
// 这样做的好处是可以重用这个Affine Transforms
// 应用Affine Transforms 到ctm的函数
void CGContextConcatCTM (
   CGContextRef c,
   CGAffineTransform transform
);
 
 
// Creating Affine Transforms
// 移动效果
CGAffineTransform CGAffineTransformMakeTranslation (
   CGFloat tx,
   CGFloat ty
);
 
CGAffineTransform CGAffineTransformTranslate (
   CGAffineTransform t,
   CGFloat tx,
   CGFloat ty
);
 
// 旋转效果
CGAffineTransform CGAffineTransformMakeRotation (
   CGFloat angle
);
 
CGAffineTransform CGAffineTransformRotate (
   CGAffineTransform t,
   CGFloat angle
);
 
// 缩放效果
CGAffineTransform CGAffineTransformMakeScale (
   CGFloat sx,
   CGFloat sy
);
 
CGAffineTransform CGAffineTransformScale (
   CGAffineTransform t,
   CGFloat sx,
   CGFloat sy
);
 
// 反转效果
CGAffineTransform CGAffineTransformInvert (
   CGAffineTransform t
);
 
// 只对局部产生效果
CGRect CGRectApplyAffineTransform (
   CGRect rect,
   CGAffineTransform t
);
 
// 判断两个AffineTrans是否相等
bool CGAffineTransformEqualToTransform (
   CGAffineTransform t1,
   CGAffineTransform t2
);
 
 
 
// 获得Affine Transform
CGAffineTransform CGContextGetUserSpaceToDeviceSpaceTransform (
   CGContextRef c
);
 
// 下面的函数只起到查看的效果，比如看一下这个用户空间的点，转换到设备空间去坐标是多少
CGPoint CGContextConvertPointToDeviceSpace (
   CGContextRef c,
   CGPoint point
);
 
CGPoint CGContextConvertPointToUserSpace (
   CGContextRef c,
   CGPoint point
);
 
CGSize CGContextConvertSizeToDeviceSpace (
   CGContextRef c,
   CGSize size
);
 
CGSize CGContextConvertSizeToUserSpace (
   CGContextRef c,
   CGSize size
);
 
CGRect CGContextConvertRectToDeviceSpace (
   CGContextRef c,
   CGRect rect
);
 
CGRect CGContextConvertRectToUserSpace (
   CGContextRef c,
   CGRect rect
);
 
 
// CTM真正的数学行为
// 这个转换矩阵其实是一个 3x3的 举证
// 如下图
 
 
// 下面举例说明几个转换运算的数学实现
// x y 是原先点的坐标
// 下面是从用户坐标转换到设备坐标的计算公式
 
 
 
 
// 下面是一个identity matrix，就是输入什么坐标，出来什么坐标，没有转换
 
// 最终的计算结果是 x=x，y=y，  
 
 
//  可以用函数判断这个矩阵是不是一个 identity matrix
bool CGAffineTransformIsIdentity (
   CGAffineTransform t
);
 
 
 
 
// 参考:http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_affine/dq_affine.html








- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation   duration:(NSTimeInterval)duration
{
        
    
        if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
        {
                b=YES;
                
                self.view=mainvv;
                self.view.transform = CGAffineTransformIdentity;
                self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(0));
                self.view.bounds = CGRectMake(0.0, 0.0, 768.0, 1004.0);
                
        }
        else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        {
                b=NO;
                
                self.view = self.vv;
                self.view.transform = CGAffineTransformIdentity;
                self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
                self.view.bounds = CGRectMake(0.0, 0.0, 1024.0, 748.0);
                
                
                
        }
        else if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
                
                b=YES;
                self.view=mainvv;
                self.view.transform = CGAffineTransformIdentity;
                self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
                self.view.bounds = CGRectMake(0.0, 0.0, 768.0, 1004.0);
                
        }
        else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
        {
                
                b=NO;
                self.view = self.vv;
                self.view.transform = CGAffineTransformIdentity;
                self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
                self.view.bounds = CGRectMake(0.0, 0.0, 1024.0, 748.0);
                
        }
        
        
}


// 3

// Quartz转换实现的原理:Quartz把绘图分成两个部分，
//     用户空间，即和设备无关，
//     设备空间，
// 用户空间和设备空间中间存在一个转换矩阵 ： CTM
// 本章实质是讲解CTM

// Quartz提供的3大功能
// 移动，旋转，缩放

// 演示如下，首先加载一张图片
void CGContextDrawImage (
   CGContextRef c,
   CGRect rect,
   CGImageRef image
);


 

 
// 移动函数
CGContextTranslateCTM (myContext, 100, 50);




// 旋转函数
include <math.h>
static inline double radians (double degrees) {return degrees * M_PI/180;}
CGContextRotateCTM (myContext, radians(–45.));



// 缩放
CGContextScaleCTM (myContext, .5, .75);



// 翻转， 两种转换合成后的效果，先把图片移动到右上角，然后旋转180度
CGContextTranslateCTM (myContext, w,h);
CGContextRotateCTM (myContext, radians(-180.));



// 组合几个动作
CGContextTranslateCTM (myContext, w/4, 0);
CGContextScaleCTM (myContext, .25,  .5);
CGContextRotateCTM (myContext, radians ( 22.));


 


CGContextRotateCTM (myContext, radians ( 22.));
CGContextScaleCTM (myContext, .25,  .5);
CGContextTranslateCTM (myContext, w/4, 0);




// 上面是通过直接修改当前的ctm实现3大效果，下面是通过创建Affine Transforms，然后连接ctm实现同样的3种效果
// 这样做的好处是可以重用这个Affine Transforms
// 应用Affine Transforms 到ctm的函数
void CGContextConcatCTM (
   CGContextRef c,
   CGAffineTransform transform
);


// Creating Affine Transforms
// 移动效果
CGAffineTransform CGAffineTransformMakeTranslation (
   CGFloat tx,
   CGFloat ty
);

CGAffineTransform CGAffineTransformTranslate (
   CGAffineTransform t,
   CGFloat tx,
   CGFloat ty
);

// 旋转效果
CGAffineTransform CGAffineTransformMakeRotation (
   CGFloat angle
);

CGAffineTransform CGAffineTransformRotate (
   CGAffineTransform t,
   CGFloat angle
);

// 缩放效果
CGAffineTransform CGAffineTransformMakeScale (
   CGFloat sx,
   CGFloat sy
);

CGAffineTransform CGAffineTransformScale (
   CGAffineTransform t,
   CGFloat sx,
   CGFloat sy
);

// 反转效果
CGAffineTransform CGAffineTransformInvert (
   CGAffineTransform t
);

// 只对局部产生效果
CGRect CGRectApplyAffineTransform (
   CGRect rect,
   CGAffineTransform t
);

// 判断两个AffineTrans是否相等
bool CGAffineTransformEqualToTransform (
   CGAffineTransform t1,
   CGAffineTransform t2
);



// 获得Affine Transform
CGAffineTransform CGContextGetUserSpaceToDeviceSpaceTransform (
   CGContextRef c
);

// 下面的函数只起到查看的效果，比如看一下这个用户空间的点，转换到设备空间去坐标是多少
CGPoint CGContextConvertPointToDeviceSpace (
   CGContextRef c,
   CGPoint point
);

CGPoint CGContextConvertPointToUserSpace (
   CGContextRef c,
   CGPoint point
);

CGSize CGContextConvertSizeToDeviceSpace (
   CGContextRef c,
   CGSize size
);

CGSize CGContextConvertSizeToUserSpace (
   CGContextRef c,
   CGSize size
);

CGRect CGContextConvertRectToDeviceSpace (
   CGContextRef c,
   CGRect rect
);

CGRect CGContextConvertRectToUserSpace (
   CGContextRef c,
   CGRect rect
);


// CTM真正的数学行为
// 这个转换矩阵其实是一个 3x3的 举证
// 如下图


// 下面举例说明几个转换运算的数学实现
// x y 是原先点的坐标
// 下面是从用户坐标转换到设备坐标的计算公式




// 下面是一个identity matrix，就是输入什么坐标，出来什么坐标，没有转换

// 最终的计算结果是 x=x，y=y，  


//  可以用函数判断这个矩阵是不是一个 identity matrix
bool CGAffineTransformIsIdentity (
   CGAffineTransform t
);


// 移动矩阵
// 缩放矩阵
// 旋转矩阵
// 旋转加移动矩阵