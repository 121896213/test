
//
//  SZPropertyRechargeViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyWithdrawViewController.h"
#import "SZWithdrawHeaderView.h"
#import "SZWithdrawFooterView.h"
#import "SZWithdrawCountCell.h"
#import "SZPropertyWithdrawAddressCell.h"
#import "SZWithdrawServiceFeeCell.h"
#import "SZWithdrawPasswordCell.h"
#import "SZPropertyRechargeViewModel.h"
#import "SZSecurityCodeView.h"
#import <QRCodeReaderViewController.h>

#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import <AVCaptureSessionManager.h>
#import "SZAddressSaoCodeViewController.h"
#import "SZAddressDetailViewController.h"

@interface SZPropertyWithdrawViewController ()<UITableViewDelegate,UITableViewDataSource,SZAddressSaoCodeDelegate,SZAddressDetailDelegate>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) SZWithdrawHeaderView* headerView;
@property (nonatomic,strong) SZWithdrawFooterView* footerView;


@end

@implementation SZPropertyWithdrawViewController
- (SZPropertyWithdrawViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel=[[SZPropertyWithdrawViewModel alloc]init];
    }
    return _viewModel;
    
}
-(SZSecurityCodeViewModel *)securityCodeViewModel{
    
    if (!_securityCodeViewModel) {
        _securityCodeViewModel=[[SZSecurityCodeViewModel alloc]init];
    }
    return _securityCodeViewModel;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.view.backgroundColor=MainBackgroundColor;
    [self.viewModel signalRequestPropertyDrawRtcWithParameter:self.viewModel.propertyCellViewModel.bbPropertyModel.fvirtualcointypeId];
   
    [self setTitleText:[NSString stringWithFormat:@"%@  %@",self.viewModel.propertyCellViewModel.bbPropertyModel.fvirtualcointypeName,NSLocalizedString(@"提币", nil)]];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(NavigationStatusBarHeight);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight-NavigationStatusBarHeight);
    }];
    self.tableView.backgroundColor=MainBackgroundColor;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.sectionHeaderHeight=FIT3(172);
    self.headerView=[[SZWithdrawHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT3(172))];
    self.headerView.propertyCellViewModel=self.viewModel.propertyCellViewModel;
    self.tableView.tableHeaderView=self.headerView;
    
    
    self.footerView=[[SZWithdrawFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT3(386))];
    self.footerView.withdrawViewModel=self.viewModel;
    self.tableView.tableFooterView=self.footerView;

    
    [self.tableView registerClass:[SZWithdrawCountCell class] forCellReuseIdentifier:SZWithdrawCountCellReuseIdentifier];
    [self.tableView registerClass:[SZPropertyWithdrawAddressCell class] forCellReuseIdentifier:SZPropertyWithdrawAddressCellReuseIdentifier];
    [self.tableView registerClass:[SZWithdrawServiceFeeCell class] forCellReuseIdentifier:SZRechargeServiceFeeReuseIdentifier];
    [self.tableView registerClass:[SZWithdrawPasswordCell class] forCellReuseIdentifier:SZWithdrawPasswordCellReuseIdentifier];

    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
  
    
    
    [self setActions];
    
}


-(void)setActions{
    @weakify(self);
    [[self.headerView.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        self.footerView.withdrawViewModel=self.viewModel;
        [self showErrorHUDWithTitle:x];
        [self.tableView reloadData];
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];
    }];
    [self.viewModel.otherSignal subscribeNext:^(id x) {
        @strongify(self);
        if ([x isEqualToString:SZWithdrawPasswordCellTextFieldDidChanged] || [x isEqualToString:SZPropertyWithdrawAddressCellTextFieldDidChanged] || [x isEqualToString:SZWithdrawCountCellTextFieldDidChanged] ){
            [self.tableView reloadData];
        }else if ( [x isEqualToString:@"RechargeButtonTouchUpInside"]){
            SZSecurityCodeView* securityCodeView=[[SZSecurityCodeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT(250))];
            [securityCodeView showInView:self.view directionType:SZPopViewFromDirectionTypeBottom];
            securityCodeView.viewModel.securityCodeType=SZSecurityCodeViewTypeCommitWithdraw;;

            [[securityCodeView.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self);
                if (isEmptyString(securityCodeView.securityTextField.text)) {
                    [self showPromptHUDWithTitle:@"请输入手机验证码"];
                }else{
                    NSDictionary* parameters=@{@"address":self.viewModel.currentAddress,@"withdrawAddr":@(0),@"withdrawAmout":self.viewModel.reachCoinCount,@"tradePwd":  [AppUtil md5:self.viewModel.currentPassword],@"googleCode":@"",@"phoneCode":securityCodeView.securityTextField.text,@"symbol":self.viewModel.propertyCellViewModel.bbPropertyModel.fvirtualcointypeId};
                    [self showLoadingMBProgressHUD];
                    [self.viewModel commitWithdrawWithParameters:parameters];
                    [securityCodeView disMissView];
                }
            }];
        }else if ([x isEqualToString:SZPropertyWithdrawAddressCellSaoButtonAction]){
            
            @weakify(self);
            [AVCaptureSessionManager checkAuthorizationStatusForCameraWithGrantBlock:^{
                @strongify(self);
                SZAddressSaoCodeViewController *addressSaoCodeVC = [SZAddressSaoCodeViewController new];
                addressSaoCodeVC.delegate=self;
                [self.navigationController pushViewController:addressSaoCodeVC animated:YES];
            } DeniedBlock:^{
                @strongify(self);
                UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相机权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
                [controller addAction:aciton];
                [self presentViewController:controller animated:YES completion:nil];
                
            }];
        }else if ([x isEqualToString:SZPropertyWithdrawAddressCellAddressButtonAction]){
            
            SZAddressListCellViewModel* cellViewModel=[SZAddressListCellViewModel new];
            cellViewModel.model=[SZCoinAddressModel new];
            cellViewModel.model.fShortName=self.viewModel.propertyCellViewModel.bbPropertyModel.fvirtualcointypeName;
            cellViewModel.model.fid=self.viewModel.propertyCellViewModel.bbPropertyModel.fvirtualcointypeId;
            
            SZAddressDetailViewController* addressDetailVC=[[SZAddressDetailViewController alloc]initWithCoinCellViewModel:cellViewModel];
            addressDetailVC.delegate=self;
            [self.navigationController pushViewController:addressDetailVC animated:YES];
        }
    }];
    
    

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        SZPropertyWithdrawAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:SZPropertyWithdrawAddressCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.withdrawViewModel=self.viewModel;
      
        return cell;
    }else if (indexPath.row == 1){
        
        SZWithdrawCountCell *cell = [tableView dequeueReusableCellWithIdentifier:SZWithdrawCountCellReuseIdentifier forIndexPath:indexPath];
    
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.viewModel=self.viewModel.propertyCellViewModel;
        cell.withdrawViewModel=self.viewModel;
        return cell;
    }else if (indexPath.row  == 2){
        SZWithdrawServiceFeeCell *cell = [tableView dequeueReusableCellWithIdentifier:SZRechargeServiceFeeReuseIdentifier forIndexPath:indexPath];

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.viewModel=self.viewModel.propertyCellViewModel;
        cell.withdrawViewModel=self.viewModel;
        return cell;
    }else if (indexPath.row  == 3){
        SZWithdrawPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:SZWithdrawPasswordCellReuseIdentifier forIndexPath:indexPath];

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.withdrawViewModel=self.viewModel;
        return cell;
    }else{
        
        return nil;
    }
    
}

#pragma mark - SZAddressSaoCodeDelegate  Methods


- (void)reader:(SZAddressSaoCodeViewController *)saoCodeViewController didScanResult:(NSString *)result{
    
    self.viewModel.currentAddress=result;
    [self.tableView reloadData];
}
-(void)reader:(SZAddressDetailViewController *)addressDetailViewController didSelectResult:(NSString *)result{
    
    self.viewModel.currentAddress=result;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FIT3(326);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
