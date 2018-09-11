//
//  TradeSevenTableViewCell.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/4.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SevenBuyOrSelDataModel.h"

typedef NS_ENUM(NSInteger,TradeSevenTableViewCellType) {
    TradeSevenTableViewCellTypeBuy,
    TradeSevenTableViewCellTypeSel,
    TradeSevenTableViewCellTypeTitle
};

#define kTradeSevenTableViewCellReusedID @"kTradeSevenTableViewCellReusedID"
@interface TradeSevenTableViewCell : UITableViewCell

@property (nonatomic,assign)TradeSevenTableViewCellType cellType;
-(void)setMarket:(NSString *)market andCoinName:(NSString *)coinName;
-(void)setCellWithModel:(SevenBuyOrSelDataModel *)model;

@end
