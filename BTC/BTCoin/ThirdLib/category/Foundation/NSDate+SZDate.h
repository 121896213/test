//
//  NSDate+SZDate.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SZDate)

+(NSString *)getTodayString;
+(NSString *)getTheDayBeforeTodayString;
+(NSString *)getTheFirstDayOfThisMonth;

@end
