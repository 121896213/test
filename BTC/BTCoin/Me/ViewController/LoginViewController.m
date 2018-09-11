//

//  LoginViewController.m
//  99SVR
//
//  Created by xia zhonglin  on 12/7/15.
//  Copyright © 2015 xia zhonglin . All rights reserved.
//

#import "LoginViewController.h"
#import "PopupViewHUD.h"
#import "NSString+Custom.h"
#import "UIButton+Extension.h"
#import "UserInfo.h"
#import "BaseService.h"
#import "QCheckBox.h"
#import "Toast+UIView.h"
#import "LoginTextField.h"
#import "PhoneRegisterViewController.h"
#import "SZForgetPwdViewController.h"
#import "RegisterTextField.h"
#import "UIImage+Extension.h"
#import "UserService.h"
#import "StatusBarHUD.h"
#import "NSString+Regex.h"
#import "UIButton+Extension.h"
#import "SZUserDefaultCenter.h"
#import "SZModifyPwdViewController.h"
#import "SZPersonCenterViewModel.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    UIView  *headView;
    BOOL _bLogin;
    UIView *hidenView;
    NSTimer *_timer;
    int nSecond;
}

@property (nonatomic,copy) NSString *strToken;
@property (nonatomic,copy) NSString *strOpenId;
@property (nonatomic,copy) NSString *strNickName;
@property (nonatomic,strong) UIButton *btnLogin;
@property (nonatomic,strong) UIImageView *imgBg;
@property (nonatomic,strong) LoginTextField *txtUser;
@property (nonatomic,strong) RegisterTextField *txtPwd;
//@property (nonatomic,strong) LoginTextField * codeField;
@property (nonatomic,strong) QCheckBox *check;
@property (nonatomic,strong) QCheckBox *autoLogin;
@property (nonatomic,strong) UIButton *btnFind;
//@property (nonatomic, strong) UIButton *btnCode;
@property (nonatomic,strong) SZPersonCenterViewModel *personCenterViewModel;

@end

@implementation LoginViewController


- (SZPersonCenterViewModel *)personCenterViewModel{
    
    if (!_personCenterViewModel) {
        _personCenterViewModel=[SZPersonCenterViewModel new];
        
        @weakify(self);
        [_personCenterViewModel.successSignal subscribeNext:^(id x) {
            [self hideMBProgressHUD];
            [[NSNotificationCenter defaultCenter] postNotificationName:LISTENTOAPPLOGINNOTIFICATION object:nil userInfo:@{@"isLogin":[NSNumber numberWithBool:YES]}];
            if (self.boolBlock) {
                self.boolBlock(YES);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [_personCenterViewModel.otherSignal subscribeNext:^(id x) {
//            [self hideMBProgressHUD];
//            [[NSNotificationCenter defaultCenter] postNotificationName:LISTENTOAPPLOGINNOTIFICATION object:nil userInfo:@{@"isLogin":[NSNumber numberWithBool:YES]}];
//            if (self.boolBlock) {
//                self.boolBlock(YES);
//            }
//            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [_personCenterViewModel.failureSignal subscribeNext:^(id x) {
            @strongify(self);
            [self showErrorHUDWithTitle:x];

        }];
        
    }
    return _personCenterViewModel;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton * cancelBtn = [UIButton initWithFrame:CGRectZero title:NSLocalizedString(@"取消",nil)];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:color_333333];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(StatusBarHeight + 2);
        make.height.mas_equalTo(40);
        make.width.mas_greaterThanOrEqualTo(40);
    }];
    
    UIButton * registerBtn = [UIButton initWithFrame:CGRectZero title:NSLocalizedString(@"注册",nil)];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitleColor:color_333333];
    [self.view addSubview:registerBtn];
#ifdef Release
    registerBtn.hidden = YES;
#endif
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.top.mas_equalTo(StatusBarHeight + 2);
        make.height.mas_equalTo(40);
        make.width.mas_greaterThanOrEqualTo(40);
    }];

    [self initUIHead];
    
    NSString *userId = [UserDefaults objectForKey:kUserId];
    _txtUser.text = userId == nil ? @"" : userId;
    
    if ([userId isEqualToString:@""] || [userId length]==0) {
        self.btnLogin.enabled = NO;
    }
    if ([_txtUser.text isEqualToString:@"13143468947"]) {
        if ([BaseHttpUrl isEqualToString:@"https://app.btktrade.com/corn-app"]) {
            _txtPwd.text = @"a123456";
        }else{
            _txtPwd.text = @"a123456";
        }
    }else if ([_txtUser.text isEqualToString:@"15710752900"]){
        _txtPwd.text = @"gongxiang0"; // 交易密码 g111111
    }
#ifdef Debug
    
#endif
    
//        else if ([_txtUser.text isEqualToString:@"13612983931"]){
//        _txtPwd.text = @"ABC123";
//    }else if ([_txtUser.text isEqualToString:@"17051207206"]){
//        _txtPwd.text = @"bty123456";
//    }else if ([_txtUser.text isEqualToString:@"13612983930"]){
//        _txtPwd.text = @"ABC123";
//    }
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)]];
    
    //测试
//    _txtUser.text = @"17318037763";
//    NSString* loginUser=SZUserDefaultCenterGetValue(SZUserDefalutLoginUser);
//    if(!isEmptyString(loginUser)){
//        NSData *JSONData = [loginUser dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil removingNulls:YES ignoreArrays:NO];
//        UserInfo* userInfo=[UserInfo sharedUserInfo];
//        [userInfo mj_setKeyValues:dictionary];
//        _txtUser.text = userInfo.userName;
//        if ([_txtUser.text isEqualToString:@"13143468947"]) {
//            _txtPwd.text = @"a123456";
//        }
//    }
    self.btnLogin.enabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:)
                                                  name:UIKeyboardWillHideNotification object:nil];
    [self.headView setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.headView setHidden:NO];


}



- (void)initUIHead
{
    CGSize bodySize = bodySize = CGSizeMake(165, 30);
    NSString * bodyImageName = @"login_top_img";
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:Rect(20.0, StatusBarHeight+NaviBarHeight+30, bodySize.width, bodySize.height)];
    logoImageView.image = [UIImage imageNamed:bodyImageName];
    logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:logoImageView];
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:Rect(logoImageView.x, CGRectGetMaxY(logoImageView.frame)+15, 100, 20)];
    [loginLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [loginLabel setTextColor:color_333333];
//    loginLabel.text = @"登录BTK";
    [loginLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:loginLabel];
    
    _txtUser = [[LoginTextField alloc] initWithFrame:CGRectMake(15,loginLabel.y+loginLabel.height+50, kScreenWidth-30, 44)];
    _txtPwd = [[RegisterTextField alloc] initWithFrame:CGRectMake(_txtUser.x, _txtUser.frame.origin.y+_txtUser.frame.size.height+30, _txtUser.width, _txtUser.height)];
//    _txtPwd.moveToTheRight = 0;
//    _codeField = [[LoginTextField alloc] initWithFrame:CGRectMake(_txtUser.x,CGRectGetMaxY(_txtPwd.frame)+30, _txtUser.width, _txtUser.height)];
    
    _txtUser.delegate = self;
    _txtPwd.delegate = self;
//    _codeField.delegate = self;
    
    [_txtUser addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_txtPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    [_codeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_txtUser setBorderStyle:UITextBorderStyleNone];
    [_txtPwd setBorderStyle:UITextBorderStyleNone];
//    [_codeField setBorderStyle:UITextBorderStyleNone];
    _txtUser.autocorrectionType = UITextAutocorrectionTypeNo;
    _txtUser.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _txtUser.returnKeyType = UIReturnKeyDone;
    _txtUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    
//    _codeField.autocorrectionType = UITextAutocorrectionTypeNo;
//    _codeField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    _codeField.returnKeyType = UIReturnKeyDone;
//    _codeField.clearButtonMode = UITextFieldViewModeNever;//不出现清除按钮
    
    CGFloat imageWidth = 16;
    UIImageView *imgUser = [[UIImageView alloc] init];
    imgUser.frame = Rect(0, 0, imageWidth, imageWidth);
    imgUser.image = [UIImage imageNamed:@"login_icon1"];
    imgUser.contentMode = UIViewContentModeScaleAspectFit;
    
    [_txtUser setReturnKeyType:UIReturnKeyNext];
    _txtUser.leftView = imgUser;
//    _txtUser.leftViewMode = UITextFieldViewModeAlways;
    _txtUser.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_txtUser setTextColor:UIColorFromRGB(0x343434)];
    [_txtUser setBackgroundColor:[UIColor clearColor]];
    [_txtPwd setReturnKeyType:UIReturnKeyDone];
    _txtPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIImageView *imgPwd = [[UIImageView alloc] init];
    imgPwd.frame = Rect(0, 0, imageWidth, imageWidth);
    imgPwd.image = [UIImage imageNamed:@"login_icon2"];
    imgPwd.contentMode = UIViewContentModeScaleAspectFit;
    _txtPwd.leftView = imgPwd;
    
    _txtPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    _txtPwd.leftViewMode = UITextFieldViewModeAlways;
    [_txtPwd setBackgroundColor:[UIColor clearColor]];
    [_txtPwd setTextColor:UIColorFromRGB(0x343434)];
    _txtPwd.isShowTextBool = YES;
//    _txtPwd.leftViewImageName = @"register_pwd";
    
    UIColor *color = UIColorFromRGB(0xB2B2B2);
    _txtUser.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"邮箱或者手机号码",nil) attributes:@{NSForegroundColorAttributeName: color}];
//    _codeField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: color}];
    _txtPwd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"密码",nil) attributes:@{NSForegroundColorAttributeName:color}];
    
    _txtUser.tag = 1;
    _txtPwd.tag = 2;
//    _codeField.tag = 3;
    
    [_txtPwd setSecureTextEntry:YES];
    [_txtUser setFont:XCFONT(15)];
//    [_codeField setFont:XCFONT(15)];
    [_txtPwd setFont:XCFONT(15)];
    
    [_txtUser setKeyboardType:UIKeyboardTypeASCIICapable];
    [_txtPwd setKeyboardType:UIKeyboardTypeASCIICapable];
//    [_codeField setKeyboardType:UIKeyboardTypeNumberPad];
    
    _check = [[QCheckBox alloc] initWithDelegate:self];
    _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnFind = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _btnLogin.layer.masksToBounds = YES;
    _btnLogin.layer.cornerRadius = 3;
    
    [_btnFind setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_btnFind setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [_btnFind setTitle:NSLocalizedString(@"忘记密码?",nil) forState:UIControlStateNormal];
    CGSize findSize = [@"忘记密码?" sizeWithAttributes:@{NSFontAttributeName:XCFONT(15)}];
    [self.view addSubview:_btnFind];
    
    [_btnLogin setTitle:NSLocalizedString(@"登 录",nil) forState:UIControlStateNormal];
    [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_btnLogin setBackgroundImage:[UIImage imageWithColor:color_ffbd5b] forState:UIControlStateNormal];
//
//    [_btnLogin setBackgroundImage:[UIImage imageWithColor:color_ea971c] forState:UIControlStateHighlighted];
//    [_btnLogin setBackgroundImage:[UIImage imageWithColor:color_ffdead] forState:UIControlStateDisabled];
    _btnLogin.titleLabel.font = XCFONT(16);
    
    [_btnLogin addTarget:self action:@selector(loginServer) forControlEvents:UIControlEventTouchUpInside];
    [_btnFind addTarget:self action:@selector(findPwd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_txtUser];
    [self.view addSubview:_txtPwd];
//    [self.view addSubview:_codeField];
    [self.view addSubview:_btnLogin];
    
    // 验证码获取
//    _btnCode = [UIButton initWithVerificationCodeFrame:Rect(kScreenWidth - 105,_codeField.y-3, 95, 36)];
//    [_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
//    _btnCode.layer.borderColor = color_ffbd5b.CGColor;
//    [_btnCode addTarget:self action:@selector(getAuthCode) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_btnCode];
//    [_btnCode mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_codeField);
//        make.trailing.equalTo(_codeField);
//        make.width.mas_equalTo(95);
//        make.height.mas_equalTo(36);
//    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = UIColorFromRGB(0xc9c9c9);
    [self.view addSubview:line1];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = line1.backgroundColor;
    [self.view addSubview:line2];
//    UIView *line3 = [[UIView alloc] init];
//    line3.backgroundColor = line1.backgroundColor;
//    [self.view addSubview:line3];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_txtUser.width, 0.5));
        make.left.equalTo(_txtUser);
        make.bottom.equalTo(_txtUser);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_txtPwd.width, 0.5));
        make.left.equalTo(_txtPwd);
        make.bottom.equalTo(_txtPwd);
    }];
//    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(_codeField.width, 0.5));
//        make.left.equalTo(_codeField);
//        make.bottom.equalTo(_codeField);
//    }];
    
    _btnLogin.frame = Rect(15, CGRectGetMaxY(_txtPwd.frame)+40, kScreenWidth-30, 44);
    _btnFind.titleLabel.font = XCFONT(15);
    [_btnFind setFrame:Rect(20,CGRectGetMaxY(_btnLogin.frame)+10, findSize.width,40)];
    
    hidenView = [[UIView alloc] initWithFrame:Rect(0, kScreenHeight-150, kScreenWidth,150)];
    hidenView.clipsToBounds = YES;
    [self.view addSubview:hidenView];
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bottom"]];
    [hidenView addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(hidenView);
        make.height.mas_equalTo(70);
    }];
    
    [_btnLogin setGradientBackGround];

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(id)sender
{
    [self checkLogBtnIsEnableWithPwd:_txtPwd.text withUser:_txtUser.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==_txtUser){
        [_txtPwd becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    [self checkLogBtnIsEnableWithPwd:_txtPwd.text withUser:_txtUser.text];
    
    return YES;
}

#pragma mark - 键盘弹出/隐藏 notifications
- (void)keyboardWasShown:(NSNotification *) notification
{
    [UIView animateWithDuration:1.0 delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:
     ^{
         if (kScreenHeight <= 480)
         {
             [self.view setFrame:Rect(0, -64, kScreenWidth, kScreenHeight)];
         }
     } completion:nil];
}

- (void)keyboardWasHidden:(NSNotification *) notification
{
    self.view.frame = Rect(0, 0, kScreenWidth, kScreenHeight);
}

#pragma mark - 取消，注册，关闭键盘
- (void)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.boolBlock) {
        self.boolBlock(NO);
    }
}

- (void)registerAction:(UIButton *)sender {
    PhoneRegisterViewController * registerVC = [[PhoneRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)closeKeyBoard
{
    [self.view endEditing:YES];
}

#pragma mark 登录
- (void)loginServer
{
    NSString *strUser = [[_txtUser text] trim];
    NSString *strPwd = [[_txtPwd text] trim];
//    NSString * code = [[_codeField text] trim];
    if ([strUser isEqualToString:@""] || [strUser length]==0) {
        _bLogin = NO;
        return ;
    } else if([strPwd isEqualToString:@""] || [strPwd length]==0)
    {
        _bLogin = NO;
        return ;
    }
    
    //进入新的界面先
    [self showLoadingMBProgressHUD];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setValue:strUser forKey:@"loginName"];
    [params setValue:[AppUtil md5:strPwd] forKey:@"password"];
//    [params setValue:code forKey:@"phoneCode"];
    NSLog(@"password:%@",[AppUtil md5:strPwd]);

    [[UserService sharedUserService] loginApp:params success:^(id responseObject) {
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (base.code == SuccessCode) {
            UserInfo * userInfo = [UserInfo sharedUserInfo];
            [userInfo mj_setKeyValues:responseObject];
            [UserInfo sharedUserInfo].bIsLogin = YES;
            [UserInfo sharedUserInfo].appLoginName=strUser;
            // NSString* mjJonsString=[[UserInfo sharedUserInfo] mj_JSONString];
            //SZUserDefaultCenterSetValue(SZUserDefalutLoginUser, mjJonsString);

            [UserDefaults setObject:strUser forKey:kUserId];
            [self.personCenterViewModel getSecurityInfo:nil];
            [self.personCenterViewModel c2cH5Login:params];
        }else {
            [UserInfo sharedUserInfo].bIsLogin = NO;
            [self showErrorHUDWithTitle:base.msg];
        }
    } fail:^(NSError *error) {
        [UserInfo sharedUserInfo].bIsLogin = NO;
        [self showErrorHUDWithTitle:error.localizedDescription];
    }];
}

#pragma mark 忘记密码，获取验证码
- (void)findPwd{
    [self.navigationController pushViewController:[[SZForgetPwdViewController alloc] init] animated:YES];
}

- (void)getAuthCode
{
    NSString *strMobile = [_txtUser.text trim];
    if (strMobile.length==0){
        [StatusBarHUD showError:@"手机号不能为空" toView:self.view];
        return ;
    }if (strMobile.length!=11){
        [StatusBarHUD showError:@"手机号码长度错误" toView:self.view];
        return ;
    }if(![strMobile isValidateMobile]){
        [StatusBarHUD showError:@"请输入正确的手机号" toView:self.view];
        return ;
    }
    [self showLoadingMBProgressHUD];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:4];
    [params setValue:strMobile forKey:@"phone"];
    [params setValue:@(17) forKey:@"type"];
    [params setValue:@"86" forKey:@"areaCode"];
    
    [[UserService sharedUserService] getValidateCode:params success:^(id responseObject) {
        [self hideMBProgressHUD];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
            if (SuccessCode == baseModel.code) {
                [self showErrorHUDWithTitle:baseModel.msg];
                [self startTimer];
//                self.btnCode.enabled = NO;
//                [self.codeField becomeFirstResponder];
            } else {
                [self showErrorHUDWithTitle:baseModel.msg];
            }
        }
    } fail:^(NSError *error) {
        [self showErrorHUDWithTitle:error.localizedDescription];
    }];
}

#pragma mark - 手机旋转 rotation
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 检测loginBtn是否可点击
/**
 *  检测loginBtn是否可点击
 *
 *  @param pwdText  密码
 *  @param userText 账号
 */
-(void)checkLogBtnIsEnableWithPwd:(NSString *)pwdText withUser:(NSString *)userText{
    
    BOOL isPwdBool;
    BOOL isUserBool;
//    BOOL isCodeBool;
    
    if (([pwdText isEqualToString:@""]||[pwdText length]==0)) {
        
        isPwdBool = NO;
        
    }else{
        isPwdBool = YES;
    }
    
    if (([userText isEqualToString:@""]||[userText length]==0)) {
        isUserBool = NO;
    }else{
        isUserBool = YES;
    }
    
//    if (([[_codeField.text trim] isEqualToString:@""]||[[_codeField.text trim] length]==0)) {
//        isCodeBool = NO;
//    }else{
//        isCodeBool = YES;
//    }
    
    _btnLogin.enabled = (isPwdBool && isUserBool); // && isCodeBool 验证码非必传
}

#pragma mark 登录超时
- (void)loginTimeOut
{
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(),^{
        @strongify(self);
        
        [self hideMBProgressHUD];
        [self showErrorHUDWithTitle:@"登录超时"];
        
        _btnLogin.enabled = YES;
    });
}

-(void)animation1
{
//    if (nSecond==0)
//    {
//        _btnCode.enabled  = YES;
//        [_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [_timer invalidate];
//        return ;
//    }
//    NSString *strInfo = [NSString stringWithFormat:@"%d s后重试",nSecond];
//    [_btnCode setTitle:strInfo forState:UIControlStateNormal];
//    nSecond--;
}

- (void)startTimer
{
    nSecond = 59;
    if (_timer)
    {
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end


