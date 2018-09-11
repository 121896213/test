//
//  SZC2CAdPriceSwitchCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdPriceSwitchCell.h"

@implementation SZC2CAdPriceSwitchCell
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
    [button setTitle:NSLocalizedString(@"开启固定价格", nil) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ad_tip"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:FIT(14)];
    [button setImagePositionWithType:SSImagePositionTypeRight spacing:10.f];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        JCAlertController *alert = [JCAlertController alertWithTitle:@"开启固定价格" message:@"启用后,您的币价不会随市场波动,价格不变。"];
        [alert addButtonWithTitle:@"我知道了" type:JCButtonTypeWarning clicked:nil];
        [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];

    }];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(120));
        make.height.mas_equalTo(FIT(30));
        make.left.mas_equalTo(FIT(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    UIButton* switchBtn=[UIButton new];
    [switchBtn setImage:[UIImage imageNamed:@"ad_price_switch_close"] forState:UIControlStateNormal];
    [switchBtn setImage:[UIImage imageNamed:@"ad_price_switch_on"] forState:UIControlStateSelected];
    [self addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(90));
        make.height.mas_equalTo(FIT(30));
        make.right.mas_equalTo(FIT(-16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [[switchBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       
        [switchBtn setSelected:!switchBtn.isSelected];
        
    }];
   
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
