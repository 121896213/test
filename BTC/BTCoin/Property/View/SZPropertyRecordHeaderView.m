//
//  SZPropertyRecordHeaderView.m
//  BTCoin
//
//  Created by Shizi on 2018/5/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyRecordHeaderView.h"

@implementation SZPropertyRecordHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
        self.backgroundColor=UIColorFromRGB(0xecfbff);
    }
    return self;
}



-(void)setSubView{
    
    UILabel* tradeTimeLab=[UILabel new];
    tradeTimeLab.text= NSLocalizedString(@"交易时间", nil);
    tradeTimeLab.textColor=UIColorFromRGB(0x999999);
    tradeTimeLab.font=[UIFont systemFontOfSize:12.0f];
    tradeTimeLab.adjustsFontSizeToFitWidth=YES;
    [self addSubview:tradeTimeLab];
    [tradeTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT2(14));
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(FIT2(122));
        make.height.mas_equalTo(SZPropertyRecordHeaderViewHeight);
    }];
    
    
    UILabel* tradeTypeLab=[UILabel new];
    tradeTypeLab.text=NSLocalizedString(@"类型", nil);
    tradeTypeLab.textColor=UIColorFromRGB(0x999999);
    tradeTypeLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeTypeLab];
    [tradeTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeTimeLab.mas_right).offset(FIT2(14));
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(FIT2(100));
        make.height.mas_equalTo(SZPropertyRecordHeaderViewHeight);
    }];
    
    
    UILabel* tradeAmountLab=[UILabel new];
    tradeAmountLab.text=NSLocalizedString(@"金额", nil);
    tradeAmountLab.textColor=UIColorFromRGB(0x999999);
    tradeAmountLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeAmountLab];
    [tradeAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeTypeLab.mas_right).offset(FIT2(14));
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(FIT2(180));
        make.height.mas_equalTo(SZPropertyRecordHeaderViewHeight);
    }];
    
    UILabel* tradeFeeLab=[UILabel new];
    tradeFeeLab.text=NSLocalizedString(@"手续费", nil);
    tradeFeeLab.textColor=UIColorFromRGB(0x999999);
    tradeFeeLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeFeeLab];
    [tradeFeeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeAmountLab.mas_right).offset(FIT2(14));
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(FIT2(150));
        make.height.mas_equalTo(SZPropertyRecordHeaderViewHeight);
    }];
    
    UILabel* tradeStatusLab=[UILabel new];
    tradeStatusLab.text=NSLocalizedString(@"状态", nil);
    tradeStatusLab.textColor=UIColorFromRGB(0x999999);
    tradeStatusLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeStatusLab];
    [tradeStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeFeeLab.mas_right).offset(FIT2(14));
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(FIT2(95));
        make.height.mas_equalTo(SZPropertyRecordHeaderViewHeight);
    }];
    
    
}


@end
