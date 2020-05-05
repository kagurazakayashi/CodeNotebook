// 一次性手势 : Tap : 点击 : UITapGestureRecognizer
UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapmethod:)];
tap.numberOfTouchesRequired = 2;//点击出点需要几个点
tap.numberOfTapsRequired = 2;//连续点击几次才能引发手势事件
//上面两个参数默认不写的时候，系统默认是1；
[self.view addGestureRecognizer:tap];
//如何判断点击的地方是在视图的什么地方？
//在tap引发的时间中传入的UIGestureRecognizer 有一个方法:[tap locationInView:tpbview];
//这个方法可以得到一个CGPoint, 双指头点击的时候这个方法是无效的，因为无论点击哪里得到的都是同一个CGPoint

// 一次性手势 : Swipe : 轻扫 : UISwipeGestureRecognizer
- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipemethod:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft| UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer: swipe];
}
-(void)swipemethod:(UIGestureRecognizer *)swipe{
    NSLog(@"123");
}

// 连续性手势 : LongPress : 长按 : UILongPressGestureRecognizer
- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer *LongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressmethod:)];
    LongPress.minimumPressDuration = 2;
    [self.view addGestureRecognizer: LongPress];
}
-(void) LongPressmethod:(UIGestureRecognizer *) LongPress{
    if (LongPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"began");
    } else if (LongPress.state == UIGestureRecognizerStateChanged){
        NSLog(@"change");
    } else if (LongPress.state == UIGestureRecognizerStateEnded){
        NSLog(@"end");
    }
    CGPoint point = [LongPress locationInView:self.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
}
//长按方法在长按时长达到时间后，执行一次，抬起的时候也执行一次

// 连续性手势 : Pan : 拖动 : UIPanGestureRecognizer
- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}
-(void)pan:(UIPanGestureRecognizer *)pan{
    //当前位置
    CGPoint point = [pan locationInView:self.view];
    //相对于一开始按下的位置的位移
    CGPoint point2 = [pan translationInView:self.view];
    NSLog(@"point1:%@",NSStringFromCGPoint(point));
    NSLog(@"point2:%@",NSStringFromCGPoint(point2));
}

// 连续性手势 : Pinch : 捏合,扩张 : UIPinchGestureRecognizer
- (void)viewDidLoad {
    [super viewDidLoad];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.view addGestureRecognizer:pinch];
}
- (void)pinch:(UIPinchGestureRecognizer *)pin{
    CGFloat velocity = pin.velocity; //捏合或者扩展的速度快慢
    CGFloat scale = pin.scale; //捏合的动作比例
    NSLog(@"velocity = %lf",velocity);
    NSLog(@"scale = %lf",scale);
}

// 连续性手势 : Rotation : 旋转