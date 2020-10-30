
//使用MPMoviePlayerController播放视频
- (void)initMediaPlay
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    
    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:sourceMovieURL];
    moviePlayer.view.frame=CGRectMake(0, 0, 1024, 768);
    moviePlayer.controlStyle=MPMovieControlStyleNone;
    // Play the movie!
    [self.view addSubview:moviePlayer.view];
}
//使用AVPlayerLayer播放视频
- (void)initAVPlay
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    
    AVAsset *movieAsset    = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.layer.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.view.layer addSublayer:playerLayer];
    [player play];
}
 
//使用MPMoviePlayerController 播放视频
- (void)initMoviePlay
{
NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
MPMoviePlayerController* theMovie= [[MPMoviePlayerController alloc] initWithContentURL:theURL];
    theMovie.scalingMode=MPMovieScalingModeAspectFill;
    [self.view addSubview:theMovie.view];
[theMovie play];
}