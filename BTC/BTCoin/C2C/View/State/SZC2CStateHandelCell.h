//
//  SZC2CStateHandelCell.h
//  BTCoin
//
//  Created by sumrain on 2018/8/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SZC2CStateHandelCellHeight FIT(60)
#define SZC2CStateHandelCellReuseIdentifier  @"SZC2CStateHandelCellReuseIdentifier"
@interface SZC2CStateHandelCell : UITableViewCell
-(void)setHandleBtnTitle:(NSString*)title;
@end
