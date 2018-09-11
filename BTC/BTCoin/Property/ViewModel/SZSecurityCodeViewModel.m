//
//  SZSecurityCodeViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSecurityCodeViewModel.h"

@implementation SZSecurityCodeViewModel

-(void)getWithdrawSecurityCodeWithParameters:(id)parameters
{
//    _mobile=isEmptyObject(parameters)?[UserInfo sharedUserInfo].appLoginName:parameters;
    _areaCode=isEmptyObject(_areaCode)?@"86":_areaCode;
    [[[SZHttpsService sharedSZHttpsService] signalRequestWithdrawSecurityCodeWithPhone:_mobile areaCode:_areaCode securityCodeType:FormatString(@"%lu",(unsigned long)_securityCodeType)]subscribeNext:^(id x) {
        NSDictionary* responseDictionary=x;
        if ([responseDictionary[@"code"] integerValue] == 0) {
            
            [(RACSubject*)self.otherSignal sendNext:@"SecurityCode"];
        }else{
            
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject*)self.failureSignal sendNext:errorMessage];
        }
    } error:^(NSError *error) {
        
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];

    }];

}
-(void)getEmailCodeWithParameters:(NSString*)email securityCodeType:(SZSecurityCodeViewType) securityCodeType
{
    [[[SZHttpsService sharedSZHttpsService] signalRequestEmailCodeWithEmail:email  securityCodeType:FormatString(@"%lu",(unsigned long)securityCodeType)]subscribeNext:^(id x) {
        NSDictionary* responseDictionary=x;
        if ([responseDictionary[@"code"] integerValue] == 0) {
            
            [(RACSubject*)self.otherSignal sendNext:@"SecurityCode"];
        }else{
            
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject*)self.failureSignal sendNext:errorMessage];
        }
    } error:^(NSError *error) {
        
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];

    }];
    
}
@end
