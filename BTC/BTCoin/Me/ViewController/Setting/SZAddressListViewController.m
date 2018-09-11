//
//  SZWithdrawAddressListViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZAddressListViewController.h"
#import "SZWithdrawAddressCell.h"
#import "SZAddressDetailViewController.h"
#import "SZAddressListViewModel.h"
#import "SZAddressListCellViewModel.h"
@interface SZAddressListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,copy)  NSArray* currentData;
@property (nonatomic,strong) SZAddressListViewModel* viewModel;
@end

@implementation SZAddressListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setSubviews];
    }
    return self;
}

-(SZAddressListViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZAddressListViewModel new];
    }
    return _viewModel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)setSubviews{

    self.currentData=[[NSArray alloc]init];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight-NavigationStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[SZWithdrawAddressCell class] forCellReuseIdentifier:SZWithdrawAddressCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight=FIT(60);
    [self.view addSubview:self.tableView];

    [self setTitleText:NSLocalizedString(@"提币地址", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self hideMBProgressHUD];
        [self.tableView reloadData];
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];
    
    [self showLoadingMBProgressHUD];
    [self.viewModel getAddressList:nil];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.addressListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZWithdrawAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:SZWithdrawAddressCellReuseIdentifier forIndexPath:indexPath];

//    if (indexPath.row%2 == 1) {
//        cell.backgroundColor=MainBackgroundColor;
//    }else if (indexPath.row%2 ==0){
//        cell.backgroundColor=[UIColor whiteColor];
//    }
    
    SZAddressListCellViewModel* cellViewModel= [self.viewModel addressListCellViewModelAtIndexPath:indexPath];
    cell.viewModel=cellViewModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SZAddressListCellViewModel* cellViewModel= [self.viewModel addressListCellViewModelAtIndexPath:indexPath];
//
    SZAddressDetailViewController* szAddressDetailVC=[[SZAddressDetailViewController alloc]initWithCoinCellViewModel:cellViewModel];
    [self.navigationController pushViewController:szAddressDetailVC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
