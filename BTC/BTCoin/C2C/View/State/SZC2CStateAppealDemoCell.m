//
//  SZC2CStateAppealDemoCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStateAppealDemoCell.h"

@implementation SZC2CStateAppealDemoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=MainC2CBackgroundColor;
        
    }
    return self;
}

-(void)setSubView{
    UILabel* appealTitleLab=[UILabel new];
    appealTitleLab.text=NSLocalizedString(@"上传资料", nil);
    appealTitleLab.textColor=MainLabelBlackColor;
    appealTitleLab.font = [UIFont systemFontOfSize:FIT(16)];
    [self addSubview:appealTitleLab];
    [appealTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(78));
        make.height.mas_equalTo(appealTitleLab.font.lineHeight);
        make.left.mas_equalTo(FIT(0));
        make.top.mas_equalTo(FIT(10));
    }];
    UIButton* sampleBtn=[UIButton new];
    [sampleBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [sampleBtn setTitle:NSLocalizedString(@"示例一", nil) forState:UIControlStateNormal];
    [sampleBtn setImage:[UIImage imageNamed:@"ad_tip"] forState:UIControlStateNormal];
    sampleBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [sampleBtn setImagePositionWithType:SSImagePositionTypeTop spacing:10.f];
    sampleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sampleBtn setCircleBorderWidth:FIT(1) bordColor:LineColor radius:FIT(1)];
    [self addSubview:sampleBtn];
    [sampleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(82));
        make.height.mas_equalTo(FIT(82));
        make.left.mas_equalTo(FIT(0));
        make.top.equalTo(appealTitleLab.mas_bottom).offset(FIT(13));
    }];
    
    UIButton* sampleBtn2=[UIButton new];
    [sampleBtn2 setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [sampleBtn2 setTitle:NSLocalizedString(@"示例二", nil) forState:UIControlStateNormal];
    [sampleBtn2 setImage:[UIImage imageNamed:@"ad_tip"] forState:UIControlStateNormal];
    sampleBtn2.titleLabel.font = [UIFont systemFontOfSize:FIT(12)];
    [sampleBtn2 setImagePositionWithType:SSImagePositionTypeTop spacing:10.f];
    sampleBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sampleBtn2 setCircleBorderWidth:FIT(1) bordColor:LineColor radius:FIT(1)];
    
    [self addSubview:sampleBtn2];
    [sampleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(82));
        make.height.mas_equalTo(FIT(82));
        make.left.equalTo(sampleBtn.mas_right).offset(FIT(15));
        make.top.equalTo(sampleBtn.mas_top);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
