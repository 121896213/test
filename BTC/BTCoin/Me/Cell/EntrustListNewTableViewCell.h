//
//  EntrustListNewTableViewCell.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TradeDataModel.h"

#define kEntrustListTableViewCellReuseID @"kEntrustListTableViewCellReuseID"
typedef void(^CancelEntrust)(void);

@interface EntrustListNewTableViewCell : UITableViewCell

@property (nonatomic,copy)CancelEntrust cancel;
-(void)setCellWithModel:(TradeDataModel *)model isOpen:(BOOL)isOpen;

@end
