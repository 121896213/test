//
//  SZC2CTradeCommonCell.h
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SZTradeCommonCellHeight FIT(76)
#define SZTradeCommonCellReuseIdentifier  @"SZTradeCommonCellReuseIdentifier"
@interface SZC2CTradeCommonCell : UITableViewCell
@property (nonatomic, strong) UITextField*  textField;
-(void)setContentStyle:(NSIndexPath*) indexPath isTradeSell:(BOOL)isTradeSell;
@end
