//
//  SZAddressListViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZAddressListViewModel.h"
#import "SZCoinAddressModel.h"
#import "SZAddressListCellViewModel.h"
@implementation SZAddressListViewModel


-(void)getAddressList:(id)parameters{
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestGetCoinListWithParameter:parameters]subscribeNext:^(id responseDictionary) {
        @strongify(self);
        self.addressListArr=[NSMutableArray new];
        NSInteger code=[responseDictionary[@"code"] integerValue];
        if (code == 0) {
            NSArray* coinsArr=responseDictionary[@"alls"];
            for (NSDictionary* dictionary in coinsArr) {
                SZCoinAddressModel* addressModel=[SZCoinAddressModel new];
                [addressModel mj_setKeyValues:dictionary];
                [self.addressListArr addObject:addressModel];
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
- (SZAddressListCellViewModel *)addressListCellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    SZAddressListCellViewModel *cellViewModel = nil;
    if (indexPath.row < self.addressListArr.count) {
        cellViewModel = [[SZAddressListCellViewModel alloc] init];
        SZCoinAddressModel *model = self.addressListArr[indexPath.row];
        cellViewModel.model=model;
    }
    return cellViewModel;
}


@end
