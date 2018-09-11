//
//  NSArray+Util.m
//  GoldRushStreet
//
//  Created by LionIT on 4/15/16.
//  Copyright © 2016 tracy. All rights reserved.
//

#import "NSArray+Util.h"

@implementation NSArray (Util)

- (NSArray*)sortStringValueByDicKey:(NSString*)key isDescend:(BOOL)b {
    NSUInteger count = self.count;
    if (count < 2) {
        return self;
    }
    
    return [self sortedArrayUsingComparator:^NSComparisonResult(NSDictionary*  _Nonnull obj1, NSDictionary*  _Nonnull obj2) {
        NSString * value1 = obj1[key];
        NSString * value2 = obj2[key];
        
        NSComparisonResult result = [value1 compare:value2];
        if (result == NSOrderedSame) {
            return result;
        }
        return b ? -result : result;
    }];
}

@end
