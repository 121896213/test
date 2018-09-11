//
//  RealTimeModel.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "RealTimeModel.h"

@implementation RealTimeModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"newPrice"]) {
        [super setValue:value forKey:@"curPrice"];
    }
    else{
        NSLog(@"没有发现________%@",value);
    }
}

-(void)setValueWithJsonString:(NSString *)json
{
    NSDictionary * dict = [NSDictionary dictionaryWithJsonString:json];
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        [self mj_setKeyValues:dict];
        _maxPrice = [self stringFromDecimal:dict[@"maxPrice"]];
        _minPrice = [self stringFromDecimal:dict[@"minPrice"]];
        _volume = [self stringFromDecimal:dict[@"volume"]];
        _curPrice = [self stringFromDecimal:dict[@"newPrice"]];
        
        if (![dict objectForKey:@"openPrice"]) {
            _changeValue = @"--";
            _changeValuePercent = @"--";
        }else{
            CGFloat value = [dict[@"newPrice"] doubleValue] - [dict[@"openPrice"] doubleValue];
            _changeValue = [NSString stringWithFormat:@"%.5f",value];
            _changeValuePercent = [NSString stringWithFormat:@"%.2f%%",value /[dict[@"openPrice"] doubleValue]];
        }
    }
    /*
    {"amount":20028.959999999974,
        "averagePrice":3.8288969604282115,
        "closePrice":5.9500000000000002,

        "mv":4.0,
        "openPrice":5.9500000000000002,
        "stockId":42,
        "strokeCount":5231.0,
        "time":1525950779,
*/
}

-(void)setValueWithJsonString:(id)json andPointModel:(MarketHomeListModel *)model{
    NSDictionary * dict = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dict = json;
    }else{
        dict = [NSDictionary dictionaryWithJsonString:json];
    }
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        [self mj_setKeyValues:dict];
        _maxPrice = [self stringFromDecimal:dict[@"H"] andPrecision:model.fcount1];
        _minPrice = [self stringFromDecimal:dict[@"L"] andPrecision:model.fcount1];
        _volume = [self stringFromDecimal:dict[@"V"] andPrecision:model.fcount2];
        _curPrice = [self stringFromDecimal:dict[@"C"] andPrecision:model.fcount1];
        
        if (![dict objectForKey:@"LP"]) {
            _changeValue = @"--";
            _changeValuePercent = @"--";
        }else{
            double value = [dict[@"C"] doubleValue] - [dict[@"LP"] doubleValue];
            NSString *format = [NSString stringWithFormat:@"%%.%df",model.fcount1];
            _changeValue =  [NSString stringWithFormat:format,value];
            _changeValuePercent = [NSString stringWithFormat:@"%.2f%%",value * 100/[dict[@"LP"] doubleValue]];
        }
    }
}


-(NSString *)stringFromDecimal:(NSNumber *)number{
    CGFloat value = [number doubleValue];
    return [NSString stringWithFormat:@"%.5f",value];
}

-(NSString *)stringFromDecimal:(NSNumber *)number andPrecision:(int)precision{
    NSString *format = [NSString stringWithFormat:@"%%.%df",precision];
    double value = [number doubleValue];
    return [NSString stringWithFormat:format,value];
}

@end
