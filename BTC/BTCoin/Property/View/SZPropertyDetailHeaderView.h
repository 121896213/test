//
//  SZPropertyDetailHeaderView.h
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyCellViewModel.h"
@interface SZPropertyDetailHeaderView : UIView
@property (nonatomic,strong) UILabel* ablePropertyCountLabel;
@property (nonatomic,strong) UILabel* unablePropertyCountLabel;
@property (nonatomic,strong) UILabel* BTCTypeLabel;
@property (nonatomic,strong) UIButton* backButton;
@property (nonatomic,strong) UIButton* totalRecordButton;
@property (nonatomic,strong) SZPropertyCellViewModel* viewModel;

@end
