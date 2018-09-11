//
//  SZPropertyViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyViewModel.h"
#import "SZPropertyTypeListModel.h"
#import "SZBBPropertyModel.h"
#import "SZPropertyCellViewModel.h"
#import "SZBaseListModel.h"
#import "SZScPropertyCell.h"
#import "SZBbPropertyCell.h"
@implementation SZPropertyViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentPage=1;
    }
    return self;
}
-(void)getPropertyListWithParameters:(id)parameters{

    if (self.walletType == SZWalletTypeBB) {
        [[[SZHttpsService sharedSZHttpsService] signalRequestPropertyListWithParameter:parameters]subscribeNext:^(id responseDictionray) {
            if ([responseDictionray[@"code"] integerValue] == 0) {
                self.listModel=[SZPropertyTypeListModel new];
                self.listModel.modelTypeList=[NSMutableArray new];
                self.listModel.totalCapital = [NSString stringWithFormat:@"%@",responseDictionray[@"totalCapital"]];
                self.listModel.totalNet= [NSString stringWithFormat:@"%@",responseDictionray[@"totalNet"] ];
                NSArray* propertyTypes=responseDictionray[@"wallets"];
                for (NSDictionary* dictionary in propertyTypes) {
                    SZBBPropertyModel* propertybbPropertyModel= [SZBBPropertyModel  new];
                    [propertybbPropertyModel mj_setKeyValues:dictionary];
                    [self.listModel.modelTypeList addObject:propertybbPropertyModel];
                }
                [(RACSubject *) self.successSignal sendNext:nil];
            }else{
                NSString* errorMessage=responseDictionray[@"msg"];
                [(RACSubject *) self.failureSignal sendNext:errorMessage];
            }
        } error:^(NSError *error) {
            [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
            
        }];
    } else if (self.walletType == SZWalletTypeSC){
        
        
        [[[SZHttpsService sharedSZHttpsService] signalRequestGetScPropertyListParameter:@{@"currentPage":@(self.currentPage),@"pageSize":@(10)}]subscribeNext:^(id responseDictionray) {
            
            SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionray];
            if (base.code == 0) {
                
                SZBaseListModel* listModel=[SZBaseListModel new];
                [listModel mj_setKeyValues:base.data];
                listModel.dataList=[SZSCPropertyModel mj_objectArrayWithKeyValuesArray:listModel.dataList];
                if (listModel.pageIndex == 1) {
                    self.scListModel=listModel;
                }else{
                    [self.scListModel.dataList addObjectsFromArray:listModel.dataList];
                }
                self.currentPage=listModel.pageIndex+1;
                NSInteger i =0;
                for (SZSCPropertyModel* scModel in listModel.dataList) {
                    scModel.scID=base.data[@"dataList"][i][@"id"];
                    i++;
                }
                [(RACSubject *) self.successSignal sendNext:nil];
                
            }else{
                [(RACSubject *) self.failureSignal sendNext:base.msg];
            }
        } error:^(NSError *error) {
            [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
        }];
    
    }  else {
        [[[SZHttpsService sharedSZHttpsService] signalRequestGetC2CPropertyListParameter:parameters]subscribeNext:^(id responseDictionray) {
            SZBaseModel * base = [SZBaseModel modelWithJson:responseDictionray];
            if (base.code == 0) {
                
                SZBaseListModel* listModel=[SZBaseListModel new];
                [listModel mj_setKeyValues:base.data];
                listModel.dataList=[SZC2CPropertyModel  mj_objectArrayWithKeyValuesArray:listModel.dataList];
                self.c2cListModel=listModel;
                [(RACSubject *) self.successSignal sendNext:nil];
                
            }else{
                [(RACSubject *) self.failureSignal sendNext:base.msg];
            }
            
        } error:^(NSError *error) {
            [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
            
        }];
    }
}

-(NSInteger)getPropertyCellNumber{
    if (self.walletType == SZWalletTypeC2C) {
        return self.c2cListModel.dataList.count;
    }else if(self.walletType == SZWalletTypeBB){
        return self.listModel.modelTypeList.count;
    }else{
        return self.scListModel.dataList.count;
    }
}
-(CGFloat)getPropertyCellHeight{
    if (self.walletType == SZWalletTypeC2C) {
        return SZBbPropertyCellHeight;
    }else if(self.walletType == SZWalletTypeBB){
        return SZBbPropertyCellHeight;
    }else{
        return SZScPropertyCellHeight;
    }
}
- (SZPropertyCellViewModel *)propertyCellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    SZPropertyCellViewModel *cellViewModel = nil;
    if (self.walletType == SZWalletTypeC2C) {
        if (indexPath.section < self.c2cListModel.dataList.count) {
            cellViewModel = [[SZPropertyCellViewModel alloc] init];
            SZC2CPropertyModel *model = self.c2cListModel.dataList[indexPath.section];
            cellViewModel.c2cPropertyModel=model;
        }
    }
    else if (self.walletType == SZWalletTypeBB) {
        if (indexPath.section < self.listModel.modelTypeList.count) {
            cellViewModel = [[SZPropertyCellViewModel alloc] init];
            SZBBPropertyModel *bbPropertyModel = self.listModel.modelTypeList[indexPath.section];
            cellViewModel.bbPropertyModel=bbPropertyModel;
        }
    }else{
        if (indexPath.section < self.scListModel.dataList.count) {
            cellViewModel = [[SZPropertyCellViewModel alloc] init];
            SZSCPropertyModel *bbPropertyModel = self.scListModel.dataList[indexPath.section];
            cellViewModel.scPropertyModel=bbPropertyModel;
        }
    }
    return cellViewModel;
}

@end
