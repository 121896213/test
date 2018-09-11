//
//  SZPropertyWithdrawAddressCell.h
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyWithdrawViewModel.h"
#define SZPropertyWithdrawAddressCellCellHeight FIT(100)
#define SZPropertyWithdrawAddressCellReuseIdentifier  @"SZPropertyWithdrawAddressCellReuseIdentifier"
#define SZPropertyWithdrawAddressCellTextFieldDidChanged  @"SZPropertyWithdrawAddressCellTextFieldDidChanged"
#define SZPropertyWithdrawAddressCellAddressButtonAction  @"SZPropertyWithdrawAddressCellAddressButtonAction"
#define SZPropertyWithdrawAddressCellSaoButtonAction  @"SZPropertyWithdrawAddressCellSaoButtonAction"

@interface SZPropertyWithdrawAddressCell : UITableViewCell
@property (nonatomic,strong) SZPropertyWithdrawViewModel* withdrawViewModel;
@property (nonatomic,strong)UIButton* addressButton;
@property (nonatomic,strong)UIButton* saoButton;
@end
