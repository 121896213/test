//
//  SevenBuyOrSelDataModel.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SevenBuyOrSelDataModel.h"

@implementation SevenBuyOrSelDataModel

+(NSArray *)getDefaultNodata
{
    NSMutableArray * sonArr_buy = [NSMutableArray array];
    NSMutableArray * sonArr_sel = [NSMutableArray array];
    for (int i = 7; i>0; i--) {
        SevenBuyOrSelDataModel * model = [SevenBuyOrSelDataModel new];
        model.title = [NSString stringWithFormat:@"%@%d",NSLocalizedString(@"卖", nil),i];
        model.price = @"--";
        model.volume = @"--";
        [sonArr_sel addObject:model];
    }
    for (int i = 1; i<8; i++) {
        SevenBuyOrSelDataModel * model = [SevenBuyOrSelDataModel new];
        model.title = [NSString stringWithFormat:@"%@%d",NSLocalizedString(@"买", nil),i];
        model.price = @"--";
        model.volume = @"--";
        [sonArr_buy addObject:model];
    }
    return @[sonArr_sel,sonArr_buy];
}

+(NSArray *)dealDataFromSocket:(id)socketMessgae compareModel:(MarketHomeListModel *)ruleModel
{
    NSDictionary * dict = [NSDictionary dictionaryWithJsonString:socketMessgae];
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        if ([[dict objectForKey:@"ID"] integerValue] != [ruleModel.fCoinType integerValue]) {
            return [self getDefaultNodata];
        }
        if ([dict objectForKey:@"B"] && [dict objectForKey:@"S"])
        {
            NSMutableArray * sonArr_buy = [NSMutableArray array];
            NSMutableArray * sonArr_sel = [NSMutableArray array];
            NSArray * arrbuy = [dict objectForKey:@"B"];
            NSArray * arrSel = [dict objectForKey:@"S"];
            
            for (int i = 6; i>=0; i--) {
                SevenBuyOrSelDataModel * model = [SevenBuyOrSelDataModel new];
                model.title = [NSString stringWithFormat:@"%@%d",NSLocalizedString(@"卖", nil),i+1];
                NSDictionary * dict = arrSel[i];
                model.price = [self stringFromDecimal:dict[@"P"] andPrecision:ruleModel.fcount1];
                model.volume = [self stringFromDecimal:dict[@"V"] andPrecision:ruleModel.fcount2];
                [sonArr_sel addObject:model];
            }
            for (int i = 0; i<7; i++) {
                SevenBuyOrSelDataModel * model = [SevenBuyOrSelDataModel new];
                model.title = [NSString stringWithFormat:@"%@%d",NSLocalizedString(@"买", nil),i+1];
                NSDictionary * dict = arrbuy[i];
                model.price = [self stringFromDecimal:dict[@"P"] andPrecision:ruleModel.fcount1];
                model.volume = [self stringFromDecimal:dict[@"V"] andPrecision:ruleModel.fcount2];
                [sonArr_buy addObject:model];
            }
            return @[sonArr_sel,sonArr_buy];
        }
    }
    return [self getDefaultNodata];
}
//+(NSArray *)dealDataFromSocket:(id)socketMessgae compareModel:(MarketHomeListModel *)ruleModel
//{
//    NSDictionary * dict = [NSDictionary dictionaryWithJsonString:socketMessgae];
//    if ([dict isKindOfClass:[NSDictionary class]])
//    {
//        if ([[dict objectForKey:@"stockId"] integerValue] != [ruleModel.fCoinType integerValue]) {
//            return [self getDefaultNodata];
//        }
//        if ([dict objectForKey:@"buys"] && [dict objectForKey:@"sells"])
//        {
//            NSMutableArray * sonArr_buy = [NSMutableArray array];
//            NSMutableArray * sonArr_sel = [NSMutableArray array];
//            NSArray * arrbuy = [dict objectForKey:@"buys"];
//            NSArray * arrSel = [dict objectForKey:@"sells"];
//
//            for (int i = 6; i>=0; i--) {
//                SevenBuyOrSelDataModel * model = [SevenBuyOrSelDataModel new];
//                model.title = [NSString stringWithFormat:@"%@%d",NSLocalizedString(@"卖", nil),i+1];
//                NSDictionary * dict = arrSel[i];
//                model.price = [self stringFromDecimal:dict[@"price"] andPrecision:ruleModel.fcount1];
//                model.volume = [self stringFromDecimal:dict[@"volume"] andPrecision:ruleModel.fcount2];
//                [sonArr_sel addObject:model];
//            }
//            for (int i = 0; i<7; i++) {
//                SevenBuyOrSelDataModel * model = [SevenBuyOrSelDataModel new];
//                model.title = [NSString stringWithFormat:@"%@%d",NSLocalizedString(@"买", nil),i+1];
//                NSDictionary * dict = arrbuy[i];
//                model.price = [self stringFromDecimal:dict[@"price"] andPrecision:ruleModel.fcount1];
//                model.volume = [self stringFromDecimal:dict[@"volume"] andPrecision:ruleModel.fcount2];
//                [sonArr_buy addObject:model];
//            }
//            return @[sonArr_sel,sonArr_buy];
//        }
//    }
//    return [self getDefaultNodata];
//}

+(NSString *)stringFromDecimal:(NSNumber *)number andPrecision:(int)precision{
    NSString *format = [NSString stringWithFormat:@"%%.%df",precision];
    double value = [number doubleValue];
    return [NSString stringWithFormat:format,value];
    
//    CGFloat value = [number doubleValue];
//    NSString * str = [NSString stringWithFormat:@"%g",value];
//    if ([str isEqualToString:@"0"]) {
//        str = @"--";
//    }
//    return str;
}


@end
