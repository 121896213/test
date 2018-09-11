//
//  SZPropertyWithdrawViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/8.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyWithdrawViewModel.h"

@implementation SZPropertyWithdrawViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)signalRequestPropertyDrawRtcWithParameter:(id)parameters{
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestPropertyDrawRtcWithParameter:parameters]subscribeNext:^(id responseDictionary) {
        
        @strongify(self);
        NSInteger code=[responseDictionary[@"code"] integerValue];
        if (code !=-1) {
            
            NSArray* withdrawFeesArr=responseDictionary[@"withdrawFees"];
            if (withdrawFeesArr.count) {
                NSString* withdrawFee=withdrawFeesArr[0][@"ffee"];
                self.withdrawFee=[NSString stringWithFormat:@"%lf",[withdrawFee doubleValue]];
                [(RACSubject *) self.successSignal sendNext:nil ];
            }else{
                self.withdrawFee=@"0.000000";
                [(RACSubject *) self.failureSignal sendNext:@"暂无手续费" ];
            }
            
        }else{
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject *) self.failureSignal sendNext:errorMessage ];
        }
    } error:^(NSError *error) {
        @strongify(self);

        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];

    }];
    
}


-(void)commitWithdrawWithParameters:(id)parameters
{
    
    
    [[[SZHttpsService sharedSZHttpsService] signalRequestCommitWithdrawWithAddress:parameters[@"address"] withdrawAddr:parameters[@"withdrawAddr"] withdrawAmount:parameters[@"withdrawAmout"]  tradePwd:parameters[@"tradePwd"] googleCode:parameters[@"googleCode"] phoneCode:parameters[@"phoneCode"] symbol:parameters[@"symbol"]]subscribeNext:^(id x) {
        NSDictionary* responseDictionary=x;
        if ([responseDictionary[@"code"] integerValue] == 0) {
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject*)self.successSignal sendNext:errorMessage];
        }else{
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject*)self.failureSignal sendNext:errorMessage];
        }
    } error:^(NSError *error) {
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];
        
    }];
    
    
}
@end
