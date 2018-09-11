//
//  PhonePwdViewController.m
//  BTCoin
//
//  Created by LionIT on 14/03/2018.
//  Copyright © 2018 LionIT. All rights reserved.
//

#import "PhonePwdViewController.h"
#import "UIButton+Extension.h"
#import "MQVerCodeInputView.h"
#import "RegisterTextField.h"
#import "QCheckBox.h"
#import "NSString+Custom.h"
#import "UserService.h"
#import "NSString+Helper.h"
#import "SZUserProtocolViewController.h"
@interface PhonePwdViewController ()<QCheckBoxDelegate,UITextFieldDelegate> {
    NSTimer *_timer;
    int nSecond;
}

//密码
@property (nonatomic,strong) RegisterTextField *txtPwd;
//密码确认
@property (nonatomic,strong) RegisterTextField *txtConfirmPwd;
//同意
@property (nonatomic,strong) QCheckBox * checkAgree;
//重发验证码
@property (nonatomic,strong) UIButton * btnCode;
//注册
@property (nonatomic,strong) UIButton * signUpBtn;
//
@property (nonatomic,copy) NSString * validateCode;

@end

@implementation PhonePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headView.backgroundColor = COLOR_Bg_White;
    self.view.backgroundColor = [UIColor whiteColor];

    float itemBarWidth = 44.0;
    UIButton * loginBtn = [UIButton initWithFrame:Rect(kScreenWidth-itemBarWidth-10.0, StatusBarHeight+(NaviBarHeight-itemBarWidth)/2, itemBarWidth, itemBarWidth) title:NSLocalizedString(@"登录", nil)];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:color_333333];
    [self setRightBtn:loginBtn];
    
    
    [self initUIHead];
}

- (void)initUIHead {
    UILabel * loginLabel = [[UILabel alloc] init];
    [loginLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [loginLabel setTextColor:color_333333];
    loginLabel.text = self.regType == 0 ? NSLocalizedString(@"手机注册", nil) : NSLocalizedString(@"邮箱注册", nil);
    [loginLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(20.0);
        make.top.equalTo(self.headView.mas_bottom).offset(30);
    }];
    
    UILabel * codeLabel = [[UILabel alloc] init];
    [codeLabel setFont:[UIFont systemFontOfSize:17]];
    [codeLabel setTextColor:color_333333];
    codeLabel.text = NSLocalizedString(@"验证码", nil);
    [codeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(loginLabel);
        make.top.equalTo(loginLabel.mas_bottom).offset(40);
    }];
    
    float height = 130;
    if (iPhone6_Plus) {
        height = 130;
    } else if (iPhoneX) {
        
    } else if (iPhone5) {
        height = 80;
    }
    
    @WeakObj(self)
    CGFloat l_w = [loginLabel.text widthWithFont:loginLabel.font];
    CGFloat l_h = [loginLabel.text heightWithFont:loginLabel.font inWidth:l_w];
    CGFloat c_w = [codeLabel.text widthWithFont:codeLabel.font];
    CGFloat c_h = [codeLabel.text heightWithFont:codeLabel.font inWidth:c_w];
    CGFloat ver_y = CGRectGetMaxY(self.headView.frame)+30+l_h+30+c_h+15;
    MQVerCodeInputView *verView = [[MQVerCodeInputView alloc] initWithFrame:CGRectMake(0, ver_y, ScreenWidth -40, 50)];
    verView.maxLenght = 6;//最大长度
    verView.keyBoardType = UIKeyboardTypeNumberPad;
    [verView mq_verCodeViewWithMaxLenght];
    verView.block = ^(NSString *text) {
        selfWeak.validateCode = text;
        [selfWeak checkLogBtnIsEnable];
    };
    verView.center = CGPointMake(self.view.center.x, verView.center.y);
    [self.view addSubview:verView];
    [verView beginEdit];
    
    UIColor *color = UIColorFromRGB(0xB2B2B2);
    _txtPwd = [[RegisterTextField alloc] initWithFrame:CGRectZero];
    _txtPwd.delegate = self;
    [_txtPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_txtPwd setBorderStyle:UITextBorderStyleNone];
    [_txtPwd setReturnKeyType:UIReturnKeyDone];
    _txtPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _txtPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _txtPwd.leftViewMode = UITextFieldViewModeAlways;
    [_txtPwd setBackgroundColor:[UIColor clearColor]];
    [_txtPwd setTextColor:UIColorFromRGB(0x343434)];
    _txtPwd.isShowTextBool = YES;
    _txtPwd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"密码",nil) attributes:@{NSForegroundColorAttributeName:color}];
    _txtPwd.tag = 2;
    [_txtPwd setSecureTextEntry:YES];
    [_txtPwd setFont:XCFONT(15)];
    [_txtPwd setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.view addSubview:_txtPwd];
    [_txtPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verView.mas_bottom).offset(30);
        make.leading.equalTo(loginLabel);
        make.trailing.equalTo(self.view).offset(-20.0);
        make.height.mas_equalTo(40);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = color_f2f2f2;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(_txtPwd);
        make.top.equalTo(_txtPwd.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    _txtConfirmPwd = [[RegisterTextField alloc] initWithFrame:CGRectZero];
    _txtConfirmPwd.delegate = self;
    [_txtConfirmPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_txtConfirmPwd setBorderStyle:UITextBorderStyleNone];
    [_txtConfirmPwd setReturnKeyType:UIReturnKeyDone];
    _txtConfirmPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _txtConfirmPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _txtConfirmPwd.leftViewMode = UITextFieldViewModeAlways;
    [_txtConfirmPwd setBackgroundColor:[UIColor clearColor]];
    [_txtConfirmPwd setTextColor:UIColorFromRGB(0x343434)];
    _txtConfirmPwd.isShowTextBool = YES;
    _txtConfirmPwd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"确认密码",nil) attributes:@{NSForegroundColorAttributeName:color}];
    _txtConfirmPwd.tag = 2;
    [_txtConfirmPwd setSecureTextEntry:YES];
    [_txtConfirmPwd setFont:XCFONT(15)];
    [_txtConfirmPwd setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.view addSubview:_txtConfirmPwd];
    [_txtConfirmPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(_txtPwd);
        make.height.mas_equalTo(40);
    }];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = color_f2f2f2;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(_txtConfirmPwd);
        make.top.equalTo(_txtConfirmPwd.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    // 重发验证码
    _btnCode = [UIButton initWithVerificationCodeFrame:Rect(20,lineView.y+20, 95, 36)];
    _btnCode.layer.borderWidth = 0;
    //_btnCode.layer.borderColor = color_ffbd5b.CGColor;
    
    [_btnCode addTarget:self action:@selector(getAuthCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCode];
    [_btnCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.leading.equalTo(lineView);
    }];
    
    _checkAgree = [[QCheckBox alloc] initWithDelegate:self];
    [_checkAgree setTitle:NSLocalizedString(@"我同意",nil) forState:UIControlStateNormal];
    [_checkAgree setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    _checkAgree.titleLabel.font = XCFONT(14);
    [self.view addSubview:_checkAgree];
    [_checkAgree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_btnCode);
        make.top.equalTo(_btnCode.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    UIButton * agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreementBtn.backgroundColor = [UIColor clearColor];
    [agreementBtn setTitle:NSLocalizedString(@"使用协议", nil) forState:UIControlStateNormal];
    [agreementBtn setTitleColor:color_d2d2d2];
    agreementBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [agreementBtn addTarget:self action:@selector(showDetailAgreementAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreementBtn];
    [agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_checkAgree.mas_trailing).offset(5);
        make.centerY.equalTo(_checkAgree);
    }];
    
    _signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _signUpBtn.backgroundColor = color_d2d2d2;
    [_signUpBtn setTitle:NSLocalizedString(@"注册", nil) forState:UIControlStateNormal];
    [_signUpBtn setTitleColor:COLOR_Bg_White];
    _signUpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_signUpBtn addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    _signUpBtn.enabled = NO;
    [self.view addSubview:_signUpBtn];
    [_signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(verView);
        make.top.equalTo(_checkAgree.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
    }];
 

}


#pragma mark 注册
- (void)signUpAction:(UIButton *)sender {
    
    if (self.txtPwd.text.length <=0 || self.txtConfirmPwd.text <=0) {
        [self showPromptHUDWithTitle:@"请输入6-16位字母、数字组合"];
        return;
    }else if (![[self.txtPwd.text trim] isEqualToString:[self.txtConfirmPwd.text trim]]) {
        [self showPromptHUDWithTitle:@"密码不一致,请重新输入"];
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
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSString * md5Pwd = [AppUtil md5:[self.txtPwd.text trim]];
    [mDict setValue:md5Pwd forKey:@"password"];
    [mDict setValue:self.phoneNum forKey:@"regName"];
    [mDict setValue:@(self.regType) forKey:@"regType"];
    if (self.regType == 0) {
        
    } else {
        
    }
    [mDict setValue:self.validateCode forKey:@"phoneCode"];
    [mDict setValue:self.validateCode forKey:@"ecode"];
    [mDict setValue:self.areaCode forKey:@"areaCode"];
    
    [[UserService sharedUserService] registerAccount:mDict success:^(id responseObject) {
        [self hideMBProgressHUD];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
            
            if (SuccessCode == baseModel.code) {
                [self showErrorHUDWithTitle:baseModel.msg];
                [[SZSundriesCenter instance] delayExecutionInMainThread:^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            } else {
                [self showErrorHUDWithTitle:baseModel.msg];
            }
        }
    } fail:^(NSError *error) {
        [self showErrorHUDWithTitle:error.localizedDescription];
    }];
}

#pragma mark 显示协议
- (void)showDetailAgreementAction:(UIButton *)sender {
    
    SZUserProtocolViewController* userProtocolVC=[SZUserProtocolViewController new];
    [self.navigationController pushViewController:userProtocolVC animated:YES];
    
}

#pragma mark 重发验证码
- (void)getAuthCode:(UIButton *)sender {
    if (self.phoneNum.length == 0) {
        NSString *prompt = self.regType == 0 ? @"手机号码" : @"邮箱";
        [self showErrorHUDWithTitle:prompt];
        return;
    }
    [self showLoadingMBProgressHUD];
    
    if (self.regType == 0) { //发送手机验证码
        
        NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithCapacity:3];
        [mDict setValue:self.phoneNum forKey:@"phone"];
        [mDict setValue:@(12) forKey:@"type"];
        [mDict setValue:self.areaCode forKey:@"areaCode"];
        
        [[UserService sharedUserService] getValidateCode:mDict success:^(id responseObject) {
            [self hideMBProgressHUD];
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
                
                if (SuccessCode == baseModel.code) {
                    [self showErrorHUDWithTitle:baseModel.msg];
                } else {
                    [self showErrorHUDWithTitle:baseModel.msg];
                }
            }
        } fail:^(NSError *error) {
            [self showErrorHUDWithTitle:error.localizedDescription];
        }];
    
    } else { //发送邮箱验证码
        
        [[UserService sharedUserService] getEmailValidateCode:self.phoneNum success:^(id responseObject) {
            [self hideMBProgressHUD];
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
                if (SuccessCode == baseModel.code) {
                    [self showErrorHUDWithTitle:baseModel.msg];
                } else {
                    [self showErrorHUDWithTitle:baseModel.msg];
                }
            }
        } fail:^(NSError *error) {
            [self showErrorHUDWithTitle:error.localizedDescription];
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender
{
    [self checkLogBtnIsEnable];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self checkLogBtnIsEnable];
    
    return YES;
}

#pragma mark - QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    checkbox.checked = checked;
    [self checkLogBtnIsEnable];
}

#pragma mark - 检查输入情况以设置注册的可用性
- (void)checkLogBtnIsEnable {
    if (6 == self.validateCode.length && [self.txtPwd.text trim].length > 0 && [self.txtConfirmPwd.text trim].length > 0 && self.checkAgree.checked) {
        self.signUpBtn.enabled = YES;
        [self.signUpBtn setGradientBackGround];
    } else {
        self.signUpBtn.enabled = NO;
        self.signUpBtn.backgroundColor = color_d2d2d2;
        [self.signUpBtn removeGradientBackGround];
    }
}

- (void)startTimer{
    nSecond = 59;
    if (_timer)
    {
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

- (void)animation1{
    if (nSecond==0){
        _btnCode.enabled  = YES;
        [_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timer invalidate];
        return ;
    }
    NSString *strInfo = [NSString stringWithFormat:@"重新发送(%d)",nSecond];
    [_btnCode setTitle:strInfo forState:UIControlStateNormal];
    nSecond--;
}


#pragma mark - 切换到登录
- (void)loginAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end
