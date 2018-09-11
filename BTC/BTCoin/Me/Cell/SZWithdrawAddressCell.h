//
//  SZWithdrawAddressCell.h
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZAddressListCellViewModel.h"
#define SZWithdrawAddressCellHeight FIT3(146)

#define SZWithdrawAddressCellReuseIdentifier  @"SZWithdrawAddressCellReuseIdentifier"
@interface SZWithdrawAddressCell : UITableViewCell
@property (nonatomic,strong) UILabel* coinTypeLab;
@property (nonatomic,strong) UILabel* coinTypeCountLab;
@property (nonatomic,strong) SZAddressListCellViewModel* viewModel;
@property (nonatomic,strong) UITextField* textFiled;
-(void)setAmountTradeCellStyle:(NSIndexPath*)indexPath;
-(void)setAboutUSCellStyle:(NSIndexPath*)indexPath;
@end
