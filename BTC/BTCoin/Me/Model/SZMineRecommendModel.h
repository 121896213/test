//
//  SZMineRecommendModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"
#import "SZBaseListModel.h"
@interface SZMineRecommendListModel : SZBaseListModel

@property (nonatomic,assign)NSInteger directUserCount;
@property (nonatomic,assign)NSInteger indirectUserCount;

@end

@interface SZMineRecommendModel : SZBaseModel

@property (nonatomic,copy)NSString* recommendAccount;
@property (nonatomic,copy)NSString* recommendRealName;
@property (nonatomic,copy)NSString* account;
@property (nonatomic,copy)NSString* recommendTime;
@property (nonatomic,copy)NSString* isValid;
@property (nonatomic,assign)NSInteger recommendCount;


@end
