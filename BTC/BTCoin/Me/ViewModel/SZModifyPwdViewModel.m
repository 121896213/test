//
//  SZModifyPwdViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZModifyPwdViewModel.h"

@implementation SZModifyPwdViewModel

-(void)modifyPasswordWithParameters{
    
    [[[SZHttpsService sharedSZHttpsService] signalSetLoginPwdWithPhone:self.mobileEmail newPassword:self.password msgCode:self.securityCode ]subscribeNext:^(id responseDictionary) {
        
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
