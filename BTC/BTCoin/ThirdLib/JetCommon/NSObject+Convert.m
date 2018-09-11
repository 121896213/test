//
//  NSObject+Convert.m
//  NetDemo
//
//  Created by lixinglou on 16/7/18.
//  Copyright © 2016年 lixinglou. All rights reserved.
//

#import "NSObject+Convert.h"
#import "NSData+AES256.h"
#import "NSData+Base64.h"
#import "MJExtension.h"
#import <NSObject+YYModel.h>

static NSString* const AES253Key_SAP = @"P)(%&#*~<>diuej8ApU!Wm,#@:3TuoiQ";

@implementation NSObject (Convert)

- (NSString *)encryptStr{
    NSString *baseValue ;
    
    NSData *cData ;
    if( [self isKindOfClass:[NSData class]] ){
        cData = (NSData*)self ;
    }else if( [self isKindOfClass:[NSString class]] ){
        NSString *json = (NSString *)self ;
        cData = [json dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        cData = [self jsonData];
    }
    
    cData = [cData AES256EncryptWithKey:AES253Key_SAP];
    
    baseValue = [cData base64EncodedStringWithOptions:0];
    
    return baseValue;
}

- (id)decryptIsJson:(BOOL)isJosn{
    
    if (![self isKindOfClass:[NSString class]] && ![self isKindOfClass:[NSData class]]) {
        return @"";
    }
    
    NSData *bsData;
    if ([self isKindOfClass:[NSData class]]) {
        bsData = (NSData*)self;
    }else if([self isKindOfClass:[NSString class]]){
//        bsData= [[NSData alloc] initWithBase64EncodedString:(NSString *)self];
        bsData = [[NSData alloc]initWithBase64EncodedString:(NSString*)self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }else{
        return nil;
    }
    NSData *nData = [bsData AES256DecryptWithKey:AES253Key_SAP];
    
    if( ! nData ){
        NSLog(@"⚠️⚠️⚠️⚠️⚠️⚠️警告⚠️⚠️⚠️⚠️⚠️⚠️⚠️，这里返回空值，请查看");
        return @"" ;
    }
    
    NSString *resultString = [[NSString alloc] initWithData:nData encoding:NSUTF8StringEncoding] ;
    
    if( isJosn ){
        NSError *error = nil ;
        id result = [NSJSONSerialization JSONObjectWithData:nData options:NSJSONReadingAllowFragments error:&error];
        
//        id result = [resultString objectFromJSONString];
        return result ;
    }else{
        return resultString ;
    }
}

//将json转成字典
- (NSDictionary *)jsonToNSDicationary{
    if( ![self isKindOfClass:[NSString class]] ) return nil ;
    NSString *jsonValue = (id)self ;
    
    NSData *ddata = [jsonValue dataUsingEncoding:NSUTF8StringEncoding];
    
    id result = [NSJSONSerialization JSONObjectWithData:ddata options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *dic ;
    if( [result isKindOfClass:[NSDictionary class]] ){
        dic = (NSDictionary *)result ;
    }
    
    return dic ;
}

//将json转成数组
- (NSArray *)jsonToNSArray{
    if( ![self isKindOfClass:[NSString class]] ) return nil ;
    NSString *jsonValue = (id)self ;
    
    NSData *ddata = [jsonValue dataUsingEncoding:NSUTF8StringEncoding];
    
    id result = [NSJSONSerialization JSONObjectWithData:ddata options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *dic ;
    if( [result isKindOfClass:[NSArray class]] ){
        dic = (NSArray *)result ;
    }
    
    return dic ;
}

- (NSData *)jsonData{
    NSData *tempData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
#if TARGET_IPHONE_SIMULATOR
    NSString *jsonString = [[NSString alloc]initWithData:tempData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString is %@" ,jsonString);
#endif
    return tempData;
}

- (NSString *)jsonStr{
    
    if ([self isKindOfClass:[NSArray class]]
        || [self isKindOfClass:[NSDictionary class]]
        ||  [self isKindOfClass:[NSSet class]]) {
        
        NSData *tempData = [self jsonData];
        return [[NSString alloc]initWithData:tempData encoding:NSUTF8StringEncoding];
    }else if ([self isKindOfClass:[NSString class]]){
//        return [(NSString*)self JSONStringWithOptions:JKSerializeOptionNone includeQuotes:YES error:NULL];
        NSMutableString *testPostStr = [[NSMutableString alloc]initWithString:[@[(NSString*)self] jsonStr]];
        if (testPostStr.length >1) {
            [testPostStr deleteCharactersInRange:NSMakeRange(testPostStr.length - 1, 1)];
            [testPostStr deleteCharactersInRange:NSMakeRange(0, 1)];
            return testPostStr;
        }
        return (NSString *)self;
        
    } else if([self isKindOfClass:[NSNumber class]]){
        return [[(NSNumber *)self stringValue] jsonStr];
    }else{
        return [self sap_JSONString];
    }
    
    return [self description];
}

- (NSString *)groupStringWithDecimalLenght:(NSUInteger)decimalLength{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    if (decimalLength > 0 && decimalLength != NSNotFound) {
        [formatter setMaximumFractionDigits:decimalLength];
    }
    formatter.generatesDecimalNumbers = YES;
    id value = self;
    if ([self isKindOfClass:[NSString class]]) {
        value = @([(NSString*)self doubleValue]);
    }
    NSString* string=[formatter stringForObjectValue:value];
    return string;
}

- (NSString *)sap_JSONString{
    
    return [self mj_JSONString];
}

- (NSDictionary *)sap_keyValues{
    
//    return self.mj_keyValues;
    return [self modelToJSONObject];
}

- (NSMutableDictionary *)sap_keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys{
    
    NSDictionary *yyDict = [self sap_keyValues];
    NSMutableDictionary *resultDict;
    if ([yyDict isKindOfClass:[NSMutableDictionary class]]) {
        resultDict = (NSMutableDictionary *)yyDict;
    }else if ([yyDict isKindOfClass:[NSDictionary class]]){
        resultDict = [[NSMutableDictionary alloc]initWithDictionary: yyDict];
    }else{
          return nil;
    }
    [ignoredKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([resultDict valueForKey:[obj description]]) {
            [resultDict removeObjectForKey:[obj description]];
        }
    }];
    
    return resultDict;
}

+ (NSMutableArray *)sap_keyValuesArrayWithObjectArray:(NSArray *)objectArray{
    
    NSMutableArray *resultArr = [NSMutableArray new];
    [objectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *keyValues = [obj sap_keyValues];
        if (keyValues) {
            [resultArr addObject:keyValues];
        }
    }];
//    return [self mj_keyValuesArrayWithObjectArray:objectArray];
    return resultArr;
}

//数组里面包含model
+ (NSDictionary *)modelContainerPropertyGenericClass{

    if([self.class respondsToSelector:@selector(sap_objectClassInArray)]){
        
        return [self.class sap_objectClassInArray];
        
    }else if([self.class respondsToSelector:@selector(mj_objectClassInArray)]){
        
        return [self.class mj_objectClassInArray];
    }else if ([self respondsToSelector:@selector(objectClassInArray)]) {
        
        return [self performSelector:@selector(objectClassInArray)];
    }
    
    return nil;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    
    if([self.class respondsToSelector:@selector(sap_modelCustomPropertyMapper)]){
        
        return [self.class sap_modelCustomPropertyMapper];
        
    }else if([self.class respondsToSelector:@selector(mj_replacedKeyFromPropertyName)]){
        
        return [self.class mj_replacedKeyFromPropertyName];
    }else if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        
        return [self performSelector:@selector(replacedKeyFromPropertyName)];
    }
    
    return nil;
}

+ (NSArray *)changeToObjectArray:(id)keyValueArray{
//    return [self mj_objectArrayWithKeyValuesArray:keyValueArray];
    return [NSArray modelArrayWithClass:[self class] json:keyValueArray];
}

- (instancetype)sap_setKeyValues:(id)keyValues{
    
    if ([self modelSetWithDictionary:keyValues]) return self;
    return nil;
}

//将字典转换成对象
+ (instancetype)changeToObject:(id)keyValueDic{
//    return [self mj_objectWithKeyValues:keyValueDic];
    return [[self class] modelWithJSON:keyValueDic];
}

//将对象转成字典
+ (NSDictionary *)changeToKeyValueDic:(NSObject *)objectClass{
    return objectClass.sap_keyValues;
}

//将对象转成新的对象，相当于复制
- (id)copyToNewInstance{
//    NSDictionary *dic = self.mj_keyValues ;
//    
//    return [[self class] changeToObject:dic];
    NSDictionary *dic = [self modelToJSONObject];
    return [[self class] changeToObject:dic];
}

/*
 将网络请求返回来的数据转换成字典，如果object是数组或者字符等非字典情况，返回为nil
 如果是字典，如果key不为空，则返回key对应下的字典，如果key对应的不是字典，则返回nil,如果key对应的没有值，则返回字典
 */
+ (NSDictionary *)dicFromWebObject:(id)objects key:(NSString *)key{
    if( [objects isKindOfClass:[NSDictionary class]] ){
        NSDictionary *dic = (NSDictionary *)objects ;
        
        if( key ){
            id kObjects = [dic objectForKey:key];
            if( [kObjects isKindOfClass:[NSDictionary class]] ){
                return kObjects ;
            }else if( kObjects ){
                return nil;
            }else{
                return dic ;
            }
        }else{
            return dic ;
        }
    }else{
        return nil;
    }
}

/*
 将网络请求返回来的数据转换成数组，如果object是数组，在key为nil的情况下返回本身，否则返回nil；
 如果是字典，在key不为空时，则返回key对应下的数组对象，如果key对应的不是数组，则返回nil
 */
+ (NSArray *)arrayFromWebObject:(id)objects key:(NSString *)key{
    if( [objects isKindOfClass:[NSDictionary class]] && key ){
        NSDictionary *dic = (NSDictionary *)objects ;
        id kObjects = [dic objectForKey:key];
        if( [kObjects isKindOfClass:[NSArray class]] ){
            return kObjects ;
        }else{
            return nil ;
        }
    }else if( [objects isKindOfClass:[NSArray class]] ){
        return objects ;
    }else{
        return nil ;
    }
}

/*
 将网络请求返回来的数据转换成字符，如果object是字符，在key为nil的情况下返回本身；
 如果是字典，在key不为空时，则返回key对应下的字符对象，如果key对应的不是字符，则返回nil
 */
+ (NSString *)stringFromWebObject:(id)objects key:(NSString *)key{
    if( [objects isKindOfClass:[NSArray class]] ){
        return nil ;
    }else if( [objects isKindOfClass:[NSDictionary class]] ){
        NSDictionary *dic = (NSDictionary *)objects ;
        if( key ){
            id kObjects = [dic objectForKey:key];
            if( [kObjects isKindOfClass:[NSArray class]] || [kObjects isKindOfClass:[NSDictionary class]] || [kObjects isKindOfClass:[NSNull class]] ){
                return nil;
            }else{
                return [NSString checkNULLstring:kObjects];
            }
        }else{
            return nil ;
        }
    }else{
        return [NSString checkNULLstring:objects];
    }
}

@end
