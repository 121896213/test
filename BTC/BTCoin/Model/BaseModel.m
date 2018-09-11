//
//  BaseModel.m
//  GoldNewsHC
//
//  Created by xia zhonglin  on 11/2/16.
//  Copyright © 2016 xia zhonglin . All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(BaseModel *)modelWithJson:(id)json{
    BaseModel * model = [[BaseModel alloc]init];
    if ([json isKindOfClass:[NSDictionary class]]) {
        [model mj_setKeyValues:json];
        model.errorMessage = nil;
        if (model.code != 0) {
            model.errorMessage = model.msg;
        }
    }else{
        model.errorMessage = @"数据格式有误";
    }
    return model;

}


@end
