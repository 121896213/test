//
//  SZWithdrawFooterView.h
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZPropertyWithdrawViewModel.h"
@interface SZWithdrawFooterView : UIView
@property (nonatomic,strong) UIButton* rechargeBtn;
@property (nonatomic,strong) SZPropertyWithdrawViewModel* withdrawViewModel;
@end
