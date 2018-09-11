//
//  SZBbPropertyCell.h
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyCellViewModel.h"

#define SZBbPropertyCellHeight FIT3(200)
#define SZBbPropertyCellReuseIdentifier  @"SZBbPropertyCellReuseIdentifier"

@interface SZBbPropertyCell : UITableViewCell
@property (nonatomic, strong) SZPropertyCellViewModel *viewModel;

@end
