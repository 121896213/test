//
//  MarketDeatilHeadView.m
//  BTCoin
//
//  Created by zzg on 2018/4/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "MarketDeatilHeadView.h"
#import "Masonry.h"

@interface MarketDeatilHeadView (){
    UILabel * staLabA;
    UILabel * staLabB;
    UILabel * staLabC;
}

@property (nonatomic, strong) UILabel   *newsPrice;  //最新价
@property (nonatomic, strong) UILabel   *HighPrice;  //最高价
@property (nonatomic, strong) UILabel   *lowPrice;  //最低价
@property (nonatomic, strong) UILabel   *equalRMBLab;  //等同人民币价格
@property (nonatomic, strong) UILabel   *increaseLabel;  //涨跌
@property (nonatomic, strong) UILabel   *increasePercentLabel;  //涨跌幅百分比

@end
@implementation MarketDeatilHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubviewsAdd];
    }
    return self;
}

- (void)setSubviewsAdd
{
    self.backgroundColor = WhiteColor;

    _newsPrice          = [self createLabelWithFont:[UIFont boldSystemFontOfSize:24] defaultText:@"--" ];
    _equalRMBLab        = [self createLabelWithFont:kFontSize(12) defaultText:nil ];
    _increaseLabel      = [self createLabelWithFont:kFontSize(14) defaultText:@"--" ];
    _increasePercentLabel = [self createLabelWithFont:kFontSize(14) defaultText:@"--" ];
    
    _HighPrice          = [self createLabelWithFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] defaultText:@"--" ];
    _lowPrice           = [self createLabelWithFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] defaultText:@"--" ];
    _twenty_fourPrice   = [self createLabelWithFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] defaultText:@"--" ];
     staLabA   = [self createLabelWithFont:kFontSize(12) defaultText:@"高:" ];
     staLabB   = [self createLabelWithFont:kFontSize(12) defaultText:@"低:" ];
     staLabC   = [self createLabelWithFont:kFontSize(12) defaultText:@"24H量:" ];

    
    [self.newsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.leading.mas_equalTo(16);
        make.height.mas_equalTo(18);
    }];
    
    [self.equalRMBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.newsPrice.mas_leading);
        make.top.mas_equalTo(self.newsPrice.mas_bottom).offset(7);
        make.height.mas_equalTo(10);
    }];
    
    [self.increaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.newsPrice.mas_leading);
        make.top.mas_equalTo(self.equalRMBLab.mas_bottom).offset(12);
        make.height.mas_equalTo(12);
    }];
    
    [self.increasePercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.increaseLabel.mas_trailing).offset(20);
        make.top.height.mas_equalTo(self.increaseLabel);
    }];
    
    [staLabA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-86);
        make.width.mas_equalTo(41);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(19);
    }];
    
    [staLabB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.height.width.mas_equalTo(staLabA);
        make.top.mas_equalTo(staLabA.mas_bottom).offset(12);
    }];
    
    [staLabC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.height.width.mas_equalTo(staLabA);
        make.top.mas_equalTo(staLabB.mas_bottom).offset(12);
    }];
    
    
    [self.HighPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(staLabA.mas_trailing).offset(12);
        make.trailing.mas_equalTo(-15);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(19);
    }];
    
    [self.lowPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.mas_equalTo(self.HighPrice);
        make.top.mas_equalTo(self.HighPrice.mas_bottom).offset(12);
    }];
    
    [self.twenty_fourPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.mas_equalTo(self.HighPrice);
        make.top.mas_equalTo(self.lowPrice.mas_bottom).offset(12);
    }];
    self.HighPrice.textAlignment = self.lowPrice.textAlignment = self.twenty_fourPrice.textAlignment = NSTextAlignmentRight;
}

-(void)setIsBlack:(BOOL)isBlack{
    if (isBlack) {
        self.backgroundColor = UIColorFromRGB(0x000000);
        _equalRMBLab.textColor = staLabA.textColor = staLabB.textColor = staLabC.textColor = UIColorFromRGB(0xBBBBBB);
        _HighPrice.textColor = _lowPrice.textColor = _twenty_fourPrice.textColor = WhiteColor;
    }else{
        self.backgroundColor = WhiteColor;
        _equalRMBLab.textColor = staLabA.textColor = staLabB.textColor = staLabC.textColor = UIColorFromRGB(0x666666);
        _HighPrice.textColor = _lowPrice.textColor = _twenty_fourPrice.textColor = UIColorFromRGB(0x333333);
    }
}

-(void)setViewWithModel:(RealTimeModel *)model{
    _newsPrice.text = model.curPrice;
    _HighPrice.text = model.maxPrice;
    _lowPrice.text = model.minPrice;
    _twenty_fourPrice.text = [NSString stringWithFormat:@"%ld",(NSInteger)round([model.volume doubleValue])];
    
    _increaseLabel.text = model.changeValue;
    _increasePercentLabel.text = model.changeValuePercent;
    
    if ([model.changeValue isEqualToString:@"--"]) {
        _newsPrice.textColor = _increaseLabel.textColor = _increasePercentLabel.textColor = UIColorFromRGB(0x333333);
        return;
    }
    if ([model.changeValue doubleValue] > 0 ) {
        _newsPrice.textColor = UIColorFromRGB(0x03c087)  ;
        _increaseLabel.textColor = UIColorFromRGB(0x03c087)  ;
        _increasePercentLabel.textColor =  UIColorFromRGB(0x03c087)  ;
        _increaseLabel.text = FormatString(@"+%@",model.changeValue) ;
        _increasePercentLabel.text = FormatString(@"+%@",model.changeValuePercent);
    }else{
        _newsPrice.textColor =UIColorFromRGB(0xff6333) ;
        _increaseLabel.textColor = UIColorFromRGB(0xff6333) ;
        _increasePercentLabel.textColor = UIColorFromRGB(0xff6333) ;
    }
}
-(void)setEqualRmbPrice:(NSString *)price{
    _equalRMBLab.text = [NSString stringWithFormat:@"≈ %@ CNY",price];
}

- (UILabel *)createLabelWithFont:(UIFont *)font defaultText:(NSString *)text{
    UILabel * label = [[UILabel alloc] init];
    label.font = font;
    label.text = NSLocalizedString(text, nil);
    label.textColor = UIColorFromRGB(0x666666);
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
    return label;
}

@end
