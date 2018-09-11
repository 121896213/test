//
//  SZC2CAdViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdViewModel.h"
#import "SZAdCellModel.h"
@implementation SZC2CAdViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


- (NSMutableArray *)cellModelsArr{
    
    if (!_cellModelsArr) {
        
        _cellModelsArr=[NSMutableArray new];
        NSArray* cellTypesArr=@[@[@(SZAdCellTypeCommonTextFiled),@(SZAdCellTypeCommonTextFiled),@(SZAdCellTypeCommonTextFiled)],@[@(SZAdCellTypeC2cPriceSwitch),@(SZAdCellTypeC2cPremium)],@[@(SZAdCellTypeC2cAmountPart)],@[@(SZAdCellTypeCommonTextFiled),@(SZAdCellTypeCommonTextFiled),@(SZAdCellTypeCommonTextFiled),@(SZAdCellTypeCommonTextFiled),@(SZAdCellTypeCommonTextFiled),@(SZAdCellTypeC2cPayType)]];

        NSArray* titlesArr=@[@[NSLocalizedString(@"交易币种", nil),NSLocalizedString(@"国家", nil),NSLocalizedString(@"货币", nil)],@[NSLocalizedString(@"开启固定价格", nil),NSLocalizedString(@"溢价", nil)],@[NSLocalizedString(@"所属分区", nil)],@[NSLocalizedString(@"交易价格", nil),NSLocalizedString(@"交易数量", nil),NSLocalizedString(@"最小交易额", nil),NSLocalizedString(@"最大交易额", nil),NSLocalizedString(@"收款期限", nil),NSLocalizedString(@"收款方式", nil)]];
        NSArray* placeHoldersArr=@[@[NSLocalizedString(@"请选择交易币种", nil),NSLocalizedString(@"请选择国家", nil),NSLocalizedString(@"请选择货币", nil)],@[NSLocalizedString(@"开启固定价格", nil),NSLocalizedString(@"请输入0-30位整数", nil)],@[NSLocalizedString(@"所属分区", nil)],@[NSLocalizedString(@"请输入交易价格", nil),NSLocalizedString(@"请输入交易数量", nil),NSLocalizedString(@"请输入最小交易额", nil),NSLocalizedString(@"请输入最大交易额", nil),NSLocalizedString(@"请输入15-30(单位:分钟)", nil),NSLocalizedString(@"请输入收款方式", nil)]];
        
        int i=0;
        for (NSArray* arr in cellTypesArr) {
            
            int j=0;
            NSMutableArray* array=[NSMutableArray new];
            for (NSNumber* cellType in arr) {
                SZAdCellModel* cellModel=[SZAdCellModel new];
                SZAdCellType type=(SZAdCellType)[cellType integerValue];
                if (type ==  SZAdCellTypeCommonTextFiled) {
                    cellModel.placeholder=placeHoldersArr[i][j];
                }
                if (i == 0) {
                    cellModel.isRightBtnHidden=NO;
                    cellModel.isTextFieldEnable=NO;
                }else{
                    cellModel.isRightBtnHidden=YES;
                    cellModel.isTextFieldEnable=YES;
                }
                
                cellModel.cellType=type;
                cellModel.title=titlesArr[i][j];
                j++;
                [array addObject:cellModel];
            }
            
            [_cellModelsArr addObject:array];
            i++;
        }
        
        
    }
    return _cellModelsArr;
    
}


@end
