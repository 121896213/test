//
//  RealTimeModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "BaseModel.h"
#import "MarketHomeListModel.h"

/**实时socket数据*/
@interface RealTimeModel : BaseModel

@property (nonatomic,copy)NSString * amount;
@property (nonatomic,copy)NSString * averagePrice;
@property (nonatomic,copy)NSString * closePrice;
@property (nonatomic,copy)NSString * maxPrice;
@property (nonatomic,copy)NSString * minPrice;
@property (nonatomic,copy)NSString * curPrice;
@property (nonatomic,copy)NSString * openPrice;
@property (nonatomic,copy)NSString * stockId;
@property (nonatomic,copy)NSString * strokeCount;
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * volume;
@property (nonatomic,copy)NSString * mv;


@property (nonatomic,copy)NSString * changeValue;
@property (nonatomic,copy)NSString * changeValuePercent;


-(void)setValueWithJsonString:(NSString *)json;
-(void)setValueWithJsonString:(id)json andPointModel:(MarketHomeListModel *)model;

@end
