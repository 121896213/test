//
//  TradeCommonModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketHomeListModel.h"

/**交易区公共类*/
@interface TradeCommonModel : NSObject

DEFINE_SINGLETON_FOR_HEADER(TradeCommonModel)

@property (nonatomic,copy)NSString * areaName;//当前选择的大区名
@property (nonatomic,strong)MarketHomeListModel * model;
@property (nonatomic,assign)TradeVCType tradeVCType;

@property (nonatomic,assign)BOOL needSetDefaultBuyState;//切换大区设置默认状态
@property (nonatomic,assign)BOOL needSetDefaultSellState;//切换大区设置默认状态
@end
