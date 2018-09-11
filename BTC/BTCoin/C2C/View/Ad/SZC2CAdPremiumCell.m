//
//  SZC2CAdPremiumCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdPremiumCell.h"

@implementation SZC2CAdPremiumCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=[UIColor whiteColor];

    }
    return self;
}

-(void)setSubView{
    
    UIButton * button = [UIButton new];
    button.backgroundColor = UIColorFromRGB(0xFFFFFF);
    [button setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [button setTitle:NSLocalizedString(@"溢价", nil) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ad_tip"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:FIT(14)];
    [button setImagePositionWithType:SSImagePositionTypeRight spacing:10.f];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        JCAlertController *alert = [JCAlertController alertWithTitle:@"溢价" message:@"基于市场价的溢出比例,市场价是根据部分大型交易所实时价格得出的,确保您的报价趋于一个相对合理的范围,比如当前价格为5000,溢价比例为10%,那么价格为5500。"];
        [alert addButtonWithTitle:@"我知道了" type:JCButtonTypeWarning clicked:nil];
        [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
        

    }];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(78));
        make.height.mas_equalTo(FIT(30));
        make.left.mas_equalTo(FIT(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    UITextField*  textField=[UITextField new];
    textField.placeholder=NSLocalizedString(@"请输入0-30位整数", nil);
    textField.font=[UIFont systemFontOfSize:FIT(14)];
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.mas_right);
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(FIT(43));
        make.top.mas_equalTo(0);
        
    }];
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    [textField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-0.5);
        make.height.mas_equalTo(0.5);
        
    }];
    UILabel*  promptLab=[UILabel new];
    promptLab.text=NSLocalizedString(@"参考价:0.000000", nil);
    promptLab.textColor=MainLabelGrayColor;
    promptLab.font=[UIFont systemFontOfSize:FIT(12)];
    [self addSubview:promptLab];
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textField.mas_left);
        make.top.equalTo(textField.mas_bottom).offset(FIT(4));;
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(FIT(12));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
