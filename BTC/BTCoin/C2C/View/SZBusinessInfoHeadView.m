//
//  SZBusinessInfoHeadView.m
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBusinessInfoHeadView.h"
@implementation SZBusinessInfoHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
}



-(void)setSubView{
    
    
    UIImageView* backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.image=[UIImage imageNamed:@"bussinessInfo_backImage"];
    backgroundImageView.contentMode=UIViewContentModeScaleToFill;
    [self addSubview:backgroundImageView];
    self.backgroundImageView=backgroundImageView;
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(0));
        make.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(164)+NavigationStatusBarHeight);
        
    }];
 
    UIButton* backButton=[UIButton new];
    [backButton setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
    [self addSubview:backButton];
    self.backButton=backButton;
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(StatusBarHeight);
        make.width.height.mas_equalTo(FIT3(120));
    }];
    
    UILabel* titleLab=[UILabel new];
    titleLab.textColor=[UIColor whiteColor];
    titleLab.font=[UIFont systemFontOfSize:18.0f];
    titleLab.text=NSLocalizedString(@"商家信息", nil);
    titleLab.textAlignment=NSTextAlignmentCenter;
    [backgroundImageView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backgroundImageView.mas_centerX);
        make.top.equalTo(backButton.mas_top);
        make.height.mas_equalTo(FIT(40));
        make.width.mas_equalTo(FIT(120));
    }];
    
    
    UIButton* headerBtn=[UIButton new];
    [headerBtn setImage:[UIImage imageNamed:@"header_icon"] forState:UIControlStateNormal];
    [backgroundImageView addSubview:headerBtn];
    self.headBtn=headerBtn;
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backgroundImageView.mas_centerY).offset(FIT(15));
        make.width.height.mas_equalTo(FIT(61));
        make.left.mas_equalTo(FIT(18));
        
    }];
    [self.headBtn setEnlargeEdgeWithTop:0 right:FIT3(400)+FIT3(49) bottom:0 left:0];
    
    
    UILabel* nickLab=[UILabel new];
    nickLab.textColor=[UIColor whiteColor];
    nickLab.font=[UIFont systemFontOfSize:FIT(16.0f)];
    nickLab.text=NSLocalizedString(@"用户的名称", nil);
    self.nickLab=nickLab;
    [backgroundImageView addSubview:nickLab];
    [nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBtn.mas_right).offset(FIT(13));
        make.top.equalTo(headerBtn.mas_top);
        make.height.mas_equalTo(FIT(30.5));
        make.width.mas_equalTo(FIT(300));
    }];
    
    
    UILabel* levelLab=[UILabel new];
    levelLab.textColor=[UIColor whiteColor];
    levelLab.font=[UIFont systemFontOfSize:14.0f];
    levelLab.text=NSLocalizedString(@"认证等级:", nil);
    [backgroundImageView addSubview:levelLab];
    [levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBtn.mas_right).offset(FIT(13));
        make.top.equalTo(nickLab.mas_bottom);
        make.height.mas_equalTo(FIT(30.5));
        make.width.mas_equalTo(FIT(80));
    }];
    
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 120, FIT(20.5)) numberOfStars:4];
    self.starRateView.scorePercent = 3;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    [self addSubview:self.starRateView];
    [self.starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(levelLab.mas_right).offset(FIT(1));
        make.top.equalTo(levelLab.mas_top);
        make.width.mas_equalTo(FIT(100));
        make.height.mas_equalTo(FIT(30.5));

    }];
    
    UILabel* tradeNumberLab=[UILabel new];
    tradeNumberLab.textAlignment=NSTextAlignmentRight;
    tradeNumberLab.text=@"成交 56 笔";
    tradeNumberLab.font=[UIFont systemFontOfSize:FIT(14.0f)];
    tradeNumberLab.textColor=[UIColor whiteColor];
    [self addSubview:tradeNumberLab];
    [tradeNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelLab.mas_top);
        make.right.mas_equalTo(FIT(-16));
        make.width.mas_equalTo(FIT(300));
        make.height.mas_equalTo(FIT(30.5));
        
    }];
    
    [self setTotalTradeView];
}
-(void)setTotalTradeView{
    
    UIView* tradeView=[UIView new];
    tradeView.backgroundColor=[UIColor whiteColor];
    [tradeView setCircleBorderWidth:FIT(1) bordColor:tradeView.backgroundColor radius:FIT(3)];
    [self addSubview:tradeView];
    [tradeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headBtn.mas_bottom).offset(FIT(23));
        make.width.mas_equalTo(FIT(382));
        make.height.mas_equalTo(FIT(150));
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    
    UILabel* usdtLab=[UILabel new];
    usdtLab.textColor=UIColorFromRGB(0x666666);
    usdtLab.font=[UIFont systemFontOfSize:FIT(14)];
    usdtLab.text=NSLocalizedString(@"USDT交易量", ni);
    [tradeView addSubview:usdtLab];

    [usdtLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(FIT(100));
        make.height.mas_equalTo(FIT(50));
        make.left.mas_equalTo(FIT(10));
        
    }];
    
    UILabel* btcLab=[UILabel new];
    btcLab.textColor=UIColorFromRGB(0x666666);
    btcLab.font=[UIFont systemFontOfSize:FIT(14)];
    btcLab.text=NSLocalizedString(@"BTC交易量", ni);
    [tradeView addSubview:btcLab];

    [btcLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(usdtLab.mas_bottom);
        make.width.mas_equalTo(FIT(100));
        make.height.mas_equalTo(FIT(50));
        make.left.mas_equalTo(FIT(10));
        
    }];
    
    
    UILabel* ethLab=[UILabel new];
    ethLab.textColor=UIColorFromRGB(0x666666);
    ethLab.font=[UIFont systemFontOfSize:FIT(14)];
    ethLab.text=NSLocalizedString(@"ETH交易量", ni);
    [tradeView addSubview:ethLab];

    [ethLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btcLab.mas_bottom);
        make.width.mas_equalTo(FIT(100));
        make.height.mas_equalTo(FIT(50));
        make.left.mas_equalTo(FIT(10));
        
    }];
    
    UILabel* usdValueLab=[UILabel new];
    usdValueLab.textColor=MainThemeBlueColor;
    usdValueLab.font=[UIFont systemFontOfSize:FIT(16)];
    usdValueLab.text=@"73036.03012545";
    usdValueLab.textAlignment=NSTextAlignmentRight;

    [tradeView addSubview:usdValueLab];

    [usdValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(FIT(300));
        make.height.mas_equalTo(FIT(50));
        make.right.mas_equalTo(FIT(-10));
        
    }];
    
    UILabel* btcValueLab=[UILabel new];
    btcValueLab.textColor=MainThemeBlueColor;
    btcValueLab.font=[UIFont systemFontOfSize:FIT(16)];
    btcValueLab.text=@"5236.00000005";
    btcValueLab.textAlignment=NSTextAlignmentRight;
    [tradeView addSubview:btcValueLab];

    [btcValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(usdValueLab.mas_bottom);
        make.width.mas_equalTo(FIT(300));
        make.height.mas_equalTo(FIT(50));
        make.right.mas_equalTo(FIT(-10));

    }];
    
    
    UILabel* ethValueLab=[UILabel new];
    ethValueLab.textColor=MainThemeBlueColor;
    ethValueLab.font=[UIFont systemFontOfSize:FIT(16)];
    ethValueLab.text=@"4230.03012545";
    [tradeView addSubview:ethValueLab];
    ethValueLab.textAlignment=NSTextAlignmentRight;

    [ethValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btcValueLab.mas_bottom);
        make.width.mas_equalTo(FIT(300));
        make.height.mas_equalTo(FIT(50));
        make.right.mas_equalTo(FIT(-10));

    }];
    
    UILabel* titleLab=[UILabel new];
    titleLab.textColor=UIColorFromRGB(0x1C2F5F);
    titleLab.font=[UIFont systemFontOfSize:FIT(16)];
    titleLab.text=NSLocalizedString(@"成交记录", nil);
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tradeView.mas_bottom).offset(FIT(15));
        make.width.mas_equalTo(FIT(80));
        make.left.mas_equalTo(FIT(16));
        make.bottom.mas_equalTo(FIT(-15));

        
    }];
    
    
    
}


@end
