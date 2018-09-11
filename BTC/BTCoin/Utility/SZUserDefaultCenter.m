//
//  ConfigManager.m
//  efaxin
//
//  Created by mac2 on 15/8/17.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import "SZUserDefaultCenter.h"
@implementation SZUserDefaultCenter

+(void)setKey:(NSString*)key andValue:(NSString*)value
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}
+(NSString*)getValueWithKey:(NSString*)key
{

    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    NSString* value=[defaults objectForKey:key];
    
    if (isEmptyString(value)) {
        return @"";
    }
    //根据键值取出name
    return  value;
}


+(void)setBoolKey:(NSString *)key andValue:(BOOL)value
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setBool: value forKey:key];
    //用synchronize方法把数据持久化到standardUserDefaults数据库
    [defaults synchronize];
    
}

+(BOOL)getBoolValueWithKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


+(void)setIntegerKey:(NSString*)key  andValue:(NSInteger)value
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    //用synchronize方法把数据持久化到standardUserDefaults数据库
    [defaults synchronize];
}
+(NSInteger)getIntegerValueWithKey:(NSString*)key{
    
     return [[NSUserDefaults standardUserDefaults] integerForKey:key];
    
}

@end


