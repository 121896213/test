//
//  PhonePwdViewController.h
//  BTCoin
//
//  Created by LionIT on 14/03/2018.
//  Copyright © 2018 LionIT. All rights reserved.
//

#import "CustomViewController.h"

@interface PhonePwdViewController : CustomViewController

@property (nonatomic,assign) NSInteger regType;//0:手机注册，1:邮箱注册
@property (nonatomic,copy) NSString * phoneNum;//手机号码
@property (nonatomic,copy) NSString * areaCode;//手机区号

@end
