//
//  SZBaseModel.m
//  BTCoin
//
//  Created by fanhongbin on 2018/6/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"

@implementation SZBaseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(SZBaseModel *)modelWithJson:(id)json{
    SZBaseModel * model = [[SZBaseModel alloc]init];
    if ([json isKindOfClass:[NSDictionary class]]) {
        [model mj_setKeyValues:json];
    }else{
        model.msg = @"数据格式有误";
    }
    return model;
    
}
@end
