//
//  SZC2CAdAmountPartCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdAmountPartCell.h"

@implementation SZC2CAdAmountPartCell
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
    titleLab.text=NSLocalizedString(@"所属分区", nil);
    titleLab.textColor=MainLabelBlackColor;
    titleLab.font = [UIFont systemFontOfSize:FIT(14)];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(SZC2CAdAmountPartCellHeight);
        make.left.mas_equalTo(FIT(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    UIButton* normalDealBtn=[UIButton new];
    [normalDealBtn setTitleColor:MainThemeColor forState:UIControlStateSelected];
    [normalDealBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];

    [normalDealBtn setTitle:NSLocalizedString(@"普通交易区", nil) forState:UIControlStateNormal];
    [normalDealBtn setImage:[UIImage imageNamed:@"c2c_radio_normal"] forState:UIControlStateNormal];
    [normalDealBtn setImage:[UIImage imageNamed:@"c2c_radio_select"] forState:UIControlStateSelected];
    normalDealBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [normalDealBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    normalDealBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self addSubview:normalDealBtn];
    [normalDealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(120));
        make.height.mas_equalTo(FIT(30));
        make.left.equalTo(titleLab.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
   
    
    UIButton* bigDealBtn=[UIButton new];
    [bigDealBtn setTitleColor:MainThemeColor forState:UIControlStateSelected];
    [bigDealBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [bigDealBtn setTitle:NSLocalizedString(@"大宗交易区", nil) forState:UIControlStateNormal];
    [bigDealBtn setImage:[UIImage imageNamed:@"c2c_radio_normal"] forState:UIControlStateNormal];
    [bigDealBtn setImage:[UIImage imageNamed:@"c2c_radio_select"] forState:UIControlStateSelected];

    bigDealBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [bigDealBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    bigDealBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self addSubview:bigDealBtn];
    [bigDealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(120));
        make.height.mas_equalTo(FIT(30));
        make.left.equalTo(normalDealBtn.mas_right).offset(FIT(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [[bigDealBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [bigDealBtn setSelected:!bigDealBtn.isSelected];
        [normalDealBtn setSelected:!bigDealBtn.isSelected];
        
    }];
    
    [[normalDealBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [normalDealBtn setSelected:!normalDealBtn.isSelected];
        [bigDealBtn setSelected:!normalDealBtn.isSelected];
        
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
