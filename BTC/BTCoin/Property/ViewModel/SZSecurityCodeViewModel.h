//
//  SZSecurityCodeViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
typedef NS_OPTIONS(NSUInteger, SZSecurityCodeViewType) {
    SZSecurityCodeViewTypeBindMobileEmail=2,
    SZSecurityCodeViewTypeCommitWithdraw=5,
    SZSecurityCodeViewTypeModifyLoginPassword=6,
    SZSecurityCodeViewTypeModifyTradePassword=7,
    SZSecurityCodeViewTypeAddAddress=8,
    SZSecurityCodeViewTypeFindLoginPassword=9,

};
@interface SZSecurityCodeViewModel : SZRootViewModel

-(void)getWithdrawSecurityCodeWithParameters:(id)parameters;
-(void)getEmailCodeWithParameters:(NSString*)email securityCodeType:(SZSecurityCodeViewType) securityCodeType;
@property (nonatomic,assign) SZSecurityCodeViewType  securityCodeType;
@property (nonatomic,copy) NSString* mobile;
@property (nonatomic,copy) NSString* areaCode;

@end
