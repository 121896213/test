//
//  SZPromotionRecordViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPromotionRecordViewController.h"
#import "SZPromotionRecordHeadView.h"
#import "SZPromotionRecordCell.h"
#import "SZPromotionRecordViewModel.h"
#import "SZSelectCoinTypeView.h"
@interface SZPromotionRecordViewController ()<UITableViewDelegate,UITableViewDataSource,SZSelectCoinTypeDelegate>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) SZPromotionRecordHeadView* promotionRecordHeaderView;
@property (nonatomic,strong) SZPromotionRecordViewModel* viewModel;

@end

@implementation SZPromotionRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self.viewModel getPromotionRecordList:nil];
    
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        self.promotionRecordHeaderView.listModel=self.viewModel.baseListModel;
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
}

- (SZPromotionRecordViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZPromotionRecordViewModel new];
    }
    return _viewModel;
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        [self.view addSubview:self.promotionRecordHeadView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MainBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight=FIT3(48);
        _tableView.sectionFooterHeight=FIT3(0);
        _tableView.rowHeight=SZPromotionRecordCelllHight;
        _tableView.estimatedRowHeight=150.0f;

        [_tableView registerClass:[SZPromotionRecordCell class] forCellReuseIdentifier:SZPromotionRecordCellReuseIdentifier];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.promotionRecordHeadView.mas_bottom);
            make.leading.trailing.equalTo(self.view);
            make.height.mas_equalTo(ScreenHeight-self.promotionRecordHeaderView.frameMaxY-NavigationStatusBarHeight-40.0f);
        }];
        

        @weakify(self);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self showLoadingMBProgressHUD];
            self.viewModel.currentPage=1;
            [self.viewModel getPromotionRecordList:nil];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self showLoadingMBProgressHUD];
            [self.viewModel getPromotionRecordList:nil];
        }];
        self.tableView.footRefreshState =MJFooterRefreshStateNormal;
    }
    return _tableView;
}


- (SZPromotionRecordHeadView *)promotionRecordHeadView {
    if (!_promotionRecordHeaderView) {
        _promotionRecordHeaderView = [[SZPromotionRecordHeadView alloc] initWithFrame:CGRectMake(0, FIT3(48), ScreenWidth, FIT3(183))];
        @weakify(self);
        [[_promotionRecordHeaderView.selectCoinTypeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            if (self.viewModel.baseListModel.coinList.count > 0) {
                
                NSMutableArray* coinsList=[[NSMutableArray alloc]initWithArray:self.viewModel.baseListModel.coinList];
                [coinsList insertObject:@"ALL" atIndex:0];
             
                NSInteger lineNumber=coinsList.count;
                if (lineNumber%4==0) {
                    lineNumber=lineNumber/4;
                }else{
                    lineNumber=lineNumber/4+1;
                }
                SZSelectCoinTypeView* coinTypeView=[[SZSelectCoinTypeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-FIT(32), lineNumber*FIT(60))];
                coinTypeView.delegate=self;
                [coinTypeView showInView:TheAppDel.window.rootViewController.view directionType:SZPopViewFromDirectionTypeCenter];
                coinTypeView.dataList=coinsList;
            }
            
        }];
    }
    return _promotionRecordHeaderView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.viewModel.baseListModel.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZPromotionRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:SZPromotionRecordCellReuseIdentifier forIndexPath:indexPath];
    
    SZPromotionRecordCellViewModel* cellViewModel=[self.viewModel promotionRecordCellViewModellAtIndexPath:indexPath];
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

-(void)selectCoinType:(SZSelectCoinTypeView *)View coinType:(NSString *)coinType{
    
    [self showLoadingMBProgressHUD];
    [self.promotionRecordHeaderView.selectCoinTypeBtn setTitle:coinType forState:UIControlStateNormal];

    if ([coinType isEqualToString:@"ALL"]) {
        coinType=@"";
    }
    self.viewModel.currentPage=1;
    [self.viewModel getPromotionRecordList:@{@"virtualCurrency":coinType}];
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
