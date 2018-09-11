//
//  SZWalletViewCell.h
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZWalletCellViewModel.h"
#define SZWalletViewCellHeight FIT(200)
#define SZWalletViewCellReuseIdentifier  @"SZWalletViewCellReuseIdentifier"
@interface SZWalletViewCell : UITableViewCell
@property (nonatomic,strong) SZWalletCellViewModel* viewModel;
-(void)setCellContent:(NSIndexPath*)indexPath;
@end
