//
//  SZAddressListCellViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZCoinAddressModel.h"
@interface SZAddressListCellViewModel : SZRootViewModel
@property (nonatomic, strong) SZCoinAddressModel *model;

@end
