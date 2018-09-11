//
//  SZTextFieldCommonCell.h
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SZTextFieldCommonCellHeight FIT(50)
#define SZTextFieldCommonCellReuseIdentifier  @"SZTextFieldCommonCellReuseIdentifier"

@interface SZTextFieldCommonCell : UITableViewCell
@property (nonatomic,strong) UITextField* textField;
@property (nonatomic,strong) UILabel* titleLab;
@property (nonatomic,strong) UIButton* rightBtn;
@end
