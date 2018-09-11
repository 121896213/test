//
//  MarketHomeSubViewController.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "MarketHomeSubViewController.h"
#import "MarketListTableViewCell.h"
#import "MarketHomeListModel.h"
#import "BaseService.h"
#import <MJRefresh/MJRefresh.h>
#import "MarkDeatilViewController.h"
#import "SelfCollectArrayModel.h"
#import "AddSelfSelectViewController.h"

@interface MarketHomeSubViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UIView * tableHeaderView;
@property (nonatomic,strong) UIView * tableFooterView;//展示自选时可用
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataSource; //数据
@property (nonatomic,assign) NSInteger page;

@end

@implementation MarketHomeSubViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (_isSelfSelect) {
        [self.tableView.mj_header beginRefreshing];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
//    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMarketDataNotifaction:) name:kGetMarketDataNotifaction object:nil];
}

-(void)getMarketDataNotifaction:(NSNotification *)noti{
    @synchronized(self){
        NSDictionary * dict = noti.userInfo;
//        NSInteger stockId = [dict[@"stockId"] integerValue];
        NSInteger stockId = [dict[@"ID"] integerValue];
        for (MarketHomeListModel * model in self.dataSource) {
            if ([model.fCoinType integerValue] == stockId) {
                [model refreshDataWithDict:dict];
                [self.tableView reloadData];
                NSLog(@"%@__%@",model.fCoinType,model.fShortName);
                return;
            }
        }
    };
    
}

-(void)configSubViews
{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(0);
    }];
    __weak typeof(self) weakSelf = self;
    if (_isSelfSelect) {
        self.tableView.tableFooterView = self.tableFooterView;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestLimitData];
        }];
    }else{
        self.tableView.tableFooterView = nil;

        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1;
            [weakSelf requestData];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
        }];
    }

}

-(void)requestData
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/market.do",BaseHttpUrl];
   
    NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [mDict setValue:@(_page) forKey:@"currentPage"];
    [mDict setValue:_areaName forKey:@"fShortName"];
    
//    int typeFid = [_areaName isEqualToString:@"BTC"] ? 1 :([_areaName isEqualToString:@"USDT"] ? 2 :13);
    [mDict setValue:@([_fCoinType integerValue]) forKey:@"typeFid"];
    
    [self showLoadingMBProgressHUD];
    
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager get:urlStr appendParameters:mDict successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (base.currentPage == base.totalPage) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            weakSelf.page = base.currentPage + 1;
        }
        if (base.currentPage == 1) {
            [weakSelf.dataSource removeAllObjects];
        }
        if (!base.errorMessage) {
            NSArray * array = responseObject[@"list"];
            double  quotes = [responseObject[@"quotes"] doubleValue];

            for (NSDictionary * dict in array) {
                MarketHomeListModel * model = [[MarketHomeListModel alloc]init];
                [model mj_setKeyValues:dict];
                model.quotes = quotes;
                model.areaName = weakSelf.areaName;
                [weakSelf.dataSource addObject:model];
            }
            [weakSelf.tableView reloadData];
            [weakSelf orderSocketMessage];

        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

-(void)requestLimitData{
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    NSArray * array = [[SelfCollectArrayModel sharedSelfCollectArrayModel]getCollectDataByMarketType:_fCoinType];

    if (array.count == 0) {
        [self.tableView.mj_header endRefreshing];
        return ;
    }
    NSMutableString * mString = [NSMutableString stringWithString:array[0]];
    for (int i = 1; i < array.count; i++) {
        [mString appendFormat:@",%@",array[i]];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/marketSearch.do",BaseHttpUrl];
    
    NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithCapacity:5];
    [mDict setValue:@(1) forKey:@"currentPage"];
    [mDict setValue:@(1000) forKey:@"pageSize"];
    [mDict setValue:_fCoinType forKey:@"marketType"];
    [mDict setValue:mString forKey:@"searchText"];
    [mDict setValue:@(1) forKey:@"searchType"];
    
    [self showLoadingMBProgressHUD];
    
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager get:urlStr appendParameters:mDict successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        
        
        if (!base.errorMessage) {
            NSArray * array = responseObject[@"data"][@"dataList"];
            double  quotes = [responseObject[@"data"][@"dataBase"][@"quotes"] doubleValue];
            
            for (NSDictionary * dict in array) {
                MarketHomeListModel * model = [[MarketHomeListModel alloc]init];
                [model mj_setKeyValues:dict];
                model.H24Volume = dict[@"h24Volume"];
                model.quotes = quotes;
                model.areaName = weakSelf.areaName;
                [weakSelf.dataSource addObject:model];
            }
            [weakSelf.tableView reloadData];
            [weakSelf orderSocketMessage];
            
        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarketListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMarketListTableViewCellReuseID forIndexPath:indexPath];
    MarketHomeListModel *model = self.dataSource[indexPath.row];
    [cell setMarketModel:model isAddPage:NO];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.tableHeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MarketHomeListModel *model = self.dataSource[indexPath.row];
    MarkDeatilViewController * detailVC = [[MarkDeatilViewController alloc]init];
    detailVC.model = model;
    detailVC.areaName = _areaName;
    detailVC.marketCoinType = _fCoinType;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self orderSocketMessage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self orderSocketMessage];
}

-(void)orderSocketMessage{
    if (self.dataSource.count == 0) {
        return;
    }
    NSMutableString * mString = [NSMutableString string];
    NSArray * array = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath * indexPath in array) {
        if (indexPath.row < self.dataSource.count) {
            MarketHomeListModel * model = self.dataSource[indexPath.row];
            if (mString.length >0) {
                [mString appendFormat:@",%@",model.fCoinType];
            }else{
                [mString appendString:model.fCoinType];
            }
        }
    }
    NSLog(@"%@",mString);
    [[SZSocket sharedSZSocket]orderMessage:mString];
}


#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = WhiteColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"MarketListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kMarketListTableViewCellReuseID];
    }
    return _tableView;
}

-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        _tableHeaderView.backgroundColor = UIColorFromRGB(0xf5f5f5);
        
        UILabel * labelOne = [self createLabelWithText:@"名称/代码"];
        [labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(15);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_tableHeaderView.mas_centerY);
        }];
        UILabel * labelTwo = [self createLabelWithText:@"现价"];
        labelTwo.textAlignment = NSTextAlignmentCenter;
        [labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.trailing.mas_equalTo(-142);
            make.centerY.mas_equalTo(_tableHeaderView.mas_centerY);
        }];
        UILabel * labelThree = [self createLabelWithText:@"涨跌幅"];
        labelThree.textAlignment = NSTextAlignmentCenter;
        [labelThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.trailing.mas_equalTo(-8);
            make.centerY.mas_equalTo(_tableHeaderView.mas_centerY);
            make.height.mas_equalTo(20);
        }];
    }
    return _tableHeaderView;
}

-(UIView *)tableFooterView{
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 143)];
        _tableFooterView.backgroundColor = WhiteColor;
        
        UIButton * addButton = [UIButton new];
        [addButton setImage:kIMAGE_NAMED(@"addMarket") forState:UIControlStateNormal];
        [addButton setTitle:NSLocalizedString(@"添加自选", nil) forState:UIControlStateNormal];
        [addButton setTitleColor:HomeLightColor forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addSelfCollect) forControlEvents:UIControlEventTouchUpInside];
        [_tableFooterView addSubview:addButton];
        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_tableFooterView.mas_centerX);
            make.top.mas_equalTo(30);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(100);
        }];
    }
    return _tableFooterView;
}
-(void)addSelfCollect{
    AddSelfSelectViewController * addVC = [[AddSelfSelectViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}
/**创建label*/
-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel * label = [UILabel new];
    label.text = NSLocalizedString(text, nil);
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    label.textColor = UIColorFromRGB(0x999999);
    [_tableHeaderView addSubview:label];
    return label;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
