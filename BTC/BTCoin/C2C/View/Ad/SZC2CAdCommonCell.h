//
//  SZC2CAdCommonCell.h
//  BTCoin
//
//  Created by sumrain on 2018/7/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZAdCellModel.h"

#define SZC2CAdCommonCellHeight FIT(50)
#define SZC2CAdCommonCellReuseIdentifier  @"SZC2CAdCommonCellReuseIdentifier"

@interface SZC2CAdCommonCell : UITableViewCell
@property (nonatomic, strong) SZAdCellModel *cellModel;

@end
