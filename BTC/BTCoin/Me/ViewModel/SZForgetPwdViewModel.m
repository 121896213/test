//
//  SZForgetPwdViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZForgetPwdViewModel.h"

@implementation SZForgetPwdViewModel

-(void)checkSecurityCodeWithPhone:(NSString*)phone msgCode:(NSString*)msgCode{
    
    [[[SZHttpsService sharedSZHttpsService] signalcheckSecurityCodeWithPhone:phone msgCode:msgCode]subscribeNext:^(id responseDictionary) {
        
        if ([responseDictionary[@"code"] integerValue] == 0) {
            NSString* msg=responseDictionary[@"msg"];
            [(RACSubject*)self.successSignal sendNext:msg];
        }else{
            NSString* msg=responseDictionary[@"msg"];
            [(RACSubject*)self.failureSignal sendNext:msg];
        }
    }error:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];

    }];

}

-(void)checkSecurityCodeWithEmail:(NSString*)Email msgCode:(NSString*)msgCode{
    
    [[[SZHttpsService sharedSZHttpsService] signalcheckSecurityCodeWithEmail:Email msgCode:msgCode]subscribeNext:^(id responseDictionary) {
        
        if ([responseDictionary[@"code"] integerValue] == 0) {
            NSString* msg=responseDictionary[@"msg"];
            [(RACSubject*)self.successSignal sendNext:msg];
        }else{
            NSString* msg=responseDictionary[@"msg"];
            [(RACSubject*)self.failureSignal sendNext:msg];
        }
    }error:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];

    }];
    
    
}



@end
