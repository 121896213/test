//
//  SZC2CAdPayTypeCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdPayTypeCell.h"

@implementation SZC2CAdPayTypeCell
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
    titleLab.text=NSLocalizedString(@"收款方式", nil);
    titleLab.textColor=MainLabelBlackColor;
    titleLab.font = [UIFont systemFontOfSize:FIT(14)];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(78));
        make.height.mas_equalTo(SZC2CAdPayTypeCellHeight);
        make.left.mas_equalTo(FIT(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.left.equalTo(titleLab.mas_right);
        make.bottom.mas_equalTo(-0.3);
        make.height.mas_equalTo(0.3);
        
    }];
    
    UIButton* bankBtn=[UIButton new];
    [bankBtn setTitle:NSLocalizedString(@"银行卡", nil) forState:UIControlStateNormal];
    [bankBtn setTitleColor:MainThemeBlueColor forState:UIControlStateSelected];
    [bankBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];

    [bankBtn setImage:[UIImage imageNamed:@"c2c_check_select"] forState:UIControlStateSelected];
    [bankBtn setImage:[UIImage imageNamed:@"c2c_check_normal"] forState:UIControlStateNormal];

    bankBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [bankBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    bankBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self addSubview:bankBtn];
    [bankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(30));
        make.left.equalTo(titleLab.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    UIButton* weChatBtn=[UIButton new];
    [weChatBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [weChatBtn setTitleColor:MainThemeBlueColor forState:UIControlStateSelected];

    [weChatBtn setTitle:NSLocalizedString(@"微信", nil) forState:UIControlStateNormal];
    [weChatBtn setImage:[UIImage imageNamed:@"c2c_check_normal"] forState:UIControlStateNormal];
    [weChatBtn setImage:[UIImage imageNamed:@"c2c_check_select"] forState:UIControlStateSelected];

    weChatBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [weChatBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    weChatBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self addSubview:weChatBtn];
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(30));
        make.left.equalTo(bankBtn.mas_right).offset(FIT(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UIButton* alipayBtn=[UIButton new];
    [alipayBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [alipayBtn setTitleColor:MainThemeBlueColor forState:UIControlStateSelected];

    [alipayBtn setTitle:NSLocalizedString(@"支付宝", nil) forState:UIControlStateNormal];
    [alipayBtn setImage:[UIImage imageNamed:@"c2c_check_normal"] forState:UIControlStateNormal];
    [alipayBtn setImage:[UIImage imageNamed:@"c2c_check_select"] forState:UIControlStateSelected];

    alipayBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [alipayBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    alipayBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self addSubview:alipayBtn];
    [alipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(30));
        make.left.equalTo(weChatBtn.mas_right).offset(FIT(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    [[bankBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        
        [bankBtn setSelected:!bankBtn.isSelected];
//        [weChatBtn setSelected:!bankBtn.isSelected];
//        [alipayBtn setSelected:!bankBtn.isSelected];

    }];
    
    [[weChatBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [weChatBtn setSelected:!weChatBtn.isSelected];
//        [bankBtn setSelected:!weChatBtn.isSelected];
//        [alipayBtn setSelected:!weChatBtn.isSelected];

    }];
    
    [[alipayBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [alipayBtn setSelected:!alipayBtn.isSelected];
//        [bankBtn setSelected:!alipayBtn.isSelected];
//        [weChatBtn setSelected:!alipayBtn.isSelected];

    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
