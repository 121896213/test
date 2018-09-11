//
//  MarketParseSocketData.h
//  99Gold
//
//  Created by Robin on 12/23/16.
//  Copyright © 2016 xia zhonglin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetInterface.h"
#import "ICBCDataItems.h"
#import "DCInterface.h"

@interface MarketParseSocketData : NSObject
DEFINE_SINGLETON_FOR_HEADER(MarketParseSocketData)

- (void)parseCLIENTTYPE_TYPELIST:(NSData *)data Block:(void(^)(TYPELIST_RES * resHead, NSArray * array))block;

/*成交明细**/
+ (NSMutableArray *)parseCLIENTTYPE_CJMX:(NSData *)data tradingUnit:(int)tradingUnit;

/*动态数据**/
- (void)parseCLIENTTYPE_INTEREST:(NSData *)data block:(void(^)(NSArray *  tradeTimeIndexArray, NSArray * stkDynaDataArray,NSArray * wdDataArray))block;

/*走势**/
+ (void)parseCLIENTTYPE_ZS:(NSData *)data stkDynaData:(StkDynaData *)baseInfo block:(void(^)(NSArray * zsArray))block;

/*K线**/
+ (NSMutableArray *)parseCLIENTTYPE_KLINE:(NSData *)data stkDynaData:(StkDynaData *)baseInfo;

@end
