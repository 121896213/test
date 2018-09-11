//
//  SZPersonCenterHeadView.h
//  BTCoin
//
//  Created by Shizi on 2018/6/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyViewModel.h"
#import "UserInfo.h"
@interface SZPersonCenterHeadView : UIView

@property(nonatomic, strong) UIButton* loginBtn;
@property(nonatomic,strong) UIImageView* backgroundImageView;
@property(nonatomic, strong) UIButton* rightBtn;
@property(nonatomic, strong) UIButton* closeBtn;
@property(nonatomic, strong) UIButton* handleBtn;
@property(nonatomic, strong)UIView* promptView;

@property(nonatomic, strong)SZPropertyViewModel* propertyViewModel;
@property(nonatomic, strong)UserInfo* info;

@end
