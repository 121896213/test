//
//  SZAddressEditViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZAddressEditViewModel.h"

@implementation SZAddressEditViewModel

-(void)addAddressWithParameters:(id)parameters{
    
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestAddAddressWithAddress:parameters[@"address"] googleCode:@"" phoneCode:parameters[@"phoneCode"] symbol:parameters[@"symbol"] addressRemark:parameters[@"withdrawRemark"]]subscribeNext:^(id responseDictionary) {
        
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

-(void)deleteAddressWithParameters:(id)parameters{
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestdeleteAddressWithAddressId:parameters]subscribeNext:^(id responseDictionary) {
        
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
