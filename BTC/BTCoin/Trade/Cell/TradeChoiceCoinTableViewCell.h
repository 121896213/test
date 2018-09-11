//
//  TradeChoiceCoinTableViewCell.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketHomeListModel.h"

#define kTradeChoiceCoinTableViewCellReuseID @"kTradeChoiceCoinTableViewCellReuseID"
@interface TradeChoiceCoinTableViewCell : UITableViewCell

-(void)setMarketModel:(MarketHomeListModel *)model;

@end
