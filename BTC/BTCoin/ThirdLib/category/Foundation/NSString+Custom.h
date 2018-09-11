//
//  NSString+Custom.h
//  MengShare
//
//  Created by jeebee on 6/1/15.
//  Copyright (c) 2015 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Custom)

- (NSString *)trim;

- (NSString *)stringValue;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

- (NSString*)clean;
- (NSString *)URLEncodingUTF8String;

- (NSString *)stringByReversed;

- (NSString *)truncateByByteLength:(NSInteger)len;

- (NSString *)toMoneyCapitalLetters;

/**将浮点数字符串转为指定精度的浮点数字符串*/
-(NSString *)convertSpecifiedPrecisionFloatString:(int)precision;

/**
 身份证出生日期那八位显示为******

 @return 
 */
- (NSString *)formateCardID;

+(NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
