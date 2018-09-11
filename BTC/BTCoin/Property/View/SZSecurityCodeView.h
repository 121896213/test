//
//  SZSecurityCodeView.h
//  BTCoin
//
//  Created by Shizi on 2018/5/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPopView.h"
#import "SZSecurityCodeViewModel.h"
#import "SZPropertyWithdrawViewModel.h"
#import "SZAddressEditViewModel.h"

@interface SZSecurityCodeView : SZPopView

@property (nonatomic,strong) UIButton* confirmBtn;
@property (nonatomic,strong) UITextField* securityTextField;


@property (nonatomic,strong) SZSecurityCodeViewModel* viewModel;

@property (nonatomic,strong) SZPropertyWithdrawViewModel* withDrawViewModel;


@property (nonatomic,strong) SZAddressEditViewModel* addressEditViewModel;

@end
