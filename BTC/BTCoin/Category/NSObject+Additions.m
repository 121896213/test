//
//  NSObject+Additions.m
//  BTCoin
//
//  Created by Shizi on 2018/5/26.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "NSObject+Additions.h"

@implementation NSObject (Additions)

+ (BOOL)isNullOrNilWithObject:(id)object
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}
@end
