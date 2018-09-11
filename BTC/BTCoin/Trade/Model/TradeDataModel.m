//
//  TradeDataModel.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "TradeDataModel.h"

@implementation TradeDataModel
-(void)setValueWithJson:(id)Json{
    [self mj_setKeyValues:Json];
}

-(NSString *)statusString{
    switch (_fstatus) {
        case TradeStateUnOver:
            return NSLocalizedString(@"未完成",nil);
            break;
        case TradeStateSomeOver:
            return NSLocalizedString(@"部分成交",nil);
            break;
        case TradeStateAllOver:
            return NSLocalizedString(@"完全成交",nil);
            break;
        case TradeStateUserCancel:
            return NSLocalizedString(@"用户撤销",nil);
            break;
        default:
            return NSLocalizedString(@"未完成",nil);
            break;
    }
}

@end


