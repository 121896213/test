//
//  SZPropertyRecordCell.h
//  BTCoin
//
//  Created by Shizi on 2018/5/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyRecordCellViewModel.h"
#define SZPropertyRecordCellHeight  FIT3(213)
#define SZPropertyRecordCellReuseIdentifier  @"SZPropertyRecordCellReuseIdentifier"

@interface SZPropertyRecordCell : UITableViewCell
@property (nonatomic,strong) SZPropertyRecordCellViewModel* viewModel;

@end
