//
//  SZForgetPwdViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"

@interface SZForgetPwdViewModel : SZRootViewModel

-(void)checkSecurityCodeWithPhone:(NSString*)phone msgCode:(NSString*)msgCode;
-(void)checkSecurityCodeWithEmail:(NSString*)Email msgCode:(NSString*)msgCode;
@end
