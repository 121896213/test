//
//  SZC2CAdFooterView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdFooterView.h"



@implementation SZC2CAdFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=MainC2CBackgroundColor;
        [self setSubView];
        
    }
    return self;
}



-(void)setSubView{
    
    UIButton* agreeBtn=[UIButton new];
    [agreeBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [agreeBtn setTitle:NSLocalizedString(@"我已遵守并同意《交易守则》", nil) forState:UIControlStateNormal];
    [agreeBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"c2c_check_normal"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"c2c_check_select"] forState:UIControlStateSelected];
    [[agreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [agreeBtn setSelected:!agreeBtn.isSelected];
    }];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [agreeBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    agreeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [agreeBtn.titleLabel setAttributedTextColorWithBeforeString:NSLocalizedString(@"我已遵守并同意", nil)  beforeColor:MainLabelGrayColor afterString:NSLocalizedString(@"《交易守则》", nil) afterColor:MainThemeBlueColor];
    [self addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(200));
        make.height.mas_equalTo(FIT(30));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(FIT(10));
    }];
  
    self.agreeBtn=agreeBtn;
    
    UIButton* commitBtn=[UIButton new];
    [commitBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [commitBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [commitBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(agreeBtn.mas_bottom).offset(FIT(10));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(50));
    }];
    [commitBtn setGradientBackGround];

    
}

@end
