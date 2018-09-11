//
//  UINavigationController+StatusBarStyle.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"

@implementation UINavigationController (StatusBarStyle)

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden{
    return self.visibleViewController;
}
@end
