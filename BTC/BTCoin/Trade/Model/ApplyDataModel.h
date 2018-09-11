//
//  ApplyDataModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplyDataModel : NSObject

//@property (nonatomic,copy)NSString * createTime;
//@property (nonatomic,copy)NSString * dateDifferDay;
//@property (nonatomic,copy)NSString * dealCount;
//@property (nonatomic,copy)NSString * dealPrice;
//@property (nonatomic,copy)NSString * fees;
//@property (nonatomic,copy)NSString * ftrademapping;
//@property (nonatomic,copy)NSString * grantRate;
//@property (nonatomic,copy)NSString * fvirtualcointypeName1;
//@property (nonatomic,copy)NSString * fvirtualcointypeName2;//

@property (nonatomic,copy)NSString * fees;//：手续费
@property (nonatomic,copy)NSString * lockDays;//：锁仓天数
@property (nonatomic,copy)NSString * orderId;//：订单号
@property (nonatomic,copy)NSString * fvirtualcointypeName1;//：市场
@property (nonatomic,copy)NSString * fvirtualcointypeName2;//：虚拟币
@property (nonatomic,copy)NSString * dateDifferDay;//：剩余天数
@property (nonatomic,copy)NSString * grantRate;//：已放利息
@property (nonatomic,copy)NSString * direction;//：方向
@property (nonatomic,copy)NSString * createTime;//：创建时间
@property (nonatomic,copy)NSString * createTimeSdf;//：格式化后创建时间
@property (nonatomic,copy)NSString * dealPrice;//：价格
@property (nonatomic,copy)NSString * dealCount;//：申购数量
@property (nonatomic,copy)NSString * profitLoss;//:盈亏
@property (nonatomic,copy)NSString * tradeBuyEndTime;//: 1530264824000 //锁仓截止时间
@property (nonatomic,assign)NSInteger beginStatus;// 1 //是否可以加仓
@property (nonatomic,copy)NSNumber * cnyPrice;//"21.42", //人民币计价的最初申购价格

@property (nonatomic,assign)NSInteger fcount2;//数量小数位
@property (nonatomic,assign)NSInteger fcount1;//单价小数位

@property (nonatomic,copy)NSString * fvirtualcointype2;
@property (nonatomic,copy)NSString * fvirtualcointype1;
@property (nonatomic,copy)NSString * ftrademapping;

@property (nonatomic,copy)NSString * buyType;;

-(void)dealDataWithDictionary:(NSDictionary *)dict;
-(NSMutableAttributedString *)youTeShuZuoyong;

-(NSString *)limitTimeString;

@end
