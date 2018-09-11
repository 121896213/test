//
//  SZSCPropertyModel.m
//  BTCoin
//
//  Created by sumrain on 2018/7/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSCPropertyModel.h"

@implementation SZSCPropertyModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [SZSCPropertyModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{ @"id" : @"scID"};
        }];
    }
    return self;
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{ @"id" : @"scID"};
}

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        
    }
}
@end
