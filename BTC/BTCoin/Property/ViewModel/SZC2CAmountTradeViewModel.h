//
//  SZC2CAmountTradeViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZPropertyCellViewModel.h"
typedef enum : NSUInteger {
    SZC2CAmountTradeTypeOut=1,
    SZC2CAmountTradeTypeIn=2,

} SZC2CAmountTradeType;

@interface SZC2CAmountTradeViewModel : SZRootViewModel
@property (nonatomic,strong) SZPropertyCellViewModel* cellViewModel;
@property (nonatomic,assign) SZC2CAmountTradeType amountTradeType;
@property (nonatomic,copy) NSString* tradeAmount;
@property (nonatomic,copy) NSString* tradePassword;
@property (nonatomic,copy) SZBaseListModel* listModel;
@property (nonatomic,strong)SZBBPropertyModel* bbPropertyModel;

-(void)requestUserWalletWithParameter:(id)parameter;
-(void)requestC2CBBTransfersWithParameter:(id)parameter;
@end
