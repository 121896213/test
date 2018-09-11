//
//  SZPurchaseRecordViewController.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/6.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPurchaseRecordViewController.h"
#import "ApplyRecordTableViewCell.h"
#import "AddStoreViewController.h"

@interface SZPurchaseRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource_apply;
@property (nonatomic,assign)NSInteger page_apply;
@end

@implementation SZPurchaseRecordViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"申购记录", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page_apply = 1;
        [weakSelf requestApplyDataFromNet];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [weakSelf requestApplyDataFromNet];
    }];
    self.tableView.footRefreshState =MJFooterRefreshStateNormal;

    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = MainBackgroundColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationStatusBarHeight);
        make.leading.trailing.bottom.mas_equalTo(0);
    }];
}

-(void)requestApplyDataFromNet
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/lock/qryLockOrderList.do",BaseHttpUrl];
    
    NSDictionary * dict = @{@"currentNumber":@(20),
                            @"currentPage":@(_page_apply)};
    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:dict bodyParameters:nil successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            
            if (weakSelf.page_apply == 1) {
                [weakSelf.dataSource_apply removeAllObjects];
            }
            
            NSArray * array = responseObject[@"data"][@"list"];
            NSInteger maxCount = [responseObject[@"data"][@"total"] integerValue];
            for (NSDictionary * dict in array) {
                ApplyDataModel * model = [ApplyDataModel new];
                [model mj_setKeyValues:dict];
                [model dealDataWithDictionary:dict];
                [weakSelf.dataSource_apply addObject:model];
            }
            [weakSelf.tableView reloadData];
            if (weakSelf.dataSource_apply.count  == maxCount) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                weakSelf.page_apply = weakSelf.dataSource_apply.count / 20 +1;
            }
            
        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
        }
        
        
        if (weakSelf.dataSource_apply.count == 0) {
            [weakSelf showNoResultView];
        }else{
            [weakSelf hideNoResultView];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource_apply.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ApplyRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kApplyRecordTableViewCellResueID forIndexPath:indexPath];
    ApplyDataModel * model = self.dataSource_apply[indexPath.row];
    [cell setCellWithModel:model];
    __weak typeof(self)weakSelf = self;
    cell.addStoreBlock = ^{
        AddStoreViewController * addVC = [[AddStoreViewController alloc]init];
        addVC.model = model;
        [weakSelf.navigationController pushViewController:addVC animated:YES];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 254;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"ApplyRecordTableViewCell" bundle:nil] forCellReuseIdentifier:kApplyRecordTableViewCellResueID];
    }
    return _tableView;
}
-(NSMutableArray *)dataSource_apply{
    if (!_dataSource_apply) {
        _dataSource_apply = [NSMutableArray array];
    }
    return _dataSource_apply;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
