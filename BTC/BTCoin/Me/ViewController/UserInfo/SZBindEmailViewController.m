//
//  SZBindEmailViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBindEmailViewController.h"
#import "SZBindEmailViewModel.h"
#import "SZSecurityCodeViewModel.h"
@interface SZBindEmailViewController ()
@property (nonatomic,strong) UIButton* confirmButton;
@property (nonatomic,strong) UIButton* saoButton;

@property (nonatomic,strong) SZBindEmailViewModel* viewModel;
@property (nonatomic,strong) SZSecurityCodeViewModel* securityCodeViewModel;

@property (nonatomic,strong) UITextField* addressTextField;
@property (nonatomic,strong) UITextField* remarkTextFiled;
@end

@implementation SZBindEmailViewController


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
- (SZBindEmailViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel=[SZBindEmailViewModel new];
    }

    return _viewModel;
}
-(SZSecurityCodeViewModel *)securityCodeViewModel{
    if (!_securityCodeViewModel) {
        _securityCodeViewModel=[SZSecurityCodeViewModel new];
    }
    
    return _securityCodeViewModel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setSubviews{
    
    [self setTitleText:NSLocalizedString(@"绑定邮箱", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    
    UILabel* addressLabel=[UILabel new];
    [addressLabel setText:NSLocalizedString(@"邮箱地址", nil)];
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
    
    
    UITextField* addressTextField=[UITextField new];
    addressTextField.placeholder=NSLocalizedString(@"请输入邮箱地址", nil);
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
    [remarkLabel setText:NSLocalizedString(@"邮箱验证码", nil)];
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
    
    
    UITextField* remarkTextField=[UITextField new];
    remarkTextField.placeholder=NSLocalizedString(@"请输入邮箱验证码", nil);
    remarkTextField.textColor=[UIColor blackColor];
    remarkTextField.font=[UIFont systemFontOfSize:14.0f];
    [remarkView addSubview:remarkTextField];
    self.remarkTextFiled=remarkTextField;
    [remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkLabel.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth-FIT3(48));
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    
    UIButton* saoButton=[UIButton new];
    self.saoButton=saoButton;
    [self.saoButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.saoButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.saoButton setTitle:NSLocalizedString(@"发送", nil) forState:UIControlStateNormal];
    [self.saoButton setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [remarkView addSubview:saoButton];
    [self.saoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(remarkView.mas_right);
        make.top.equalTo(remarkTextField.mas_top);
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(200));
        
    }];
    
    
    self.confirmButton=[UIButton new];
    [self.confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.confirmButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.confirmButton setTitle:NSLocalizedString(@"绑定", nil) forState:UIControlStateNormal];
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
        [self.navigationController popViewControllerAnimated:YES];
        [UserInfo sharedUserInfo].isBindEmail=YES;
        [UserInfo sharedUserInfo].email=self.addressTextField.text;
        [[SZSundriesCenter instance]delayExecutionInMainThread:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];
    
    
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        
        if (isEmptyString(self.addressTextField.text)) {
            [self showPromptHUDWithTitle:@"请输入邮箱地址"];
        }else if (isEmptyString(self.remarkTextFiled.text)){
            [self showPromptHUDWithTitle:@"请输入邮箱验证码"];
        }else{
            NSDictionary* parameters=@{@"email":self.addressTextField.text,@"ecode":self.remarkTextFiled.text};
            [self showLoadingMBProgressHUD];
            [self.viewModel bindEmailWithParameters:parameters];
        }
        
    }];

    
    __block NSInteger seconds=0;
    __block RACSignal* timerSignal;
    [self.viewModel.otherSignal subscribeNext:^(id x) {
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
            
            NSString* email=[self.addressTextField.text trim];
            if (![email isEmail]) {
                [self showPromptHUDWithTitle:@"请输入合法的邮箱账号"];
            }else{
                
                [self showLoadingMBProgressHUD];
                [self.viewModel getEmailCodeWithParameters:email];
            }
        }
      
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
