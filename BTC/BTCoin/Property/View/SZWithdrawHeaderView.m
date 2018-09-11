//
//  SZWithdrawHeaderView.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWithdrawHeaderView.h"
@interface SZWithdrawHeaderView ()
@property (nonatomic,strong) UILabel* BTCTypeLabel;
@property (nonatomic,strong) UILabel* ableCountLabel;
@end
@implementation SZWithdrawHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
}

-(void)setSubView{
    
//    UIButton* backBtn=[UIButton new];
//    [backBtn setImage:[UIImage imageNamed:@"attention_return_n"] forState:UIControlStateNormal];
//    [self addSubview:backBtn];
//    self.backBtn=backBtn;
//    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(FIT3(48));
//        make.top.mas_equalTo(StatusBarHeight);
//        make.width.height.mas_equalTo(FIT3(105));
//    }];
//
//
//    UILabel* BTCTypeLabel=[UILabel new];
//    [BTCTypeLabel setText:NSLocalizedString(@"BTC  提币", nil)];
//    [BTCTypeLabel setFont:[UIFont boldSystemFontOfSize:FIT3(72)]];
//    [BTCTypeLabel setTextColor:[UIColor blackColor]];
//    [self addSubview:BTCTypeLabel];
//    self.BTCTypeLabel=BTCTypeLabel;
//    [BTCTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(backBtn.mas_bottom).offset(FIT3(11));
//        make.left.equalTo(backBtn.mas_left);
//        make.width.mas_equalTo(ScreenWidth-FIT3(48));
//        make.height.mas_equalTo(FIT3(108));
//    }];
    
    UILabel* ableLabel=[UILabel new];
    [ableLabel setText:NSLocalizedString(@"可用", nil)];
    [ableLabel setFont:[UIFont boldSystemFontOfSize:FIT3(42)]];
    [ableLabel setTextColor:[UIColor blackColor]];
    [self addSubview:ableLabel];
    [ableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(21));
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(FIT3(300));
        make.bottom.mas_equalTo(FIT3(-21));
    }];
    
    
    
    UILabel* ableCountLabel=[UILabel new];
    [ableCountLabel setText:NSLocalizedString(@"0.00000000  BTC", nil)];
    [ableCountLabel setFont:[UIFont boldSystemFontOfSize:FIT3(42)]];
    [ableCountLabel setTextColor:[UIColor blackColor]];
    [ableCountLabel setTextAlignment:NSTextAlignmentRight];
    self.ableCountLabel=ableCountLabel;
    [self addSubview:ableCountLabel];
    [ableCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ableLabel.mas_top);
        make.right.mas_equalTo(FIT2(-30));
        make.width.mas_equalTo(FIT3(500));
        make.bottom.mas_equalTo(FIT3(-21));
    }];
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT3(-1.5));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    
    
    
}


- (void)setPropertyCellViewModel:(SZPropertyCellViewModel *)propertyCellViewModel
{
    [self.BTCTypeLabel setText: [NSString stringWithFormat:@"%@    %@",propertyCellViewModel.bbPropertyModel.fvirtualcointypeName,NSLocalizedString(@"提币", nil)]];
    [self.ableCountLabel setText:[NSString stringWithFormat:@"%@  %@",propertyCellViewModel.bbPropertyModel.ftotal,propertyCellViewModel.bbPropertyModel.fvirtualcointypeId]];
    _propertyCellViewModel=propertyCellViewModel;
    
}
@end
