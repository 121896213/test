//
//  SZC2CStateHeaderView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStateHeaderView.h"
@interface SZC2CStateHeaderView()
@property (nonatomic, strong) UILabel*  titleLab;
@property (nonatomic, strong) UILabel*  orderIdLab;
@property (nonatomic, strong) UIButton* contactBtn;

@end
@implementation SZC2CStateHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
        self.backgroundColor=MainC2CBackgroundColor;
    }
    return self;
}



-(void)setSubView{
    
    
    UILabel* titleLab=[UILabel new];
    titleLab.text=NSLocalizedString(FormatString(@"卖出%@",@"USDT"), nil);
    titleLab.font=[UIFont systemFontOfSize:FIT(16.0f)];
    titleLab.textColor=MainLabelBlackColor;
    [self addSubview:titleLab];
    self.titleLab=titleLab;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(16));
        make.left.mas_equalTo(FIT(0));
        make.height.mas_equalTo(titleLab.font.lineHeight);
        make.width.mas_equalTo(FIT(300));
    }];
    
    UILabel* orderIdLab=[UILabel new];
    orderIdLab.text=NSLocalizedString(FormatString(@"订单号:%@",@"#567eewrwtt434464646676767"), nil);
    orderIdLab.font=[UIFont systemFontOfSize:FIT(16.0f)];
    orderIdLab.textColor=MainLabelGrayColor;
    [self addSubview:orderIdLab];
    self.orderIdLab=orderIdLab;
    [orderIdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(FIT(16));
        make.left.equalTo(titleLab.mas_left);
        make.height.mas_equalTo(titleLab.font.lineHeight);
        make.width.mas_equalTo(FIT(300));
    }];
    
    UIButton* contactBtn=[UIButton new];
    [contactBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [contactBtn setTitle:NSLocalizedString(@"联系买家", nil) forState:UIControlStateNormal];
    [contactBtn setImage:[UIImage imageNamed:@"ad_tip"] forState:UIControlStateNormal];
    contactBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [contactBtn setImagePositionWithType:SSImagePositionTypeRight spacing:10.f];
    contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:contactBtn];
    self.contactBtn=contactBtn;
    [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(87));
        make.height.mas_equalTo(FIT(25));
        make.right.mas_equalTo(FIT(-17));
        make.top.mas_equalTo(FIT(9));
    }];
    [contactBtn setCircleBorderWidth:FIT(1) bordColor:UIColorFromRGB(0x6790F9) radius:FIT(3)];
    

    
    
}

@end
