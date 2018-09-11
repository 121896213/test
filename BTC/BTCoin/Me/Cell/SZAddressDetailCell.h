//
//  SZAddressDetailCell.h
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZAddressDetailCellViewModel.h"
#define SZAddressDetailCellHeight FIT3(200)

#define SZAddressDetailCellReuseIdentifier  @"SZAddressDetailCellReuseIdentifier"
@interface SZAddressDetailCell : UITableViewCell
@property (nonatomic,strong) SZAddressDetailCellViewModel* viewModel;
@end
