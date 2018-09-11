//
//  SZModifyPwdViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"

@interface SZModifyPwdViewModel : SZRootViewModel
@property (nonatomic,copy)NSString* mobileEmail;
@property (nonatomic,copy)NSString* securityCode;
@property (nonatomic,copy)NSString* password;
@property (nonatomic,copy)NSString* renewPwd;

-(void)modifyPasswordWithParameters;
@end
