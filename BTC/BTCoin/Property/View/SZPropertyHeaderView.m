//
//  SZPropertyHeaderView.m
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyHeaderView.h"

@implementation SZPropertyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
}



-(void)setSubView{
    
    
    UIImageView* backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backgroundImageView.image=[UIImage imageNamed:@"account_bg"];
    backgroundImageView.contentMode=UIViewContentModeScaleToFill;
    [self addSubview:backgroundImageView];
    self.backgroundImageView=backgroundImageView;
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(0));
        make.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(self.frame.size.height);

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
    [self.backButton setHidden:YES];

    UILabel* totalPropertyLabel=[UILabel new];
    [totalPropertyLabel setText:NSLocalizedString(@"总资产",nil)];
    [totalPropertyLabel setTextColor:[UIColor whiteColor]];
    [totalPropertyLabel setFont:[UIFont systemFontOfSize:FIT(16)]];
    totalPropertyLabel.adjustsFontSizeToFitWidth=YES;
    totalPropertyLabel.textAlignment=NSTextAlignmentCenter;
    self.totalPropertyLabel=totalPropertyLabel;
//    NSShadow *shadow = [[NSShadow alloc]init];
//    shadow.shadowBlurRadius = 1.0;
//    shadow.shadowOffset = CGSizeMake(1, 1);
//    shadow.shadowColor = [UIColor blackColor];
//    NSMutableAttributedString* attributedStr=[[NSMutableAttributedString alloc] initWithAttributedString:totalPropertyLabel.attributedText];
//    [attributedStr addAttribute:NSShadowAttributeName
//                              value:shadow
//                              range:NSMakeRange(0, attributedStr.length)];
//    totalPropertyLabel.attributedText=attributedStr;
    
    [self addSubview:totalPropertyLabel];
    [totalPropertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(FIT3(104)+NaviBarHeight);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(42));
    }];
    
    UILabel* properLabel=[UILabel new];
    [properLabel setText:@"0.00000000 USDT"];
    [properLabel setTextColor:[UIColor whiteColor]];
    [properLabel setFont:[UIFont boldSystemFontOfSize:FIT3(72)]];
    properLabel.textAlignment=NSTextAlignmentCenter;
    properLabel.adjustsFontSizeToFitWidth=YES;
    [self addSubview:properLabel];
    self.normalPropertyLabel=properLabel;
    [properLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(totalPropertyLabel.mas_left);
        make.top.mas_equalTo(totalPropertyLabel.mas_bottom).offset(FIT3(69));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(72));
    }];
    
    
    UILabel* convertProperLabel=[UILabel new];
    [convertProperLabel setText:@"≈0.00 CNY"];
    [convertProperLabel setTextColor:[UIColor whiteColor]];
    [convertProperLabel setFont:[UIFont boldSystemFontOfSize:FIT3(36)]];
    convertProperLabel.adjustsFontSizeToFitWidth=YES;
    convertProperLabel.textAlignment=NSTextAlignmentCenter;

    [self addSubview:convertProperLabel];
    self.convertPropertyLabel=convertProperLabel;
    [convertProperLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(totalPropertyLabel.mas_left);
        make.top.equalTo(properLabel.mas_bottom).offset(FIT3(60));
        make.height.mas_equalTo(FIT3(36));
        make.width.mas_equalTo(ScreenWidth);
    }];
    
    
}


- (void)setViewModel:(SZPropertyViewModel *)viewModel{
    
    
    if (viewModel.walletType == SZWalletTypeC2C) {
        
    }
    else if (viewModel.walletType == SZWalletTypeBB) {
        if (!isEmptyObject(viewModel.listModel)) {
            self.normalPropertyLabel.text=viewModel.listModel.totalCapital;
            self.convertPropertyLabel.text=[NSString stringWithFormat:@"≈ %@ CNY",viewModel.listModel.totalNet];

        }

    }else{
        
        [self.totalPropertyLabel setText:NSLocalizedString(@"锁仓账户",nil)];
//        [self.backgroundImageView setImage:[UIImage imageNamed:@"wallet_scAcount_image"]];
        [self.totalPropertyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo((self.height-self.totalPropertyLabel.height)/2);

        }];
    }
}
-(void)setWalletListModel:(SZWalletListModel *)walletListModel{
    
    _walletListModel=walletListModel;
    self.convertPropertyLabel.text=[NSString stringWithFormat:@"≈ %@ CNY",walletListModel.cnyNum];
    
    self.normalPropertyLabel.text=FormatString(@"%@ USDT",walletListModel.usdtNum);
    [self.normalPropertyLabel setAttributedTextWithBeforeString:walletListModel.usdtNum beforeColor:self.normalPropertyLabel.textColor beforeFont:self.normalPropertyLabel.font afterString:@" USDT" afterColor:self.normalPropertyLabel.textColor afterFont:[UIFont systemFontOfSize:12.0f]];
    
}
-(void)setWalletModel:(SZWalletModel *)walletModel{
    [self.backButton setHidden:NO];
    if(!walletModel){
        return;
    }
    _walletModel=walletModel;
    if (walletModel.assetsType == SZWalletTypeC2C) {
        [self.totalPropertyLabel setText:NSLocalizedString(@"C2C账户总资产",nil)];

    }else if (walletModel.assetsType == SZWalletTypeBB){
        [self.totalPropertyLabel setText:NSLocalizedString(@"币币账户总资产",nil)];

    }else{
        [self.totalPropertyLabel setText:NSLocalizedString(@"锁仓账户总资产",nil)];
//        [self.backgroundImageView setImage:[UIImage imageNamed:@"wallet_scAcount_image"]];

    }
    self.convertPropertyLabel.text=[NSString stringWithFormat:@"≈ %@ CNY",walletModel.cnyNum];
    
    self.normalPropertyLabel.text=FormatString(@"%@ USDT",walletModel.usdtNum);
    [self.normalPropertyLabel setAttributedTextWithBeforeString:walletModel.usdtNum beforeColor:self.normalPropertyLabel.textColor beforeFont:self.normalPropertyLabel.font afterString:@" USDT" afterColor:self.normalPropertyLabel.textColor afterFont:[UIFont systemFontOfSize:12.0f]];
}

@end
