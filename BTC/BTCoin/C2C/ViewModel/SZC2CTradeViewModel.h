//
//  SZC2CTradeViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"

@interface SZC2CTradeViewModel : SZRootViewModel
@property (nonatomic, assign)BOOL isTradeSell;
@property (nonatomic, copy)NSString* tradeCount;
@property (nonatomic, copy)NSString* tradeAmount;

@end
