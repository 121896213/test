//
//  SZSocket.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/8.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSocket.h"
#import <SRWebSocket.h>

@interface SZSocket()<SRWebSocketDelegate>{
    NSTimer * heartBeat;//webSocket心跳
    NSTimeInterval reConnectTime;//重连次数
}
@property (nonatomic,strong)SRWebSocket * webSocket;
@property (nonatomic,copy)NSString * orderMessage;

@end

@implementation SZSocket

DEFINE_SINGLETON_FOR_CLASS(SZSocket)
 
-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

-(void)openSocket{
    [self destroyWebsocket];
    [self.webSocket open];

}

-(void)orderMessage:(NSString *)messages{
    _orderMessage = messages;
    NSDictionary * dict = @{@"symd":@{@"ID":messages}};
    NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
    [self sendData:data];
}


#pragma mark -- SocketDelegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
//    NSLog(@"Received \"%@\"", message);
    NSDictionary * dict = [NSDictionary dictionaryWithJsonString:message];
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:kGetMarketDataNotifaction object:nil userInfo:dict];
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    reConnectTime = 0;
    [self initHeartBeat];
    if (_orderMessage.length > 0) {
        NSDictionary * dict = @{@"symd":@{@"ID":_orderMessage}};
        NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
        [self sendData:data];
    }
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"Received \"%@\"", error);
    [self reConnect];
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    [self destroyWebsocket];
}
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{

}

-(void)destroyWebsocket{
    if (_webSocket) {
        _webSocket.delegate = nil;
        [_webSocket close];
        _webSocket = nil;
    }
    [self destoryHeartBeat];
}

#pragma mark -------webSocket重连等相关
- (void)reConnect
{
    [self destroyWebsocket];
    if (reConnectTime > 64) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _webSocket = nil;
        [self.webSocket open];
    });
    
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }
}

-(void)sendPingMessage{
    [self sendData:@"heart"];
}
- (void)sendData:(id)data
{
    __weak typeof(self)weakSelf = self;
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    dispatch_async(queue, ^{
        if (weakSelf.webSocket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法，不然要崩
            if (weakSelf.webSocket.readyState == SR_OPEN) {
                if ([[data class]isKindOfClass:[NSString class]]) {
                    [weakSelf.webSocket sendPing:nil];
                }else{
                    [weakSelf.webSocket send:data];    // 发送数据
                }
            } else if (weakSelf.webSocket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                [self reConnect];
            } else if (weakSelf.webSocket.readyState == SR_CLOSING || weakSelf.webSocket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                [self reConnect];
            }
        } else {
            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
        }
    });
}

#pragma mark ------webSocket心跳相关
- (void)initHeartBeat
{
    dispatch_main_async_safe(^{
        [self destoryHeartBeat];
        heartBeat = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(sendPingMessage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:heartBeat forMode:NSRunLoopCommonModes];
    })
}
//取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if (heartBeat) {
            [heartBeat invalidate];
            heartBeat = nil;
        }
    })
}


-(SRWebSocket *)webSocket{
    if (!_webSocket) {
        _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:SocketUrlForMarket]]];
        _webSocket.delegate = self;
    }
    return _webSocket;
}


-(void)dealloc{
    _webSocket.delegate = nil;
    [_webSocket close];
    _webSocket = nil;
}

@end
