//
//  SZWithdrawFooterView.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWithdrawFooterView.h"

@implementation SZWithdrawFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
}

-(void)setSubView{
    
    UIButton* rechargeBtn=[[UIButton alloc]init];
    [rechargeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechargeBtn setTitle:NSLocalizedString(@"提币", nil) forState:UIControlStateNormal];
   
    [ShareFunction setCircleBorder:rechargeBtn];

    [self addSubview:rechargeBtn];
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT3(-170));
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth-FIT3(48)*2);
        make.height.mas_equalTo(FIT3(146));
    }];
    [rechargeBtn setGradientBackGround];
    [rechargeBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    self.rechargeBtn=rechargeBtn;

    [self addActions];
}

-(void)addActions{
    
    [[self.rechargeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       
        NSString* errorMsg;
        if (isEmptyString(self.withdrawViewModel.currentAddress)) {
            errorMsg=NSLocalizedString(@"请输入提币地址", nil);
        }else if (isEmptyString(self.withdrawViewModel.currentCoinCount)){
            errorMsg=NSLocalizedString(@"请输入提币数量", nil);
        }else if (![UserInfo sharedUserInfo].isTradePassword){
            errorMsg=NSLocalizedString(@"请设置交易密码", nil);
        }else if (isEmptyString(self.withdrawViewModel.currentPassword)){
            errorMsg=NSLocalizedString(@"请输入提币交易密码", nil);
        }
        if (isEmptyString(errorMsg)) {
            [(RACSubject*)self.withdrawViewModel.otherSignal sendNext:@"RechargeButtonTouchUpInside"];

        }else{
            [(RACSubject*)self.withdrawViewModel.failureSignal sendNext:errorMsg];

        }
    }];
    
}

@end
