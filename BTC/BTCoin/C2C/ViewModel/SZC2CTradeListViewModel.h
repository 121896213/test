//
//  SZC2CTradeListViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZSelectTradeAreaView.h"
@interface SZC2CTradeListViewModel : SZRootViewModel
@property (nonatomic,assign) BOOL isBuy;
@property (nonatomic,assign) SZTradeMarketType marketType;
@property (nonatomic,assign) SZTradeAreaType areaType;
@property (nonatomic,assign) SZTradeType tradeType;
@property (nonatomic,assign) BOOL isOnLine;

@end
