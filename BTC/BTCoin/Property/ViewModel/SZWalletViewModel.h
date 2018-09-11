//
//  SZWalletViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZWalletModel.h"
#import "SZWalletCellViewModel.h"
@interface SZWalletViewModel : SZRootViewModel
@property (nonatomic,strong) SZWalletListModel* listModel;
- (SZWalletCellViewModel *)walletCellAtIndexPath:(NSIndexPath *)indexPath ;
-(void)getWalletListWithParameters:(id)parameters;
@end
