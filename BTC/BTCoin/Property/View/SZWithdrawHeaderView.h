//
//  SZWithdrawHeaderView.h
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyCellViewModel.h"
#define SZWithdrawHeaderViewHight FIT(200)

@interface SZWithdrawHeaderView : UIView

@property (nonatomic,strong) UIButton* backBtn;
@property (nonatomic,strong) SZPropertyCellViewModel* propertyCellViewModel;

@end
