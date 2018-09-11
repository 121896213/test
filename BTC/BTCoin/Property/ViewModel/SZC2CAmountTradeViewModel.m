//
//  SZC2CAmountTradeViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/7/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAmountTradeViewModel.h"

@implementation SZC2CAmountTradeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)requestC2CBBTransfersWithParameter:(id)parameter{
    
    
    [[[SZHttpsService sharedSZHttpsService] signalRequestC2CBBTransfersParameter:@{@"fType":self.cellViewModel.c2cPropertyModel.fvirtualcointypeId,@"transType":@(self.amountTradeType),@"fcNumber":self.tradeAmount,@"password": [AppUtil md5:self.tradePassword]}]subscribeNext:^(id responseDictionray) {
        
        SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionray];
        if (base.code == 0) {
            [(RACSubject *) self.successSignal sendNext:base.msg];
        }else{
            [(RACSubject *) self.failureSignal sendNext:base.msg];
        }
    } error:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
    }];
    
}


-(void)requestUserWalletWithParameter:(id)parameter{
    
    
    [[[SZHttpsService sharedSZHttpsService] signalRequestBBPropertyListWithParameter:@{@"virtualCoinId":self.cellViewModel.c2cPropertyModel.fvirtualcointypeId}]subscribeNext:^(id responseDictionray) {
        
        SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionray];
        if (base.code == 0) {

            SZBaseListModel* listModel=[SZBaseListModel new];
            [listModel mj_setKeyValues:base.data];
            listModel.dataList=[SZBBPropertyModel mj_objectArrayWithKeyValuesArray:listModel.dataList];
            if (listModel.dataList.count>0) {
                self.bbPropertyModel=listModel.dataList[0];
                [(RACSubject *) self.otherSignal sendNext:NSLocalizedString(@"获取账户余额成功", nil)];
            }else{
                [(RACSubject *) self.failureSignal sendNext:NSLocalizedString(@"获取账户余额失败", nil)];
            }
        }else{
            [(RACSubject *) self.failureSignal sendNext:base.msg];
        }
    } error:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
    }];
    
}
@end
