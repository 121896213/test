//
//  MePageTableViewCell.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMePageTableViewCellReuseID @"MePageTableViewCell"
@interface MePageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *remindImageView;
@end
