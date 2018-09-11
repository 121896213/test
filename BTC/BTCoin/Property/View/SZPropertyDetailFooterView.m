//
//  SZPropertyDetailFooterView.m
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyDetailFooterView.h"

@implementation SZPropertyDetailFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}



-(void)setSubView{
    
    UIView* lineView=[[UIView alloc]init];
    lineView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(0.5));
        
    }];
    
    
    
    UIButton* rechargeBtn=[UIButton new];
    [rechargeBtn setBackgroundImage:[UIImage imageWithColor: UIColorFromRGB(0x03c087) ] forState:UIControlStateNormal];
    [rechargeBtn setBackgroundImage:[UIImage imageWithColor: UIColorFromRGB(0x03c000) ] forState:UIControlStateSelected];
    [rechargeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechargeBtn setTitle:NSLocalizedString(@"充币", nil) forState:UIControlStateNormal];
    [ShareFunction setCircleBorder:rechargeBtn];
    [self addSubview:rechargeBtn];
    self.rechargeBtn=rechargeBtn;
    
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT2(27));
        make.height.mas_equalTo(FIT2(80));
        make.width.mas_equalTo(FIT2(243));
        make.left.mas_equalTo(FIT2(40));
    }];
   
    
    
    UIButton* withdrawBtn=[UIButton new];
    [withdrawBtn setBackgroundImage:[UIImage imageWithColor: MainThemeColor ] forState:UIControlStateNormal];
    [withdrawBtn setBackgroundImage:[UIImage imageWithColor: UIColorFromRGB(0x00B500) ] forState:UIControlStateSelected];

    [withdrawBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [withdrawBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [withdrawBtn setTitle:NSLocalizedString(@"提币", nil) forState:UIControlStateNormal];
    [ShareFunction setCircleBorder:withdrawBtn];
    [self addSubview:withdrawBtn];
    self.withdrawBtn=withdrawBtn;
    
    [withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeBtn.mas_top);
        make.height.mas_equalTo(FIT2(80));
        make.width.mas_equalTo(FIT2(243));
        make.left.equalTo(rechargeBtn.mas_right).offset(FIT2(40));
    }];
    
 
    UIButton* tradeBtn=[UIButton new];
    [tradeBtn setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [tradeBtn setTitle:NSLocalizedString(@"去交易", nil) forState:UIControlStateNormal];
    [tradeBtn setImage:[UIImage imageNamed:@"property_detail_icon"] forState:UIControlStateNormal];
    [tradeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [tradeBtn setImagePositionWithType:SSImagePositionTypeRight spacing:10.f];
    [self addSubview:tradeBtn];
    self.tradebBtn=tradeBtn;
    [tradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(withdrawBtn.mas_right).offset(FIT2(40));
        make.height.mas_equalTo(FIT2(80));
        make.width.mas_equalTo(FIT2(200));
        make.top.mas_equalTo(withdrawBtn.mas_top);
        
    }];
    
}


- (void)setWalletType:(SZWalletType)walletType{
    _walletType=walletType;
    if (walletType  == SZWalletTypeBB) {
        
    }else if (walletType == SZWalletTypeC2C){
        [self.withdrawBtn setTitle:NSLocalizedString(@"转出", nil) forState:UIControlStateNormal];
        [self.rechargeBtn setTitle:NSLocalizedString(@"转入", nil) forState:UIControlStateNormal];

    }
    
}
@end
