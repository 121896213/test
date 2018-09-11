//
//  SZPersonCenterViewModel.m
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
#import "SZPersonCenterViewModel.h"
#import "SZBaseModel.h"
#import "SZH5LoginModel.h"
@implementation SZPersonCenterViewModel
#pragma mark - private methods
- (void)getSecurityInfo:(id)parameters {
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestGetSecurityInfoParameter:parameters]subscribeNext:^(id responseDictionary) {
        @strongify(self);
        BaseModel * userInfo = [[BaseModel alloc] initWithDictionary:responseDictionary error:nil];
        if (userInfo.code == 0) {
            [[UserInfo sharedUserInfo] updateUserSecurityInfo:responseDictionary];
            [(RACSubject *) self.successSignal sendNext:nil ];

        }else{
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject *) self.failureSignal sendNext:errorMessage ];
        }
    } error:^(NSError *error) {
        @strongify(self);
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];
    }];
    
}
- (void)c2cH5Login:(id)parameters{
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestC2CH5LoginParameter:parameters]subscribeNext:^(id responseDictionary) {
        @strongify(self);
        SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionary];
        if (base.code == 0) {
            SZH5LoginModel* h5LoginModel=[SZH5LoginModel new];
            [h5LoginModel mj_setKeyValues:base.data];
            
            [UserInfo sharedUserInfo].redisTokenKey=h5LoginModel.redisTokenKey;
            [(RACSubject *) self.otherSignal sendNext:nil ];
            
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
