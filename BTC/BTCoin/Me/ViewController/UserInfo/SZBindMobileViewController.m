//
//  SZBindMobileViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBindMobileViewController.h"
#import "SZBindPhoneViewModel.h"
#import "SZSecurityCodeViewModel.h"
#import "JCountryViewController.h"
#import "JCountryModel.h"
@interface SZBindMobileViewController ()
@property (nonatomic,strong) UIButton* confirmButton;
@property (nonatomic,strong) UIButton* saoButton;
@property (nonatomic,strong) SZBindPhoneViewModel* viewModel;
@property (nonatomic,strong) SZSecurityCodeViewModel* securityCodeViewModel;

@property (nonatomic,strong) UITextField* addressTextField;
@property (nonatomic,strong) UITextField* remarkTextFiled;

@property (nonatomic,strong) UILabel* countryPhoneLabel;
@property (nonatomic,strong)UIButton* selectContryBtn;

@property (nonatomic,strong)JCountryModel *countryModel;

@end

@implementation SZBindMobileViewController

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
- (SZBindPhoneViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel=[SZBindPhoneViewModel new];
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
    
    [self setTitleText:NSLocalizedString(@"绑定手机", nil)];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    
    UILabel* addressLabel=[UILabel new];
    [addressLabel setText:NSLocalizedString(@"手机号码", nil)];
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
    //国籍代码
    UILabel* countryPhoneLabel = [[UILabel alloc] init];
    [countryPhoneLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [countryPhoneLabel setTextColor:color_333333];
    countryPhoneLabel.text = @"+86";
    countryPhoneLabel.textAlignment = NSTextAlignmentLeft;
    self.countryPhoneLabel=countryPhoneLabel;
    CGFloat width = [countryPhoneLabel.text widthWithFont:countryPhoneLabel.font];
    [textFieldView addSubview:countryPhoneLabel];
    [countryPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(textFieldView).offset(FIT3(48));
        make.centerY.equalTo(textFieldView.mas_centerY);
        make.width.mas_equalTo(width);
    }];
    //国籍下箭头
    UIButton* arrowImageView = [[UIButton alloc] init];
    [arrowImageView setImage:[UIImage imageNamed:@"meCenterArrowDown"] forState:UIControlStateNormal];
    arrowImageView.contentMode=UIViewContentModeScaleAspectFit;
    [textFieldView addSubview:arrowImageView];
    self.selectContryBtn=arrowImageView;
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(countryPhoneLabel.mas_trailing).offset(10.0);
        make.centerY.equalTo(textFieldView.mas_centerY);
        make.width.mas_equalTo(FIT3(48));
        make.height.mas_equalTo(FIT3(48));
    }];
    
    
    
    UITextField* addressTextField=[UITextField new];
    addressTextField.placeholder=NSLocalizedString(@"请输入手机号码", nil);
    addressTextField.textColor=[UIColor blackColor];
    addressTextField.font=[UIFont systemFontOfSize:14.0f];
    self.addressTextField=addressTextField;
    [textFieldView addSubview:addressTextField];
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_bottom);
        make.left.equalTo(arrowImageView.mas_right).offset(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    
    UILabel* remarkLabel=[UILabel new];
    [remarkLabel setText:NSLocalizedString(@"手机验证码", nil)];
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
    remarkTextField.placeholder=NSLocalizedString(@"请输入手机验证码", nil);
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
        [UserInfo sharedUserInfo].isBindTelephone=YES;
        [UserInfo sharedUserInfo].telNumber=self.addressTextField.text;
        
        [[SZSundriesCenter instance]delayExecutionInMainThread:^{
           
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];
    
    [[self.selectContryBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        JCountryViewController *vc = [[JCountryViewController alloc] init];
        @weakify(self);
        [vc setCountryBlock:^(JCountryModel *countryModel) {
            @strongify(self);
            self.countryModel = countryModel;
            self.countryPhoneLabel.text = [NSString stringWithFormat:@"+%@",countryModel.phoneCode];
            
            CGFloat width = [self.countryPhoneLabel.text widthWithFont:self.countryPhoneLabel.font];
            [self.countryPhoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
            }];
        }];
        vc.currCountryModel = self.countryModel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        
        if (isEmptyString(self.addressTextField.text)) {
            [self showPromptHUDWithTitle:@"请输入手机号码"];
        }else if (isEmptyString(self.remarkTextFiled.text)){
            [self showPromptHUDWithTitle:@"请输入验证码"];
        }else{
            NSDictionary* parameters=@{@"areaCode":(self.countryModel.phoneCode?self.countryModel.phoneCode:@"86"),@"phone":self.addressTextField.text,@"newCode":self.remarkTextFiled.text};
            [self showLoadingMBProgressHUD];
            [self.viewModel bindPhoneWithParameters:parameters];
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
        [self hideMBProgressHUD];
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
            
            if (![self.addressTextField.text isMobliePhone]) {
                [self showPromptHUDWithTitle:@"请输入手机号码"];	
            }else{
                
                [self showLoadingMBProgressHUD];
                self.securityCodeViewModel.areaCode=self.countryModel.phoneCode?self.countryModel.phoneCode:@"86";
                self.securityCodeViewModel.securityCodeType=SZSecurityCodeViewTypeBindMobileEmail;
                self.securityCodeViewModel.mobile=self.addressTextField.text;
                [self.securityCodeViewModel getWithdrawSecurityCodeWithParameters:nil];
            }
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
