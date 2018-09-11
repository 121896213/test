//
//  RecordDataModel.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/26.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "RecordDataModel.h"

@implementation RecordDataModel

-(void)setValueWithDictionary:(NSDictionary *)dictionary andBigArea:(NSString *)bigArea{
    [self mj_setKeyValues:dictionary];
    if ([_fType isEqualToString:@"买入"]) {
        _fUnit = bigArea;
    }
}

@end
