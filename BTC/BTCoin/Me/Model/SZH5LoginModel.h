//
//  SZH5LoginModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/26.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"

@interface SZH5LoginModel : SZBaseModel
@property (nonatomic,assign)BOOL hasRealValidate;
@property (nonatomic,copy)NSString* redisTokenKey;
@property (nonatomic,copy)NSString* userId;
@property (nonatomic,copy)NSString* tokenMsg;
@property (nonatomic,copy)NSString* token;

@end
