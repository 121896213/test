//
//  SZC2CTradeStateViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZC2COrderModel.h"
#import "SZOrderStateCellModel.h"

@interface SZC2CTradeStateViewModel : SZRootViewModel
@property (nonatomic, assign)SZC2COrderStateType orderStateType;
@property (nonatomic, assign)SZC2COrderState orderState;

@property (nonatomic, assign)BOOL isBuyIn;
@property (nonatomic, copy)NSArray *titlesArr;
@property (nonatomic, copy)NSArray *cellTypesArr;
@property (nonatomic, strong)NSMutableArray *cellModelArr;

@end
