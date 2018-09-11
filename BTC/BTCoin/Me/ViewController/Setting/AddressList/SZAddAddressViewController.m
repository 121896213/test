//
//  SZAddAddressViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZAddAddressViewController.h"
#import "SZSecurityCodeView.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import <AVCaptureSessionManager.h>
#import "SZAddressSaoCodeViewController.h"
@interface SZAddAddressViewController ()<SZAddressSaoCodeDelegate>
@property (nonatomic,strong) UIButton* confirmButton;
@property (nonatomic,strong) UIButton* saoButton;
@property (nonatomic,strong) UIButton* deleteAddressBtn;

@property (nonatomic,strong) UITextField* addressTextField;
@property (nonatomic,strong) UITextField* remarkTextFiled;
@property (nonatomic,assign) BOOL isEdit;

@end

@implementation SZAddAddressViewController



- (instancetype)initWithIsEdit:(BOOL) isEdit
{
    self = [super init];
    if (self) {
        self.view.backgroundColor=MainBackgroundColor;
        self.isEdit=isEdit;
        [self setSubviews];
        [self addActions];
    }
    return self;
}
- (SZAddressEditViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZAddressEditViewModel new];
    }
    
    return _viewModel;
}
-(void)setCellViewModel:(SZAddressDetailCellViewModel *)cellViewModel
{
    self.addressTextField.text=cellViewModel.model.fadderess;
    self.remarkTextFiled.text=cellViewModel.model.fremark;
    _cellViewModel=cellViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setSubviews{
    
    [self setTitleText:self.isEdit?NSLocalizedString(@"编辑提币地址", nil):NSLocalizedString(@"添加地址", nil)];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    if (self.isEdit) {
        UIButton* rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, FIT3(120), 44)];
        [rightBtn setTitle:@"删除" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.deleteAddressBtn=rightBtn;
        [self setRightBtn:rightBtn];
    }
    
    
    
    UILabel* addressLabel=[UILabel new];
    [addressLabel setText:NSLocalizedString(@"地址", nil)];
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
    addressTextField.placeholder=NSLocalizedString(@"输入或长按粘贴地址", nil);
    addressTextField.textColor=[UIColor blackColor];
    addressTextField.font=[UIFont systemFontOfSize:14.0f];
    self.addressTextField=addressTextField;
    [textFieldView addSubview:addressTextField];
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(FIT3(800));
        make.height.mas_equalTo(FIT3(146));
    }];
    
    UIButton* saoButton=[UIButton new];
    [saoButton setImage:[UIImage imageNamed:@"property_sao_icon"] forState:UIControlStateNormal];
    [textFieldView addSubview:saoButton];
    self.saoButton=saoButton;
    [saoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(addressTextField.mas_top);
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(100));
        
    }];
    
    
    
    
    UILabel* remarkLabel=[UILabel new];
    [remarkLabel setText:NSLocalizedString(@"备注", nil)];
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
    remarkTextField.placeholder=NSLocalizedString(@"请输入地址备注", nil);
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
    

    
    self.confirmButton=[UIButton new];
    [self.confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.confirmButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.confirmButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
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
        
        [self.delegate editAddressSuccess:self];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];
    
    if (self.isEdit) {
        [[self.deleteAddressBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [self showLoadingMBProgressHUD];
            [self.viewModel deleteAddressWithParameters:self.cellViewModel.model.fid];
            
        }];
    }
    
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        
        if (isEmptyString(self.addressTextField.text)) {
            [self showPromptHUDWithTitle:@"请输入提币地址"];
        }else if (isEmptyString(self.remarkTextFiled.text)){
            [self showPromptHUDWithTitle:@"请输入地址备注"];
        }else if (![UserInfo sharedUserInfo].isBindTelephone){
            [self showPromptHUDWithTitle:@"请先绑定手机号"];
        }else{
            SZSecurityCodeView* securityCodeView=[[SZSecurityCodeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT(250))];
            [securityCodeView showInView:self.view directionType:SZPopViewFromDirectionTypeBottom];
            securityCodeView.viewModel.securityCodeType=SZSecurityCodeViewTypeAddAddress;
            securityCodeView.viewModel.mobile=[UserInfo sharedUserInfo].telNumber;
            [[securityCodeView.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self);
                if (isEmptyString(securityCodeView.securityTextField.text)) {
                    [self showPromptHUDWithTitle:@"请输入手机验证码"];

                }else{
                    NSDictionary* parameters=@{@"address":self.addressTextField.text,@"googleCode":@"",@"phoneCode":securityCodeView.securityTextField.text,@"symbol":self.viewModel.listCellViewModel.model.fid,@"withdrawRemark":self.remarkTextFiled.text};
                    [self showLoadingMBProgressHUD];
                    [self.viewModel addAddressWithParameters:parameters];
                    [securityCodeView disMissView];
                }
            }];
        }
      
    }];
    
    
    [[self.saoButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       
        [AVCaptureSessionManager checkAuthorizationStatusForCameraWithGrantBlock:^{
            
            SZAddressSaoCodeViewController *addressSaoCodeVC = [SZAddressSaoCodeViewController new];
            addressSaoCodeVC.delegate=self;
            [self.navigationController pushViewController:addressSaoCodeVC animated:YES];
            
        } DeniedBlock:^{
            
            UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相机权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
            [controller addAction:aciton];
            [self presentViewController:controller animated:YES completion:nil];
            
        }];
        
  
        
    }];
    
}
#pragma mark - SZAddressSaoCodeDelegate  Methods


- (void)reader:(SZAddressSaoCodeViewController *)saoCodeViewController didScanResult:(NSString *)result{
    
    self.addressTextField.text=result;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
