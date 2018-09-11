//
//  SZWalletViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWalletViewModel.h"

@implementation SZWalletViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)getWalletListWithParameters:(id)parameters{
    
    [[[SZHttpsService sharedSZHttpsService] signalRequestWalletTotalParameter:parameters]subscribeNext:^(id responseDictionray) {
        
        SZBaseModel *base = [SZBaseModel modelWithJson:responseDictionray];
        if (base.code == 0) {
            SZWalletListModel* listModel=[SZWalletListModel new];
            [listModel mj_setKeyValues:base.data];
            listModel.dataList=[SZWalletModel mj_objectArrayWithKeyValuesArray:listModel.dataList];
            NSMutableArray* dataList=[[NSMutableArray alloc]initWithArray:listModel.dataList];
            for (SZWalletModel* model in dataList) {
                
                if (model.assetsType == SZWalletTypeC2C) {
                    [listModel.dataList replaceObjectAtIndex:0 withObject:model];
                }else if (model.assetsType == SZWalletTypeBB) {
                    [listModel.dataList replaceObjectAtIndex:1 withObject:model];
                }else if (model.assetsType == SZWalletTypeSC) {
                    [listModel.dataList replaceObjectAtIndex:2 withObject:model];
                }
            }
            self.listModel=listModel;
            [(RACSubject *) self.successSignal sendNext:nil];

        }else{
            [(RACSubject *) self.failureSignal sendNext:base.msg];
        }
    } error:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
        
    }];

}
- (SZWalletCellViewModel *)walletCellAtIndexPath:(NSIndexPath *)indexPath {
    SZWalletCellViewModel *cellViewModel = nil;
    if (indexPath.row < self.listModel.dataList.count) {
        cellViewModel = [[SZWalletCellViewModel alloc] init];
        SZWalletModel *walletModel = self.listModel.dataList[indexPath.row];
        cellViewModel.walletModel=walletModel;
    }
 
    return cellViewModel;
}
@end
