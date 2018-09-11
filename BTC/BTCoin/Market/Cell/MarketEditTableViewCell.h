//
//  MarketEditTableViewCell.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMarketEditTableViewCellReuseID @"kMarketEditTableViewCellReuseID"

@interface MarketEditTableViewCell : UITableViewCell

@property (nonatomic,copy)void (^goTopBlock) (void);
@property (nonatomic,copy)void (^setSelBlock) (BOOL);

-(void)setCellWithTitle:(NSString *)title isSel:(BOOL)isSel;
@end
