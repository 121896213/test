//
//  SZSCPropertyModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"

@interface SZSCPropertyModel : SZBaseModel
@property (nonatomic,copy) NSString* scID;
@property (nonatomic,copy) NSString* assets;
@property (nonatomic,copy) NSString* sumGrantRate;
@property (nonatomic,copy) NSString* shortName;
@property (nonatomic,copy) NSString* currencyType;

@property (nonatomic,copy)NSString* dayAssets;
@property (nonatomic,copy)NSString* sumNotGrantRate;
@property (nonatomic,copy)NSString* profitLoss;

@end
