//
//  NSObject+Convert.h
//  NetDemo
//
//  Created by lixinglou on 16/7/18.
//  Copyright © 2016年 lixinglou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+SAPTransformation.h"
#import "NSDictionary+SAPTransformation.h"

@interface NSObject (Convert)

- (NSData *)jsonData;

- (NSString *)jsonStr;

- (NSString *)encryptStr;

- (id)decryptIsJson:(BOOL)isJosn;

//将json转成字典
- (NSDictionary *)jsonToNSDicationary;

//将json转成数组
- (NSArray *)jsonToNSArray;
//千分位显示:"###,###"
- (NSString *)groupStringWithDecimalLenght:(NSUInteger)decimalLength;

- (NSString *)sap_JSONString;
//模型转字典
- (NSDictionary *)sap_keyValues;
//模型转字典，数组
+ (NSMutableArray *)sap_keyValuesArrayWithObjectArray:(NSArray *)objectArray;
//模型转字典，过滤忽略参数
- (NSMutableDictionary *)sap_keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys;

//对已经实例化后的model设置属性
- (instancetype)sap_setKeyValues:(id)keyValues;

//数组里面包含model
+ (NSDictionary *)sap_objectClassInArray;

//属性名称映射
+ (NSDictionary *)sap_modelCustomPropertyMapper;

//将字典的数组转换成对象数组
+ (NSArray *)changeToObjectArray:(id)keyValueArray;
//将字典转换成对象
+ (instancetype)changeToObject:(id)keyValueDic;
//将对象转成字典
+ (NSDictionary *)changeToKeyValueDic:(NSObject *)objectClass;
//将对象转成新的对象，相当于复制
- (id)copyToNewInstance;

/*
 将网络请求返回来的数据转换成字典，如果object是数组或者字符等非字典情况，返回为nil
 如果是字典，如果key不为空，则返回key对应下的字典，如果key对应的不是字典，则返回nil,如果key对应的没有值，则返回字典
 */
+ (NSDictionary *)dicFromWebObject:(id)objects key:(NSString *)key;

/*
 将网络请求返回来的数据转换成数组，如果object是数组，在key为nil的情况下返回本身，否则返回nil；
 如果是字典，在key不为空时，则返回key对应下的数组对象，如果key对应的不是数组，则返回nil
 */
+ (NSArray *)arrayFromWebObject:(id)objects key:(NSString *)key;

/*
 将网络请求返回来的数据转换成字符，如果object是字符、数值类型、日期类型等，在key为nil的情况下返回本身；
 如果是字典，在key不为空时，则返回key对应下的字符对象，如果key对应的不是字符，则返回nil
 */
+ (NSString *)stringFromWebObject:(id)objects key:(NSString *)key;

@end
