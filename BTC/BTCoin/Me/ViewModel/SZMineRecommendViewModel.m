//
//  SZMineRecommendViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZMineRecommendViewModel.h"

@implementation SZMineRecommendViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentPage=1;
    }
    return self;
}
-(void)getMineRecommendList:(id)parameters{
    
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestMineRecommendRecordsParameter:@{@"currentPage":@(self.currentPage),@"pageSize":@(10)}]subscribeNext:^(id responseDictionary) {
        @strongify(self);
        SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionary];
        if (base.code == 0) {
            SZMineRecommendListModel* listModel=[SZMineRecommendListModel new];
            [listModel mj_setKeyValues:base.data];
            listModel.dataList=[SZMineRecommendModel mj_objectArrayWithKeyValuesArray:listModel.dataList];
            if (listModel.pageIndex == 1) {
                self.baseListModel=listModel;
            }else{
                [self.baseListModel.dataList addObjectsFromArray:listModel.dataList];
            }
            self.currentPage=listModel.pageIndex+1;
            [(RACSubject *) self.successSignal sendNext:nil];
            
        }else{
            [(RACSubject *) self.failureSignal sendNext:base.msg];
        }
    } error:^(NSError *error) {
        @strongify(self);
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];

    }];
    
}


- (SZMineRecommendCellViewModel *)mineRecommendCellViewModellAtIndexPath:(NSIndexPath *)indexPath {
    SZMineRecommendCellViewModel *cellViewModel = nil;
    if (indexPath.section < self.baseListModel.dataList.count) {
        cellViewModel = [[SZMineRecommendCellViewModel alloc] init];
        SZMineRecommendModel *model = self.baseListModel.dataList[indexPath.section];
        cellViewModel.model=model;
    }
    return cellViewModel;
}
@end
