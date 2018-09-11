//
//  AppDelegate.h
//  BTCoin
//
//  Created by LionIT on 22/02/2018.
//  Copyright © 2018 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"

#define TheApp           ([UIApplication sharedApplication])
#define TheAppDel        ((AppDelegate*)TheApp.delegate)

static NSString * language_sys = @"zh";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;//窗口
@property (strong, nonatomic) TabBarController* rootTabBarController;
@property (nonatomic,assign) BOOL isCanRota;//屏幕可以旋转
@property (nonatomic,assign)BOOL isKLineDarkModel;

@end

