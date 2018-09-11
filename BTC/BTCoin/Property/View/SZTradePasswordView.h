//
//  SZTradePasswordView.h
//  BTCoin
//
//  Created by sumrain on 2018/7/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPopView.h"
typedef void(^ConfirmBlock)(NSString* password);

@interface SZTradePasswordView : SZPopView

@property (nonatomic,strong) UIButton* confirmBtn;
@property (nonatomic,strong) UITextField* passwordTextField;
@property (nonatomic,copy) ConfirmBlock confirmBlock;

@end
