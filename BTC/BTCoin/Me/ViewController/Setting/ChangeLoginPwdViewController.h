//
//  ChangeLoginPwdViewController.h
//  BTCoin
//
//  Created by Shizi on 2018/4/23.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "CustomViewController.h"
#import "SZSecurityCodeViewModel.h"
typedef enum {
    kPwdChangeLogin = 0,//修改登录密码
    kPwdChangeBargaining = 1,//修改交易密码
    kPwdSetBargaining = 2,//设置交易密码
}kOperationPwdType;

@interface ChangeLoginPwdViewController : CustomViewController

@property (nonatomic, assign) kOperationPwdType pwdType;

@end
