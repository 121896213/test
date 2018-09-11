//
//  SZWithdrawPasswordCell.h
//  BTCoin
//
//  Created by Shizi on 2018/5/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyWithdrawViewModel.h"

#define SZWithdrawPasswordCellCellHeight FIT(100)
#define SZWithdrawPasswordCellReuseIdentifier  @"SZWithdrawPasswordCellReuseIdentifier"
#define SZWithdrawPasswordCellTextFieldDidChanged @"SZWithdrawPasswordCellTextFieldDidChanged"
@interface SZWithdrawPasswordCell : UITableViewCell
@property (nonatomic,strong) SZPropertyWithdrawViewModel* withdrawViewModel;
@end
