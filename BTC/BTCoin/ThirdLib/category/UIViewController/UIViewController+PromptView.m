//
//  UIViewController+PromptView.m
//  99Gold
//
//  Created by 刘海东 on 2016/12/7.
//  Copyright © 2016年 xia zhonglin . All rights reserved.
//

#import "UIViewController+PromptView.h"
#import "UIView+EmptyViewTips.h"

@implementation UIViewController (PromptView)

#pragma mark检测是否需要加上状态图
- (void)chickEmptyViewShow:(NSArray *)dataArray withCode:(NSString *)code inView:(UIView *)inView hanleBlock:(void(^)(void))hanleBlock{
    
    Loading_Hide(inView);
    
    if (dataArray.count==0&&[code intValue]!=0) {//数据为0 错误代码不为0
        
        [self.view showErrorViewInView:inView withMsg:RequestState_NetworkErrorStr(code) touchHanleBlock:^{
            Loading_Pig_Show(inView);
            
            if (hanleBlock) {
                hanleBlock();
            }
        }];
        
    }else if (dataArray.count==0&&[code intValue]==0){//空白页面
        
        [self.view showEmptyViewInView:inView withMsg:RequestState_EmptyStr(code) touchHanleBlock:nil];
        
    }else{
        [self.view hideEmptyViewInView:inView];
    }
}

@end
