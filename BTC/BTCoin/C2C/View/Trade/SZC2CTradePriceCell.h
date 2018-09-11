//
//  SZC2CTradePriceCell.h
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SZC2CTradePriceCellHeight FIT(113)
#define SZC2CTradePriceCellReuseIdentifier  @"SZC2CTradePriceCellReuseIdentifier"
typedef void(^Action)(id sender);

@interface SZC2CTradePriceCell : UITableViewCell
@property (nonatomic,copy) Action action;
@end
