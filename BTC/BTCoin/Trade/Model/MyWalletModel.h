//
//  MyWalletModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWalletModel : NSObject

@property (nonatomic,copy)NSString * ffrozen;//交易币冻结资产
@property (nonatomic,copy)NSString * ffrozenType;//基准币冻结资产
@property (nonatomic,copy)NSString * ftotal;//交易币总资产
@property (nonatomic,copy)NSString * ftotalType;//基准币总资产
@property (nonatomic,copy)NSString * bbCnyNum;//币币等价于人民币总资产
@property (nonatomic,copy)NSString * bbUsdtNum;//币币总资产

@end
