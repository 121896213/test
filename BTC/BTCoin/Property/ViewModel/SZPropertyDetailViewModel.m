//
//  SZPropertyDetailViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//
#import "SZWalletModel.h"
#import "SZPropertyDetailViewModel.h"
@implementation SZPropertyDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentPage=1;
        self.recordsArr=[NSMutableArray new];
    }
    return self;
}


-(void)requestPropertyRecords:(id)parameters{
    
    
    if (self.cellViewModel.walletType == SZWalletTypeBB) {
        NSInteger currentPage=[parameters[@"currentPage"] integerValue];
        NSInteger currentRecordType=[parameters[@"recordType"] integerValue];
        
        NSString *urlString = [NSString stringWithFormat:@"%@/account/refTenbody.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlString appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            BaseModel * base = [BaseModel modelWithJson:responseObject];
            if (base.code == 0) {
                
                if (currentRecordType !=self.currentType){
                    [_recordsArr removeAllObjects];
                    _currentPage=1;
                    _currentType=currentRecordType;
                }else{
                    if (currentPage == 1) {
                        [_recordsArr removeAllObjects];
                    }
                }
                NSArray * array = responseObject[@"list"];
                if (array.count) {
                    _currentPage+=1;
                }
                for (NSDictionary * dict in array) {
                    SZPropertyRecordModel * model = [SZPropertyRecordModel new];
                    [model mj_setKeyValues:dict];
                    [self.recordsArr addObject:model];
                }
                [(RACSubject *) self.successSignal sendNext:base.msg];
            }else{
                [(RACSubject *) self.failureSignal sendNext:base.msg];
            }
        } failureBlock:^(NSError *error) {
            [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
        }];
    }else if (self.cellViewModel.walletType == SZWalletTypeSC){

        [[[SZHttpsService sharedSZHttpsService] signalRequestGetScPropertyDetailParameter:@{@"currentPage":@(self.currentPage) ,@"pageSize":@"15",@"accountId":self.cellViewModel.scPropertyModel.scID}]subscribeNext:^(id responseDictionray) {
            SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionray];
            if (base.code == 0) {
                SZBaseListModel* listModel=[SZBaseListModel new];
                [listModel mj_setKeyValues:base.data];
                listModel.dataList=[SZScPropertyRecordModel mj_objectArrayWithKeyValuesArray:listModel.dataList];
                if (listModel.pageIndex == 1) {
                    self.scRecordArr=listModel.dataList;
                }else{
                    [self.scRecordArr addObjectsFromArray:listModel.dataList];
                }
                self.currentPage=listModel.pageIndex+1;
                [(RACSubject *) self.successSignal sendNext:nil];
            }else{
                [(RACSubject *) self.failureSignal sendNext:base.msg];
            }
        } error:^(NSError *error) {
            [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
        }];
    }else if (self.cellViewModel.walletType == SZWalletTypeC2C){
        
        [[[SZHttpsService sharedSZHttpsService] signalRequestGetC2CPropertyDetailParameter:@{@"pageIndex":@(self.currentPage) ,@"pageSize":@"15",@"currencyName":self.cellViewModel.c2cPropertyModel.fvirtualcointypeName,@"currencyId":self.cellViewModel.c2cPropertyModel.fvirtualcointypeId}]subscribeNext:^(id responseDictionray) {
            SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionray];
            if (base.code == 0) {
                SZBaseListModel* listModel=[SZBaseListModel new];
                [listModel mj_setKeyValues:base.data];
                listModel.dataList=[SZC2CPropertyRecordModel mj_objectArrayWithKeyValuesArray:listModel.dataList];
                if (listModel.pageIndex == 1) {
                    self.c2cRecordArr=listModel.dataList;
                }else{
                    [self.c2cRecordArr addObjectsFromArray:listModel.dataList];
                }
                self.currentPage=listModel.pageIndex+1;
                [(RACSubject *) self.successSignal sendNext:nil];
            }else{
                [(RACSubject *) self.failureSignal sendNext:base.msg];
            }
        } error:^(NSError *error) {
            [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
        }];
    }

}

-(NSInteger)getPropertyRecordCellNumber{
    if (self.cellViewModel.walletType == SZWalletTypeBB) {
        return self.recordsArr.count;
    }else if (self.cellViewModel.walletType == SZWalletTypeSC){
       return self.scRecordArr.count;
    }else{
        return self.c2cRecordArr.count;
    }
}
- (SZPropertyRecordCellViewModel *)recordCellViewModelAtIndexPath:(NSIndexPath *)indexPath{
    
    SZPropertyRecordCellViewModel *cellViewModel = nil;
    if (indexPath.section < self.recordsArr.count) {
        cellViewModel = [[SZPropertyRecordCellViewModel alloc] init];
        SZPropertyRecordModel *model = self.recordsArr[indexPath.section];
        cellViewModel.model=model;
    }
    
    return cellViewModel;
}

- (SZScPropertyRecordCellViewModel *)recordSzCellViewModelAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellViewModel.walletType == SZWalletTypeSC){
        SZScPropertyRecordCellViewModel *cellViewModel = nil;
        if (indexPath.section < self.scRecordArr.count) {
            cellViewModel = [[SZScPropertyRecordCellViewModel alloc] init];
            SZScPropertyRecordModel *model = self.scRecordArr[indexPath.section];
            cellViewModel.model=model;
        }
        
        return cellViewModel;
        
    }else{
        SZScPropertyRecordCellViewModel *cellViewModel = nil;
        if (indexPath.section < self.c2cRecordArr.count) {
            cellViewModel = [[SZScPropertyRecordCellViewModel alloc] init];
            SZScPropertyRecordModel *model = self.c2cRecordArr[indexPath.section];
            cellViewModel.c2cRecordModel=model;
        }
        return cellViewModel;
        
    }

}
@end
