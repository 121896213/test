//
//  SZPromotionRecordCell.h
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPromotionRecordCellViewModel.h"
#define SZPromotionRecordCelllHight FIT3(364)
#define SZPromotionRecordCellReuseIdentifier  @"SZPromotionRecordCellReuseIdentifier"

@interface SZPromotionRecordCell : UITableViewCell

@property (nonatomic,strong) SZPromotionRecordCellViewModel* viewModel;

@end
