//
//  SZTradePasswordView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZTradePasswordView.h"
@interface SZTradePasswordView()
@property (nonatomic,strong) UIButton* cancelBtn;


@end
@implementation SZTradePasswordView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self setSubView];
        [self addActions];
        
    }
    
    return self;
}

-(void)setSubView{
    
    
    UIView* leftWriteView=[UILabel new];
    [self.contentView addSubview:leftWriteView];
    self.contentView.backgroundColor=[UIColor whiteColor];
    [leftWriteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(132));
    }];
    leftWriteView.backgroundColor=[UIColor whiteColor];
    
    
    UILabel* titleLab=[UILabel new];
    titleLab.text=NSLocalizedString(@"输入密码", nil);
    titleLab.font=[UIFont systemFontOfSize:FIT(18.0)];
    titleLab.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(FIT(44));
    }];
    titleLab.backgroundColor=[UIColor whiteColor];
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(titleLab.mas_bottom);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(FIT(0.3));
        
    }];
    
    UIButton* cancelBtn=[UIButton new];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [cancelBtn setTitleColor:UIColorFromRGB(0xacacac) forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    cancelBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLab.mas_top);
        make.left.mas_equalTo(FIT(16));
        make.width.mas_equalTo(FIT(50));
        make.height.mas_equalTo(FIT(44));
    }];
    self.cancelBtn=cancelBtn;
    
    
    
    
    self.passwordTextField=[UITextField new];
    self.passwordTextField.placeholder=NSLocalizedString(@"请输入交易密码", nil);
    self.passwordTextField.textColor=[UIColor blackColor];
    self.passwordTextField.keyboardType=UIKeyboardTypeDefault;
    self.passwordTextField.font=[UIFont systemFontOfSize:14.0f];
    self.passwordTextField.secureTextEntry=YES;
    self.passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FIT(16), 0)];
    self.passwordTextField.leftViewMode=UITextFieldViewModeAlways;
    [self.contentView addSubview: self.passwordTextField];
    self.passwordTextField.backgroundColor=MainBackgroundColor;
    [self.passwordTextField setCircleBorderWidth:FIT(1) bordColor:self.passwordTextField.backgroundColor radius:FIT(3)];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelBtn.mas_bottom).offset(FIT(16)*2);
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(FIT(44));
    }];

    self.confirmBtn=[UIButton new];
    [self.confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(18)]];
    [self.confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.confirmBtn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.confirmBtn];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(FIT(25));
        make.height.mas_equalTo(FIT(50));
        make.width.mas_equalTo(ScreenWidth-FIT(16)*2);
        
    }];
    [self.confirmBtn setGradientBackGround];
    
    


}

-(void)addActions{
    
    @weakify(self);
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [self disMissView];
    }];
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        if (isEmptyString(self.passwordTextField.text)) {
            [UIViewController showPromptHUDWithTitle:NSLocalizedString(@"请输入交易密码", nil)];
        }else{
            if (self.confirmBlock) {
                self.confirmBlock(self.passwordTextField.text);
                [self disMissView];

            }
        }
        
    }];
}

-(void)disMissView{
//    [super disMissView];
    [self removeFromSuperview];
    
}
@end
