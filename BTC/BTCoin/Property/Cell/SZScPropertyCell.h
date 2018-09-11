//
//  SZScPropertyCell.h
//  BTCoin
//
//  Created by sumrain on 2018/6/29.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyCellViewModel.h"

#define SZScPropertyCellHeight FIT3(275)
#define SZScPropertyCellReuseIdentifier  @"SZScPropertyCellReuseIdentifier"
@interface SZScPropertyCell : UITableViewCell
@property (nonatomic, strong) SZPropertyCellViewModel *viewModel;

@end
