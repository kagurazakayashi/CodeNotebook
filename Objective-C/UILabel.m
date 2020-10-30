//UILabel居中
label.textAlignment = NSTextAlignmentCenter;
//UILabel阴影
//  添加带阴影的子Layer（层）,代码：
     //添加子layer
    CALayer *cyanLayer = [CALayer layer];
    cyanLayer.backgroundColor = [UIColor cyanColor].CGColor;
    cyanLayer.bounds = CGRectMake(0, 0, 300, 300);
    cyanLayer.position = CGPointMake(180, 180);
    cyanLayer.shadowOffset = CGSizeMake(0, 3); //设置阴影的偏移量
    cyanLayer.shadowRadius = 10.0;  //设置阴影的半径
    cyanLayer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
    cyanLayer.shadowOpacity = 0.9; //设置阴影的不透明度
    [backLayer addSublayer:cyanLayer];
//  图片加边框，代码：
imageLayer.borderColor = [UIColor grayColor].CGColor;  //边框颜色
imageLayer.borderWidth = 2.0;  //边框宽度
//  设置图片为椭圆角，代码：
imageLayer.cornerRadius = 10.0;  //设置layer圆角半径
imageLayer.masksToBounds = YES;  //隐藏边界

//UILabel 多行文字自动换行 （自动折行）
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 180)];  
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 150)];  
        label.text = @"where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you?";  
        //清空背景颜色  
        label.backgroundColor = [UIColor clearColor];  
        //设置字体颜色为白色  
        label.textColor = [UIColor whiteColor];  
        //文字居中显示  
        label.textAlignment = UITextAlignmentCenter;  
        //自动折行设置  
        label.lineBreakMode = UILineBreakModeWordWrap;  
        label.numberOfLines = 0;  

        
//UILabel显示多行文本
textLabel.lineBreakMode = UILineBreakModeWordWrap;
textLabel.numberOfLines = 0;

=======


#import "LabelTestViewController.h"     
@implementation LabelTestViewController     
/*   
 Accessing the Text Attributes   
 text  property     
 font  property     
 textColor  property     
 textAlignment  property     
 lineBreakMode  property       
 enabled  property     
 Sizing the Label’s Text   
 adjustsFontSizeToFitWidth  property     
 baselineAdjustment  property     
 minimumFontSize  property   无例   
 numberOfLines  property     
 Managing Highlight Values   
 highlightedTextColor  property     
 highlighted  property     
 Drawing a Shadow   
 shadowColor  property     
 shadowOffset  property     
 Drawing and Positioning Overrides   
 – textRectForBounds:limitedToNumberOfLines: 无例    
 – drawTextInRect:  无例   
 Setting and Getting Attributes   
 userInteractionEnabled  property     
 */    
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.     
- (void)viewDidLoad {     
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 20.0, 200.0, 50.0)];     
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 80.0, 200.0, 50.0)];     
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 140.0, 200.0, 50.0)];     
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 200.0, 200.0, 50.0)];     
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 260.0, 200.0, 50.0)];     
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 320.0, 200.0, 50.0)];     
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 380.0, 200.0, 50.0)];     

    //设置显示文字     
    label1.text = @"label1";     
    label2.text = @"label2";     
    label3.text = @"label3--label3--label3--label3--label3--label3--label3--label3--label3--label3--label3--";     
    label4.text = @"label4--label4--label4--label4--";     
    label5.text = @"label5--label5--label5--label5--label5--label5--";     
    label6.text = @"label6";     
    label7.text = @"label7";     

    //设置字体:粗体，正常的是 SystemFontOfSize     
    label1.font = [UIFont boldSystemFontOfSize:20];     

    //设置文字颜色  
    label1.textColor = [UIColor orangeColor];     
    label2.textColor = [UIColor purpleColor];     

    //设置文字位置     
    label1.textAlignment = UITextAlignmentRight;     
    label2.textAlignment = UITextAlignmentCenter;     
    //设置字体大小适应label宽度     
    label4.adjustsFontSizeToFitWidth = YES;     
  
    //设置label的行数     

    label5.numberOfLines = 2;    
    UIlabel.backgroudColor=[UIColor clearColor]; //可以去掉背景色   
 
    //设置高亮     
    label6.highlighted = YES;     
    label6.highlightedTextColor = [UIColor orangeColor];     

    //设置阴影     
    label7.shadowColor = [UIColor redColor];     
    label7.shadowOffset = CGSizeMake(1.0,1.0);     

    //设置是否能与用户进行交互     
    label7.userInteractionEnabled = YES;     

    //设置label中的文字是否可变，默认值是YES     
    label3.enabled = NO;     

    //设置文字过长时的显示格式     
    label3.lineBreakMode = UILineBreakModeMiddleTruncation;//截去中间     
//  typedef enum {     
//      UILineBreakModeWordWrap = 0,     
//      UILineBreakModeCharacterWrap,     
//      UILineBreakModeClip,//截去多余部分     
//      UILineBreakModeHeadTruncation,//截去头部     
//      UILineBreakModeTailTruncation,//截去尾部     
//      UILineBreakModeMiddleTruncation,//截去中间     
//  } UILineBreakMode;     

    //如果adjustsFontSizeToFitWidth属性设置为YES，这个属性就来控制文本基线的行为     
    label4.baselineAdjustment = UIBaselineAdjustmentNone;     
//  typedef enum {     
//      UIBaselineAdjustmentAlignBaselines,     
//      UIBaselineAdjustmentAlignCenters,     
//      UIBaselineAdjustmentNone,     
//  } UIBaselineAdjustment;     


    [self.view addSubview:label1];     
    [self.view addSubview:label2];     
    [self.view addSubview:label3];     
    [self.view addSubview:label4];     
    [self.view addSubview:label5];     
    [self.view addSubview:label6];     
    [self.view addSubview:label7];     

    [label1 release];     
    [label2 release];     
    [label3 release];     
    [label4 release];     
    [label5 release];     
    [label6 release];     
    [label7 release];     

    [super viewDidLoad];     
}     
/*   
 // Override to allow orientations other than the default portrait orientation.   
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {   
 // Return YES for supported orientations   
 return (interfaceOrientation == UIInterfaceOrientationPortrait);   
 }   
 */    
- (void)didReceiveMemoryWarning {     
    // Releases the view if it doesn't have a superview.     
    [super didReceiveMemoryWarning];     

    // Release any cached data, images, etc that aren't in use.     
}     
- (void)viewDidUnload {     
    // Release any retained subviews of the main view.     
    // e.g. self.myOutlet = nil;     
}     
- (void)dealloc {     
    [super dealloc];     
}     
@end
