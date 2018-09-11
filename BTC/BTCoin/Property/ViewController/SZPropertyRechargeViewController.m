//
//  SZPropertyWithdrawViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyRechargeViewController.h"
#import "SZPropertyRechargeViewModel.h"
#import "SZPropertyCellViewModel.h"
#import "UIImageView+QRCode.h"
@interface SZPropertyRechargeViewController ()
@property (nonatomic,strong) UIButton* backButton;
@property (nonatomic,strong) UIButton* savePhotosBtn;
@property (nonatomic,strong) UIButton* getAddressBtn;
@property (nonatomic,strong) UIImageView* QRCodeImageView;
@property (nonatomic,strong) UILabel* addressLab;

@end

@implementation SZPropertyRechargeViewController

- (SZPropertyRechargeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel=[[SZPropertyRechargeViewModel alloc]init];
    }
    return _viewModel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MainBackgroundColor;
//    UIButton* backBtn=[UIButton new];
//    self.backButton=backBtn;
//    [backBtn setImage:[UIImage imageNamed:@"attention_return_n"] forState:UIControlStateNormal];
//    [self.view addSubview:backBtn];
//    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(FIT2(30));
//        make.top.mas_equalTo(StatusBarHeight);
//        make.height.mas_equalTo(FIT2(70));
//        make.width.mas_equalTo(FIT2(70));
//
//    }];
    [self setTitleText:[NSString stringWithFormat:@"%@  %@",self.viewModel.propertyCellViewModel.bbPropertyModel.fvirtualcointypeName,NSLocalizedString(@"充币", nil)]];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];

    
    
    
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self setSubView];
        [self setActions];

        [self hideMBProgressHUD];
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        [self showErrorHUDWithTitle:x];
        [self setActions];
    }];
    
    [self showLoadingMBProgressHUD];
    [self.viewModel getPropertyRechargeAddressWithParameters:self.viewModel.propertyCellViewModel.bbPropertyModel.fvirtualcointypeId];
    
    

}

-(void)setSubView{

//    UILabel* BTCTypeLabel=[UILabel new];
//    [BTCTypeLabel setText:NSLocalizedString(@"BTC  充币", nil)];
//    [BTCTypeLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
//    [BTCTypeLabel setTextColor:[UIColor blackColor]];
//    BTCTypeLabel.text=[NSString stringWithFormat:@"%@  %@",self.viewModel.propertyCellViewModel.bbPropertyModel.fvirtualciontype,NSLocalizedString(@"充币", nil)];
//    [self.view addSubview:BTCTypeLabel];
//    [BTCTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.backButton.mas_bottom).offset(FIT2(36));
//        make.left.equalTo(self.backButton.mas_left);
//        make.width.mas_equalTo(FIT2(400));
//        make.height.mas_equalTo(FIT2(60));
//    }];
    
   
    UIView* QRCodeView=[UIView new];
    [self.view addSubview:QRCodeView];
    QRCodeView.backgroundColor=[UIColor whiteColor];
    [QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((ScreenWidth-FIT3(570))/2);
        make.top.mas_equalTo(FIT3(210)+NavigationStatusBarHeight);
        make.width.height.mas_equalTo(FIT3(570));
    }];
    [ShareFunction setCircleBorder:QRCodeView];
    

    UIImageView* QRCodeImageView=[UIImageView new];
    [QRCodeImageView setImage:[QRCodeImageView creatCIQRCodeImage:self.viewModel.model.fvirtualaddress]];
    [QRCodeView addSubview:QRCodeImageView];
    self.QRCodeImageView=QRCodeImageView;
    [QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(FIT3(378));
        make.centerX.equalTo(QRCodeView.mas_centerX);
        make.centerY.equalTo(QRCodeView.mas_centerY);
        
    }];
   
    
    
    UIButton* savePhotosBtn=[UIButton new];
    [savePhotosBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [savePhotosBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [savePhotosBtn setTitleColor: UIColorFromRGB(0x497c99) forState:UIControlStateHighlighted];
    [savePhotosBtn setTitle:NSLocalizedString(@"保存二维码至相册", nil) forState:UIControlStateNormal];
    [self.view addSubview:savePhotosBtn];
    self.savePhotosBtn=savePhotosBtn;
    [savePhotosBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(QRCodeView.mas_left);
        make.top.equalTo(QRCodeView.mas_bottom).offset( FIT2(30));
        make.width.mas_equalTo(FIT3(570));
        make.height.mas_equalTo(FIT2(30));
    }];
    
    NSString* addressString=self.viewModel.model.fvirtualaddress ;
    NSLog(@"addressString:%@",addressString);
    CGFloat height=[ShareFunction getHeightLineWithString:addressString withWidth:FIT2(450) withFont:[UIFont systemFontOfSize:14.0f]];
    UIView* addressView=[UIView new];
    addressView.backgroundColor=UIColorFromRGB(0xecfbff);
    [self.view addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(savePhotosBtn.mas_bottom).offset(FIT2(60));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(height+FIT2(30)*2);
    }];
    
    UILabel* addressLabel=[UILabel new];
    [addressLabel setText:addressString];
    [addressLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [addressLabel setTextColor:UIColorFromRGB(0x333333)];
    addressLabel.numberOfLines=0;
    [addressView addSubview:addressLabel];
    self.addressLab=addressLabel;
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT2(20));
        make.top.mas_equalTo(FIT2(30));
        make.width.mas_equalTo(FIT2(450));
        make.height.mas_equalTo(height);
    }];
    
    
    UIButton* copyAddressBtn=[UIButton new];
    [copyAddressBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [copyAddressBtn setBackgroundColor:UIColorFromRGB(0x03c087)];
    [copyAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [copyAddressBtn setTitle:NSLocalizedString(@"复制地址", nil) forState:UIControlStateNormal];
    [copyAddressBtn setBackgroundImage:[UIImage imageWithColor: MainThemeColor ] forState:UIControlStateNormal];
    [copyAddressBtn setBackgroundImage:[UIImage imageWithColor: UIColorFromRGB(0x00B500) ] forState:UIControlStateSelected];
    self.getAddressBtn=copyAddressBtn;
    [addressView addSubview:copyAddressBtn];
    [ShareFunction setCircleBorder:copyAddressBtn];
    [copyAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT2(-30));
        make.top.mas_equalTo(FIT2(30));
        make.width.mas_equalTo(FIT2(200));
        make.height.mas_equalTo(height);
    }];
    
    UILabel* noticeLabel=[UILabel new];
    if (isEmptyString(self.viewModel.model.fdescription) ) {
        noticeLabel.text=@"💡请勿向上述地址充值任何非BTC资产，否则资产将不可找回。您充值至上述地址后，需要整个网络节点的确认，1次网络确认后到账，6次网络确认后可提币。\n最小充值金额0.001BTC,小于最小金额的充值将不会到账。\n您的充值地址不会经常改变，可以重复充值；如有更改，我们会尽量通过网站公告或邮件通知您。\n请务必确认电脑及浏览器安全，防止信息被篡改或者泄露";
    }else{
        
        noticeLabel.text=[NSString stringWithFormat:@"💡%@",self.viewModel.model.fdescription];
    }
   
    
    noticeLabel.font=[UIFont systemFontOfSize:9];
    noticeLabel.textColor=UIColorFromRGB(0x999999);
    noticeLabel.numberOfLines=0;
    CGFloat noticeAutoHeight=[ShareFunction getHeightLineWithString:noticeLabel.text withWidth:ScreenWidth-FIT2(24)*2 withFont:[UIFont systemFontOfSize:9.0f]];
    [self.view addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT2(24));
        make.top.equalTo(addressView.mas_bottom).offset(FIT2(89));
        make.width.mas_equalTo(ScreenWidth-FIT2(24)*2);
        make.height.mas_equalTo(noticeAutoHeight);
    }];
    
}


-(void)setActions{
    @weakify(self);
    [[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    [[self.savePhotosBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
       UIImageWriteToSavedPhotosAlbum(self.QRCodeImageView.image,self,@selector(image:didFinishSavingWithError:contextInfo:),(__bridge void*)self);

    }];
    
    [[self.getAddressBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
        pastboard.string = self.addressLab.text;
        [self showErrorHUDWithTitle:@"复制成功"];
    }];
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    [self showErrorHUDWithTitle:@"保存成功"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
