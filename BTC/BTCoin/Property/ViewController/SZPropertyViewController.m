//
//  SZPropertyViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyViewController.h"
#import "SZBbPropertyCell.h"
#import "SZPropertyHeaderView.h"
#import "SZPropertyDetailViewController.h"
#import "LoginViewController.h"
#import "SZPropertyViewModel.h"
#import "SZPersonCenterViewModel.h"

#import "SZScPropertyCell.h"
@interface SZPropertyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,copy)  NSArray* currentData;
@property (nonatomic,strong) SZPropertyViewModel* propertyViewModel;
@property (nonatomic,strong) SZPersonCenterViewModel* personCenterViewModel;
@property (nonatomic,strong) SZPropertyHeaderView* headerView;

@end

@implementation SZPropertyViewController

- (instancetype)initWithWalletModel:(SZWalletModel*) walletModel
{
    self = [super init];
    if (self) {
        self.propertyViewModel.walletType=(SZWalletType)walletModel.assetsType;
        self.propertyViewModel.walletModel=walletModel;
        [self setSubViews];
    }
    return self;
}

- (SZPropertyViewModel *)propertyViewModel{
   
    if (!_propertyViewModel) {
        _propertyViewModel= [SZPropertyViewModel new];
    }
    return _propertyViewModel;
}
-(SZPersonCenterViewModel *)personCenterViewModel{
    
    if (!_personCenterViewModel) {
        _personCenterViewModel= [SZPersonCenterViewModel new];
    }
    return _personCenterViewModel;
    
}


-(void)setSubViews{
    
    self.currentData=[[NSArray alloc]init];
    
    SZPropertyHeaderView* headerView=[[SZPropertyHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, FIT3(480)+NaviBarHeight)];
    headerView.walletModel=self.propertyViewModel.walletModel;
    self.headerView=headerView;
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(480)+NaviBarHeight);
    }];
    
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.estimatedRowHeight=[self.propertyViewModel getPropertyCellHeight];
    self.tableView.backgroundColor=MainBackgroundColor;
    [self.tableView registerClass:[SZBbPropertyCell class] forCellReuseIdentifier:SZBbPropertyCellReuseIdentifier];
    [self.tableView registerClass:[SZScPropertyCell class] forCellReuseIdentifier:SZScPropertyCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(FIT(0));
        make.top.equalTo(self.headerView.mas_bottom);
    }];

    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self showLoadingMBProgressHUD];
        self.propertyViewModel.currentPage=1;
        [self.propertyViewModel getPropertyListWithParameters:[NSMutableDictionary new]];
    }];
    if (self.propertyViewModel.walletType != SZWalletTypeBB) {

        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self showLoadingMBProgressHUD];
            [self.propertyViewModel getPropertyListWithParameters:[NSMutableDictionary new]];
        }];
        self.tableView.footRefreshState =MJFooterRefreshStateNormal;
    }

    
    NSLog(@"showLoadingMBProgressHUD");
    [self showLoadingMBProgressHUD];
    [self.propertyViewModel getPropertyListWithParameters:[NSMutableDictionary new]];
    //    [self.personCenterViewModel getSecurityInfo:nil];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    [self.propertyViewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        [self hideMBProgressHUD];
        if ([self.propertyViewModel getPropertyCellNumber] == 0) {
            [self showNoResultView];
        }else{
            [self hideNoResultView];
        }
        NSLog(@"hideMBProgressHUD");

    }];
    [self.propertyViewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self showErrorHUDWithTitle:x];

    }];

    [self.personCenterViewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self hideMBProgressHUD];
    }];
    [self.personCenterViewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];
    [[self.headerView.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    

    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.headView setHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.headView setHidden:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.propertyViewModel getPropertyCellHeight];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.propertyViewModel getPropertyCellNumber];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.propertyViewModel.walletType == SZWalletTypeBB) {
        SZBbPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:SZBbPropertyCellReuseIdentifier forIndexPath:indexPath];
        SZPropertyCellViewModel* cellViewModel= [self.propertyViewModel propertyCellViewModelAtIndexPath:indexPath];
        cell.viewModel=cellViewModel; 
        return cell;
        
    }
    else if (self.propertyViewModel.walletType == SZWalletTypeSC) {
        SZScPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:SZScPropertyCellReuseIdentifier forIndexPath:indexPath];
        SZPropertyCellViewModel* cellViewModel= [self.propertyViewModel propertyCellViewModelAtIndexPath:indexPath];
        cell.viewModel=cellViewModel;
        
        return cell;

    }else{
        SZBbPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:SZBbPropertyCellReuseIdentifier forIndexPath:indexPath];
        SZPropertyCellViewModel* cellViewModel= [self.propertyViewModel propertyCellViewModelAtIndexPath:indexPath];
        cell.viewModel=cellViewModel;
        return cell;
        
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!footView) {
        footView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT3(48))];
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
    
    SZPropertyCellViewModel* cellViewModel= [self.propertyViewModel propertyCellViewModelAtIndexPath:indexPath];
    cellViewModel.walletType=self.propertyViewModel.walletType;
    SZPropertyDetailViewController* szPropertyDetailVC=[[SZPropertyDetailViewController alloc]init];
    szPropertyDetailVC.propertyCellViewModel=cellViewModel;
    
    [self.navigationController pushViewController:szPropertyDetailVC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
