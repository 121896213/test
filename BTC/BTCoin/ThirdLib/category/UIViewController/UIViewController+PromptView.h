//
//  UIViewController+PromptView.h
//  99Gold
//
//  Created by 刘海东 on 2016/12/7.
//  Copyright © 2016年 xia zhonglin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PromptView)
- (void)chickEmptyViewShow:(NSArray *)dataArray withCode:(NSString *)code inView:(UIView *)inView hanleBlock:(void(^)(void))hanleBlock;

@end
