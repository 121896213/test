//
//  SZIntroduceViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZIntroduceViewController.h"

@interface SZIntroduceViewController ()

@end

@implementation SZIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"平台介绍", nil)];

    UILabel* introduceLab=[UILabel new];
    introduceLab.text=NSLocalizedString(@"    BTK(比特王)柬埔寨数字资产交易平台是全球领先的世界级新生态数字资产交易平台。平台致力于严格审查、精心挑选全球优质数字资产，为投资者提供合理有效的数字资产配置管理平台。旨在为全球用户提供安全、专业、诚信、舒适的服务。\n\n    同时致力于构建一个开放，权威，公正且有规则的交易平台生态圈，挖掘潜在价值区块链项目、成立基金联盟、推出重磅的财经资讯，在交易服务平台形成生态闭环，高质量核心团队为区块链发展推波助澜。\n\n    BTK(比特王)数字资产交易所目前获得柬埔寨商业部，中央银行，财政部颁发的交易牌照。获得联合国区块链组织颁发的交易所牌照和运营牌照。拥有官方权威背景及资格认证。", nil) ;
    introduceLab.font=[UIFont systemFontOfSize:15.0f];
    introduceLab.numberOfLines=0;
    [self.view addSubview:introduceLab];
    [introduceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headView.mas_bottom).offset(30);
        make.left.mas_equalTo(FIT3(48));
        make.right.mas_equalTo(FIT3(-48));
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
