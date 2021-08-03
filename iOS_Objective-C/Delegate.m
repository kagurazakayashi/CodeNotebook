@protocol CustomTVCDelegate <NSObject>
- (void)reloadButton:(BOOL)isEdit;
- (void)openEditWindow:(UIViewController*)editVC;
@end

@property (nonatomic, assign) id<CustomTVCDelegate> delegate;