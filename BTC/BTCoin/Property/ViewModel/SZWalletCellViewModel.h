//
//  SZWalletCellViewModel.h
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZWalletModel.h"
@interface SZWalletCellViewModel : SZRootViewModel
@property (nonatomic,strong) SZWalletModel *walletModel;
@end
