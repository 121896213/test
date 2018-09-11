//
//  BusinessRecordViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/4/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "BusinessRecordViewController.h"
#import "EntrustSiftView.h"
#import "RecordNewTableViewCell.h"
#import "EntrustListHeaderView.h"
#import "NSDate+SZDate.h"
#import "BigAreaModel.h"


@interface BusinessRecordViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIView * topSuperView;
    BOOL _isToday;
}
@property (nonatomic,strong)UIButton * rightButton;//导航右键
@property (nonatomic,strong)UIButton * siftButton;//筛选按钮
@property (nonatomic,strong)UILabel * themeLab;//当日委托/历史委托
@property (nonatomic,strong)EntrustSiftView * siftView;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)TradeState tradeState;
@property (nonatomic,assign)NSInteger coinType;
@property (nonatomic,copy)NSString* beginDate;
@property (nonatomic,copy)NSString* endDate;
@property (nonatomic,assign)BOOL isToday;

@end

@implementation BusinessRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isToday = YES;
    [self setTitleText:NSLocalizedString(@"成交记录", nil)];
//[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    [self configSubViews];
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestDataFromNet];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataFromNet];
    }];
    
    
    _page = 1;
    _tradeState = TradeStateAll;
    _coinType = SZCoinTypeUSDT;

    [self requestDataFromNet];
}

-(void)requestDataFromNet
{
//    NSString * urlStr = self.isToday?[NSString stringWithFormat:@"%@/account/dealtoday.do",BaseHttpUrl]:[NSString stringWithFormat:@"%@/account/dealHistory.do",BaseHttpUrl];
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/dealInfo.do",BaseHttpUrl];

//    NSDictionary * dict = self.isToday?@{@"coinType":@(_coinType),@"status":@(_tradeState),@"currentPage":@(_page)}:@{@"coinType":@(_coinType),@"status":@(_tradeState),@"currentPage":@(_page),@"begindate":_beginDate,@"enddate":_endDate};
    
    NSMutableDictionary * paraDict = [NSMutableDictionary dictionary];
    [paraDict setValue:@(_coinType) forKey:@"coinType"];
    [paraDict setValue:@(20) forKey:@"pageCount"];
    [paraDict setValue:@(_page) forKey:@"page"];
    if (!self.isToday) {
        [paraDict setValue:_beginDate forKey:@"begindate"];
        [paraDict setValue:_endDate forKey:@"enddate"];
        [paraDict setValue:@(0) forKey:@"flag"];
    }else{
        [paraDict setValue:@(1) forKey:@"flag"];
    }
    
    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:paraDict bodyParameters:nil successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            NSInteger currentPage = [responseObject[@"data"][@"page"] integerValue];
            NSInteger countPage = [responseObject[@"data"][@"totalPage"] integerValue];

            if (currentPage == countPage) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                weakSelf.page = currentPage + 1;
            }
            if (currentPage == 1) {
                [weakSelf.dataSource removeAllObjects];
            }
            
            NSArray * array = responseObject[@"data"][@"datas"];
            for (NSDictionary * dict in array) {
                RecordDataModel * model = [RecordDataModel new];
                [model setValueWithDictionary:dict andBigArea:[[SZBase sharedSZBase]getAreaNameWithFid:_coinType]];
                [weakSelf.dataSource addObject:model];
            }
            [weakSelf.tableView reloadData];
        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordNewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kRecordNewTableViewCellReuseID forIndexPath:indexPath];
    RecordDataModel * model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    EntrustListHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kEntrustListHeaderViewReuseID];
//    headerView.titlelabel.text = [[SZBase sharedSZBase]getAreaNameWithFid:_coinType];
//    return headerView;
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 184;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return 26;
    return 0.01;

}
//绘制界面
-(void)configSubViews
{
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [_rightButton setTitle:NSLocalizedString(@"历史成交", nil) forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBtn:_rightButton];
    _rightButton.titleLabel.font = kFontSize(12);
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.top.mas_equalTo(StatusBarHeight);
        make.height.mas_equalTo(44);
        make.width.mas_greaterThanOrEqualTo(40);
    }];
    
    topSuperView = [UIView new];
    topSuperView.backgroundColor = [UIColor whiteColor];
    topSuperView.layer.borderWidth = 1.0f;
    topSuperView.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
    [self.view addSubview:topSuperView];
    [topSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    _themeLab = [UILabel new];
    _themeLab.textColor = UIColorFromRGB(0x000000);
    _themeLab.font = kFontSize(15);
    _themeLab.text = NSLocalizedString(@"当日成交", nil);
    [topSuperView addSubview:_themeLab];
    [_themeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(topSuperView);
    }];
    
    _siftButton = [UIButton new];
    [_siftButton setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [_siftButton setTitle:NSLocalizedString(@"筛选", nil) forState:UIControlStateNormal];
    _siftButton.titleLabel.font = kFontSize(14);
    [_siftButton addTarget:self action:@selector(siftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topSuperView addSubview:_siftButton];
    [_siftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.top.bottom.mas_equalTo(topSuperView);
        make.width.mas_equalTo(44);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topSuperView.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(0);
    }];
    [self.tableView reloadData];
}

-(void)rightButtonClick:(UIButton *)button
{
    _isToday = !_isToday;
    [button setTitle: _isToday ? NSLocalizedString(@"历史成交", nil) :NSLocalizedString(@"当日成交", nil) forState:UIControlStateNormal];
    _themeLab.text = _isToday ? NSLocalizedString(@"当日成交", nil):NSLocalizedString(@"历史成交", nil);
    [_siftView removeFromSuperview];
    _siftView = nil;
    
    
    _beginDate = [NSDate getTheFirstDayOfThisMonth];
    _endDate = [NSDate getTodayString];
    _coinType=SZCoinTypeUSDT;
    _tradeState=TradeStateAll;
    [self.tableView reloadData];
    [self.tableView.mj_header beginRefreshing];
}

-(void)siftButtonClick:(UIButton *)button{
    if (_siftView.superview) {
        [_siftView removeFromSuperview];
    }else{
        [self.view addSubview:self.siftView];
        [self.siftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topSuperView.mas_bottom);
            make.leading.trailing.bottom.mas_equalTo(self.view);
        }];
    }
}

-(EntrustSiftView *)siftView
{
    if (!_siftView) {
        _siftView =[[EntrustSiftView alloc]initWithSiftType:_isToday ? EntrustSiftTypeRecordToday : EntrustSiftTypeHistory];
        __weak typeof(self)weakSelf = self;
        _siftView.finishSiftBlock = ^(NSDictionary *dict) {
            NSLog(@"%@",dict);
            if (weakSelf.isToday) {
                weakSelf.coinType=[dict[@"coinType"] integerValue];
                weakSelf.tradeState=[dict[@"status"] integerValue];
            }else{
                weakSelf.beginDate=dict[@"begindate"];
                weakSelf.endDate=dict[@"enddate"];
                weakSelf.coinType=[dict[@"coinType"] integerValue];
                
            }
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header beginRefreshing];
        };
    }
    return _siftView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"RecordNewTableViewCell" bundle:nil] forCellReuseIdentifier:kRecordNewTableViewCellReuseID];
        [_tableView registerClass:[EntrustListHeaderView class] forHeaderFooterViewReuseIdentifier:kEntrustListHeaderViewReuseID];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
