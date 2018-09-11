//
//  SZOrderListViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/8/29.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZC2COrderModel.h"

@interface SZOrderListViewModel : SZRootViewModel
@property (nonatomic,assign) SZC2COrderStateType orderStateType;
@property (nonatomic,assign) BOOL isAdOrder;

@end
