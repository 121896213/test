//
//  SZPropertyDetailViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyDetailViewController.h"
#import "SZPropertyViewController.h"
#import "SZBbPropertyCell.h"
#import "SZPropertyHeaderView.h"
#import "SZPropertyDetailHeaderView.h"
#import "SZPropertyDetailFooterView.h"
#import "SZPropertyRechargeViewController.h"
#import "SZPropertyWithdrawViewController.h"
#import "SZPropertyTotalRecordViewController.h"
#import "SZPropertyRecordHeaderView.h"
#import "SZPropertyRecordCell.h"
#import "SZScPropertyRecordCell.h"
#import "SZPropertyDetailViewModel.h"
#import "SZC2CAmountTradeViewController.h"
@interface SZPropertyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,copy)  NSArray* currentData;
@property (nonatomic,strong) SZPropertyDetailHeaderView* headerView;
@property (nonatomic,strong) SZPropertyDetailFooterView* footerView;
@property (nonatomic,strong) SZPropertyDetailViewModel* viewModel;
@end

@implementation SZPropertyDetailViewController


-(SZPropertyDetailViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZPropertyDetailViewModel new];
        _viewModel.recordsArr=[NSMutableArray new];
        _viewModel.currentPage=1;
        _viewModel.currentType=0;
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentData=[[NSArray alloc]init];
    SZPropertyDetailHeaderView* headerView=[[SZPropertyDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, FIT3(590)+StatusBarHeight)];
    headerView.viewModel=self.propertyCellViewModel;
    self.headerView=headerView;
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(590)+StatusBarHeight);
    }];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    if (self.propertyCellViewModel.walletType == SZWalletTypeBB) {
        self.tableView.rowHeight=SZPropertyRecordCellHeight;

    }else if (self.propertyCellViewModel.walletType == SZWalletTypeC2C) {
        self.tableView.rowHeight=SZScPropertyRecordCellHeight;
        
    }else if (self.propertyCellViewModel.walletType == SZWalletTypeSC) {
        self.tableView.rowHeight=SZScPropertyRecordCellHeight;
        
    }
    self.tableView.estimatedRowHeight=150.0f;
    [self.tableView registerClass:[SZPropertyRecordCell class] forCellReuseIdentifier:SZPropertyRecordCellReuseIdentifier];
    [self.tableView registerClass:[SZScPropertyRecordCell class] forCellReuseIdentifier:SZScPropertyRecordCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=MainBackgroundColor;

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(_headerView.mas_bottom);
        make.width.mas_equalTo(ScreenWidth);
        if (_propertyCellViewModel.walletType  != SZWalletTypeSC) {
            make.height.mas_equalTo(ScreenHeight-FIT2(134)-FIT3(590)-StatusBarHeight-Botoom_IPhoneX);
        }else{
            make.height.mas_equalTo(ScreenHeight-FIT3(590)-StatusBarHeight-Botoom_IPhoneX);
        }
    }];
    
    if (_propertyCellViewModel.walletType != SZWalletTypeSC) {
        SZPropertyDetailFooterView* footerView=[SZPropertyDetailFooterView new];
        footerView.walletType=_propertyCellViewModel.walletType;
        self.footerView=footerView;
        [self.view addSubview:footerView];
        [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView.mas_bottom);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(FIT2(134)+Botoom_IPhoneX);
        }];
    }
 
    [self showLoadingMBProgressHUD];
    self.viewModel.cellViewModel=self.propertyCellViewModel;
    NSInteger recordType=self.viewModel.currentType;
    NSInteger currentPage=self.viewModel.currentPage;
    if (self.propertyCellViewModel.walletType == SZWalletTypeBB) {
        [self.viewModel requestPropertyRecords:@{@"recordType":@(recordType),@"currentPage":@(currentPage),@"symbol":self.propertyCellViewModel.bbPropertyModel.fvirtualcointypeId}];
    }else if(self.propertyCellViewModel.walletType == SZWalletTypeC2C){
        [self.viewModel requestPropertyRecords:nil];
    }else{
        [self.viewModel requestPropertyRecords:nil];
    }
    [self setActions];
}

-(void)setActions{
    @weakify(self);
    if (self.viewModel.cellViewModel.walletType != SZWalletTypeBB) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self showLoadingMBProgressHUD];
            self.viewModel.currentPage=1;
            [self.viewModel requestPropertyRecords:[NSMutableDictionary new]];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self showLoadingMBProgressHUD];
            [self.viewModel requestPropertyRecords:[NSMutableDictionary new]];
        }];
        self.tableView.footRefreshState =MJFooterRefreshStateNormal;
    }
    
    
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        if ([self.viewModel getPropertyRecordCellNumber] == 0) {
            [self showNoResultView];
        }else{
            [self hideNoResultView];
        }
        [self hideMBProgressHUD];
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self showErrorHUDWithTitle:x];

    }];
    
    [[self.headerView.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.headerView.totalRecordButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        SZPropertyTotalRecordViewController* totalRecordVC=[[SZPropertyTotalRecordViewController alloc]init];
        totalRecordVC.viewModel.cellViewModel=self.propertyCellViewModel;
        [self.navigationController pushViewController:totalRecordVC animated:YES];
    }];
    [[self.footerView.rechargeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.footerView.walletType == SZWalletTypeBB) {
            [self showPromptHUDWithTitle:NSLocalizedString(@"钱包升级，暂时无法充币，敬请谅解",nil)];
            //        SZPropertyRechargeViewController* rechargeVC=[[SZPropertyRechargeViewController alloc]init];
            //        rechargeVC.viewModel.propertyCellViewModel=self.propertyCellViewModel;
            //        [self.navigationController pushViewController:rechargeVC animated:YES];
        }else{
            
            if (![UserInfo sharedUserInfo].isTradePassword) {
                [self showPromptHUDWithTitle:NSLocalizedString(@"请先设置交易密码", nil)];
            }else if ([UserInfo sharedUserInfo].idAuthStatus !=0){//2：未认证、1：待审核、0：已认证
                NSInteger idAuthStatus=[UserInfo sharedUserInfo].idAuthStatus;
                [self showPromptHUDWithTitle:idAuthStatus==1?NSLocalizedString(@"您的身份信息正在审核中请稍后...", nil):NSLocalizedString(@"请先实名认证", nil)];
            }else {
                SZC2CAmountTradeViewController* amountTradeInVC=[[SZC2CAmountTradeViewController alloc]init];
                amountTradeInVC.viewModel.cellViewModel=self.propertyCellViewModel;
                amountTradeInVC.viewModel.amountTradeType=SZC2CAmountTradeTypeIn;
                [self.navigationController pushViewController:amountTradeInVC animated:YES];
            }
            
            
        }


    }];
    [[self.footerView.withdrawBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);

        if (self.footerView.walletType == SZWalletTypeBB) {
            [self showPromptHUDWithTitle:NSLocalizedString(@"钱包升级暂时无法提币，敬请谅解",nil)];

            //        SZPropertyWithdrawViewController*  withdrawVC=[[SZPropertyWithdrawViewController alloc]init];
            //        withdrawVC.viewModel.propertyCellViewModel=self.propertyCellViewModel;
            //        [self.navigationController pushViewController:withdrawVC animated:YES];
        }else{
            
            if (![UserInfo sharedUserInfo].isTradePassword) {
                [self showPromptHUDWithTitle:NSLocalizedString(@"请先设置交易密码", nil)];
            }else if ([UserInfo sharedUserInfo].idAuthStatus !=0){//2：未认证、1：待审核、0：已认证
                NSInteger idAuthStatus=[UserInfo sharedUserInfo].idAuthStatus;
                [self showPromptHUDWithTitle:idAuthStatus==1?NSLocalizedString(@"您的身份信息正在审核中请稍后...", nil):NSLocalizedString(@"请先实名认证", nil)];
            }else {
                SZC2CAmountTradeViewController* amountTradeInVC=[[SZC2CAmountTradeViewController alloc]init];
                amountTradeInVC.viewModel.cellViewModel=self.propertyCellViewModel;
                amountTradeInVC.viewModel.amountTradeType=SZC2CAmountTradeTypeOut;
                [self.navigationController pushViewController:amountTradeInVC animated:YES];
            }
           
        }

    }];
    [[self.footerView.tradebBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        
        if (![UserInfo sharedUserInfo].isTradePassword) {
            [self showPromptHUDWithTitle:NSLocalizedString(@"请先设置交易密码", nil)];
        }else if ([UserInfo sharedUserInfo].idAuthStatus !=0){//2：未认证、1：待审核、0：已认证
            NSInteger idAuthStatus=[UserInfo sharedUserInfo].idAuthStatus;
            [self showPromptHUDWithTitle:idAuthStatus==1?NSLocalizedString(@"您的身份信息正在审核中请稍后...", nil):NSLocalizedString(@"请先实名认证", nil)];
        }else {
            if (self.footerView.walletType == SZWalletTypeBB) {
                [self.tabBarController setSelectedIndex:1];
                [self.navigationController popToRootViewControllerAnimated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"SZPropertyDetailToTradeNotification" object:nil userInfo:nil];
                });
                
            }else{
                [self.tabBarController setSelectedIndex:2];
                [self.navigationController popToRootViewControllerAnimated:YES];

            }
        }
       
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  [self.viewModel getPropertyRecordCellNumber];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.propertyCellViewModel.walletType == SZWalletTypeBB) {
        SZPropertyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:SZPropertyRecordCellReuseIdentifier forIndexPath:indexPath];
        
        SZPropertyRecordCellViewModel* cellViewModel=[self.viewModel recordCellViewModelAtIndexPath:indexPath];
        cell.viewModel=cellViewModel;
        return cell;
    }else if (self.propertyCellViewModel.walletType == SZWalletTypeSC) {
        SZScPropertyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:SZScPropertyRecordCellReuseIdentifier forIndexPath:indexPath];
        
        SZScPropertyRecordCellViewModel* cellViewModel=[self.viewModel recordSzCellViewModelAtIndexPath:indexPath];
        cell.viewModel=cellViewModel;
        return cell;
    }else{
        SZScPropertyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:SZScPropertyRecordCellReuseIdentifier forIndexPath:indexPath];
        
        SZScPropertyRecordCellViewModel* cellViewModel=[self.viewModel recordSzCellViewModelAtIndexPath:indexPath];
        cell.viewModel=cellViewModel;
        return cell;
        
    }
  
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!footView) {
        footView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, footView.height)];
        subFootView.backgroundColor=MainBackgroundColor;
        [footView addSubview:subFootView];
    }
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return FIT3(48);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
