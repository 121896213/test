//
//  SZCommissRecordModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"
#import "SZBaseListModel.h"


@interface SZCommissRecordListModel : SZBaseListModel
@property (nonatomic,copy)NSString* sumFeesUSDT;
@property (nonatomic,copy)NSString* directSumFeesUSDT;
@property (nonatomic,copy)NSString* indirectSumFeesUSDT;

@end


@interface SZCommissRecordModel : SZBaseModel
@property (nonatomic,copy)NSString* account;
@property (nonatomic,copy)NSString* rebateTime;
@property (nonatomic,copy)NSString* isValid;
@property (nonatomic,copy)NSString* rebateType;
@property (nonatomic,copy)NSString* feesUSDT;

@end
