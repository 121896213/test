//
//  SZC2CStateOrderIdCell.h
//  BTCoin
//
//  Created by sumrain on 2018/8/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZC2CTradeStateViewModel.h"

#define SZC2CStateOrderIdCellHeight FIT(90)
#define SZC2CStateOrderIdCellReuseIdentifier  @"SZC2CStateOrderIdCellReuseIdentifier"
@interface SZC2CStateOrderIdCell : UITableViewCell
-(void)setContent:(SZC2CTradeStateViewModel*)viewModel;
@end
