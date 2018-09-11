//
//  SZRecommendRewardModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"
#import "SZBaseListModel.h"


@interface SZPromotionRecordListModel : SZBaseListModel
@property (nonatomic,copy)NSString* totalAmount;
@property (nonatomic,copy)NSArray* coinList;

@end


@interface SZPromotionRecordModel : SZBaseModel
@property (nonatomic,copy)NSString* orderDealTime;
@property (nonatomic,copy)NSString* userRealName;
@property (nonatomic,copy)NSString* grantRewardAmount;
@property (nonatomic,copy)NSString* virtualCurrency;
@end
