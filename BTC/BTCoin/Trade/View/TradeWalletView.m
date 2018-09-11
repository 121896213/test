//
//  TradeWalletView.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "TradeWalletView.h"
#import "LoginViewController.h"

@interface TradeWalletView()

@property (nonatomic,strong)UIView * needLoginView;

@property (nonatomic,strong)UIView * showDataView;
@property (nonatomic,strong)UILabel * left_one_lab;
@property (nonatomic,strong)UILabel * right_one_lab;

@property (nonatomic,strong)UILabel * left_two_lab;
@property (nonatomic,strong)UILabel * right_two_lab;

@property (nonatomic,strong)UILabel * left_thr_lab;
@property (nonatomic,strong)UILabel * right_thr_lab;

@property (nonatomic,strong)UILabel * left_four_lab;
@property (nonatomic,strong)UILabel * right_four_lab;

@property (nonatomic,strong)UILabel * totalLab;
@property (nonatomic,strong)UILabel * totalRMBLab;

@property (nonatomic,strong)MyWalletModel * walletModel;

@end

@implementation TradeWalletView

-(instancetype)init{
    if (self = [super init]) {
        self.needLoginView.hidden = NO;
    }
    return self;
}

-(UIView *)showDataView{
    if (!_showDataView) {
        _showDataView = [[UIView alloc]init];

        CGFloat margin_X = 16, height = 15;

        _left_one_lab = [self createLabel:UIColorFromRGB(0x999999) :@"可用XX:" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_left_one_lab];
        [_left_one_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.leading.mas_equalTo(margin_X);
            make.height.mas_equalTo(height);
        }];
        
        _right_one_lab = [self createLabel:UIColorFromRGB(0x666666) :@"54531.00" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_right_one_lab];
        [_right_one_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_left_one_lab.mas_top);
            make.leading.mas_equalTo(_left_one_lab.mas_trailing).offset(10);
            make.height.mas_equalTo(height);
        }];
        
        _left_two_lab = [self createLabel:UIColorFromRGB(0x999999) :@"冻结XX:" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_left_two_lab];
        [_left_two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_left_one_lab.mas_bottom).offset(10);
            make.leading.mas_equalTo(margin_X);
            make.height.mas_equalTo(height);
        }];
        
        _right_two_lab = [self createLabel:UIColorFromRGB(0x666666) :@"54531.00" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_right_two_lab];
        [_right_two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_left_two_lab.mas_top);
            make.leading.mas_equalTo(_left_two_lab.mas_trailing).offset(10);
            make.height.mas_equalTo(height);
        }];
        
        UIView * line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xE6E6E6);
        [_showDataView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_left_two_lab.mas_bottom).offset(10);
            make.leading.mas_equalTo(margin_X);
            make.height.mas_equalTo(1);
            make.trailing.mas_equalTo(0);
        }];
        
        _left_thr_lab = [self createLabel:UIColorFromRGB(0x999999) :@"可用XX:" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_left_thr_lab];
        [_left_thr_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            make.leading.mas_equalTo(margin_X);
            make.height.mas_equalTo(height);
        }];
        
        _right_thr_lab = [self createLabel:UIColorFromRGB(0x666666) :@"54531.00" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_right_thr_lab];
        [_right_thr_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_left_thr_lab.mas_top);
            make.leading.mas_equalTo(_left_thr_lab.mas_trailing).offset(10);
            make.height.mas_equalTo(height);
        }];
        
        _left_four_lab = [self createLabel:UIColorFromRGB(0x999999) :@"冻结XX:" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_left_four_lab];
        [_left_four_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_left_thr_lab.mas_bottom).offset(10);
            make.leading.mas_equalTo(margin_X);
            make.height.mas_equalTo(height);
        }];
        
        _right_four_lab = [self createLabel:UIColorFromRGB(0x666666) :@"54531.00" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_right_four_lab];
        [_right_four_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_left_four_lab.mas_top);
            make.leading.mas_equalTo(_left_four_lab.mas_trailing).offset(10);
            make.height.mas_equalTo(height);
        }];
        
        UILabel * staticLab = [self createLabel:UIColorFromRGB(0x999999) :@"当前币币账户总资产：" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:staticLab];
        [staticLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_left_four_lab.mas_bottom).offset(30);
            make.leading.mas_equalTo(margin_X);
            make.height.mas_equalTo(height);
            make.trailing.mas_equalTo(0);
        }];
        
        _totalLab = [self createLabel:UIColorFromRGB(0x666666) :@"51244.00564158  USDT" :[UIFont fontWithName:@"PingFang-SC-Medium" size:18]];
        [_showDataView addSubview:_totalLab];
        [_totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(staticLab.mas_bottom).offset(10);
            make.leading.mas_equalTo(margin_X);
            make.height.mas_equalTo(18);
            make.trailing.mas_equalTo(0);
        }];
        
        _totalRMBLab = [self createLabel:UIColorFromRGB(0x666666) :@"≈51244.00 CNY" :[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
        [_showDataView addSubview:_totalRMBLab];
        [_totalRMBLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_totalLab.mas_bottom).offset(10);
            make.leading.mas_equalTo(margin_X);
            make.height.mas_equalTo(height);
            make.trailing.mas_equalTo(0);
        }];
        
        [self addSubview: _showDataView];
        [_showDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.bottom.mas_equalTo(0);
        }];
    }
    return _showDataView;
}

-(void)refreshWalletViewWithModel:(MyWalletModel *)walletModel :(BOOL)isBuy :(MarketHomeListModel *)model
{
    _walletModel = walletModel;
    if (_walletModel) {
        self.needLoginView.hidden = YES;
        self.showDataView.hidden = NO;
        
        NSString * topName = model.fShortName ;
        NSString * bottomName = model.areaName ;

        if (isBuy) {
            topName = model.areaName ;
            bottomName = model.fShortName ;
        }

        _left_one_lab.text = FormatString(@"可用%@:",topName);
        _right_one_lab.text = isBuy ? walletModel.ftotalType : walletModel.ftotal;
        _left_two_lab.text = FormatString(@"冻结%@:",topName);
        _right_two_lab.text = isBuy ? walletModel.ffrozenType : walletModel.ffrozen;
        _left_thr_lab.text = FormatString(@"可用%@:",bottomName);
        _right_thr_lab.text = isBuy ? walletModel.ftotal : walletModel.ftotalType;
        _left_four_lab.text = FormatString(@"冻结%@:",bottomName);
        _right_four_lab.text = isBuy ? walletModel.ffrozen : walletModel.ffrozenType;
       
        NSMutableAttributedString * mAttString = [[NSMutableAttributedString alloc]initWithString:walletModel.bbUsdtNum attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:18]}];
        [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:@" USDT" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:14]}]];
        _totalLab.attributedText = mAttString;
        _totalRMBLab.text = FormatString(@"≈%@ CNY",walletModel.bbCnyNum);
        
    }else{
        self.needLoginView.hidden = NO;
        self.showDataView.hidden = YES;
    }
    
}

-(void)gotoLogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
    [TheAppDel.window.rootViewController presentViewController:loginNav animated:YES completion:nil];
}

-(UIView *)needLoginView{
    if (!_needLoginView) {
        _needLoginView = [[UIView alloc]init];
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage:kIMAGE_NAMED(@"tradeNoLoginImage")];
        [_needLoginView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(102);
            make.centerX.mas_equalTo(_needLoginView);
        }];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoLogin)];
        [imageView addGestureRecognizer:tap];
        
        UILabel * label  = [self createLabel:UIColorFromRGB(0x666666) :@"登录后进行交易" :kFontSize(14)];
        label.textAlignment = NSTextAlignmentCenter;
        [_needLoginView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView.mas_bottom).offset(25);
            make.height.mas_equalTo(15);
            make.leading.mas_equalTo(imageView.mas_leading);
        }];
        [self addSubview: _needLoginView];
        [_needLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.bottom.mas_equalTo(0);
        }];
        
    }
    return _needLoginView;
}

-(UILabel *)createLabel:(UIColor *)color :(NSString *)text :(UIFont *)font{
    UILabel * label  = [UILabel new];
    label.text = NSLocalizedString(text, nil);
    label.textColor = color;
    label.font = font;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

@end
