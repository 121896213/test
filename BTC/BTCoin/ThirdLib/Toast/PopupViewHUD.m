
#import "PopupViewHUD.h"
#import "UIView+Frame.h"

static const NSInteger popupViewTag = 999991;
@implementation PopupViewHUD

static PopupViewHUD * popupViewHUD = nil;
+ (PopupViewHUD *)shared{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popupViewHUD = [[PopupViewHUD alloc]init];
    });
    return popupViewHUD;
}
/**错误提示*/
+ (void)showErrorPopup:(NSString * _Nonnull)error{
    if (!error) {
        return ;
    }
    [[PopupViewHUD shared] createPopupViewWithString:error imageName:@"prompt_wrong"];
}
/**成功提示*/
+ (void)showSuccessPopup:(NSString * _Nonnull)success{
    
    [[PopupViewHUD shared] createPopupViewWithString:success imageName:@"prompt_down"];
    
}
/**注意提示*/
+ (void)showPromptPopup:(NSString * _Nonnull)prompt{
    
    [[PopupViewHUD shared] createPopupViewWithString:prompt imageName:@"prompt_warm"];
}


- (void)createPopupViewWithString:(NSString * _Nonnull)str imageName:(NSString * _Nonnull)imgName{
    
    //获取最上层的window
    UIWindow * window = nil;
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0,*)) {
        window = [[UIApplication sharedApplication].windows firstObject];
    } else {
        window = [[UIApplication sharedApplication].windows lastObject];
    }
#endif
    if (nil == window) {
        return;
    }
    
    UIView *view = [window viewWithTag:popupViewTag];
    if (view) {
        return;
    }
    
    UIImageView *popupImageView = [[UIImageView alloc]initWithFrame:(CGRect){0,0,21,21}];
    popupImageView.image = [UIImage imageNamed:imgName];
    
    CGFloat height = 50;
    UILabel *popupLab = [[UILabel alloc]init];
    popupLab.text = str;
    popupLab.font = [UIFont systemFontOfSize:17];
    popupLab.textColor = [UIColor whiteColor];
    popupLab.numberOfLines=0;
    [popupLab sizeToFit];
    
    UIView *popupView = [[UIView alloc]init];
    popupView.center = window.center;
    popupImageView.frame = CGRectMake(10, (height - 21.0)/2.0, 21, 21);
    popupLab.frame = CGRectMake(CGRectGetMaxX(popupImageView.frame)+5, (height - popupLab.height)/2.0, popupLab.width, popupLab.height);
    CGFloat width = CGRectGetMaxX(popupLab.frame)+10;
    popupView.size = CGSizeMake(width, height);
    [popupView setLeft:(window.width - width)/2.0];
    popupView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [popupView addSubview:popupLab];
    [popupView addSubview:popupImageView];
    popupView.layer.cornerRadius = 10;
    popupView.layer.masksToBounds = YES;
    popupView.tag = popupViewTag;
    [window addSubview:popupView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [popupView removeFromSuperview];
        });
    });
}

@end
