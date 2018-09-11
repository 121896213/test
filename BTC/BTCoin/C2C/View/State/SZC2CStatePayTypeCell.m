//
//  SZC2CStatePayTypeCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStatePayTypeCell.h"
#import "SZPaymentcodeView.h"
@implementation SZC2CStatePayTypeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=[UIColor whiteColor];

    }
    return self;
}

-(void)setSubView{
    
    UILabel*  titleLab=[UILabel new];
    titleLab.text=NSLocalizedString(@"支付方式", nil);
    titleLab.textColor=MainLabelBlackColor;
    titleLab.font = [UIFont systemFontOfSize:FIT(12)];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(16));
        make.left.mas_equalTo(FIT(16));
        make.width.mas_equalTo(FIT(60));
        make.height.mas_equalTo(FIT(30));

    }];
    

    UIButton* bankBtn=[UIButton new];
    [bankBtn setTitle:NSLocalizedString(@"银行卡", nil) forState:UIControlStateNormal];
    [bankBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [bankBtn setTitleColor:MainThemeBlueColor forState:UIControlStateSelected];
    [bankBtn setImage:[UIImage imageNamed:@"c2c_radio_normal"] forState:UIControlStateNormal];
    [bankBtn setImage:[UIImage imageNamed:@"c2c_radio_select"] forState:UIControlStateSelected];
    bankBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [bankBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    bankBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:bankBtn];
    [bankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLab.mas_right).offset(FIT(32));
        make.top.equalTo(titleLab.mas_top);
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(30));
       
    }];
    
    
    UIButton* weChatBtn=[UIButton new];
    [weChatBtn setTitle:NSLocalizedString(@"微信", nil) forState:UIControlStateNormal];
    [weChatBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [weChatBtn setTitleColor:MainThemeBlueColor forState:UIControlStateSelected];
    [weChatBtn setImage:[UIImage imageNamed:@"c2c_radio_normal"] forState:UIControlStateNormal];
    [weChatBtn setImage:[UIImage imageNamed:@"c2c_radio_select"] forState:UIControlStateSelected];
    weChatBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [weChatBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    weChatBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:weChatBtn];
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(30));
        make.left.equalTo(bankBtn.mas_right).offset(FIT(16));
        make.top.equalTo(titleLab.mas_top);
    }];
    
    UIButton* alipayBtn=[UIButton new];
    [alipayBtn setTitle:NSLocalizedString(@"支付宝", nil) forState:UIControlStateNormal];
    [alipayBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [alipayBtn setTitleColor:MainThemeBlueColor forState:UIControlStateSelected];
    [alipayBtn setImage:[UIImage imageNamed:@"c2c_radio_normal"] forState:UIControlStateNormal];
    [alipayBtn setImage:[UIImage imageNamed:@"c2c_radio_select"] forState:UIControlStateSelected];
    alipayBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [alipayBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    alipayBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:alipayBtn];
    [alipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(30));
        make.left.equalTo(weChatBtn.mas_right).offset(FIT(16));
        make.top.equalTo(titleLab.mas_top);
    }];
    
    
    UIButton* payCodeBtn=[UIButton new];
    [payCodeBtn setTitleColor:UIColorFromRGB(0x688DE8) forState:UIControlStateNormal];
    [payCodeBtn setTitle:NSLocalizedString(@"查看收款码", nil) forState:UIControlStateNormal];
    payCodeBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [payCodeBtn setCircleBorderWidth:FIT(1) bordColor:payCodeBtn.titleLabel.textColor radius:FIT(3)];
    [self addSubview:payCodeBtn];
    [payCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(73));
        make.height.mas_equalTo(FIT(24));
        make.right.mas_equalTo(FIT(-16));
        make.bottom.mas_equalTo(FIT(-12));
    }];
    
    UIButton* payTypeBtn=[UIButton new];
    [payTypeBtn setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [payTypeBtn setTitle:NSLocalizedString(@"邓思凡 sjhfdisj1008@126.com", nil) forState:UIControlStateNormal];
    [payTypeBtn setImage:[UIImage imageNamed:@"c2c_alipay"] forState:UIControlStateNormal];
    payTypeBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [payTypeBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    payTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [payTypeBtn setUserInteractionEnabled:NO];
    [self addSubview:payTypeBtn];
    [payTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(250));
        make.height.mas_equalTo(FIT(30));
        make.right.equalTo(payCodeBtn.mas_left).offset(FIT(-10));
        make.bottom.mas_equalTo(FIT(-12));
    }];
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.left.equalTo(titleLab.mas_left);
        make.bottom.mas_equalTo(-0.3);
        make.height.mas_equalTo(0.3);
        
    }];
    [[bankBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        
        [bankBtn setSelected:!bankBtn.isSelected];
        [weChatBtn setSelected:!bankBtn.isSelected];
        [alipayBtn setSelected:!bankBtn.isSelected];
        [payTypeBtn setTitle:NSLocalizedString(@"交通银行  65545455555555555", nil) forState:UIControlStateNormal];
        [payTypeBtn setImage:[UIImage imageNamed:@"22"] forState:UIControlStateNormal];
        
        [payCodeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(FIT(0));

        }];
        [payTypeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(payCodeBtn.mas_left).offset(FIT(0));

        }];
    }];
    
    [[weChatBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [weChatBtn setSelected:!weChatBtn.isSelected];
        [bankBtn setSelected:!weChatBtn.isSelected];
        [alipayBtn setSelected:!weChatBtn.isSelected];
        [payTypeBtn setTitle:NSLocalizedString(@"邓思凡 sjhfdisj1008", nil) forState:UIControlStateNormal];
        [payTypeBtn setImage:[UIImage imageNamed:@"c2c_wechat"] forState:UIControlStateNormal];
        
        
        [payCodeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(FIT(73));
        }];
        [payTypeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(payCodeBtn.mas_left).offset(FIT(-10));
        }];
    }];
    
    [[alipayBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [alipayBtn setSelected:!alipayBtn.isSelected];
        [bankBtn setSelected:!alipayBtn.isSelected];
        [weChatBtn setSelected:!alipayBtn.isSelected];
        [payTypeBtn setTitle:NSLocalizedString(@"邓思凡 sjhfdisj1008@126.com", nil) forState:UIControlStateNormal];
        [payTypeBtn setImage:[UIImage imageNamed:@"c2c_alipay"] forState:UIControlStateNormal];
        
        [payCodeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(FIT(73));
        }];
        [payTypeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(payCodeBtn.mas_left).offset(FIT(-10));
        }];
    }];
    
    [[payCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        SZPaymentcodeView* payCodeView =[[SZPaymentcodeView alloc]initWithFrame:CGRectMake(0, 0, FIT(300),FIT(300))];
        [payCodeView showInView:TheAppDel.window.rootViewController.view directionType:SZPopViewFromDirectionTypeCenter];
        
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
