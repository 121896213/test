//
//  SZPropertyDetailFooterView.h
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZWalletModel.h"
@interface SZPropertyDetailFooterView : UIView
@property (nonatomic,assign) SZWalletType walletType;
@property (nonatomic,strong) UIButton* rechargeBtn;
@property (nonatomic,strong) UIButton* withdrawBtn;
@property (nonatomic,strong) UIButton* tradebBtn;
@end
