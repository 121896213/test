//
//  JCountryModel.m
//  BTCoin
//
//  Created by Shizi on 2018/4/20.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "JCountryModel.h"

@implementation JCountryModel

- (BOOL)isChina{
    
    if ([self.phoneCode isEqualToString:@"+86"]) {
        return YES;
    }
    return NO;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_phoneCode forKey:@"phoneCode"];
    [aCoder encodeObject:_countrycn forKey:@"countrycn"];
    [aCoder encodeObject:_countryen forKey:@"countryen"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    self.phoneCode=[aDecoder decodeObjectForKey:@"phoneCode"];
    self.countrycn=[aDecoder decodeObjectForKey:@"countrycn"];
    self.countryen=[aDecoder decodeObjectForKey:@"countryen"];
    return self;
}

+ (instancetype)mj_objectWithKeyValues:(id)keyValues {
    
    return [JCountryModel new];
}


@end


@implementation JCountryListModel

+ (instancetype)mj_objectWithKeyValues:(id)keyValues {
    
    return [JCountryListModel new];
}


@end
