//
//  SZPromotionRecordViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPromotionRecordViewModel.h"
#import "SZPromotionRecordModel.h"
@implementation SZPromotionRecordViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentPage=1;
    }
    return self;
}
-(void)getPromotionRecordList:(id)parameters{
    
    NSMutableDictionary* dictionary=[NSMutableDictionary new];
    if (parameters) {
        dictionary=[[NSMutableDictionary alloc]initWithDictionary:parameters];
        [dictionary setValue:@(15) forKey:@"pageSize"];
        [dictionary setValue:@(self.currentPage) forKey:@"pageIndex"];
        self.coinType=parameters[@"virtualCurrency"];
    }else{
        [dictionary setValue:@(15) forKey:@"pageSize"];
        [dictionary setValue:@(self.currentPage) forKey:@"pageIndex"];
        if (self.coinType) {
            [dictionary setValue:self.coinType forKey:@"virtualCurrency"];
        }
    }
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestPromotionRecordsParameter:dictionary]subscribeNext:^(id responseDictionary) {
        @strongify(self);
        SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionary];
        if (base.code == 0) {
            SZPromotionRecordListModel* listModel=[SZPromotionRecordListModel new];
            [listModel mj_setKeyValues:base.data];
            listModel.dataList=[SZPromotionRecordModel mj_objectArrayWithKeyValuesArray:listModel.dataList];
            if (listModel.pageIndex == 1) {
                self.baseListModel=listModel;
            }else{
                [self.baseListModel.dataList addObjectsFromArray:listModel.dataList];
            }
            self.currentPage=listModel.pageIndex+1;
            if (listModel.dataList.count > 0) {
                [(RACSubject *) self.successSignal sendNext:nil];
            }else{
                if (listModel.pageIndex == 1) {
                    [(RACSubject *) self.successSignal sendNext:nil];
                }else{
                    [(RACSubject *) self.failureSignal sendNext:NSLocalizedString(@"已经拉到最后啦...", nil)];
                }
            }
        }else{
            [(RACSubject *) self.failureSignal sendNext:base.msg];
        }
    } error:^(NSError *error) {
        @strongify(self);
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];
    }];
    
    
}
- (SZPromotionRecordCellViewModel *)promotionRecordCellViewModellAtIndexPath:(NSIndexPath *)indexPath ;
{
    SZPromotionRecordCellViewModel *cellViewModel = nil;
    if (indexPath.section < self.baseListModel.dataList.count) {
        cellViewModel = [[SZPromotionRecordCellViewModel alloc] init];
        SZPromotionRecordModel *model = self.baseListModel.dataList[indexPath.section];
        cellViewModel.model=model;
    }
    return cellViewModel;
}
@end
