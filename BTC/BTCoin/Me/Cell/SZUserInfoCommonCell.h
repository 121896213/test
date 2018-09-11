//
//  SZUserInfoCommonCell.h
//  BTCoin
//
//  Created by sumrain on 2018/7/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SZUserInfoCommonCellHeight FIT(50)
#define SZUserInfoCommonCellReuseIdentifier  @"SZUserInfoCommonCellReuseIdentifier"

@interface SZUserInfoCommonCell : UITableViewCell
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UIButton* detailBtn;
@property (nonatomic,strong) UIButton* rightBtn;
@end
