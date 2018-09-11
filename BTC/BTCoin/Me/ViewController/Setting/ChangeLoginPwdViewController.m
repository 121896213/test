//
//  ChangeLoginPwdViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/4/23.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "ChangeLoginPwdViewController.h"
#import "RegisterTextField.h"
#import "LoginTextField.h"
#import "UIButton+Extension.h"
#import "JMeNetHelper.h"

@interface ChangeLoginPwdViewController ()<UITextFieldDelegate>

//标题
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) RegisterTextField *originallyTxtPwd;
@property (nonatomic,strong) RegisterTextField *txtPwd;
@property (nonatomic,strong) RegisterTextField *txtPwdAgain;
//验证码输入框
@property (nonatomic,strong) LoginTextField * codeField;
//请求验证码按钮
@property (nonatomic,strong) UIButton *getCodeBtn;
//登录按钮
@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic,strong) SZSecurityCodeViewModel* securityCodeViewModel;
@end

@implementation ChangeLoginPwdViewController

- (SZSecurityCodeViewModel *)securityCodeViewModel{
    if (!_securityCodeViewModel) {
        _securityCodeViewModel=[SZSecurityCodeViewModel new];
        if (_pwdType == kPwdChangeBargaining || _pwdType == kPwdSetBargaining) {
            _securityCodeViewModel.securityCodeType=SZSecurityCodeViewTypeModifyTradePassword;
        }else if (_pwdType == kPwdChangeLogin){
            _securityCodeViewModel.securityCodeType=SZSecurityCodeViewTypeModifyLoginPassword;
        }
    }
    return _securityCodeViewModel;
    
    
}
#pragma mark - Override
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MainBackgroundColor;
    NSString *strTitle = nil;
    switch (self.pwdType) {
        case kPwdChangeLogin: {
            strTitle = NSLocalizedString(@"修改登录密码", nil);
            [self.codeField setHidden:YES];
            [self.getCodeBtn setHidden:YES];
            [self configUIForChangePwd];
            self.txtPwd.placeholder=NSLocalizedString(@"请输入6-16位字母、数字组合密码",nil);
            self.txtPwdAgain.placeholder=NSLocalizedString(@"请输入6-16位字母、数字组合密码",nil);
            break;
        }
        case kPwdSetBargaining: {
            strTitle = NSLocalizedString(@"设置交易密码", nil);
            self.txtPwd.placeholder=NSLocalizedString(@"请输入6-16位字母、数字组合密码",nil);
            self.txtPwdAgain.placeholder=NSLocalizedString(@"请输入6-16位字母、数字组合密码",nil);
            [self configUIForSetPwd];
            break;
        }
        case kPwdChangeBargaining: {
            strTitle = NSLocalizedString(@"修改交易密码", nil);
            self.txtPwd.placeholder=NSLocalizedString(@"请输入6-16位字母、数字组合密码",nil);
            self.txtPwdAgain.placeholder=NSLocalizedString(@"请输入6-16位字母、数字组合密码",nil);
            [self configUIForChangePwd];
            break;
        }
        default:
            break;
    }
    [self setTitleText:strTitle];
}

//设置/修改相同UI界面
- (CGFloat)configUICommon {
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(10);
    }];
    
    [self.view addSubview:self.txtPwd];
    [self.view addSubview:self.txtPwdAgain];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.loginBtn];

    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.codeField).offset(-2);
        make.right.mas_equalTo(FIT(-16));
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(FIT3(146));
    }];
    [self.getCodeBtn setEnlargeEdgeWithTop:0 right:FIT(16) bottom:0 left:FIT(0)];
    return 10.0;//密码框上下间距
}
- (void)configUICommonEnd:(CGFloat)v_spacing {
    
    UILabel* newPwdLabel=[UILabel new];
    [newPwdLabel setText:NSLocalizedString(@"确认密码", nil)];
    [newPwdLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [newPwdLabel setTextColor:[UIColor blackColor]];
    newPwdLabel.backgroundColor=MainBackgroundColor;
    [self.view addSubview:newPwdLabel];
    [newPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtPwd.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    [self.txtPwdAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newPwdLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, FIT3(146)));
        make.centerX.equalTo(self.view);
    }];
    
    UILabel* codeLabel=[UILabel new];
    [codeLabel setText:NSLocalizedString(@"验证码", nil)];
    [codeLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [codeLabel setTextColor:[UIColor blackColor]];
    codeLabel.backgroundColor=MainBackgroundColor;
    [self.view addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtPwdAgain.mas_bottom);;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    if (self.codeField.hidden) {
        codeLabel.hidden=YES;
    }
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, FIT3(146)));
        make.centerX.equalTo(self.view);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(FIT3(-170));
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-30, FIT3(150)));
        make.centerX.equalTo(self.view);
    }];
    [self.loginBtn setGradientBackGround];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:color_ffdead] forState:UIControlStateDisabled];
    
}

//配置设置密码的UI界面
- (void)configUIForSetPwd {
    CGFloat v_spacing = [self configUICommon];
    
    UILabel* originallyPwdLabel=[UILabel new];
    [originallyPwdLabel setText:NSLocalizedString(@"新密码", nil)];
    [originallyPwdLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [originallyPwdLabel setTextColor:[UIColor blackColor]];
    originallyPwdLabel.backgroundColor=MainBackgroundColor;
    [self.view addSubview:originallyPwdLabel];
    [originallyPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    [self.txtPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(originallyPwdLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, FIT3(146)));
        make.centerX.equalTo(self.view);
    }];
    
    [self configUICommonEnd:v_spacing];
}

//配置修改密码的UI界面
- (void)configUIForChangePwd {
    CGFloat v_spacing = [self configUICommon];

    UILabel* originallyPwdLabel=[UILabel new];
    [originallyPwdLabel setText:NSLocalizedString(@"原始密码", nil)];
    [originallyPwdLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [originallyPwdLabel setTextColor:[UIColor blackColor]];
    originallyPwdLabel.backgroundColor=MainBackgroundColor;
    [self.view addSubview:originallyPwdLabel];
    [originallyPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    [self.view addSubview:self.originallyTxtPwd];

    [self.originallyTxtPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(originallyPwdLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, FIT3(146)));
        make.centerX.equalTo(self.view);
    }];
    
    UILabel* newPwdLabel=[UILabel new];
    [newPwdLabel setText:NSLocalizedString(@"新密码", nil)];
    [newPwdLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [newPwdLabel setTextColor:[UIColor blackColor]];
    newPwdLabel.backgroundColor=MainBackgroundColor;
    [self.view addSubview:newPwdLabel];
    [newPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.originallyTxtPwd.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    [self.txtPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newPwdLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, FIT3(146)));
        make.centerX.equalTo(self.view);
    }];
    
    [self configUICommonEnd:v_spacing];
}

#pragma mark - 获取验证码、提交
- (void)getAuthCode {
   
}
- (void)submitChange {
    
    
    
    if (self.pwdType == kPwdSetBargaining ||self.pwdType == kPwdChangeBargaining) {
        
        if (self.pwdType == kPwdChangeBargaining && [self.originallyTxtPwd.text length] == 0) {
            [self showErrorHUDWithTitle:@"请输入原始交易密码"];
            return;
        }else if ([self.txtPwd.text length] == 0) {
            [self showErrorHUDWithTitle:@"请输入交易密码"];
            return;
        }else if ([self.txtPwdAgain.text length] == 0) {
            [self showErrorHUDWithTitle:@"请再次输入交易密码"];
            return;
        }else if ([self.codeField.text length] == 0) {
            [self showErrorHUDWithTitle:@"请输入验证码"];
            return;
        }else if (![[self.txtPwd.text trim] isEqualToString:[self.txtPwdAgain.text trim]]) {
            [self showErrorHUDWithTitle:@"密码不一致,请重新输入"];
            return;
        }else if([self.txtPwd.text trim].length > 16  || [self.txtPwd.text trim].length < 6){
            [self showPromptHUDWithTitle:@"请输入6-16位字母、数字组合"];
            return;
        }else if ([self.txtPwd.text trim].length >= 6) {
            NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            BOOL result = [pred evaluateWithObject:self.txtPwd.text];
            if (!result) {
                [self showPromptHUDWithTitle:@"请输入6-16位字母、数字组合"];
                return ;
            }
        }
        NSString* originPwd=[self.originallyTxtPwd.text length]?self.originallyTxtPwd.text:@"";
        NSString* newPwd=[AppUtil md5:self.txtPwd.text];
        if ([originPwd length]) {
            originPwd=[AppUtil md5:self.originallyTxtPwd.text];
        }
        NSString* reNewPwd=[AppUtil md5:self.txtPwdAgain.text];
        [self showLoadingMBProgressHUD];
        [[[SZHttpsService sharedSZHttpsService] signalModifyPasswordWithNewPwd:newPwd originPwd:originPwd phoneCode:self.codeField.text pwdType:@"1" reNewPwd:reNewPwd totpCode:@""]subscribeNext:^(id responseDictionary) {
            
            if ([responseDictionary[@"code"] integerValue] == 0) {
                NSString* msg=responseDictionary[@"msg"];
                [(RACSubject*)self.securityCodeViewModel.successSignal sendNext:msg];
            }else{
                NSString* msg=responseDictionary[@"msg"];
                [(RACSubject*)self.securityCodeViewModel.failureSignal sendNext:msg];
            }
            
        }error:^(NSError *error) {
            [(RACSubject*)self.securityCodeViewModel.failureSignal sendNext:error.localizedDescription];

        }];
        
        
        
    } else {
       
        if ([self.originallyTxtPwd.text length] == 0) {
            [self showErrorHUDWithTitle:@"请输入原始登录密码"];
            return;
        }else if ([self.txtPwd.text length] == 0) {
            [self showErrorHUDWithTitle:@"请输入登录密码"];
            return;
        }else if ([self.txtPwdAgain.text length] == 0) {
            [self showErrorHUDWithTitle:@"请再次输入登录密码"];
            return;
        }
//        else if ([self.codeField.text length] == 0) {
//            [self showErrorHUDWithTitle:@"请输入验证码"];
//            return;
//        }
        else if (![[self.txtPwd.text trim] isEqualToString:[self.txtPwdAgain.text trim]]) {
            [self showErrorHUDWithTitle:@"密码不一致,请重新输入"];
            return;
        }else if(self.txtPwd.text.length < 6 || self.txtPwd.text.length > 16){
            [self showPromptHUDWithTitle:@"请输入6-16位字母、数字组合"];
            return ;
        }
        else if (self.txtPwd.text.length >= 6) {
            NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            BOOL result = [pred evaluateWithObject:self.txtPwd.text];
            if (!result) {
                [self showPromptHUDWithTitle:@"请输入6-16位字母、数字组合"];
                return ;
            }
        }
        [self showLoadingMBProgressHUD];
        NSString* newPwd=[AppUtil md5:self.txtPwd.text];
        NSString* originPwd=[AppUtil md5:self.originallyTxtPwd.text];
        NSString* reNewPwd=[AppUtil md5:self.txtPwdAgain.text];

        @weakify(self);
        [[[SZHttpsService sharedSZHttpsService] signalModifyPasswordWithNewPwd:newPwd originPwd:originPwd phoneCode:@"" pwdType:@"0" reNewPwd:reNewPwd totpCode:@""]subscribeNext:^(id responseDictionary) {
            @strongify(self);
            if ([responseDictionary[@"code"] integerValue] == 0) {
                NSString* msg=responseDictionary[@"msg"];
                [self showErrorHUDWithTitle:msg];
                [[SZSundriesCenter instance] delayExecutionInMainThread:^{
                    SZHTTPSReqManager.presentLoginVC(responseDictionary);
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
           

            }else{
                NSString* msg=responseDictionary[@"msg"];
                [(RACSubject*)self.securityCodeViewModel.failureSignal sendNext:msg];
            }
            
        }error:^(NSError *error) {
            [(RACSubject*)self.securityCodeViewModel.failureSignal sendNext:error.localizedDescription];

        }];
    }
}
#pragma mark - 公共Methods
#pragma mark 字体设置
- (UIFont *)fontOfTextField {
    return [UIFont systemFontOfSize:14];
}
- (UIFont *)fontOfAuthCodeButton {
    return [UIFont systemFontOfSize:15];
}
- (UIFont *)fontOfSubmitButton {
    return [UIFont systemFontOfSize:16];
}

#pragma mark - Getters
- (UIView *)titleView {
    if (!_titleView) {
        UIView *vt = [[UIView alloc] init];
        vt.backgroundColor = [UIColor clearColor];
        self.titleView = vt;
    }
    return _titleView;
}
- (RegisterTextField *)originallyTxtPwd {
    if (!_originallyTxtPwd) {
        RegisterTextField *tf = [[RegisterTextField alloc] init];
        tf.placeholder = NSLocalizedString(@"请输入原始密码", nil);
        tf.font = [self fontOfTextField];
//        [tf addBottomBorderWithColor:UIColorFromRGB(0xc9c9c9) andWidth:0.5];
        tf.isShowTextBool = YES;
        self.originallyTxtPwd = tf;
    }
    return _originallyTxtPwd;
}
- (RegisterTextField *)txtPwd {
    if (!_txtPwd) {
        RegisterTextField *tf = [[RegisterTextField alloc] init];
        tf.placeholder = NSLocalizedString(@"请输入密码", nil);
        tf.font = [self fontOfTextField];
//        [tf addBottomBorderWithColor:UIColorFromRGB(0xc9c9c9) andWidth:0.5];
        tf.isShowTextBool = YES;
        self.txtPwd = tf;
    }
    return _txtPwd;
}
- (RegisterTextField *)txtPwdAgain {
    if (!_txtPwdAgain) {
        RegisterTextField *tf = [[RegisterTextField alloc] init];
        tf.isShowTextBool = YES;
        tf.placeholder = NSLocalizedString(@"确认密码", nil);
        tf.font = [self fontOfTextField];
//        [tf addBottomBorderWithColor:UIColorFromRGB(0xc9c9c9) andWidth:0.5];
        
        self.txtPwdAgain = tf;
    }
    return _txtPwdAgain;
}
- (LoginTextField *)codeField {
    if (!_codeField) {
        LoginTextField *tf = [[LoginTextField alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(self.txtPwdAgain.frame)+5, kScreenWidth-30, 44)];
        tf.clearButtonMode = UITextFieldViewModeNever;
        tf.placeholder = NSLocalizedString(@"请输入验证码", nil);
        tf.font = [self fontOfTextField];
//        [tf addBottomBorderWithColor:UIColorFromRGB(0xc9c9c9) andWidth:0.5];
        
        self.codeField = tf;
    }
    return _codeField;
}
- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        UIButton *btn = [[UIButton alloc]initWithFrame:Rect(kScreenWidth - 105,CGRectGetMinY(self.codeField.frame)+20, 95, 32)];
        [btn setTitle: NSLocalizedString(@"发送", nil)  forState:UIControlStateNormal];
        btn.layer.borderColor = color_ffbd5b.CGColor;
        btn.titleLabel.font = [self fontOfAuthCodeButton];
        btn.titleLabel.textAlignment=NSTextAlignmentRight;
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [btn setTitleColor:MainThemeColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x00b500) forState:UIControlStateSelected];
        [self.view addSubview:btn];
        self.getCodeBtn = btn;
        
        @weakify(self);
        [[self.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            NSString* sendTitle=self.getCodeBtn.titleLabel.text;
            [self resignFirstResponder];
            if ([sendTitle isEqualToString:NSLocalizedString(@"发送", nil)]) {
                
                if ([[UserInfo sharedUserInfo] isBindTelephone]) {
                    [self showLoadingMBProgressHUD];
                    self.securityCodeViewModel.mobile=[UserInfo sharedUserInfo].telNumber;
                    [self.securityCodeViewModel getWithdrawSecurityCodeWithParameters:nil];
                }else{
                    [self showPromptHUDWithTitle:@"请先绑定手机"];
                }
                
            }
        }];
        
        [self.securityCodeViewModel.successSignal subscribeNext:^(id x) {
            @strongify(self);
            [self showErrorHUDWithTitle:x];
            [[SZSundriesCenter instance] delayExecutionInMainThread:^{
                [self.navigationController popViewControllerAnimated:YES];

            }];
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
                [self.getCodeBtn setTitle:FormatString(@"%lds",(long)seconds) forState:UIControlStateNormal];
                
                if (!timerSignal) {
                    timerSignal= [[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal ];
                    [timerSignal subscribeNext:^(id x) {
                        @strongify(self);
                        seconds--;
                        if (seconds <= 0) {
                            [self.getCodeBtn setTitle:NSLocalizedString(@"发送", nil) forState:UIControlStateNormal];
                        }else{
                            [self.getCodeBtn setTitle:FormatString(@"%lds",(long)seconds) forState:UIControlStateNormal];
                        }
                    }];
                }else{
                    [timerSignal startWith:@0];
                }
             
            }
        }];
    }
    return _getCodeBtn;
}
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:NSLocalizedString(@"修改", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
        btn.titleLabel.font = [self fontOfSubmitButton];
        [ShareFunction setCircleBorder:btn];
        [btn addTarget:self action:@selector(submitChange) forControlEvents:UIControlEventTouchUpInside];
        self.loginBtn = btn;
    }
    return _loginBtn;
}

@end
