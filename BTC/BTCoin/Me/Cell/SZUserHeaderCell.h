//
//  SZUserHeaderCell.h
//  BTCoin
//
//  Created by sumrain on 2018/7/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SZUserHeaderCellHeight FIT(100)

#define SZUserHeaderCellReuseIdentifier  @"SZUserHeaderCellReuseIdentifier"
@interface SZUserHeaderCell : UITableViewCell
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UIImageView* headerImageView;
@property (nonatomic,strong) UIButton* rightBtn;
@end
