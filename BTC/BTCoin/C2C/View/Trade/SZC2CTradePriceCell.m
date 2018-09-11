//
//  SZC2CTradePriceCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CTradePriceCell.h"
@interface SZC2CTradePriceCell()
@property (nonatomic, strong) UILabel*  priceValueLab;
@property (nonatomic, strong) UILabel*  unitLab;
@property (nonatomic, strong) UILabel*  coinTypeLab;

@property (nonatomic, strong) UIImageView*  arrowImageView;
@property (nonatomic, strong) UIImageView *identificationTagImageView;
@property (nonatomic, strong) UILabel* trueNameLab;
@property (nonatomic, strong) UIButton *headerBtn;

@end
@implementation SZC2CTradePriceCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.backgroundColor=[UIColor whiteColor];

    }
    return self;
}

-(void)setSubView{
    UILabel* priceValueLab=[UILabel new];
    priceValueLab.text=@"6.42";
    priceValueLab.textColor=MainThemeColor;
    priceValueLab.font=[UIFont boldSystemFontOfSize:FIT(40)];
    [self addSubview:priceValueLab];
    [priceValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(FIT(14));
        make.width.mas_equalTo(FIT(120));
        make.height.mas_equalTo(FIT(32));
    }];
    
    UILabel* unitLab=[UILabel new];
    unitLab.text=@"CNY/USDT";
    unitLab.textColor=MainThemeColor;
    unitLab.font=[UIFont systemFontOfSize:FIT(14)];
    [self addSubview:unitLab];
    [unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(14));
        make.top.equalTo(priceValueLab.mas_bottom).offset(FIT(10));
        make.width.mas_equalTo(FIT(120));
        make.height.mas_equalTo(FIT(14));
    }];
    
    
    UILabel* tradePriceLab=[UILabel new];
    tradePriceLab.text=NSLocalizedString(@"交易价格", nil);
    tradePriceLab.textColor=MainLabelGrayColor;
    tradePriceLab.font=[UIFont systemFontOfSize:FIT(12)];
    [self addSubview:tradePriceLab];
    [tradePriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(14));
        make.bottom.mas_equalTo(FIT(-19));
        make.width.mas_equalTo(FIT(120));
        make.height.mas_equalTo(FIT(13));
    }];
    
    UILabel* coinTypeLab=[UILabel new];
    coinTypeLab.text=NSLocalizedString(@"USDT", nil);
    coinTypeLab.textColor=UIColorFromRGB(0xF2F4F9);
    coinTypeLab.font=[UIFont boldSystemFontOfSize:FIT(64)];
    coinTypeLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:coinTypeLab];
    [coinTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(0));
        make.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(64));
    }];
    
    
    
    
    UIImageView *identificationTagImageView = [[UIImageView alloc] init];
    [self addSubview:identificationTagImageView];
    [identificationTagImageView setImage:[UIImage imageNamed:@"c2c_identity_yes"]];
    identificationTagImageView.contentMode=UIViewContentModeScaleAspectFit;
    [identificationTagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-13));
        make.bottom.mas_equalTo(FIT(-19));
        make.height.mas_equalTo(FIT(13));
        make.width.mas_equalTo(FIT(17));
    }];
    

    
    UIButton *headerBtn = [[UIButton alloc] init];
    [self addSubview:headerBtn];
    
    [headerBtn setImage:[UIImage imageNamed:@"c2c_header_default"] forState:UIControlStateNormal];
    [headerBtn setTitle:@"史蒂芬· 周" forState:UIControlStateNormal];
    [headerBtn setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [headerBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(14)]];
    [headerBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:FIT(5)];
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(identificationTagImageView.mas_left).offset(FIT(-5));
        make.centerY.equalTo(identificationTagImageView.mas_centerY);
        make.height.mas_equalTo(FIT(24));
        make.width.mas_equalTo(FIT(120));
    }];
    @weakify(self);
    [[headerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.action) {
            self.action(headerBtn);
        }
    }];
   
    
    self.headerBtn=headerBtn;
    self.identificationTagImageView=identificationTagImageView;
    self.priceValueLab=priceValueLab;
    self.unitLab=unitLab;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
