//
//  SZPaymentcodeView.m
//  BTCoin
//
//  Created by sumrain on 2018/8/31.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPaymentcodeView.h"
#import "UIImageView+QRCode.h"

@implementation SZPaymentcodeView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self setSubView];
    }
    
    return self;
}

-(void)setSubView{
    
    
    UIImageView* payCodeView=[UIImageView new];
    [self.contentView addSubview:payCodeView];
    [payCodeView setImage:[payCodeView creatCIQRCodeImage:@"addvcrerevcvcvxvvcsjflxjcovjfdoredosfnzljfzjdflvjcvjofdufeisocjxljcxk"]];
    payCodeView.contentMode=UIViewContentModeScaleAspectFit;
    [payCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.width.mas_equalTo(FIT(267));
        make.height.mas_equalTo(FIT(267));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);

    }];
    
    UIButton* closeBtn=[UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"zhibiaoClose_W"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_top).offset(-14);
        make.width.height.mas_equalTo(FIT(30));
    }];
    
    @weakify(self);
    [[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [self disMissView];
    }];
    
    
}



- (void)showInView:(UIView *)view directionType:(SZPopViewFromDirectionType)directionType{
    [super showInView:view directionType:directionType];

}
-(void)disMissView{
    [super disMissView];
    [self removeFromSuperview];
    
}

@end
