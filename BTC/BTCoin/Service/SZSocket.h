//
//  SZSocket.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/8.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGetMarketDataNotifaction @"kGetMarketDataNotifaction"//行情
//#define kGetTradeDataNotifaction @"kGetTradeDataNotifaction"

@interface SZSocket : NSObject
DEFINE_SINGLETON_FOR_HEADER(SZSocket)

-(void)openSocket;
- (void)destroyWebsocket;
-(void)orderMessage:(NSString *)messages;
@end
