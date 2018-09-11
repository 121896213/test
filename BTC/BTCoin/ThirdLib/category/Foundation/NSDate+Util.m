//
//  NSDate+Util.m
//  InvestNanny
//
//  Created by LionIT on 7/22/16.
//  Copyright © 2016 tracy. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)
+ (NSString *)currentTimestampString {
    return [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
}

+ (NSString *)changeTimeStyle:(SInt64)time
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
}

- (NSString *)stringWithDateFormate:(NSString *)dateFormate {
    if (nil == dateFormate) {
        return nil;
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormate];
    return [formatter stringFromDate:self];
}

@end
