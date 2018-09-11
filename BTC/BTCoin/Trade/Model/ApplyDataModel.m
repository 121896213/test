//
//  ApplyDataModel.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "ApplyDataModel.h"

@implementation ApplyDataModel

-(void)dealDataWithDictionary:(NSDictionary *)dict{

    _dealCount = [self stringFromDecimal:dict[@"dealCount"] andPrecision:_fcount2];
    _dealPrice = [self stringFromDecimal:dict[@"dealPrice"]andPrecision:_fcount1];
    _fees = [self stringFromDecimal:dict[@"fees"]andPrecision:_fcount1];
    _grantRate = [self stringFromDecimal:dict[@"grantRate"]andPrecision:_fcount1];
    _profitLoss = [self stringFromDecimal:dict[@"profitLoss"]andPrecision:_fcount1];
}
-(NSString *)direction{
    if ([_buyType isEqualToString:@"20"]) {
        return NSLocalizedString(@"加仓", nil);
    }else{
        return NSLocalizedString(@"申购", nil);
    }
}
-(NSString *)stringFromDecimal:(NSNumber *)number andPrecision:(NSInteger)precision{
    NSString *format = [NSString stringWithFormat:@"%%.%ldf",precision];
    double value = [number doubleValue];
    return [NSString stringWithFormat:format,value];
}

-(NSString *)limitTimeString
{
    NSTimeInterval interval    =[_tradeBuyEndTime integerValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString * dateString = [formatter stringFromDate: date];
    return dateString;
}


-(NSMutableAttributedString *)youTeShuZuoyong
{
    NSTimeInterval interval    =[_tradeBuyEndTime integerValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateString = [formatter stringFromDate: date];
    
    NSDictionary * dict = @{NSForegroundColorAttributeName:MainThemeColor,NSFontAttributeName:kFontSize(16)};
    NSDictionary * dict2 = @{NSForegroundColorAttributeName:UIColorFromRGB(0xbdb2a9),NSFontAttributeName:kFontSize(12)};
    
    NSMutableAttributedString * mAttString = [[NSMutableAttributedString alloc]init];
    
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:[dateString substringToIndex:4] attributes:dict]];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:NSLocalizedString(@" 年 ", nil) attributes:dict2]];

    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:[dateString substringWithRange:NSMakeRange(5, 2)] attributes:dict]];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:NSLocalizedString(@" 月 ", nil) attributes:dict2]];

    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:[dateString substringWithRange:NSMakeRange(8, 2)] attributes:dict]];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:NSLocalizedString(@" 日", nil) attributes:dict2]];
    return mAttString;
}
@end
