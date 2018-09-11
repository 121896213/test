//
//  MarkDeatilViewController.h
//  BTCoin
//
//  Created by zzg on 2018/4/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "CustomViewController.h"
#import "MarketHomeListModel.h"

@interface MarkDeatilViewController : CustomViewController

@property (nonatomic,strong)MarketHomeListModel * model;
@property (nonatomic,copy)NSString * areaName;
@property (nonatomic,copy)NSString * marketCoinType;

@end
