-(void) _RequestData:(NSNumber*) nindex {
    //NSData* indexdata = [NSData dataWithBytes:&_AnimationIndex length:sizeof(_AnimationIndex)];
    //NSDictionary *request = [NSDictionary dictionaryWithObject:indexdata forKey:@"request"];
    int index = [nindex intValue];
    if (index>=MAXKEYS || index<0) {
        return;
    }
   
    NSDictionary *request = @{@"request":@"PIC"};
    NSString* key = [NSString stringWithFormat:@"%d", index];
   
    [_AnimationPics removeObjectForKey:key];
   
    [InterfaceController openParentApplication:request reply:^(NSDictionary *replyInfo, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
            [_AnimationPics removeObjectForKey:key];
        } else {
            NSData* data = [replyInfo objectForKey:@"PIC"];
            NSArray* picarray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [_AnimationPics setObject:picarray forKey:key];
            
            //start animation
            if (_AnimationTimer == nil) {
                _AnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(SetAnimationIndex) userInfo:nil repeats:YES];
            }
            
        }
    }];
   
}

// iOS App中的响应代码
#define PICCOUNT 30
- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply {
   
    if ([[userInfo objectForKey:@"request"] isEqualToString:@"PIC"]) {
        
        NSLog(@"containing app received message from watch");
        
        
        NSMutableArray* marray = [NSMutableArray arrayWithCapacity:PICCOUNT];
        for (int i=0; i<PICCOUNT; i++) {
            UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"glance-%d@2x.png", i+_picindex]];
            NSData* imagedata = UIImagePNGRepresentation(image);
            [marray addObject:imagedata];
        }
        
        _picindex += PICCOUNT;
        _picindex %= 360;
        
        NSData* imageData = [NSKeyedArchiver archivedDataWithRootObject:marray];
        
        //NSData* imageData = UIImageJPEGRepresentation(image, 1.0f);
        NSDictionary *response = [NSDictionary dictionaryWithObject:imageData forKey:@"PIC"];//@{@"response" : @"Watchkit"};
        
        reply(response);
    }
}
