//
//  UIViewController+MBProgressHUD.h
//  scale
//
//  Created by 何志行 on 16/12/18.
//  Copyright © 2016年 gretta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MBProgressHUD)
-(void)hideMBProgressHUD;
+(void)hideMBProgressHUD;

-(void)showLoadingMBProgressHUD;
+(void)showLoadingMBProgressHUD;
-(void)showPromptHUDWithTitle:(NSString *)title;
+(void)showPromptHUDWithTitle:(NSString *)title;
-(void)showErrorHUDWithTitle:(NSString *)title;
+(void)showErrorHUDWithTitle:(NSString *)title;


-(void)showHUDWithTitle:(NSString*)title;
+(void)showHUDWithTitle:(NSString*)title;
+(void)showUnEnabledHUDWithTitle:(NSString*)title;

-(void)showSuccessHUDWithTitle:(NSString *)title;
+(void)showSuccessHUDWithTitle:(NSString *)title;

-(void)showFailureHUDWithTitle:(NSString *)title;
+(void)showFailureHUDWithTitle:(NSString *)title;

-(void)showProgressHUDWithTitle:(NSString*)title;
-(void)setHudProgress:(float) progress;

+(void)showProgressHUDWithTitle:(NSString*)title;
+(void)setHudProgress:(float) progress;
@end
