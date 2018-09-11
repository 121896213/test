//
//  ForgetPwdViewController.m
//  BTCoin
//
//  Created by LionIT on 13/03/2018.
//  Copyright © 2018 LionIT. All rights reserved.
//

#import "SZForgetPwdViewController.h"
#import "SZForgetPwdViewModel.h"
#import "SZSecurityCodeViewModel.h"
#import "SZModifyPwdViewController.h"
#import "NSString+Helper.h"
@interface SZForgetPwdViewController ()
@property (nonatomic,strong) UIButton* confirmButton;
@property (nonatomic,strong) UIButton* saoButton;
@property (nonatomic,strong) SZForgetPwdViewModel* viewModel;
@property (nonatomic,strong) SZSecurityCodeViewModel* securityCodeViewModel;

@property (nonatomic,strong) UITextField* addressTextField;
@property (nonatomic,strong) UITextField* remarkTextFiled;
@end

@implementation SZForgetPwdViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor=MainBackgroundColor;
        [self setSubviews];
        [self addActions];
    }
    return self;
}
- (SZForgetPwdViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZForgetPwdViewModel new];
    }
    
    return _viewModel;
}

-(SZSecurityCodeViewModel *)securityCodeViewModel{
    if (!_securityCodeViewModel) {
        _securityCodeViewModel=[SZSecurityCodeViewModel new];
        _securityCodeViewModel.securityCodeType=SZSecurityCodeViewTypeFindLoginPassword;
    }
    
    return _securityCodeViewModel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)setSubviews{
    
    [self setTitleText:NSLocalizedString(@"忘记密码", nil)];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    
    UILabel* addressLabel=[UILabel new];
    [addressLabel setText:NSLocalizedString(@"邮箱或手机号码", nil)];
    [addressLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [addressLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationStatusBarHeight+FIT3(32));;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    UIView* textFieldView=[UIView new];
    textFieldView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:textFieldView];
    [textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    UITextField* addressTextField=[UITextField new];
    addressTextField.placeholder=NSLocalizedString(@"请输入邮箱或手机号码", nil);
    addressTextField.textColor=[UIColor blackColor];
    addressTextField.font=[UIFont systemFontOfSize:14.0f];
    self.addressTextField=addressTextField;
    [textFieldView addSubview:addressTextField];
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    
    UILabel* remarkLabel=[UILabel new];
    [remarkLabel setText:NSLocalizedString(@"验证码", nil)];
    [remarkLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [remarkLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:remarkLabel];
    [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textFieldView.mas_bottom).offset(FIT3(32));;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    UIView* remarkView=[UIView new];
    remarkView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:remarkView];
    [remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    UITextField* remarkTextField=[UITextField new];
    remarkTextField.placeholder=NSLocalizedString(@"请输入验证码", nil);
    remarkTextField.textColor=[UIColor blackColor];
    remarkTextField.font=[UIFont systemFontOfSize:14.0f];
    [remarkView addSubview:remarkTextField];
    self.remarkTextFiled=remarkTextField;
    [remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkLabel.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    
    UIButton* saoButton=[UIButton new];
    self.saoButton=saoButton;
    [self.saoButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.saoButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.saoButton setTitle:NSLocalizedString(@"发送", nil) forState:UIControlStateNormal];
    [self.saoButton setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [remarkView addSubview:saoButton];
    [self.saoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(remarkTextField.mas_top);
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(150));
        
    }];
    
    
    self.confirmButton=[UIButton new];
    [self.confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.confirmButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.confirmButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(FIT3(-170));
        make.left.mas_equalTo(FIT3(48));
        make.right.mas_equalTo(FIT3(-48));
        make.height.mas_equalTo(FIT3(150));
    }];
    [self.confirmButton setGradientBackGround];
    [self.confirmButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    [ShareFunction setCircleBorder:self.confirmButton];
    
}

-(void)addActions{
    
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self hideMBProgressHUD];
        SZModifyPwdViewController* modifyPwdVC=[SZModifyPwdViewController new];
        modifyPwdVC.viewModel.mobileEmail=self.addressTextField.text;
        modifyPwdVC.viewModel.securityCode=self.remarkTextFiled.text;
        [self.navigationController pushViewController:modifyPwdVC animated:YES];
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];
    
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        
        if (isEmptyString(self.addressTextField.text)) {
            [self showPromptHUDWithTitle:@"请输入邮箱或手机密码"];
        }else if (isEmptyString(self.remarkTextFiled.text)){
            [self showPromptHUDWithTitle:@"请输入验证码"];
        }else{
            NSString* mobileEmail=self.addressTextField.text;
            if ([mobileEmail isMobliePhone]) {
                [self showLoadingMBProgressHUD];
                [self.viewModel checkSecurityCodeWithPhone:mobileEmail msgCode:self.remarkTextFiled.text];
            }else if ([mobileEmail isEmail]){
                [self showLoadingMBProgressHUD];
                [self.viewModel checkSecurityCodeWithEmail:mobileEmail msgCode:self.remarkTextFiled.text];
            }else{
                [self showPromptHUDWithTitle:@"请输入合法的手机号码或邮箱"];
            }
        }
    }];
    [self.securityCodeViewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];
    }];
    
    [self.securityCodeViewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];
    }];
    
    __block NSInteger seconds=0;
    __block RACSignal* timerSignal;

    [self.securityCodeViewModel.otherSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:@"验证码已发送,请查收"];
        if ([x isEqualToString:@"SecurityCode"]) {
        
            seconds=120;
            [self.saoButton setTitle:FormatString(@"%lds",(long)seconds) forState:UIControlStateNormal];
            if (!timerSignal) {
                timerSignal=[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]]takeUntil:self.rac_willDeallocSignal];
                [timerSignal subscribeNext:^(id x) {
                    @strongify(self);
                    seconds--;
                    if (seconds <= 0) {
                        [self.saoButton setTitle:NSLocalizedString(@"发送", nil) forState:UIControlStateNormal];
                    }else{
                        [self.saoButton setTitle:FormatString(@"%lds",(long)seconds) forState:UIControlStateNormal];
                    }
                }];
            }else{
                [timerSignal startWith:@0];
            }
        }
    }];
    
    [[self.saoButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        NSString* sendTitle=self.saoButton.titleLabel.text;
        if ([sendTitle isEqualToString:NSLocalizedString(@"发送", nil)]) {
            
            if (![self.addressTextField.text isMobliePhone] && ![self.addressTextField.text isEmail] ) {
                [self showPromptHUDWithTitle:@"请输入邮箱或手机密码"];
            }else{
                NSString* mobileEmail=self.addressTextField.text;
                if ([mobileEmail isMobliePhone]) {
                    [self showLoadingMBProgressHUD];
                    self.securityCodeViewModel.mobile=self.addressTextField.text;
                    [self.securityCodeViewModel getWithdrawSecurityCodeWithParameters:mobileEmail];
                }else if ([mobileEmail isEmail]){
                    [self showLoadingMBProgressHUD];
                    [self.securityCodeViewModel getEmailCodeWithParameters:mobileEmail securityCodeType:SZSecurityCodeViewTypeFindLoginPassword];
                }else{
                    [self showPromptHUDWithTitle:@"请输入合法的手机号码或邮箱"];
                }
            }
            
        }
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

