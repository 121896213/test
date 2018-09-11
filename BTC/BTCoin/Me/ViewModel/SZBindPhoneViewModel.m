//
//  SZBindPhoneViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/15.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBindPhoneViewModel.h"

@implementation SZBindPhoneViewModel

-(void)bindPhoneWithParameters:(id)parameters{
    
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalBindPhoneWithAreaCode:parameters[@"areaCode"] phone:parameters[@"phone"] newCode:parameters[@"newCode"]]subscribeNext:^(id responseDictionary) {
        
        @strongify(self);
        NSInteger code=[responseDictionary[@"code"] integerValue];
        if (code == 0) {
            NSString* msg=responseDictionary[@"msg"];
            [(RACSubject *) self.successSignal sendNext:msg];
        }else{
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject *) self.failureSignal sendNext:errorMessage ];
        }
    } error:^(NSError *error) {
        @strongify(self);
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];

    }];
    
}
@end
