//
//  TradeDataModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**交易数据Model*/
@interface TradeDataModel : NSObject

@property (nonatomic,copy)NSString * fid;//委托id
@property (nonatomic,copy)NSString * fprize;//委托单价
@property (nonatomic,copy)NSString * fcount;//委托数量
//@property (nonatomic,copy)NSString * fvirtualcoin;//交易币/法币
@property (nonatomic,copy)NSString * fvirtualcoin1;//法币
@property (nonatomic,copy)NSString * fvirtualcoin2;//交易币
@property (nonatomic,copy)NSString * fcreateTime;//委托时间
@property (nonatomic,assign)BOOL  fisLimit;//1市价委托,0限价委托
@property (nonatomic,copy)NSString * fsuccessAmount;//成交金额
@property (nonatomic,assign)TradeState fstatus; //状态:1未完成,2部分成交,3完全成交,4用户撤销
@property (nonatomic,copy)NSString * fAvgPrize;//平均价
@property (nonatomic,assign)TradeVCType fentrustType;//类型:0买入,1卖出
@property (nonatomic,copy)NSString * fsuccessCount;//成交量
@property (nonatomic,copy)NSString * ffees; //手续费
@property (nonatomic,copy)NSString * famount;//委托金额

-(void)setValueWithJson:(id)Json;

@property (nonatomic,copy)NSString * statusString; //成交状态

@end

