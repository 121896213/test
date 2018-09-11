//
//  MarketHomeListModel.m
//  BTCoin
//
//  Created by zzg on 2018/4/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "MarketHomeListModel.h"

@implementation MarketHomeListModel

+(instancetype)getBTC_USDTModel{
    MarketHomeListModel * model = [MarketHomeListModel new];
    model.fShortName = @"BTC";
    model.fCoinType = @"13";
    model.fcount1 = 6;
    model.fcount2 = 2;
    model.fNewDealPrice = @"--";
    model.fMarket = @"0";
    return model;
}

-(void)refreshDataWithDict:(NSDictionary *)dict{
    _fNewDealPrice = [self stringFromDecimal:dict[@"C"] andPrecision:_fcount1];
    _H24Volume = [self stringFromDecimal:dict[@"V"] andPrecision:_fcount2];
    double newMarket = [dict[@"C"] doubleValue] * _quotes;
    _fMarket = [self stringFromDecimal:newMarket];
    if (![dict objectForKey:@"LP"]) {
        
    }else{
        double value = [dict[@"C"] doubleValue] - [dict[@"LP"] doubleValue];
        _fTodayRiseFall = [NSString stringWithFormat:@"%.4f%%",value /[dict[@"LP"] doubleValue]];
    }
//    _fNewDealPrice = [self stringFromDecimal:dict[@"newPrice"] andPrecision:_fcount1];
//    _H24Volume = [self stringFromDecimal:dict[@"volume"] andPrecision:_fcount2];
//    double newMarket = [dict[@"newPrice"] doubleValue] * _quotes;
//    _fMarket = [self stringFromDecimal:newMarket];
//    if (![dict objectForKey:@"closePrice"]) {
//
//    }else{
//        double value = [dict[@"newPrice"] doubleValue] - [dict[@"closePrice"] doubleValue];
//        _fTodayRiseFall = [NSString stringWithFormat:@"%.4f%%",value /[dict[@"closePrice"] doubleValue]];
//    }
}




-(NSString *)stringFromDecimal:(double )number{
    NSString *format = [NSString stringWithFormat:@"%%.%df",2];
    return [NSString stringWithFormat:format,number];
}

-(NSString *)stringFromDecimal:(NSNumber *)number andPrecision:(int)precision{
    NSString *format = [NSString stringWithFormat:@"%%.%df",precision];
    double value = [number doubleValue];
    return [NSString stringWithFormat:format,value];
}


@end

