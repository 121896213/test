//
//  SZAddressDetailViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZAddressDetailViewModel.h"

@implementation SZAddressDetailViewModel


-(void)getAddressDetail:(id)parameters{
    
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestAddressDetailWithSymbol:self.coinCellViewModel.model.fid ]subscribeNext:^(id responseDictionary) {
        
        @strongify(self);
        NSInteger code=[responseDictionary[@"code"] integerValue];
        if (code == 0) {
            self.addressDetailArr=[NSMutableArray new];
            NSArray* coinsArr=responseDictionary[@"alls"];
            for (NSDictionary* dictionary in coinsArr) {
                SZAddressDetailModel* addressModel=[SZAddressDetailModel new];
                [addressModel mj_setKeyValues:dictionary];
                [self.addressDetailArr addObject:addressModel];
            }
            [(RACSubject *) self.successSignal sendNext:nil];
        }else{
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject *) self.failureSignal sendNext:errorMessage ];
        }
    } error:^(NSError *error) {
        @strongify(self);
        
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];

    }];
    
    
}

- (SZAddressDetailCellViewModel *)addressDetailCellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    SZAddressDetailCellViewModel *cellViewModel = nil;
    if (indexPath.row < self.addressDetailArr.count) {
        cellViewModel = [[SZAddressDetailCellViewModel alloc] init];
        SZAddressDetailModel *model = self.addressDetailArr[indexPath.row];
        cellViewModel.model=model;
    }
    
    return cellViewModel;
}

@end
