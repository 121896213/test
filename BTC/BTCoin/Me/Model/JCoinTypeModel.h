//
//  JCoinTypeModel.h
//  BTCoin
//
//  Created by Shizi on 2018/4/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCoinTypeModel : NSObject

//
@property (nonatomic, copy) NSString *furl;
@property (nonatomic, copy) NSString *fMarket;
@property (nonatomic, assign) NSInteger *fcount1;
//今日涨跌
@property (nonatomic, copy) NSString *fTodayRiseFall;
//交易币种名称
@property (nonatomic, copy) NSString *fName;
@property (nonatomic, assign) NSInteger fvirtualcointype2;
//价格趋势(3日)
@property (nonatomic, copy) NSArray *day3PriceTrend;
//交易类型(固定为0)
@property (nonatomic, assign) NSInteger fTradeType;
@property (nonatomic, assign) NSInteger fvirtualcointype1;
//24小时成交量
@property (nonatomic, assign) NSInteger h24Volume;
//最新成交价
@property (nonatomic, assign) CGFloat fNewDealPrice;
@property (nonatomic, assign) NSInteger fcount2;
//法币类型匹配表id
@property (nonatomic, assign) NSInteger fCoinType;
//交易币种简称
@property (nonatomic, copy) NSString *fShortName;

@end

@interface JCoinTypeListModel : NSObject

@property (nonatomic, copy) NSArray<JCoinTypeModel *> *fcurrencyInfos;
@property (nonatomic, assign) NSInteger fCurrencyArea;

@end




