//
//  SZMineRecommendViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZMineRecommendViewController.h"
#import "SZMineRecommendHeadView.h"
#import "SZMineRecommendCell.h"
#import "SZMineRecommendViewModel.h"
@interface SZMineRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) SZMineRecommendHeadView* mineRecommendHeaderView;
@property (nonatomic,strong) SZMineRecommendViewModel* viewModel;
@end

@implementation SZMineRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"我的推荐", nil)];
    [self.view addSubview: [self tableHeaderView]];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MainBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight=FIT3(48);
    self.tableView.sectionFooterHeight=FIT3(0);
    self.tableView.rowHeight=SZMineRecommendCelllHight;
    self.tableView.estimatedRowHeight=150.0f;

    [self.tableView registerClass:[SZMineRecommendCell class] forCellReuseIdentifier:SZMineRecommendCellReuseIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([self tableHeaderView].mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self showLoadingMBProgressHUD];
        self.viewModel.currentPage=1;
        [self.viewModel getMineRecommendList:[NSMutableDictionary new]];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self showLoadingMBProgressHUD];
        [self.viewModel getMineRecommendList:[NSMutableDictionary new]];
        
    }];
    self.tableView.footRefreshState =MJFooterRefreshStateNormal;

    [self.viewModel getMineRecommendList:nil];

    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.tableHeaderView.listModel=self.viewModel.baseListModel;
        if (self.viewModel.baseListModel.dataList.count == 0) {
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
   

 
}
- (SZMineRecommendViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZMineRecommendViewModel new];
     
    }
    return _viewModel;
    
}

- (SZMineRecommendHeadView *)tableHeaderView {
    
    if (!_mineRecommendHeaderView) {
        _mineRecommendHeaderView = [[SZMineRecommendHeadView alloc] initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, FIT3(219))];
   
    }
    return _mineRecommendHeaderView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.viewModel.baseListModel.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    SZMineRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:SZMineRecommendCellReuseIdentifier forIndexPath:indexPath];
    
    SZMineRecommendCellViewModel* cellViewModel=[self.viewModel mineRecommendCellViewModellAtIndexPath:indexPath];
    cell.viewModel=cellViewModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FIT3(48);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!headerView) {
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, headerView.height)];
        subFootView.backgroundColor=MainBackgroundColor;
        [headerView addSubview:subFootView];
    }
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
