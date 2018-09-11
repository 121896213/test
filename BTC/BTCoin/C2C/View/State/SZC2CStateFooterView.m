//
//  SZC2CStateFooterView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStateFooterView.h"
@interface SZC2CStateFooterView()
@property (nonatomic, strong) UILabel*  tipLab;
@property (nonatomic, strong) UILabel*  orderIdLab;
@property (nonatomic, strong) UIButton* commitBtn;
@property (nonatomic, strong) UIButton* canelBtn;
@property (nonatomic, strong) UIButton* appealBtn;

@end


@implementation SZC2CStateFooterView
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
    

    UILabel* tipLab=[UILabel new];
    tipLab.textColor=UIColorFromRGB(0xFF0000);
    tipLab.text=NSLocalizedString(@"请确认对方在线再付款", nil);
    tipLab.textAlignment=NSTextAlignmentCenter;
    tipLab.font=[UIFont systemFontOfSize:FIT(12)];
    [self addSubview: tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(14));
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(tipLab.font.lineHeight);
    }];
    
    
    
    UIButton* commitBtn=[UIButton new];
    [commitBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(14.0)]];
    [commitBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [commitBtn setTitle:NSLocalizedString(@"提醒买家付款", nil) forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLab.mas_bottom).offset(FIT(16));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(50));
    }];
    [commitBtn setGradientBackGround];
    
    UIButton* cancelBtn=[UIButton new];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(14.0)]];
    [cancelBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [cancelBtn setTitle:NSLocalizedString(@"取消交易", nil) forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColorFromRGB(0x6790F9) forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commitBtn.mas_bottom).offset(FIT(16));
        make.left.mas_equalTo(FIT(54));
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(30));
    }];
    UIButton* appealBtn=[UIButton new];
    [appealBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(14.0)]];
    [appealBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [appealBtn setTitle:NSLocalizedString(@"我要申诉", nil) forState:UIControlStateNormal];
    [appealBtn setTitleColor:UIColorFromRGB(0x6790F9) forState:UIControlStateNormal];
    [self addSubview:appealBtn];
    [appealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commitBtn.mas_bottom).offset(FIT(16));
        make.right.mas_equalTo(FIT(-54));
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(30));
    }];
    
    
    UIView* promptView=[UIView new];
    promptView.backgroundColor=UIColorFromRGB(0xF2F4F9);
    [self addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(appealBtn.mas_bottom).offset(FIT(27));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(184));
    }];
    
    UILabel* promptLab=[UILabel new];
    promptLab.text=NSLocalizedString(@"\n交易提醒\n1、您的汇款将直接进入卖家账户，交易过程中卖方出售的数字资产由平台托管保护。\n2、请在规定时间内完成付款，并务必点击我已付款，卖方确认收款后，系统会将数字资产划转到您的账户。\n3、买方当日连接3笔或累计6笔取消，广告方当日取消率超过30%，会限制当天的买入功能。\n", nil) ;
    promptLab.font=[UIFont systemFontOfSize:FIT(12.0)];
    promptLab.textColor=MainLabelGrayColor;
    promptLab.numberOfLines=0;
    [promptView addSubview:promptLab];
    [promptLab setLabelParagraphStyle];
    CGFloat height=[promptLab getLabelParagraphStyleHeightWithWidth:ScreenWidth-FIT(32)]+promptLab.font.lineHeight;
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(height);
    
    }];
    
    self.tipLab=tipLab;
    self.commitBtn=commitBtn;
    self.canelBtn=cancelBtn;
    self.appealBtn=appealBtn;
    
    
}

@end
