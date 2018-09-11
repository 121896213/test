//
//  SZPromotionCoinTypeCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPromotionCoinTypeCell.h"

@implementation SZPromotionCoinTypeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews
{

    UILabel* coinTypeLab=[UILabel new];
    coinTypeLab.text=@"BTC";
    coinTypeLab.font=[UIFont systemFontOfSize:FIT3(36)];
    coinTypeLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:coinTypeLab];
    [coinTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(FIT3(182));
        make.height.mas_equalTo(FIT3(99));
    }];
    [coinTypeLab setCircleBorderWidth:1 bordColor:UIColorFromRGB(0xCCCCCC) radius:FIT3(10.0)];
    self.coinTypeLab=coinTypeLab;
    
    
}

@end
