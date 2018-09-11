//
//  SZEditNickNameViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/7/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZEditNickNameViewController.h"
#import "SZUserInfoViewModel.h"
@interface SZEditNickNameViewController ()
@property (nonatomic,strong) SZUserInfoViewModel* viewModel;
@property (nonatomic,strong) UITextField* nickNameTextField;
@end

@implementation SZEditNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitleText:NSLocalizedString(@"昵称修改", nil)];

    
    
    UITextField* nickNameTextField=[UITextField new];
    nickNameTextField.textColor=MainLabelBlackColor;
    nickNameTextField.font=[UIFont systemFontOfSize:14.0f];
    nickNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FIT(16), 0)];
    nickNameTextField.leftViewMode=UITextFieldViewModeAlways;
    nickNameTextField.placeholder=@"请输入您的昵称";
    nickNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nickNameTextField.clearsOnBeginEditing = NO;
    nickNameTextField.backgroundColor=[UIColor whiteColor];
    nickNameTextField.text=[UserInfo sharedUserInfo].nickName;
    
    self.nickNameTextField=nickNameTextField;
    [self.view addSubview:nickNameTextField];
    [nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationStatusBarHeight+FIT(16));
        make.left.mas_equalTo(FIT(0));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(50));
    }];
    RACChannelTo(self,nickNameTextField.text) = RACChannelTo(self.viewModel,nickName);
    @weakify(self);
    [self.nickNameTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.nickName = x;
    }];
    
    
    
    
    UIButton *saveBtn=[UIButton new];
    [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(18)]];
    [saveBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [saveBtn setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.equalTo(nickNameTextField.mas_bottom).offset(FIT(66));
        make.height.mas_equalTo(FIT(50));
        make.width.mas_equalTo(ScreenWidth-FIT(16)*2);
        
    }];
    [saveBtn setGradientBackGround];
    [saveBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    
    
    [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
