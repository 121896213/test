//
//  PhoneRegisterViewController.m
//  BTCoin
//
//  Created by LionIT on 13/03/2018.
//  Copyright © 2018 LionIT. All rights reserved.
//

#import "PhoneRegisterViewController.h"
#import "NSString+Custom.h"
#import "UIButton+Extension.h"
#import "EmailRegisterViewController.h"
#import "PhonePwdViewController.h"
#import "UserService.h"
#import "BaseModel.h"
#import "JCountryViewController.h"
#import "JCountryModel.h"

@interface PhoneRegisterViewController () <UITextFieldDelegate>
//国家名称
@property (nonatomic,strong) UILabel * countryNameLabel;
//国家代码
@property (nonatomic,strong) UILabel * countryPhoneLabel;
//手机号码
@property (nonatomic,strong) UITextField * phoneTextField;
//下一步
@property (nonatomic,strong) UIButton * nextBtn;
//当前国家(默认——中国)
@property (nonatomic,strong) JCountryModel *countryModel;
@end

@implementation PhoneRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headView.backgroundColor = COLOR_Bg_White;
    self.view.backgroundColor = [UIColor whiteColor];

    //添加导航栏右侧按钮
    float itemBarWidth = 44.0;
    UIButton * loginBtn = [UIButton initWithFrame:Rect(kScreenWidth-itemBarWidth-10.0, StatusBarHeight+(NaviBarHeight-itemBarWidth)/2, itemBarWidth, itemBarWidth) title:NSLocalizedString(@"登录", nil)];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:color_333333];
    [self setRightBtn:loginBtn];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configColorForNextBtn:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:self.phoneTextField];
    
    [self initUIHead];
}

- (void)initUIHead {
    UILabel * loginLabel = [[UILabel alloc] init];
    [loginLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [loginLabel setTextColor:color_333333];
    loginLabel.text = NSLocalizedString(@"手机注册", nil);
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
    [noticeLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [noticeLabel setTextColor:color_333333];
    noticeLabel.text = NSLocalizedString(@"注册后国籍不可更改。", nil);
    [noticeLabel setTextAlignment:NSTextAlignmentLeft];
    noticeLabel.adjustsFontSizeToFitWidth=YES;
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
    //registerInfoView.backgroundColor = [UIColor redColor];
    
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

    //国籍名字
    self.countryNameLabel = [[UILabel alloc] init];
    self.countryNameLabel.userInteractionEnabled = NO;
    [self.countryNameLabel setFont:[UIFont systemFontOfSize:17]];
    [self.countryNameLabel setTextColor:color_333333];
    self.countryNameLabel.text = self.countryModel.countrycn;
    [self.countryNameLabel setTextAlignment:NSTextAlignmentLeft];
    [nationalView addSubview:self.countryNameLabel];
    [self.countryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nationalView);
        make.centerY.equalTo(nationalView.mas_centerY);
    }];
    //国籍下箭头
    UIImageView * arrowImageView = [[UIImageView alloc] init];
    arrowImageView.userInteractionEnabled = NO;
    arrowImageView.image = [UIImage imageNamed:@"icon_arrow_down"];
    [nationalView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.countryNameLabel.mas_trailing).offset(10.0);
        make.centerY.equalTo(nationalView.mas_centerY);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(7);
    }];
    
    //国籍代码+下箭头+手机号码
    UIView * phoneView = [[UIView alloc] init];
    [registerInfoView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        //手机号码和国籍之间的间距
        make.top.equalTo(nationalView.mas_bottom).offset(25);
        make.leading.trailing.equalTo(registerInfoView);
        make.height.mas_equalTo(40.0);
    }];
    
    //国籍代码
    self.countryPhoneLabel = [[UILabel alloc] init];
    [self.countryPhoneLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [self.countryPhoneLabel setTextColor:color_333333];
    self.countryPhoneLabel.text = [self countryCode];
    self.countryPhoneLabel.textAlignment = NSTextAlignmentLeft;
    CGFloat width = [self.countryPhoneLabel.text widthWithFont:self.countryPhoneLabel.font];
    [phoneView addSubview:self.countryPhoneLabel];
    [self.countryPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(phoneView).offset(0);
        make.centerY.equalTo(phoneView.mas_centerY);
        make.width.mas_equalTo(width);
    }];
    
    
    
    //国籍下箭头
    arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"icon_arrow_down"];
    [phoneView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.countryPhoneLabel.mas_trailing).offset(10.0);
        make.centerY.equalTo(phoneView.mas_centerY);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(7);
    }];
    
    //手机号码
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.delegate = self;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.placeholder = NSLocalizedString(@"手机号码", nil);
    [phoneView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(arrowImageView.mas_trailing).offset(5);
        make.top.bottom.trailing.equalTo(phoneView);
    }];
    
    //分割线
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = color_f2f2f2;
    [phoneView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(phoneView);
        make.height.mas_equalTo(1);
    }];
    
    //下一步
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self configColorForNextBtn:nil];
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
    [emailBtn setTitle:NSLocalizedString(@"邮箱注册", nil) forState:UIControlStateNormal];
    [emailBtn setTitleColor:[UIColor sapBlue]];
    [emailBtn addTarget:self action:@selector(registerByEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerInfoView addSubview:emailBtn];
    [emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nextBtn.mas_bottom).offset(22);
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
//        self.nextBtn.backgroundColor = [UIColor sapBlue];
        [self.nextBtn setGradientBackGround];
    } else {
        self.nextBtn.enabled = NO;
        self.nextBtn.backgroundColor = color_f2f2f2;//[UIColor sapGray];
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
        self.countryPhoneLabel.text = [NSString stringWithFormat:@"+%@",countryModel.phoneCode];
        
        CGFloat width = [self.countryPhoneLabel.text widthWithFont:self.countryPhoneLabel.font];
        [self.countryPhoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
        }];
    }];
    vc.currCountryModel = self.countryModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 下一步
- (void)nextStepAction:(UIButton *)sender {
    if (self.phoneTextField.text.length <= 0) {
        [self.phoneTextField becomeFirstResponder];
        return;
    }
    if (![[self.phoneTextField.text trim] isMobliePhone]) {
        [self showErrorHUDWithTitle:@"请输入合法的手机号码"];
        return;
    }
    [self showLoadingMBProgressHUD];
    /*
     type(可选参数不传默认是发送注册短信)
     1:申请api 2:绑定手机 3:解绑手机 4:人民币提�? 5:虚拟币提�?
     6:修改登陆密码  7:修改交易密码  8:虚拟币提现地�?设置 9:找回登陆密码  10:设置人民币提现账�?
     12:注册 13:币生�? 14:会员转账  15:会员添加API 17: 登录验证
     */
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithCapacity:3];
    [mDict setValue:[self.phoneTextField.text trim] forKey:@"phone"];
    [mDict setValue:@(12) forKey:@"type"];
    [mDict setValue:self.countryModel.phoneCode forKey:@"areaCode"];
    //请求时因少areaCode字段，报错：Error Domain=com.alamofire.error.serialization.response Code=-1011 "Request failed: internal server error (500)" UserInfo={NSLocalizedDescription=Request failed: internal server error (500), 
    [[UserService sharedUserService] getValidateCode:mDict success:^(id responseObject) {
        [self hideMBProgressHUD];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
            
            [self showErrorHUDWithTitle:baseModel.msg];
            if (SuccessCode == baseModel.code) {
                
                [[SZSundriesCenter instance] delayExecutionInMainThread:^{
                    PhonePwdViewController * pwdVC = [[PhonePwdViewController alloc] init];
                    pwdVC.regType = 0;//手机注册
                    pwdVC.phoneNum = mDict[@"phone"];
                    pwdVC.areaCode = mDict[@"areaCode"];
                    [self.navigationController pushViewController:pwdVC animated:YES];
                }];
                
            }
        }
    } fail:^(NSError *error) {
        [self showErrorHUDWithTitle:error.localizedDescription];
    }];
}

#pragma mark 切换到（邮箱注册、登录）
- (void)registerByEmailAction:(UIButton *)sender {
    EmailRegisterViewController * emailVC = [[EmailRegisterViewController alloc] init];
    [self.navigationController pushViewController:emailVC animated:YES];
}

- (void)loginAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


@end
