//
//  NSDate+SZDate.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "NSDate+SZDate.h"

@implementation NSDate (SZDate)

+(NSString *)getTodayString{
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    return [myDateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)getTheDayBeforeTodayString{
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate * date = [[NSDate date] dateByAddingTimeInterval:-86400];
    return [myDateFormatter stringFromDate:date];
}

+(NSString *)getTheFirstDayOfThisMonth{
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString * today = [myDateFormatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%@-01",[today substringToIndex:7]];
}

@end
