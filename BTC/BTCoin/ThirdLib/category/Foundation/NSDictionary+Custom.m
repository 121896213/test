//
//  NSDictionary+Custom.m
//  99Gold
//
//  Created by LionIT on 11/29/16.
//  Copyright © 2016 xia zhonglin . All rights reserved.
//

#import "NSDictionary+Custom.h"

@implementation NSDictionary (Custom)
- (NSString *)toJson {
    if (self == nil) {
        return nil;
    }
    
    NSError * error;
    NSData * data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"error = %@",error);
        return nil;
    }
    
    if (data == nil) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
    
    return jsonString;
}

- (NSString *)toHttpUrlPara {
    NSArray * keys = [self allKeys];
    if (0 == keys.count) {
        return nil;
    }
    
    NSString * resultStr = @"";
    for (NSString * key in keys) {
        resultStr = [resultStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,self[key]]];
    }
    
    resultStr = [resultStr substringToIndex:resultStr.length-1];
    NSString * encodingString = [resultStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return encodingString;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

/**截取浦发银行接口返回dictionary有用的信息，重新包装成NSDictionary*/
- (NSDictionary *)rebuildSPDBankResponse {
    NSMutableDictionary * buildDic = [NSMutableDictionary dictionaryWithCapacity:3];
    
    id value = [self valueForKeyPath:@"IASPDB.PLAIN.BODY"];
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSArray * keys = [value allKeys];
        for (NSString * key in keys) {
            [buildDic setObject:value[key]?:@"" forKey:key];
        }
    }
    
    value = [self valueForKeyPath:@"IASPDB.PLAIN.HEAD"];
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSArray * keys = [value allKeys];
        for (NSString * key in keys) {
            [buildDic setObject:value[key]?:@"" forKey:key];
        }
    }
    
    value = [self valueForKeyPath:@"IASPDB.SIGNATURE"];
    [buildDic setObject:value?:@"" forKey:@"SIGNATURE"];
    
    return buildDic;
}

@end
