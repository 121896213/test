//
//  RecordNewTableViewCell.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TradeDataModel.h"
#import "RecordDataModel.h"

#define kRecordNewTableViewCellReuseID @"kRecordNewTableViewCellReuseID"

@interface RecordNewTableViewCell : UITableViewCell

-(void)setCellWithModel:(RecordDataModel *)model;

@end
