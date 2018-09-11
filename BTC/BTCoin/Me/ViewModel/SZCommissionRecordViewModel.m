//
//  SZCommissionRecordViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZCommissionRecordViewModel.h"


@implementation SZCommissionRecordViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentPage=1;
    }
    return self;
}

-(void)getCommissRecordList:(id)parameters{
    
    NSMutableDictionary* dictionary=[NSMutableDictionary new];
    if (parameters) {
        dictionary=[[NSMutableDictionary alloc]initWithDictionary:parameters];
        [dictionary setValue:@(5) forKey:@"pageSize"];
        [dictionary setValue:@(self.currentPage) forKey:@"pageIndex"];
    }else{
        [dictionary setValue:@(5) forKey:@"pageSize"];
        [dictionary setValue:@(self.currentPage) forKey:@"pageIndex"];
        if (self.beginDate) {
            [dictionary setValue:self.beginDate forKey:@"startTime"];
        }if (self.endDate) {
            [dictionary setValue:self.endDate forKey:@"endTime"];
        }
    }
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestCommissionRecordsParameter:dictionary]subscribeNext:^(id responseDictionary) {
        @strongify(self);
        SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionary];
        if (base.code == 0) {
            SZCommissRecordListModel* listModel=[SZCommissRecordListModel new];
            [listModel mj_setKeyValues:base.data];
            listModel.dataList=[SZCommissRecordModel mj_objectArrayWithKeyValuesArray:listModel.dataList];
            if (listModel.pageIndex == 1) {
                self.baseListModel=listModel;
            }else{
                [self.baseListModel.dataList addObjectsFromArray:listModel.dataList];
            }
            self.currentPage=listModel.pageIndex+1;
            self.beginDate=listModel.startTime;
            self.endDate=listModel.endTime;
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
- (SZCommissionRecordCellViewModel *)commissionRecordCellViewModellAtIndexPath:(NSIndexPath *)indexPath ;
{
    SZCommissionRecordCellViewModel *cellViewModel = nil;
    if (indexPath.section < self.baseListModel.dataList.count) {
        cellViewModel = [[SZCommissionRecordCellViewModel alloc] init];
        SZCommissRecordModel *model = self.baseListModel.dataList[indexPath.section];
        cellViewModel.model=model;
    }
    return cellViewModel;
}
@end
