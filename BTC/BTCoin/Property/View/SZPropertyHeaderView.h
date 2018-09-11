//
//  SZPropertyHeaderView.h
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyViewModel.h"
#import "SZWalletViewModel.h"
@interface SZPropertyHeaderView : UIView

@property (nonatomic,strong) UILabel* totalPropertyLabel;
@property (nonatomic,strong) UILabel* normalPropertyLabel;
@property (nonatomic,strong) UILabel* convertPropertyLabel;
@property (nonatomic,strong) UIImageView* backgroundImageView;
@property (nonatomic,strong) UIButton* backButton;


@property (nonatomic,strong) SZPropertyViewModel* viewModel;
@property (nonatomic,strong) SZWalletListModel* walletListModel;
@property (nonatomic,strong) SZWalletModel* walletModel;

@end
