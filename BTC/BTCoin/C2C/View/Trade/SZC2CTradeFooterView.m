//
//  SZC2CStateFooterView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CTradeFooterView.h"
@interface SZC2CTradeFooterView()
@property (nonatomic, strong)  UIButton* tradeBtn;

@end

@implementation SZC2CTradeFooterView

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
    
    
    UIButton* tradeBtn = [[UIButton alloc]init];
    tradeBtn.backgroundColor = UIColorFromRGB(0x497cce);
    [tradeBtn setTitle:NSLocalizedString(@"买入(45秒)", nil) forState:UIControlStateNormal];
    [tradeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tradeBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:tradeBtn];
    [tradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(37));
        make.right.mas_equalTo(FIT(0));
        make.left.mas_equalTo(FIT(0));
        make.height.mas_equalTo(FIT(50));
    }];
    self.tradeBtn=tradeBtn;
}


-(void)setViewStlyeWithIsTradeSell:(BOOL)isTradeSell{
    
    if (isTradeSell) {
        [self.tradeBtn setTitle:NSLocalizedString(@"卖出(45秒)", nil) forState:UIControlStateNormal];
        self.tradeBtn.backgroundColor=MainThemeBlueColor;
    }else{
        [self.tradeBtn setTitle:NSLocalizedString(@"买入(45秒)", nil) forState:UIControlStateNormal];
        self.tradeBtn.backgroundColor=MainThemeBlueColor;

    }
    [self.tradeBtn setCircleBorderWidth:FIT(1) bordColor:self.tradeBtn.backgroundColor radius:FIT(3)];

}
@end
