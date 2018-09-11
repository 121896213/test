//
//  SZWithdrawCountCell.h
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyCellViewModel.h"
#import "SZPropertyWithdrawViewModel.h"
#define SZWithdrawCountCellHeight FIT(100)
#define SZWithdrawCountCellReuseIdentifier  @"SZWithdrawCountCellReuseIdentifier"
#define SZWithdrawCountCellTextFieldDidChanged @"SZWithdrawCountCellTextFieldDidChanged"

@interface SZWithdrawCountCell : UITableViewCell
@property (nonatomic,strong) SZPropertyCellViewModel* viewModel;
@property (nonatomic,strong) SZPropertyWithdrawViewModel* withdrawViewModel;
@end
