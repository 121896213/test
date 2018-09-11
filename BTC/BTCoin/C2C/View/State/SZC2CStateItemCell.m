//
//  SZC2CStateItemCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStateItemCell.h"
@interface SZC2CStateItemCell()
@property (nonatomic, strong) UILabel*  tradeValueLab;
@end
@implementation SZC2CStateItemCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=[UIColor whiteColor];

    }
    return self;
}

-(void)setSubView{
    UILabel* tradeItemLab=[UILabel new];
    [tradeItemLab setText:NSLocalizedString(@"交易数量", nil)];
    [tradeItemLab setFont:[UIFont systemFontOfSize:FIT(12.0)]];
    [tradeItemLab setTextColor:MainLabelBlackColor];
    [self addSubview:tradeItemLab];
    [tradeItemLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);;
        make.left.mas_equalTo(FIT(16));
        make.width.mas_equalTo(FIT(150));
        make.height.mas_equalTo(SZC2CStateItemCellHeight);
    }];
    
 
    
    UILabel* tradeItemValueLab=[UILabel new];
    [tradeItemValueLab setText:NSLocalizedString(@"400 USDT", nil)];
    [tradeItemValueLab setFont:[UIFont systemFontOfSize:FIT(14.0f)]];
    [tradeItemValueLab setTextColor:UIColorFromRGB(0xacacac)];
    [tradeItemValueLab setTextAlignment:NSTextAlignmentRight];
    [self addSubview:tradeItemValueLab];
    [tradeItemValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(tradeItemValueLab.font.lineHeight);
        make.width.mas_equalTo(FIT(200));
        make.centerY.equalTo(self.mas_centerY);
    }];

    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:LineColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT(-0.5));
        make.left.equalTo(tradeItemLab.mas_left);
        make.right.mas_equalTo(tradeItemValueLab.mas_right);
        make.height.mas_equalTo(FIT(0.5));
    }];
    
    
    self.tradeItemLab=tradeItemLab;
    self.tradeValueLab=self.tradeValueLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
