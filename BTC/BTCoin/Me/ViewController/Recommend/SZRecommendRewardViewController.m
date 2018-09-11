//
//  SZRecommendRewardViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRecommendRewardViewController.h"

@interface SZRecommendRewardViewController ()

@end

@implementation SZRecommendRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self setTitleText:NSLocalizedString(@"推荐奖励规则", nil)];
    NSString* content=NSLocalizedString(@"1.好友接受邀请后，每产生一笔真实交易手续费，会产生相应比例的返佣。好友再次邀请一人，邀请的人每产生一笔真实交易手续费，也会产生相应比例的返佣。\n\n2.返佣的形式以USDT的形式返佣到您的交易账户，直接推荐返佣比例为10%，间接推荐返佣比例为5%。\n\n3.好友交易返佣当日统计，次日到账；返佣额=实际交易量*手续费比例*返佣比例。\n\n4.平台将以每5分钟取一次市价进行相应币种的USDT实时换算，返佣金额以实际返佣金额为准。\n\n5.充币、提币不参与手续费返佣。\n\n6.通过不正当获得奖励，平台有权取消和追回所获奖励。", nil) ;
    CGFloat noticeAutoHeight=[ShareFunction getHeightLineWithString:content withWidth:ScreenWidth-FIT3(48)*2 withFont:[UIFont systemFontOfSize:15.0f]]-[UIFont systemFontOfSize:15.0f].lineHeight*10;

    
    UIView* backgroundView=[UIView new];
    backgroundView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationStatusBarHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(noticeAutoHeight+FIT3(104)+FIT3(42)+FIT3(131));
    }];
    
    
    UILabel* introduceLab=[UILabel new];
    introduceLab.text=content ;
    introduceLab.font=[UIFont systemFontOfSize:15.0f];
    introduceLab.numberOfLines=0;
    introduceLab.textAlignment=NSTextAlignmentNatural;
    [backgroundView addSubview:introduceLab];
    [introduceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(48));
        make.left.mas_equalTo(FIT3(48));
        make.right.mas_equalTo(FIT3(-48));
        make.height.mas_equalTo(noticeAutoHeight);
    }];
  
    
    UILabel* finalLab=[UILabel new];
    finalLab.text=NSLocalizedString(@"最终解释权归BTK交易平台所有。", nil) ;
    finalLab.font=[UIFont systemFontOfSize:16.0f];
    finalLab.textAlignment=NSTextAlignmentCenter;
    finalLab.textColor=UIColorFromRGB(0xFF0000);
    [backgroundView addSubview:finalLab];

    [finalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(introduceLab.mas_bottom).offset(FIT3(104));
        make.left.mas_equalTo(FIT3(186));
        make.right.mas_equalTo(FIT3(-186));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    
    
    
    UIButton*  shareBtn=[UIButton new];
    shareBtn=[UIButton new];
    [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [shareBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [shareBtn setTitle:NSLocalizedString(@"立即分享", nil) forState:UIControlStateNormal];
    [shareBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [shareBtn setHidden:YES];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView.mas_bottom).offset(FIT3(112));
        make.height.mas_equalTo(FIT3(150));
        make.width.mas_equalTo(FIT3(1146));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [shareBtn setGradientBackGround];
    [shareBtn setBackgroundImage:[UIImage imageWithColor:MainThemeHighlightColor] forState:UIControlStateSelected];

    [ShareFunction setCircleBorder:shareBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
