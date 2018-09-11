//
//  MarketHomeListModel.h
//  BTCoin
//
//  Created by zzg on 2018/4/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "BaseModel.h"

@interface MarketHomeListModel : BaseModel

@property (nonatomic, copy) NSString    *fCoinType;     //法币类型匹配表id
@property (nonatomic, copy) NSString    *fName;         //名称
@property (nonatomic, copy) NSString    *fShortName;    //简称
@property (nonatomic, copy) NSString    *fTodayRiseFall;//今日涨跌幅
@property (nonatomic, copy) NSString    *fNewDealPrice; //最新成交价
@property (nonatomic, copy) NSString    *H24Volume;     //24小时成交量
@property (nonatomic, copy) NSString    *fMarket;     //兑换人民币
@property (nonatomic, copy) NSString    *fTradeType;    //交易类型
@property (nonatomic, copy) NSString    *furl;          //图片二进制编码
@property (nonatomic, assign) int    fcount1;     //单价小数位
@property (nonatomic, assign) int    fcount2;     //数量小数位
@property (nonatomic, assign) double    quotes;     //汇率
@property (nonatomic, assign) int    flockCurrent;     //锁仓标识

@property (nonatomic, assign) BOOL isHaveSelected;//已选择

+(instancetype)getBTC_USDTModel;

-(void)refreshDataWithDict:(NSDictionary *)dict;

@property (nonatomic, copy) NSString    *areaName;//大区名<暂用于交易区选择币种时>

@end




