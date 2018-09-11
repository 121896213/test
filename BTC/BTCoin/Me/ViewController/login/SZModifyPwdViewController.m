//
//  SZConfirmPwdViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZModifyPwdViewController.h"
#import "SZSecurityCodeViewModel.h"
#import  "RegisterTextField.h"
@interface SZModifyPwdViewController ()
@property (nonatomic,strong) UIButton* confirmButton;
@property (nonatomic,strong) UIButton* saoButton;

@property (nonatomic,strong) UITextField* addressTextField;
@property (nonatomic,strong) UITextField* remarkTextFiled;
@end

@implementation SZModifyPwdViewController

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
- (SZModifyPwdViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZModifyPwdViewModel new];
    }
    
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setSubviews{
    
    [self setTitleText:NSLocalizedString(@"忘记密码", nil)];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    
    UILabel* addressLabel=[UILabel new];
    [addressLabel setText:NSLocalizedString(@"密码", nil)];
    [addressLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [addressLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationStatusBarHeight);;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(178));
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
    
    
    RegisterTextField* addressTextField=[RegisterTextField new];
    addressTextField.placeholder=NSLocalizedString(@"请输入交易密码", nil);
    addressTextField.textColor=[UIColor blackColor];
    addressTextField.font=[UIFont systemFontOfSize:14.0f];
    addressTextField.isShowTextBool = YES;

    [addressTextField setSecureTextEntry:YES];

    self.addressTextField=addressTextField;
    [textFieldView addSubview:addressTextField];
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    
    UILabel* remarkLabel=[UILabel new];
    [remarkLabel setText:NSLocalizedString(@"确认密码", nil)];
    [remarkLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [remarkLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:remarkLabel];
    [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textFieldView.mas_bottom);;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(178));
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
    
    
    RegisterTextField* remarkTextField=[RegisterTextField new];
    remarkTextField.placeholder=NSLocalizedString(@"请再次输入密码", nil);
    remarkTextField.textColor=[UIColor blackColor];
    remarkTextField.font=[UIFont systemFontOfSize:14.0f];
    [remarkTextField setSecureTextEntry:YES];
    remarkTextField.isShowTextBool = YES;

    [remarkView addSubview:remarkTextField];
    self.remarkTextFiled=remarkTextField;
    [remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    
    
    self.confirmButton=[UIButton new];
    [self.confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.confirmButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.confirmButton setTitle:NSLocalizedString(@"确认修改", nil) forState:UIControlStateNormal];
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
        [self showErrorHUDWithTitle:x];
        
        [[SZSundriesCenter instance] delayExecutionInMainThread:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];


    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];
    
    
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        
        if ([self.addressTextField.text length] == 0) {
            [self showPromptHUDWithTitle:@"请输入登录密码"];
            return;
        }else if ([self.remarkTextFiled.text length] == 0) {
            [self showPromptHUDWithTitle:@"请再次输入登录密码"];
            return;
        }
        else if (![[self.remarkTextFiled.text trim] isEqualToString:[self.addressTextField.text trim]]) {
            [self showPromptHUDWithTitle:@"密码不一致,请重新输入"];
            return;
        }else if(self.addressTextField.text.length < 6 || self.addressTextField.text.length > 16){
            [self showPromptHUDWithTitle:@"请输入6-16位字母、数字组合"];
            return ;
        }
        else if (self.addressTextField.text.length >= 6) {
            NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            BOOL result = [pred evaluateWithObject:self.addressTextField.text];
            if (!result) {
                [self showPromptHUDWithTitle:@"请输入6-16位字母、数字组合"];
                return ;
            }
        }
        self.viewModel.password=[AppUtil md5:self.addressTextField.text];
        self.viewModel.renewPwd=[AppUtil md5:self.remarkTextFiled.text];
        [self showLoadingMBProgressHUD];
        [self.viewModel modifyPasswordWithParameters];

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
