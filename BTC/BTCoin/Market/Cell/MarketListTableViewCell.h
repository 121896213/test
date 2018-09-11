//
//  MarketListTableViewCell.h
//  BTCoin
//
//  Created by zzg on 2018/4/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketHomeListModel.h"

#define kMarketListTableViewCellReuseID @"kMarketListTableViewCellReuseID"

@interface MarketListTableViewCell : UITableViewCell

@property (nonatomic,copy)void (^addCollectBlock)(NSString * name);
@property (nonatomic,copy)void (^removeCollectBlock)(NSString * name);

-(void)setMarketModel:(MarketHomeListModel *)model isAddPage:(BOOL)isAddPage;
@end
