//
//  SZBusinessInfoHeadView.h
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@interface SZBusinessInfoHeadView : UIView
@property (nonatomic,strong) UIImageView* backgroundImageView;
@property (nonatomic,strong) UIButton* backButton;
@property(nonatomic, strong) UIButton* headBtn;
@property(nonatomic, strong) UILabel* nickLab;
@property(nonatomic, strong) CWStarRateView* starRateView;
@end
