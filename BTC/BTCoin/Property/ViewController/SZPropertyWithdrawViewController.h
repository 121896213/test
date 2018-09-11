//
//  SZPropertyRechargeViewController.h
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "CustomViewController.h"
#import "SZPropertyWithdrawViewModel.h"
#import "SZSecurityCodeViewModel.h"
@interface SZPropertyWithdrawViewController : CustomViewController
@property (nonatomic,strong) SZPropertyWithdrawViewModel* viewModel;
@property (nonatomic,strong) SZSecurityCodeViewModel* securityCodeViewModel;

@end
