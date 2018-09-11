

//
//  SZSecurityCodeView.m
//  BTCoin
//
//  Created by Shizi on 2018/5/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSecurityCodeView.h"
@interface SZSecurityCodeView()
@property (nonatomic,strong) UILabel* phoneLab;
@property (nonatomic,strong) UIButton* cancelBtn;
@property (nonatomic,strong) UIButton* sendBtn;


@end
@implementation SZSecurityCodeView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self setSubView];
        [self addActions];

    }
    
    return self;
}

- (SZSecurityCodeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel=[SZSecurityCodeViewModel new];
    }
    return _viewModel;
}
-(void)setSubView{
    

    UIView* leftWriteView=[UILabel new];
    [self.contentView addSubview:leftWriteView];
    self.contentView.backgroundColor=MainBackgroundColor;
    [leftWriteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(132));
    }];
    leftWriteView.backgroundColor=[UIColor whiteColor];
    
    
    UILabel* titleLab=[UILabel new];
    titleLab.text=NSLocalizedString(@"安全验证", nil);
    titleLab.font=[UIFont systemFontOfSize:18.0f];
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(132));
    }];
    titleLab.backgroundColor=[UIColor whiteColor];
    
    

    UIButton* cancelBtn=[UIButton new];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [cancelBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [cancelBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColorFromRGB(0xacacac) forState:UIControlStateNormal];
    [self.contentView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(titleLab.mas_top);
        make.right.mas_equalTo(FIT3(-48));
        make.width.mas_equalTo(FIT3(150));
        make.height.mas_equalTo(FIT3(132));
    }];
    self.cancelBtn=cancelBtn;
    

    UILabel* phoneLab=[UILabel new];
    phoneLab.text=[UserInfo sharedUserInfo].telNumber;
    phoneLab.font=[UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.equalTo(titleLab.mas_bottom);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(185));
    }];
    
    UIView* textFieldView=[UIView new];
    textFieldView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:textFieldView];
    [textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLab.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    self.securityTextField=[UITextField new];
    self.securityTextField.placeholder=NSLocalizedString(@"请输入手机验证码", nil);
    self.securityTextField.textColor=[UIColor blackColor];
    self.securityTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    self.securityTextField.font=[UIFont systemFontOfSize:14.0f];
    self.securityTextField.secureTextEntry=YES;
//    self.securityTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FIT(16), 0)];
    self.securityTextField.leftViewMode=UITextFieldViewModeAlways;
    self.securityTextField.font=[UIFont systemFontOfSize:14.0f];
    [textFieldView addSubview:self.securityTextField];
    [self.securityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(phoneLab.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    self.sendBtn=[UIButton new];
    [self.sendBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.sendBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.sendBtn setTitle:NSLocalizedString(@"发送", nil) forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [textFieldView addSubview:self.sendBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT2(-30));
        make.top.equalTo(self.securityTextField.mas_top);
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(120));
        
    }];
    
    self.confirmBtn=[UIButton new];
    [self.confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.confirmBtn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.confirmBtn];

    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.equalTo(self.securityTextField.mas_bottom).offset(FIT3(77));
        make.height.mas_equalTo(FIT3(150));
        make.width.mas_equalTo(ScreenWidth-FIT3(48)*2);

    }];
    [self.confirmBtn setGradientBackGround];
    [self.confirmBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    
}

-(void)addActions{
    
    @weakify(self);
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [self disMissView];
    }];
    [[self.sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        NSString* sendTitle=self.sendBtn.titleLabel.text;
        if ([sendTitle isEqualToString:NSLocalizedString(@"发送", nil)]) {

            if ([[UserInfo sharedUserInfo] isBindTelephone]) {
                self.viewModel.mobile=[UserInfo sharedUserInfo].telNumber;
                [self.viewModel getWithdrawSecurityCodeWithParameters:nil];
            }else{
                [UIViewController showPromptHUDWithTitle:@"请先绑定手机"];
            }

        }
    }];
    
    [self.viewModel.successSignal subscribeNext:^(id x) {
        [UIViewController showPromptHUDWithTitle:x];
    }];
    
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        [UIViewController showErrorHUDWithTitle:x];
    }];
    
    __block NSInteger seconds=0;
    __block RACSignal* timerSignal;
    [self.viewModel.otherSignal subscribeNext:^(id x) {
        @strongify(self);
        [UIViewController showPromptHUDWithTitle:NSLocalizedString(@"验证码已发送,请查收", nil) ];
        if ([x isEqualToString:@"SecurityCode"]) {
            
            seconds=120;
            [self.sendBtn setTitle:FormatString(@"%lds",(long)seconds) forState:UIControlStateNormal];

            if (!timerSignal) {
                timerSignal=[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]]takeUntil:self.rac_willDeallocSignal];
                [timerSignal subscribeNext:^(id x) {
                    @strongify(self);
                    seconds--;
                    if (seconds <= 0) {
                        [self.sendBtn setTitle:NSLocalizedString(@"发送", nil) forState:UIControlStateNormal];
                    }else{
                        [self.sendBtn setTitle:FormatString(@"%lds",(long)seconds) forState:UIControlStateNormal];
                    }
                }];
            }else{
                [timerSignal startWith:@0];
            }
        }
    }];
}

-(void)setWithDrawViewModel:(SZPropertyWithdrawViewModel *)withDrawViewModel{
    
    _withDrawViewModel=withDrawViewModel;
    
}
-(void)disMissView{
    [super disMissView];
    [self removeFromSuperview];
    
}
@end
