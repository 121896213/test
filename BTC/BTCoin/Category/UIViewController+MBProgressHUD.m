//
//  UIViewController+MBProgressHUD.m
//  scale
//
//  Created by 何志行 on 16/12/18.
//  Copyright © 2016年 gretta. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"
@implementation UIViewController (MBProgressHUD)


-(void)hideMBProgressHUD{
   [MBProgressHUD hideHUDForView:self.view animated:YES];

}
+(void)hideMBProgressHUD{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window.rootViewController.view animated:YES];
    
}

-(void)showLoadingMBProgressHUD{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view ];
    hud.userInteractionEnabled = NO;
    hud.label.textColor=[UIColor whiteColor];
    hud.label.numberOfLines=0;
    //修改样式，否则等待框背景色将为半透明
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor =UIColorFromRGBWithAlpha(0X000000, 0.8);
    hud.removeFromSuperViewOnHide = YES;
    //设置菊花框为白色
    [[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]] setColor:[UIColor whiteColor]];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    
}
+(void)showLoadingMBProgressHUD{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
    hud.userInteractionEnabled = YES;
    hud.label.textColor=[UIColor whiteColor];
    hud.label.numberOfLines=0;
    //修改样式，否则等待框背景色将为半透明
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor =UIColorFromRGBWithAlpha(0X000000, 0.8);
    hud.removeFromSuperViewOnHide = YES;
    //设置菊花框为白色
    [[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]] setColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view  addSubview:hud];
    [hud showAnimated:YES];
}

-(void)showPromptHUDWithTitle:(NSString *)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor=[UIColor whiteColor];
    hud.label.text = title;
    hud.label.numberOfLines=0;

    // Move to bottm center.
//    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor =UIColorFromRGBWithAlpha(0X000000, 0.8);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5f];
}
+(void)showPromptHUDWithTitle:(NSString *)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window.rootViewController.view animated:YES];
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor=[UIColor whiteColor];
    hud.label.numberOfLines=0;
    hud.label.text = title;
    // Move to bottm center.
//    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor =UIColorFromRGBWithAlpha(0X000000, 0.8);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5f];
}


-(void)showErrorHUDWithTitle:(NSString *)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor=[UIColor whiteColor];
    hud.label.text = title;
    hud.label.numberOfLines=0;
    // Move to bottm center.
//    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor =UIColorFromRGBWithAlpha(0X000000, 0.8);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5f];

}
+(void)showErrorHUDWithTitle:(NSString *)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window.rootViewController.view animated:YES];
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor=[UIColor whiteColor];
    hud.label.text = title;
    hud.label.numberOfLines=0;
    // Move to bottm center.
    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor =UIColorFromRGBWithAlpha(0X000000, 0.8);

    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5f];
}












-(void)showHUDWithTitle:(NSString*)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view ];
    hud.label.text=@"加载中...";
    hud.userInteractionEnabled = NO;
    hud.label.textColor=[UIColor whiteColor];
    //修改样式，否则等待框背景色将为半透明
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.removeFromSuperViewOnHide = YES;
    //设置菊花框为白色
    [[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]] setColor:[UIColor whiteColor]];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    
}
+(void)showHUDWithTitle:(NSString*)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
    hud.label.text=@"加载中...";
    hud.userInteractionEnabled = YES;
    hud.label.textColor=[UIColor whiteColor];
    //修改样式，否则等待框背景色将为半透明
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.removeFromSuperViewOnHide = YES;
    //设置菊花框为白色
    [[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]] setColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view  addSubview:hud];
    [hud showAnimated:YES];
}



+(void)showUnEnabledHUDWithTitle:(NSString *)title
{
    [self hideMBProgressHUD];
    MBProgressHUD* HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window.rootViewController.view animated:YES];
    HUD.label.text=title;
    HUD.label.textColor=[UIColor whiteColor];
    HUD.customView.backgroundColor=[UIColor blackColor];
    [HUD showAnimated:YES];

}



-(void)showSuccessHUDWithTitle:(NSString *)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor=[UIColor whiteColor];
    hud.label.text = title;
    // Move to bottm center.
//    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5f];
}
+(void)showSuccessHUDWithTitle:(NSString *)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view  addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success"]];
    HUD.customView.contentMode=UIViewContentModeScaleAspectFit;
    HUD.customView.backgroundColor=[UIColor blackColor];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text=title;
    HUD.label.textColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.5f];
}


-(void)showFailureHUDWithTitle:(NSString *)title{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view ];
    [self.view  addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_lose"]];
    HUD.customView.contentMode=UIViewContentModeScaleAspectFit;
    HUD.customView.backgroundColor=[UIColor blackColor];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text=title;
    HUD.label.textColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.5f];
    
}
+(void)showFailureHUDWithTitle:(NSString *)title{
    
    [self hideMBProgressHUD];
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window.rootViewController.view ];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view  addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_lose"]];
    HUD.customView.contentMode=UIViewContentModeScaleAspectFit;
    HUD.customView.backgroundColor=[UIColor blackColor];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text=title;
    HUD.label.textColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.5f];
    
}


-(void)showProgressHUDWithTitle:(NSString*)title
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.userInteractionEnabled = NO;
    HUD.customView.backgroundColor=[UIColor blackColor];
    HUD.label.text=title;
    HUD.label.textColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
}
+(void)showProgressHUDWithTitle:(NSString*)title
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window.rootViewController.view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.userInteractionEnabled = NO;
    HUD.customView.backgroundColor=[UIColor blackColor];
    HUD.label.text=title;
    HUD.label.textColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
    
    
}

-(void)setHudProgress:(float) progress
{
    
    MBProgressHUD* HUD=[MBProgressHUD HUDForView:self.view];

    HUD.progress = progress;
}

+(void)setHudProgress:(float) progress
{
    
    MBProgressHUD* HUD=[MBProgressHUD HUDForView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
 
    
    HUD.progress = progress;
}
@end
