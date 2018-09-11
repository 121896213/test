//
//  TradeCoinMessageView.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "TradeCoinMessageView.h"

@interface TradeCoinMessageView(){
    UIImageView * _imageView;
}

@property (nonatomic,strong)UILabel * coinLabel;
@property (nonatomic,strong)UILabel * priceLabel;
@property (nonatomic,strong)UILabel * rmbPriceLabel;
@property (nonatomic,strong)UILabel * downOrUpLabel;


@end

@implementation TradeCoinMessageView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColorFromRGB(0xF5F6FA);
        
        _coinLabel = [self createLabel:UIColorFromRGB(0x333333) :[UIFont fontWithName:@"PingFang-SC-Medium" size:18] :NSTextAlignmentLeft];
        [_coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(16);
            make.centerY.mas_equalTo(self);
        }];
        _coinLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCoin)];
        [_coinLabel addGestureRecognizer:tap];
        
        _imageView = [[UIImageView alloc]initWithImage:kIMAGE_NAMED(@"tradexiala")];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_coinLabel.mas_trailing).offset(7);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(11);
            make.height.mas_equalTo(6);
        }];
        
        _downOrUpLabel = [self createLabel:UIColorFromRGB(0xffffff) :[UIFont fontWithName:@"PingFang-SC-Bold" size:14] :NSTextAlignmentCenter];
        _downOrUpLabel.layer.cornerRadius = 3.0f;
        _downOrUpLabel.clipsToBounds = YES;
        _downOrUpLabel.backgroundColor = UIColorFromRGB(0xFF6333);
        [_downOrUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-16);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(87);
            make.centerY.mas_equalTo(self);
        }];
        
        _priceLabel = [self createLabel:UIColorFromRGB(0xFF6333) :[UIFont fontWithName:@"PingFang-SC-Bold" size:19] :NSTextAlignmentRight];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(_downOrUpLabel.mas_leading).offset(-13);
            make.top.mas_equalTo(_downOrUpLabel.mas_top);
            make.height.mas_equalTo(14);
        }];
        
        _rmbPriceLabel = [self createLabel:UIColorFromRGB(0x999999) :kFontSize(12) :NSTextAlignmentRight];
        [_rmbPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(_downOrUpLabel.mas_leading).offset(-13);
            make.bottom.mas_equalTo(_downOrUpLabel.mas_bottom);
            make.height.mas_equalTo(9);
        }];
        [self setText];
    }
    return self;
}
-(void)changeCoin{
    if (self.changeCoinBlock) {
        self.changeCoinBlock();
    }
}

-(void)disableTapEvent
{
    _imageView.hidden = YES;
    _coinLabel.userInteractionEnabled = NO;
}

-(void)refreshViewWithModel:(MarketHomeListModel *)model
{
    _coinLabel.text = FormatString(@"%@/%@",model.fShortName,model.areaName);
    _downOrUpLabel.text = [NSString stringWithFormat:@"%.2f%%",[model.fTodayRiseFall doubleValue]* 100];
    _priceLabel.text = model.fNewDealPrice;
    _rmbPriceLabel.text = FormatString(@"≈￥%@",model.fMarket) ;

    
    CGFloat zdf = [model.fTodayRiseFall floatValue];
    if (zdf > 0.00000000) {
        self.priceLabel.textColor = self.downOrUpLabel.backgroundColor = UIColorFromRGB(0x03c087);
        _downOrUpLabel.text = [NSString stringWithFormat:@"+%.2f%%",[model.fTodayRiseFall doubleValue]* 100];
    }else if (zdf < 0.0000000) {
        self.priceLabel.textColor = self.downOrUpLabel.backgroundColor = UIColorFromRGB(0xff6333);
    }else{
        self.priceLabel.textColor = self.downOrUpLabel.backgroundColor = UIColorFromRGB(0xacacac);
    }
    
}

-(void)setText{
    _coinLabel.text = NSLocalizedString(@"请选择币种", nil);
    _downOrUpLabel.text = @"--";
    _priceLabel.text = @"--";
    _rmbPriceLabel.text = @"≈￥--";

}

-(UILabel *)createLabel:(UIColor *)textColor :(UIFont *)font :(NSTextAlignment)alignment{
    UILabel * label = [UILabel new];
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = alignment;
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
    return label;
}

@end
