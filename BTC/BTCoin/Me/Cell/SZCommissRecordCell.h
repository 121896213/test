//
//  SZCommissRecordCell.h
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCommissionRecordCellViewModel.h"
#define SZCommissRecordCelllHight FIT3(434)
#define SZCommissRecordCellReuseIdentifier  @"SZCommissRecordCellReuseIdentifier"

@interface SZCommissRecordCell : UITableViewCell
@property (strong,nonatomic) SZCommissionRecordCellViewModel* viewModel;
@end
