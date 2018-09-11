//
//  SZPropertyCellViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/8.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZBBPropertyModel.h"
#import "SZBaseListModel.h"
#import "SZSCPropertyModel.h"
#import "SZWalletModel.h"
#import "SZC2CPropertyModel.h"
@interface SZPropertyCellViewModel : SZRootViewModel
@property (nonatomic, assign) SZWalletType walletType;

@property (nonatomic, strong) SZBBPropertyModel *bbPropertyModel;
@property (nonatomic, strong) SZSCPropertyModel *scPropertyModel;
@property (nonatomic, strong) SZC2CPropertyModel *c2cPropertyModel;

@end
