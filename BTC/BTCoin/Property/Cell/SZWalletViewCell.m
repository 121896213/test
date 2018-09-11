//
//  SZWalletViewCell.m
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWalletViewCell.h"
@interface SZWalletViewCell()
@property (nonatomic,strong) UIImageView* backgroundImageView;
@property (nonatomic,strong) UIButton* accountTypeBtn;
@property (nonatomic,strong) UIButton* enterAccountBtn;

@property (nonatomic,strong) UILabel* propertyLab;
@property (nonatomic,strong) UILabel* convertProperLab;
@end



@implementation SZWalletViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
        self.backgroundColor=MainBackgroundColor;
    }
    return self;
}

-(void)setSubViews
{
    
    UIImageView* backgroundImageView=[UIImageView new];//[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account_bg"]];
    self.backgroundImageView=backgroundImageView;
    backgroundImageView.backgroundColor=[UIColor whiteColor];
    [self addSubview:backgroundImageView];
    [backgroundImageView setCircleBorderWidth:FIT3(3) bordColor:[UIColor whiteColor] radius:FIT3(10)];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(FIT3(48));
        make.right.mas_equalTo(FIT3(-48));
        make.bottom.mas_equalTo(FIT3(0));
        
    }];
    
    UIButton* accountTypeBtn=[UIButton new];
    [accountTypeBtn setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [accountTypeBtn setTitle:NSLocalizedString(@"C2C账户", nil) forState:UIControlStateNormal];
    [accountTypeBtn setImage:[UIImage imageNamed:@"wallet_account_c2c"] forState:UIControlStateNormal];
    [accountTypeBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(16)]];
    [accountTypeBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10.f];
    accountTypeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.accountTypeBtn=accountTypeBtn;
    [backgroundImageView addSubview:accountTypeBtn];
    [accountTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(FIT(10));
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(40));
        
    }];
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    [backgroundImageView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(FIT(0));
        make.bottom.equalTo(accountTypeBtn.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel* properLabel=[UILabel new];
    [properLabel setText:@"0.00000000 USDT"];
    [properLabel setTextColor:MainLabelBlackColor];
    [properLabel setFont:[UIFont systemFontOfSize:FIT(30)]];
    properLabel.textAlignment=NSTextAlignmentCenter;
    properLabel.adjustsFontSizeToFitWidth=YES;
    [properLabel setAttributedTextWithBeforeString:@"0.00000000" beforeColor:properLabel.textColor beforeFont:properLabel.font afterString:@" USDT" afterColor:properLabel.textColor afterFont:[UIFont systemFontOfSize:12.0f]];
    [backgroundImageView addSubview:properLabel];
    self.propertyLab=properLabel;
    [properLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(lineView.mas_bottom).offset(FIT3(69));
        make.centerX.equalTo(backgroundImageView.mas_centerX);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(properLabel.font.lineHeight);
    }];
    
    
    UILabel* convertProperLabel=[UILabel new];
    [convertProperLabel setText:@"≈ 0.00 CNY"];
    [convertProperLabel setTextColor:MainLabelLightBlackColor];
    [convertProperLabel setFont:[UIFont systemFontOfSize:FIT(16)]];
    convertProperLabel.adjustsFontSizeToFitWidth=YES;
    convertProperLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:convertProperLabel];
    self.convertProperLab=convertProperLabel;
    [convertProperLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(backgroundImageView.mas_centerX);
        make.top.equalTo(properLabel.mas_bottom).offset(FIT(16));
        make.height.mas_equalTo(convertProperLabel.font.lineHeight);
        make.width.mas_equalTo(ScreenWidth);
    }];
    

    
    UIButton* enterAccountBtn=[UIButton new];
    [enterAccountBtn setTitleColor:MainLabelLightBlackColor forState:UIControlStateNormal];
    [enterAccountBtn setTitle:NSLocalizedString(@"进入C2C账户", nil) forState:UIControlStateNormal];
    [enterAccountBtn setImage:[UIImage imageNamed:@"property_detail_icon"] forState:UIControlStateNormal];
    [enterAccountBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(16)]];
    [enterAccountBtn setImagePositionWithType:SSImagePositionTypeRight spacing:10.f];
    enterAccountBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [backgroundImageView addSubview:enterAccountBtn];
    self.enterAccountBtn=enterAccountBtn;
    [enterAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(backgroundImageView.mas_centerX);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(40));
        
    }];
    
    UIView* botoomlineView=[UIView new];
    botoomlineView.backgroundColor=LineColor;
    [backgroundImageView addSubview:botoomlineView];
    [botoomlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(FIT(0));
        make.bottom.equalTo(enterAccountBtn.mas_top);
        make.height.mas_equalTo(0.3);
    }];
}

-(void)setCellContent:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
    }else if(indexPath.row == 1){
        [self.accountTypeBtn setTitle:NSLocalizedString(@"币币账户", nil)  forState:UIControlStateNormal];
        [self.accountTypeBtn setImage:[UIImage imageNamed:@"wallet_account_bb"] forState:UIControlStateNormal];
        [self.enterAccountBtn setTitle:NSLocalizedString(@"进入币币账户", nil)  forState:UIControlStateNormal];
        [self.enterAccountBtn setImagePositionWithType:SSImagePositionTypeRight spacing:10.f];
        self.enterAccountBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;

    }else{
        [self.accountTypeBtn setTitle:NSLocalizedString(@"锁仓账户", nil)  forState:UIControlStateNormal];
        [self.accountTypeBtn setImage:[UIImage imageNamed:@"wallet_account_sc"] forState:UIControlStateNormal];
        [self.enterAccountBtn setTitle:NSLocalizedString(@"进入锁仓账户", nil)  forState:UIControlStateNormal];
        [self.enterAccountBtn setImagePositionWithType:SSImagePositionTypeRight spacing:10.f];
        self.enterAccountBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    }
    
}


-(void)setViewModel:(SZWalletCellViewModel *)viewModel{
    _viewModel=viewModel;
    self.convertProperLab.text=FormatString(@"≈ %@ CNY",viewModel.walletModel.cnyNum); ;
    self.propertyLab.text=FormatString(@"%@ USDT",viewModel.walletModel.usdtNum);
    [self.propertyLab setAttributedTextWithBeforeString:viewModel.walletModel.usdtNum beforeColor:self.propertyLab.textColor beforeFont:self.propertyLab.font afterString:@" USDT" afterColor:self.propertyLab.textColor afterFont:[UIFont systemFontOfSize:12.0f]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
