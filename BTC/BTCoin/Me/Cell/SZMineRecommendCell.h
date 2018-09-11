//
//  SZMineRecommendCell.h
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZMineRecommendCellViewModel.h"
#define SZMineRecommendCelllHight FIT3(364)

#define SZMineRecommendCellReuseIdentifier  @"SZMineRecommendCellReuseIdentifier"
@interface SZMineRecommendCell : UITableViewCell
@property (strong,nonatomic) SZMineRecommendCellViewModel* viewModel;

@end
