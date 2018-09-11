//
//  EmailRegisterViewController.m
//  BTCoin
//
//  Created by LionIT on 13/03/2018.
//  Copyright © 2018 LionIT. All rights reserved.
#import "EmailRegisterViewController.h"
#import "NSString+Custom.h"
#import "UIButton+Extension.h"
#import "EmailRegisterViewController.h"
#import "PhonePwdViewController.h"
#import "UserService.h"
#import "BaseModel.h"
#import "JCountryViewController.h"
#import "JCountryModel.h"

@interface EmailRegisterViewController ()
//国籍
@property (nonatomic,strong) UILabel * countryNameLabel;
//邮箱
@property (nonatomic,strong) UITextField * phoneTextField;
//下一步
@property (nonatomic,strong) UIButton * nextBtn;
//当前国家(默认——中国)
@property (nonatomic,strong) JCountryModel *countryModel;

@end

@implementation EmailRegisterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.headView.backgroundColor = COLOR_Bg_White;
    self.view.backgroundColor = [UIColor whiteColor];

    float itemBarWidth = 44.0;
    UIButton * loginBtn = [UIButton initWithFrame:Rect(kScreenWidth-itemBarWidth-10.0, StatusBarHeight+(NaviBarHeight-itemBarWidth)/2, itemBarWidth, itemBarWidth) title:NSLocalizedString(@"登录", nil)];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:color_333333];
    [self setRightBtn:loginBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configColorForNextBtn:) name:UITextFieldTextDidChangeNotification object:nil];
    [self initUIHead];
}

- (void)initUIHead {
    UILabel * loginLabel = [[UILabel alloc] init];
    [loginLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [loginLabel setTextColor:color_333333];
    loginLabel.text = NSLocalizedString(@"邮箱注册", nil);
    [loginLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(20.0);
        make.top.equalTo(self.headView.mas_bottom).offset(30);
    }];
    
    UIImageView * noticeImageView = [[UIImageView alloc] init];
    noticeImageView.image = [UIImage imageNamed:@"remind_icon"];
    [self.view addSubview:noticeImageView];
    [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(loginLabel);
        make.top.equalTo(loginLabel.mas_bottom).offset(10);
        make.width.height.mas_equalTo(15);
    }];
    
    UILabel * noticeLabel = [[UILabel alloc] init];
    [noticeLabel setFont:[UIFont systemFontOfSize:12]];
    [noticeLabel setTextColor:color_333333];
    noticeLabel.text = NSLocalizedString(@"注册后国籍不可更改。", nil);
    noticeLabel.adjustsFontSizeToFitWidth=YES;
    [noticeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(noticeImageView.mas_trailing).offset(5.0);
        make.centerY.equalTo(noticeImageView.mas_centerY);
    }];
    
    //注册信息
    UIView * registerInfoView = [[UIView alloc] init];
    [self.view addSubview:registerInfoView];
    [registerInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noticeImageView.mas_bottom).offset(40.0);
        make.leading.equalTo(noticeImageView);
        make.trailing.equalTo(self.view).offset(-20);
    }];
    
    //国籍+下箭头
    UIControl * nationalView = [[UIControl alloc] init];
    [registerInfoView addSubview:nationalView];
    [nationalView addTarget:self action:@selector(searchNationalityAction:) forControlEvents:UIControlEventTouchDown];
    [nationalView mas_makeConstraints:^(MASConstraintMaker *make) {
        //与registerInfoView高度的关系
        make.top.leading.equalTo(registerInfoView);
        //make.width.mas_equalTo(50.0);
        make.height.mas_equalTo(40.0);
        make.width.mas_equalTo(150);
    }];
    
    self.countryNameLabel = [[UILabel alloc] init];
    [self.countryNameLabel setFont:[UIFont systemFontOfSize:17]];
    [self.countryNameLabel setTextColor:color_333333];
    self.countryNameLabel.text = @"中国";
    [self.countryNameLabel setTextAlignment:NSTextAlignmentLeft];
    [nationalView addSubview:self.countryNameLabel];
    [self.countryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nationalView);
        make.centerY.equalTo(nationalView.mas_centerY);
    }];
    
    UIImageView * arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"icon_arrow_down"];
    [nationalView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.countryNameLabel.mas_trailing).offset(15.0);
        make.centerY.equalTo(nationalView.mas_centerY);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(7);
    }];
    
    //手机号码
    UIView * phoneView = [[UIView alloc] init];
    [registerInfoView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nationalView.mas_bottom).offset(25);
        make.leading.trailing.equalTo(registerInfoView);
        make.height.mas_equalTo(40.0);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.phoneTextField.placeholder = NSLocalizedString(@"邮箱", nil);
    [phoneView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(phoneView);
        make.top.leading.bottom.trailing.equalTo(phoneView);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = color_f2f2f2;
    [phoneView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(phoneView);
        make.height.mas_equalTo(1);
    }];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self configColorForNextBtn:nil];
    self.nextBtn.backgroundColor = color_d2d2d2;
    self.nextBtn.enabled = false;
    [self.nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:COLOR_Bg_White];
    [self.nextBtn addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerInfoView addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).offset(30);
        make.leading.trailing.equalTo(registerInfoView);
        make.height.mas_equalTo(44);
    }];
    
    UIButton * emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    emailBtn.backgroundColor = [UIColor clearColor];
    [emailBtn setTitle:NSLocalizedString(@"手机注册", nil) forState:UIControlStateNormal];
    [emailBtn setTitleColor:[UIColor sapBlue]];
    [emailBtn addTarget:self action:@selector(registerByPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerInfoView addSubview:emailBtn];
    [emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nextBtn.mas_bottom).offset(30);
        make.leading.bottom.equalTo(registerInfoView);
    }];
}

#pragma mark 获取默认国籍
- (JCountryModel *)countryModel {
    if (!_countryModel) {
        JCountryModel *model = [[JCountryModel alloc] init];
        model.countrycn = @"中国";
        model.countryen = @"China";
        model.phoneCode = @"86";
        self.countryModel = model;
    }
    return _countryModel;
}

#pragma mark 获取国家代码的函数
- (NSString *)countryCode {
    return [NSString stringWithFormat:@"+%@",self.countryModel.phoneCode];
}
#pragma mark 设置“下一步”按钮的可用性 且 TextFiled内容改变通知调用
- (void)configColorForNextBtn:(NSNotification *)sender {
    BOOL hasValue = [self.phoneTextField.text trim].length > 0;
    if (hasValue) {
        self.nextBtn.enabled = YES;
        [self.nextBtn setGradientBackGround];
    } else {
        self.nextBtn.enabled = NO;
        [self.nextBtn removeGradientBackGround];
    }
}
#pragma mark 选择国家
- (void)searchNationalityAction:(UIButton *)sender {
    JCountryViewController *vc = [[JCountryViewController alloc] init];
    @weakify(self);
    [vc setCountryBlock:^(JCountryModel *countryModel) {
        @strongify(self);
        self.countryModel = countryModel;
        self.countryNameLabel.text = countryModel.countrycn;
    }];
    vc.currCountryModel = self.countryModel;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 下一步
- (void)nextStepAction:(UIButton *)sender {
    
    if (![[self.phoneTextField.text trim] isEmail]) {
        [self showErrorHUDWithTitle:@"请输入合法的邮箱账号"];
        return;
    }
    
    [self showLoadingMBProgressHUD];
    [[UserService sharedUserService] getEmailValidateCode:[self.phoneTextField.text trim] success:^(id responseObject) {
        [self hideMBProgressHUD];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
            if (SuccessCode == baseModel.code) {
                NSLog(@"baseModel.msg:%@",baseModel.msg);
                [self showErrorHUDWithTitle:baseModel.msg];
                
                [[SZSundriesCenter instance] delayExecutionInMainThread:^{
                    PhonePwdViewController * pwdVC = [[PhonePwdViewController alloc] init];
                    pwdVC.regType = 1;//email注册
                    pwdVC.phoneNum = [self.phoneTextField.text trim];
                    pwdVC.areaCode = self.countryModel.phoneCode;
                    [self.navigationController pushViewController:pwdVC animated:YES];
                }];
            
            } else {
                [self showErrorHUDWithTitle:baseModel.msg];
            }
        }
    } fail:^(NSError *error) {
        [self showErrorHUDWithTitle:error.localizedDescription];
    }];
    
}
#pragma mark 切换到（手机注册、登录）
- (void)registerByPhoneAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loginAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
