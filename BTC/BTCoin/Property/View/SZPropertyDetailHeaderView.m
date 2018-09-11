//
//  SZPropertyDetailHeaderView.m
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyDetailHeaderView.h"
#import "SZWalletModel.h"
@interface SZPropertyDetailHeaderView()
@property (nonatomic,strong) UILabel* ablePropertyLabel;
@property (nonatomic,strong) UILabel* unablePropertyLabel;
@property (nonatomic,strong) UIImageView* backgroundImageView;
@property (nonatomic,strong) UILabel* propertyRecordLabel;
@end

@implementation SZPropertyDetailHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}



-(void)setSubView{
    
    UIImageView* backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.image=[UIImage imageNamed:@"account_bg"];
    backgroundImageView.contentMode=UIViewContentModeScaleToFill;
    [self addSubview:backgroundImageView];
    self.backgroundImageView=backgroundImageView;
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(0));
        make.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(422)+StatusBarHeight);
    }];
    
    UIButton* backBtn=[UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
    [self addSubview:backBtn];
    self.backButton=backBtn;
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(StatusBarHeight);
        make.width.height.mas_equalTo(FIT3(120));
    }];
    
    UILabel* BTCTypeLabel=[UILabel new];
    [BTCTypeLabel setText:@"BTC"];
    [BTCTypeLabel setFont:[UIFont boldSystemFontOfSize:FIT(18.0f)]];
    [BTCTypeLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:BTCTypeLabel];
    self.BTCTypeLabel= BTCTypeLabel;
    [BTCTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backBtn.mas_top);
        make.left.equalTo(backBtn.mas_right);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(120));
    }];
    [self addPropertyView];
    
    UILabel* propertyRecordLabel=[UILabel new];
    [propertyRecordLabel setText:NSLocalizedString(@"财务记录", nil)];
    [propertyRecordLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [propertyRecordLabel setTextColor:[UIColor blackColor]];
    [self addSubview:propertyRecordLabel];
    self.propertyRecordLabel=propertyRecordLabel;
    [propertyRecordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.equalTo(backgroundImageView.mas_bottom).offset(FIT3(48));
        make.width.mas_equalTo(FIT2(400));
        make.bottom.mas_equalTo(FIT3(-48));
    }];
    

    UIButton* totalRecordBtn=[UIButton new];
//    [totalRecordBtn setImage:[UIImage imageNamed:@"property_total_icon"] forState:UIControlStateNormal];
    [totalRecordBtn setTitle:NSLocalizedString(@"全部", nil) forState:UIControlStateNormal];
    [totalRecordBtn setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [totalRecordBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self addSubview:totalRecordBtn];
    [totalRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(propertyRecordLabel.mas_top);
        make.width.mas_equalTo(FIT2(200));
        make.height.mas_equalTo(FIT2(60));
        make.right.mas_equalTo(FIT2(30));
    }];
    
    self.totalRecordButton=totalRecordBtn;

}


-(UIView*)addPropertyView{
    UIView* propertyView=[UIView new];
    propertyView.backgroundColor=[UIColor whiteColor];
    [self addSubview:propertyView];
    
    [propertyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BTCTypeLabel.mas_bottom).offset(FIT3(48));
        make.width.mas_equalTo(FIT2(690));
        make.height.mas_equalTo(FIT2(145));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    
    UILabel* ablePropertyCountLabel=[UILabel new];
    [ablePropertyCountLabel setText:@"0.000000"];
    [ablePropertyCountLabel setTextColor:[UIColor blackColor]];
    [ablePropertyCountLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [ablePropertyCountLabel setTextAlignment:NSTextAlignmentCenter];
    [propertyView addSubview: ablePropertyCountLabel];
    self.ablePropertyCountLabel=ablePropertyCountLabel;
    [ablePropertyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(FIT2(41));
        make.height.mas_equalTo(FIT2(28));
        make.width.mas_equalTo(FIT2(690)/2);
    }];
    ;
    
    UILabel* ablePropertyLabel=[UILabel new];
    [ablePropertyLabel setFont:[UIFont boldSystemFontOfSize:9]];
    [ablePropertyLabel setTextColor:UIColorFromRGB(0x999999)];
    [ablePropertyLabel setText:NSLocalizedString(@"可用", nil)];
    [ablePropertyLabel setTextAlignment:NSTextAlignmentCenter];
    self.ablePropertyLabel=ablePropertyLabel;
    [propertyView addSubview:ablePropertyLabel];

    [ablePropertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ablePropertyCountLabel.mas_left);
        make.top.equalTo(ablePropertyCountLabel.mas_bottom).offset(FIT2(23));
        make.height.mas_equalTo(FIT2(18));
        make.width.mas_equalTo(ablePropertyCountLabel.mas_width);

    }];
    
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [propertyView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(FIT2(30));
        make.left.mas_equalTo(FIT2(345));
        make.width.mas_equalTo(FIT2(1));
        
    }];
    
    
    UILabel* unablePropertyCountLabel=[UILabel new];
    [unablePropertyCountLabel setText:@"0.000000"];
    [unablePropertyCountLabel setTextColor:[UIColor blackColor]];
    [unablePropertyCountLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [unablePropertyCountLabel setTextAlignment:NSTextAlignmentCenter];
    [propertyView addSubview: unablePropertyCountLabel];
    self.unablePropertyCountLabel=unablePropertyCountLabel;
    [unablePropertyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right);
        make.top.mas_equalTo(FIT2(41));
        make.height.mas_equalTo(FIT2(28));
        make.width.mas_equalTo(ablePropertyCountLabel.mas_width);

    }];
    ;
    
    UILabel* unablePropertyLabel=[UILabel new];
    [unablePropertyLabel setFont:[UIFont boldSystemFontOfSize:9]];
    [unablePropertyLabel setTextColor:UIColorFromRGB(0x999999)];
    [unablePropertyLabel setText:NSLocalizedString(@"冻结", nil)];
    [unablePropertyLabel setTextAlignment:NSTextAlignmentCenter];
    [propertyView addSubview:unablePropertyLabel];
    self.unablePropertyLabel=unablePropertyLabel;
    [unablePropertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right);
        make.top.equalTo(unablePropertyCountLabel.mas_bottom).offset(FIT2(23));
        make.height.mas_equalTo(FIT2(18));
        make.width.mas_equalTo(unablePropertyCountLabel.mas_width);

    }];
    
    
    UIView* bottonLineView=[UIView new];
    [bottonLineView setBackgroundColor:MainBackgroundColor];
    [propertyView addSubview:bottonLineView];
    [bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(FIT2(200));
        make.height.mas_equalTo(FIT2(1));
        make.bottom.mas_equalTo(FIT2(1));
    }];
    
    [ShareFunction setCircleBorder:propertyView];
    return propertyView;
}

- (void)setViewModel:(SZPropertyCellViewModel *)viewModel{
    
    _viewModel=viewModel;
    if (viewModel.walletType == SZWalletTypeBB) {
        self.BTCTypeLabel.text=viewModel.bbPropertyModel.fvirtualcointypeName;
        self.ablePropertyCountLabel.text=viewModel.bbPropertyModel.ftotal;
        self.unablePropertyCountLabel.text=viewModel.bbPropertyModel.frozen;
    }else  if (viewModel.walletType == SZWalletTypeSC) {
        self.ablePropertyLabel.text=NSLocalizedString(@"当日锁定", nil);
        self.unablePropertyLabel.text=NSLocalizedString(@"待发放利息", nil);
//        [self.backgroundImageView setImage:[UIImage imageNamed:@"wallet_scAcount_image"]];
        [self.totalRecordButton setHidden:YES];
        [self.propertyRecordLabel setText:NSLocalizedString(@"变动明细", nil)];
        
        self.BTCTypeLabel.text=viewModel.scPropertyModel.shortName;
        self.ablePropertyCountLabel.text=viewModel.scPropertyModel.dayAssets;
        self.unablePropertyCountLabel.text=viewModel.scPropertyModel.sumNotGrantRate;
    }else{
       

//        [self.backgroundImageView setImage:[UIImage imageNamed:@"wallet_scAcount_image"]];
        [self.totalRecordButton setHidden:YES];
        [self.propertyRecordLabel setText:NSLocalizedString(@"变动明细", nil)];

        self.BTCTypeLabel.text=viewModel.c2cPropertyModel.fvirtualcointypeName;
        self.ablePropertyCountLabel.text=viewModel.c2cPropertyModel.ftotal;
        self.unablePropertyCountLabel.text=viewModel.c2cPropertyModel.ffrozen;
    }
    
   
}
@end
