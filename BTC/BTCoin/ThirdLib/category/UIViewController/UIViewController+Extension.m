//
//  UIViewController+Extension.m
//  99Gold
//
//  Created by LionIT on 17/08/2017.
//  Copyright © 2017 xia zhonglin . All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (BOOL)isCurrentVisible
{
    return (self.isViewLoaded && self.view.window);
}

@end
