//
//  SZC2COrderModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"

typedef enum : NSUInteger {
    SZC2COrderStateTypeToBePay,
    SZC2COrderStateTypePayDone,
    SZC2COrderStateTypeFinished,
    SZC2COrderStateTypeCancel,
    SZC2COrderStateTypeAppeal,
} SZC2COrderStateType;

typedef enum : NSUInteger {
    //卖方状态
    SZC2COrderStateSellerToBePay,
    SZC2COrderStateSellerPaying,
    SZC2COrderStateSellerPayDone,
    SZC2COrderStateSellerComplete,
    
    SZC2COrderStateBuyerConfirmPay,
    SZC2COrderStateBuyerToBeTradeOut,
    SZC2COrderStateBuyerTradingOut,
    SZC2COrderStateBuyerFinish,
    SZC2COrderStateBuyerCancelDone,
    
    SZC2COrderStateAppeal,
    SZC2COrderStateAppealing,


} SZC2COrderState;

@interface SZC2COrderModel : SZBaseModel

@end
