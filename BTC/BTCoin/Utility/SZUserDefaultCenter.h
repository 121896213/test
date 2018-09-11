//
//  ConfigManager.h
//
//
//  Created by mac2 on 15/8/17.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  AppVersion @"AppVersion"
#define  SZUserDefalutLoginUser  @"LoginUser"
#define  SZUserAppThemeValue     @"SZUserAppThemeValue"  //0表示白天，1表示黑夜

#define SZUserDefaultCenterGetValue(key)   [SZUserDefaultCenter getValueWithKey:key]
#define SZUserDefaultCenterSetValue(key,value)  [SZUserDefaultCenter setKey:key andValue:value];

#define SZUserDefaultCenterGetBoolValue(key)   [SZUserDefaultCenter getBoolValueWithKey:key]
#define SZUserDefaultCenterSetBoolValue(key,value)  [SZUserDefaultCenter setBoolKey:key andValue:value];

#define SZUserDefaultCenterGetIntegerValue(key)   [SZUserDefaultCenter getIntegerValueWithKey:key]
#define SZUserDefaultCenterSetIntegerValue(key,value)  [SZUserDefaultCenter setIntegerKey:key andValue:value];

@interface SZUserDefaultCenter : NSObject

+(void)setKey:(NSString*)key andValue:(NSString*)value;
+(NSString*)getValueWithKey:(NSString*)key;

+(BOOL)getBoolValueWithKey:(NSString*) key;
+(void)setBoolKey:(NSString *)key andValue:(BOOL)value;

+(void)setIntegerKey:(NSString*)key  andValue:(NSInteger)value;
+(NSInteger)getIntegerValueWithKey:(NSString*)key;

@end
