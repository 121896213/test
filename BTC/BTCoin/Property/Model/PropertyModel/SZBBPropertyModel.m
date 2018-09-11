//
//  SZBBPropertyModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBBPropertyModel.h"
#import "MJExtension.h"
@implementation SZBBPropertyModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
          @"fvirtualcoinType" : @"fvirtualcointype.fShortName",
          };
}
@end
