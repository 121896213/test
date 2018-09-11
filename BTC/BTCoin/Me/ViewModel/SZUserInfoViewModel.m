//
//  SZUserInfoViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/7/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZUserInfoViewModel.h"

@interface SZUserInfoViewModel()

@end


@implementation SZUserInfoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        self.titleArr=@[ @[NSLocalizedString(@"头像", nil),NSLocalizedString(@"昵称", nil),NSLocalizedString(@"登录名", nil),NSLocalizedString(@"注册时间", nil)],
                         @[NSLocalizedString(@"身份认证", nil),NSLocalizedString(@"手机号", nil),NSLocalizedString(@"邮箱", nil)]];

    }
    return self;
}

@end

