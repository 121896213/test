//
//  SZWalletViewController.m
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWalletViewController.h"
#import "SZWalletViewCell.h"
#import "SZPropertyViewController.h"
#import "LoginViewController.h"
#import "SZPropertyHeaderView.h"
#import "SZWalletViewModel.h"
@interface SZWalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,copy)  NSArray* currentData;
@property (nonatomic,strong)  SZPropertyHeaderView* headerView;
@property (nonatomic,strong)  SZWalletViewModel* viewModel;

@end

@implementation SZWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"钱包", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    [self hideLeftBtn];
    self.currentData=@[NSLocalizedString(@"C2C账户", nil),NSLocalizedString(@"币币账户", nil),NSLocalizedString(@"锁仓账户", nil)];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-TabBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=MainBackgroundColor;
    self.tableView.rowHeight =SZWalletViewCellHeight;
    [self.tableView registerClass:[SZWalletViewCell class] forCellReuseIdentifier:SZWalletViewCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    SZPropertyHeaderView* headerView=[[SZPropertyHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, FIT3(480)+NaviBarHeight)];
    self.headerView=headerView;
    [self.tableView setTableHeaderView:headerView];
    [self.view addSubview:self.tableView];
    
    
    
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        [self hideMBProgressHUD];
        self.headerView.walletListModel=self.viewModel.listModel;
        
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];
    }];
}
-(SZWalletViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel=[SZWalletViewModel new];
        return _viewModel;
    }
    return _viewModel;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZWalletViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SZWalletViewCellReuseIdentifier forIndexPath:indexPath];
    [cell setCellContent:indexPath];
    if (self.viewModel.listModel.dataList.count) {
        SZWalletCellViewModel* cellViewModel= [self.viewModel walletCellAtIndexPath:indexPath];
        cell.viewModel=cellViewModel;
    }
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SZWalletCellViewModel* cellViewModel= [self.viewModel walletCellAtIndexPath:indexPath];

    if (![UserInfo isLogin]) {
        LoginViewController* loginVC=[[LoginViewController alloc]init];
        GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNav animated:YES completion:^{
            
        }];
    }else{
        SZPropertyViewController *propertyVC=[[SZPropertyViewController alloc]initWithWalletModel:cellViewModel.walletModel];
        [self.navigationController pushViewController:propertyVC animated:YES];

    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.headView setHidden:YES];
    
    if ([UserInfo isLogin]) {
        [self.viewModel getWalletListWithParameters:nil];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.headView setHidden:NO];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //图片高度
    CGFloat imageHeight = self.headerView.frame.size.height;
    //图片宽度
    CGFloat imageWidth = kScreenWidth;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;//上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        self.headerView.backgroundImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
