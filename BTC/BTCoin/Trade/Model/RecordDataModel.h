//
//  RecordDataModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/26.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordDataModel : NSObject

@property (nonatomic,copy)NSString * currencyName;// 交易币简称
@property (nonatomic,copy)NSString * fAmount;// 成交额
@property (nonatomic,copy)NSString * fCount;//数量
@property (nonatomic,copy)NSString * fCreateTime;// 交易时间
@property (nonatomic,copy)NSString * fFees;// 手续费
@property (nonatomic,copy)NSString * fPrice;//价格
@property (nonatomic,copy)NSString * fType;// 买入/卖出
@property (nonatomic,copy)NSString * fUnit;//单位
@property (nonatomic,copy)NSString * fVirtualcointype1;//市场
@property (nonatomic,copy)NSString * fVirtualcointype2;// 交易币

-(void)setValueWithDictionary:(NSDictionary *)dictionary andBigArea:(NSString *)bigArea;
@end
