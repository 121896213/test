//
//  SZBussinessRecordCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBussinessRecordCell.h"

@implementation SZBussinessRecordCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
   
    UILabel* orderTypeLab=[UILabel new];
    orderTypeLab.text=@"买入";
    orderTypeLab.font=[UIFont systemFontOfSize:FIT(14.0F)];
    [self addSubview:orderTypeLab];
    [orderTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.mas_equalTo(FIT(20));
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
    
    
    [self addBottomLineView];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
