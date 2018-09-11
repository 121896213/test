//
//  NSDate+Util.h
//  InvestNanny
//
//  Created by LionIT on 7/22/16.
//  Copyright © 2016 tracy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Util)
+ (NSString *)currentTimestampString;
+ (NSString *)changeTimeStyle:(SInt64)time;
- (NSString *)stringWithDateFormate:(NSString *)dateFormate;
@end
