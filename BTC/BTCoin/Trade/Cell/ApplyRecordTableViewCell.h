//
//  ApplyRecordTableViewCell.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ApplyDataModel.h"
#define kApplyRecordTableViewCellResueID @"kApplyRecordTableViewCellResueID"

@interface ApplyRecordTableViewCell : UITableViewCell

-(void)setCellWithModel:(ApplyDataModel *)model;
@property (nonatomic,copy)void (^addStoreBlock)(void);

@end
