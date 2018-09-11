//
//  SZScPropertyRecordCell.h
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZScPropertyRecordCellViewModel.h"

#define SZScPropertyRecordCellHeight  FIT3(297)
#define SZScPropertyRecordCellReuseIdentifier  @"SZScPropertyRecordCellReuseIdentifier"
@interface SZScPropertyRecordCell : UITableViewCell

@property (nonatomic,strong) SZScPropertyRecordCellViewModel* viewModel;

@end
