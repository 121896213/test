//
//  TabBarController.h
//  99SVR
//
//  Created by Jiangys on 16/3/14.
//  Copyright © 2016年 Jiangys . All rights reserved.
//
#import "Reachability.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TabTag) {
    TabTagTrade,
    TabTagAboutMe
};

@interface TabBarController : UITabBarController
@property (nonatomic, assign) NetworkStatus nowStatus;

+(TabBarController *)singletonTabBarController;

- (void)selectedIndex:(NSUInteger)sIndex ToRoot:(BOOL)toroot;

- (UIViewController *)getNavControl;

@end
