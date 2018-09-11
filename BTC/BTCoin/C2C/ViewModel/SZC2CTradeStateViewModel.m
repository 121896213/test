//
//  SZC2CTradeStateViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CTradeStateViewModel.h"
@implementation SZC2CTradeStateViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    
    return self;
}

-(NSArray *)titlesArr{
    
    if (!_titlesArr) {
        _titlesArr=[NSArray new];
    
        
        if (_orderState == SZC2COrderStateSellerToBePay ) {
            
            _titlesArr=@[@[NSLocalizedString(@"卖出USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"待付款时间", nil)],@[NSLocalizedString(@"提醒买家付款", nil)]];
            
        }else if (_orderState == SZC2COrderStateSellerPaying) {
            
             _titlesArr=@[@[NSLocalizedString(@"卖出USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"待付款时间", nil)],@[NSLocalizedString(@"买家付款中", nil)]];
            
        }else if (_orderState == SZC2COrderStateSellerPayDone ) {
            
            _titlesArr=@[@[NSLocalizedString(@"卖出USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"付款参考号", nil),NSLocalizedString(@"付款状态",nil)],@[NSLocalizedString(@"确认付款,释放USDT", nil),NSLocalizedString(@"我要申诉", nil)]];
            
        }else if (_orderState == SZC2COrderStateSellerComplete) {
            
            _titlesArr=@[@[NSLocalizedString(@"卖出USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"付款参考号", nil),NSLocalizedString(@"付款状态",nil)],@[NSLocalizedString(@"已完成", nil)]];
            
        }else if (_orderState == SZC2COrderStateAppeal) {
            
            _titlesArr=@[@[NSLocalizedString(@"卖出USDT", nil),NSLocalizedString(@"成交价格", nil),NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil)],@[NSLocalizedString(@"申诉描述", nil),NSLocalizedString(@"上传资料", nil),NSLocalizedString(@"上传截图", nil),NSLocalizedString(@"提交", nil),NSLocalizedString(@"温馨提示", nil)]];
            
        }else if (_orderState == SZC2COrderStateAppealing) {
            
            _titlesArr=@[@[NSLocalizedString(@"卖出USDT", nil),NSLocalizedString(@"成交价格", nil),NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil)],@[NSLocalizedString(@"申诉描述", nil),NSLocalizedString(@"证明资料", nil),NSLocalizedString(@"申诉中", nil),NSLocalizedString(@"温馨提示", nil)]];
            
        }else if (_orderState == SZC2COrderStateBuyerConfirmPay) {
            
            _titlesArr=@[@[NSLocalizedString(@"买入USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"付款方式", nil),NSLocalizedString(@"付款参考号", nil)],@[NSLocalizedString(@"确认付款(2分59秒)", nil),NSLocalizedString(@"取消交易", nil),NSLocalizedString(@"交易提醒", nil)]];
            
        }else if (_orderState == SZC2COrderStateBuyerToBeTradeOut ) {
            
             _titlesArr=@[@[NSLocalizedString(@"买入USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"付款参考号", nil)],@[NSLocalizedString(@"提醒卖家，释放USDT", nil),NSLocalizedString(@"取消交易", nil),NSLocalizedString(@"交易提醒", nil)]];
            
        }else if (_orderState == SZC2COrderStateBuyerTradingOut) {
            
            _titlesArr=@[@[NSLocalizedString(@"买入USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"付款参考号", nil)],@[NSLocalizedString(@"卖家正在发币中", nil),NSLocalizedString(@"取消交易", nil),NSLocalizedString(@"交易提醒", nil)]];
                        
        }else if (_orderState == SZC2COrderStateBuyerFinish) {
            
           _titlesArr=@[@[NSLocalizedString(@"买入USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"付款参考号", nil),NSLocalizedString(@"付款状态", nil)],@[NSLocalizedString(@"已完成", nil),NSLocalizedString(@"取消交易                           我要申诉", nil),NSLocalizedString(@"交易提醒", nil)]];
            
        }else if (_orderState == SZC2COrderStateBuyerCancelDone) {
            
           _titlesArr=@[@[NSLocalizedString(@"买入USDT", nil),NSLocalizedString(@"成交价格", nil)],@[NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"付款参考号", nil),NSLocalizedString(@"付款状态", nil)],@[NSLocalizedString(@"已取消", nil)]];
            
        }else{
            
        }
 
        
    }
    return _titlesArr;
    
}
-(NSArray *)cellTypesArr{
    if (!_cellTypesArr) {
        _cellTypesArr=[NSArray new];
        if (_orderState == SZC2COrderStateSellerToBePay ) {
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction)]];
            
        }else if (_orderState == SZC2COrderStateSellerPaying) {
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction)]];
            
        }else if (_orderState == SZC2COrderStateSellerPayDone ) {
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypeHandleAction)]];
            
        }else if (_orderState == SZC2COrderStateSellerComplete) {
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction)]];
            
        }else if (_orderState == SZC2COrderStateAppeal) {
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeAppealDesc),@(SZOrderStateCellTypeAppealDemo),@(SZOrderStateCellTypeAppealInfo),@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypePrompt)]];
            
        }else if (_orderState == SZC2COrderStateAppealing) {
            _titlesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeAppealDesc),@(SZOrderStateCellTypeAppealInfo),@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypePrompt)]];
            
        }else if (_orderState == SZC2COrderStateBuyerConfirmPay) {
            
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypePayType),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypePrompt)]];
            
        }else if (_orderState == SZC2COrderStateBuyerToBeTradeOut ) {
            
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypePrompt)]];
            
        }else if (_orderState == SZC2COrderStateBuyerTradingOut) {
            
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypePrompt)]];
            
        }else if (_orderState == SZC2COrderStateBuyerFinish) {
            
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypeHandleAction),@(SZOrderStateCellTypePrompt)]];
            
        }else if (_orderState == SZC2COrderStateBuyerCancelDone) {
            
            _cellTypesArr=@[@[@(SZOrderStateCellTypeOrderId),@(SZOrderStateCellTypePrice)],@[@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon),@(SZOrderStateCellTypeCommon)],@[@(SZOrderStateCellTypeHandleAction)]];
            
        }else{
            
        }
        
    }
    return _cellTypesArr;
    
    
}
-(NSMutableArray *)cellModelArr{
    
    if (!_cellModelArr) {
        _cellModelArr=[NSMutableArray new];
        
        
        if (_isBuyIn) {
            if (_orderStateType == SZC2COrderStateTypeToBePay) {
                
                _orderState=SZC2COrderStateBuyerConfirmPay;
                
            }else if (_orderStateType == SZC2COrderStateTypePayDone){
                
                _orderState=SZC2COrderStateBuyerToBeTradeOut;//|SZC2COrderStateBuyerTradingOut;
                
            }else if (_orderStateType == SZC2COrderStateTypeFinished){
                
                _orderState=SZC2COrderStateBuyerFinish;
                
            }else if(_orderStateType == SZC2COrderStateTypeCancel){
                
                _orderState=SZC2COrderStateBuyerCancelDone;
                
            }else if (_orderStateType == SZC2COrderStateTypeAppeal){
                
                _orderState=SZC2COrderStateAppeal;//|SZC2COrderStateAppealing;
                
            }
            
        }else{
            
            if (_orderStateType == SZC2COrderStateTypeToBePay) {
                
                _orderState=SZC2COrderStateSellerToBePay ;//| SZC2COrderStateSellerPaying;
                
            }else if (_orderStateType == SZC2COrderStateTypePayDone){
                
                _orderState=SZC2COrderStateSellerPayDone;
                
            }else if (_orderStateType == SZC2COrderStateTypeFinished){
                
                _orderState=SZC2COrderStateSellerComplete;
                
            }else if(_orderStateType == SZC2COrderStateTypeCancel){
                
                _orderState=SZC2COrderStateBuyerCancelDone;

            }else if (_orderStateType == SZC2COrderStateTypeAppeal){
                
                _orderState=SZC2COrderStateAppeal;//|SZC2COrderStateAppealing;
                
            }
        }
        
        
        NSLog(@"_orderState:%ld",_orderState);
        NSLog(@"_isBuyIn:%d",_isBuyIn);
        int i=0;
        for (NSArray* arr in self.cellTypesArr) {
            int j=0;
            NSMutableArray* array=[NSMutableArray new];
            for (NSNumber* cellType in arr) {
                SZOrderStateCellModel* cellModel=[SZOrderStateCellModel new];
                SZOrderStateCellType type=(SZOrderStateCellType)[cellType integerValue];
                cellModel.cellType=type;
                cellModel.title=self.titlesArr[i][j];
                j++;
                [array addObject:cellModel];
            }
            
            [_cellModelArr addObject:array];
            i++;
        }
    }
    return _cellModelArr;
    
}

@end
