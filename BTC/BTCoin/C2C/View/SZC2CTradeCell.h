//
//  SZC2CTradeCell.h
//  BTCoin
//
//  Created by sumrain on 2018/7/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SZC2CTradeCellHeight FIT(126)
#define SZC2CTradeCellReuseIdentifier  @"SZC2CTradeCellReuseIdentifier"
typedef void(^Action)(id sender);
@interface SZC2CTradeCell : UITableViewCell
@property (nonatomic,copy) Action action;
@end
