//
//  SZCommissionRecordViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZCommissionRecordViewController.h"
#import "SZCommissionRecordHeadView.h"
#import "SZCommissRecordCell.h"
#import "SZCommissionRecordViewModel.h"
@interface SZCommissionRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) SZCommissionRecordHeadView* commissRecordHeaderView;
@property (nonatomic,strong) SZCommissionRecordViewModel* viewModel;

@end

@implementation SZCommissionRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.commissRecordHeaderView];
    [self tableView];
    
    
    
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [_tableView reloadData];
        self.commissRecordHeaderView.listModel=self.viewModel.baseListModel;
        [self hideMBProgressHUD];
        if (self.viewModel.baseListModel.dataList.count == 0) {
            [self showNoResultView];
        }else{
            [self hideNoResultView];
        }
    }];
    
    
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self showErrorHUDWithTitle:x];

    }];
  
    
    [self.viewModel getCommissRecordList:nil];

}

- (SZCommissionRecordViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZCommissionRecordViewModel new];
    }
    return _viewModel;
    
}
- (UITableView *)tableView {
    if (!_tableView) {

        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MainBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight=FIT3(48);
        _tableView.sectionFooterHeight=FIT3(0);
        _tableView.rowHeight=SZCommissRecordCelllHight;
        _tableView.estimatedRowHeight=150.0f;

        [_tableView registerClass:[SZCommissRecordCell class] forCellReuseIdentifier:SZCommissRecordCellReuseIdentifier];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commissRecordHeaderView.mas_bottom);
            make.leading.trailing.equalTo(self.view);
            make.bottom.mas_equalTo(0);
        }];
        @weakify(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self showLoadingMBProgressHUD];
            self.viewModel.currentPage=1;
            [self.viewModel.baseListModel.dataList removeAllObjects];
            [self.tableView reloadData];
            [self.viewModel getCommissRecordList:nil];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self showLoadingMBProgressHUD];
            [self.viewModel getCommissRecordList:nil];
        }];
        _tableView.footRefreshState =MJFooterRefreshStateNormal;

    }
    return _tableView;
}
- (SZCommissionRecordHeadView *)commissRecordHeaderView {
    if (!_commissRecordHeaderView) {
        _commissRecordHeaderView = [[SZCommissionRecordHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT3(813))];
        @weakify(self);
        [[_commissRecordHeaderView.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            
            
            NSString* beginDate=_commissRecordHeaderView.beginDateButton.titleLabel.text;
            NSString* endDate=_commissRecordHeaderView.endDateButton.titleLabel.text;
            if ([beginDate compare:endDate] == NSOrderedDescending) {
                [self showPromptHUDWithTitle:NSLocalizedString(@"截止日期小于起始日期", nil)];
                return ;
            }
            [self showLoadingMBProgressHUD];
            self.viewModel.currentPage=1;
            [self.viewModel.baseListModel.dataList removeAllObjects];
            [self.tableView reloadData];
            [self.viewModel getCommissRecordList:@{@"startTime":beginDate,@"endTime":endDate}];

            
        }];
    }
    return _commissRecordHeaderView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.viewModel.baseListModel.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZCommissRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:SZCommissRecordCellReuseIdentifier forIndexPath:indexPath];
    
    SZCommissionRecordCellViewModel* cellViewModel=[self.viewModel commissionRecordCellViewModellAtIndexPath:indexPath];
    cell.viewModel=cellViewModel;
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return FIT3(813)+FIT3(48);
//    }else{
        return FIT3(48);
//    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    if (section == 0) {
//        static NSString *reuseId = @"sectionHeader0";
//        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
//        if (!headerView) {
//            headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
//            [headerView addSubview:self.commissRecordHeaderView];
//            UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, self.commissRecordHeaderView.frameMaxY, ScreenWidth, FIT3(48))];
//            subFootView.backgroundColor=MainBackgroundColor;
//            [headerView addSubview:subFootView];
//        }
//        self.commissRecordHeaderView.listModel=self.viewModel.baseListModel;
//        return headerView;
//    }else{
        static NSString *reuseId = @"sectionHeader";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
        if (!headerView) {
            headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
            UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, headerView.height)];
            subFootView.backgroundColor=MainBackgroundColor;
            [headerView addSubview:subFootView];
        }
        return headerView;
        
//    }
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
