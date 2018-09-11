//
//  SZC2COrderListCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2COrderListCell.h"

@implementation SZC2COrderListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    UIButton*  userBtn=[UIButton new];
    [userBtn setTitle:@"用户的名称" forState:UIControlStateNormal];
    [userBtn setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [userBtn setImage:[UIImage imageNamed:@"c2c_header_default"] forState:UIControlStateNormal];
    [userBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:FIT(15)]; 
    userBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;

    userBtn.titleLabel.font=[UIFont systemFontOfSize:FIT(14.0F)];
    [self addSubview:userBtn];
    [userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.mas_equalTo(FIT(16));
        make.width.mas_equalTo(FIT(200));
        make.height.mas_equalTo(FIT(25));
        
    }];

    UILabel* orderStatusLab=[UILabel new];
    orderStatusLab.text=@"处理中";
    orderStatusLab.textColor=UIColorFromRGB(0xFFA53A);
    orderStatusLab.font=[UIFont systemFontOfSize:FIT(16.0f)];
    orderStatusLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:orderStatusLab];
    [orderStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.top.equalTo(userBtn.mas_top);
        make.width.mas_equalTo(FIT(200));
        make.height.mas_equalTo(FIT(25));
    }];
    [orderStatusLab setHidden:YES];
    
    UILabel* orderTypeLab=[UILabel new];
    orderTypeLab.text=@"买入";
    orderTypeLab.font=[UIFont systemFontOfSize:FIT(14.0F)];
    [self addSubview:orderTypeLab];
    [orderTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userBtn.mas_left);
        make.top.equalTo(userBtn.mas_bottom).offset(FIT(9));
        make.width.mas_equalTo(FIT(200));
        make.height.mas_equalTo(orderTypeLab.font.lineHeight);
    }];
    
    UILabel* orderValueLab=[UILabel new];
    orderValueLab.text=@"+730306.03012545";
    orderValueLab.font=[UIFont systemFontOfSize:16.0f];
    orderValueLab.textAlignment=NSTextAlignmentRight;
    orderValueLab.textColor=MainC2CBlueColor;
    [self addSubview:orderValueLab];
    [orderValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.top.equalTo(orderTypeLab.mas_top);
        make.left.equalTo(orderTypeLab.mas_right);
        make.height.mas_equalTo(orderValueLab.font.lineHeight);
    }];
    
    UILabel* orderTimeLab=[UILabel new];
    orderTimeLab.text=NSLocalizedString(@"2018-06-12 14:36:34", nil) ;
    orderTimeLab.font=[UIFont systemFontOfSize:FIT(14.0)];
    orderTimeLab.textColor=MainLabelGrayColor;
    [self addSubview:orderTimeLab];
    [orderTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderTypeLab.mas_left);
        make.top.mas_equalTo(orderTypeLab.mas_bottom).offset(FIT(9));
        make.width.mas_equalTo(FIT(200));
        make.height.mas_equalTo(orderTimeLab.font.lineHeight);
    }];
    
    UILabel* unitLab=[UILabel new];
    unitLab.text=NSLocalizedString(@"USDT", nil);
    unitLab.font=[UIFont systemFontOfSize:12.0f];
    unitLab.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:unitLab];
    [unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(orderValueLab.mas_right);
        make.top.mas_equalTo(orderTimeLab.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(unitLab.font.lineHeight);
    }];
    self.orderStatusLab=orderStatusLab;
    
    [self addBottomLineView];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
