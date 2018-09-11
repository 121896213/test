//
//  SZScPropertyRecordModel.h
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "BaseModel.h"
//"changeAmount": 9.98, //变动金额
//"changeType": 10, 变动类型（10:买入,20利息,30解锁）
//"createTime": 1528700376000//变动时间

@interface SZScPropertyRecordModel : BaseModel
@property (nonatomic,copy) NSString* changeAmount;
@property (nonatomic,copy) NSString* changeType;
@property (nonatomic,copy) NSString* createTime;

@end
