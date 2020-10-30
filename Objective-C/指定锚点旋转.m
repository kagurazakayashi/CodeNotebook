- (void)startAnimation
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(20 * (M_PI / 180.0f));
    [UIView animateWithDuration:_speed delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _wingLeft.transform = endAngle;
    } completion:^(BOOL finished) {
        if (_isAni) {
            CGAffineTransform endAngle = CGAffineTransformMakeRotation(-20 * (M_PI / 180.0f));
            [UIView animateWithDuration:_speed delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                _wingLeft.transform = endAngle;
            } completion:^(BOOL finished) {
                if (_isAni) {
                    [self startAnimation];
                }
            }];
        }
    }];
}
