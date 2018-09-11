//
//  SZPropertyRechargeViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/8.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyRechargeViewModel.h"
@implementation SZPropertyRechargeViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)getPropertyRechargeAddressWithParameters:(id)parameters{
    
    [[[SZHttpsService sharedSZHttpsService] signalRequestPropertyAddressWithParameter:parameters]subscribeNext:^(id responseDicitonray) {
        NSInteger code=[responseDicitonray[@"code"] integerValue];
        if (code == 0) {
            SZRechargePropertyModel* model=[SZRechargePropertyModel new];
            model.fdescription= responseDicitonray[@"fvirtualcointype"][@"fdescription"];
            NSDictionary* fvirtualAddress=responseDicitonray[@"fvirtualaddress"];
            if (isEmptyObject(fvirtualAddress)) {
                model.fvirtualaddress=@"";
            }else{
                model.fvirtualaddress=responseDicitonray[@"fvirtualaddress"][@"fadderess"];
            }
            self.model=model;
            if (isEmptyString(model.fvirtualaddress)) {
                [self manualGetPropertyRechargeAddressWithParameters:self.propertyCellViewModel.bbPropertyModel.fvirtualcointypeId];
            }else{
                [(RACSubject *) self.successSignal sendNext:nil];
            }
        }else{
            NSString* errorMessage=responseDicitonray[@"msg"];
            [(RACSubject *) self.failureSignal sendNext:errorMessage ];
        }
    } error:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];

    }];
    
    
}


-(void)manualGetPropertyRechargeAddressWithParameters:(id)parameters{
    
    [[[SZHttpsService sharedSZHttpsService] signalRequestManualPropertyAddressWithParameter:parameters]subscribeNext:^(id responseDictionary) {
        NSInteger code=[responseDictionary[@"code"] integerValue];
        if (code == 0) {
            
        }else{
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject *) self.failureSignal sendNext:errorMessage ];
        }
    } error:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];

    }];;
    
    
}

@end
