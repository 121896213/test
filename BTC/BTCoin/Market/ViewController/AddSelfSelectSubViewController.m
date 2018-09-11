//
//  AddSelfSelectSubViewController.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "AddSelfSelectSubViewController.h"
#import "MarketListTableViewCell.h"
#import "MarketHomeListModel.h"
#import "BaseService.h"
#import <MJRefresh/MJRefresh.h>
#import "SelfCollectArrayModel.h"

@interface AddSelfSelectSubViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>{
    UITextField * search;
}

@property (nonatomic,strong) UIView * tableHeaderView;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataSource; //数据

@end

@implementation AddSelfSelectSubViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [search becomeFirstResponder];
//}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [search resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMarketDataNotifaction:) name:kGetMarketDataNotifaction object:nil];
}

-(void)getMarketDataNotifaction:(NSNotification *)noti
{
    @synchronized(self){
        NSDictionary * dict = noti.userInfo;
        NSInteger stockId = [dict[@"ID"] integerValue];
        for (MarketHomeListModel * model in self.dataSource) {
            if ([model.fCoinType integerValue] == stockId) {
                [model refreshDataWithDict:dict];
                [self.tableView reloadData];
                return;
            }
        }
    };
}

-(void)configSubViews
{
    self.view.backgroundColor = WhiteColor;
    
    search = [[UITextField alloc]init];
    search.backgroundColor = UIColorFromRGB(0xf5f5f5);
//    search.layer.borderWidth = 0.5f;
    search.layer.cornerRadius = 3.0f;
//    search.layer.borderColor = UIColorFromRGB(0xB4BDD3).CGColor;
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image = kIMAGE_NAMED(@"search");
    [leftView addSubview:imageView];
    search.leftView = leftView;
    search.leftViewMode = UITextFieldViewModeAlways;
    search.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜  索" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x838A9A),NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:16]}];
    search.returnKeyType = UIReturnKeySearch;
    search.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    search.delegate = self;
    [self.view addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.leading.mas_equalTo(16);
        make.trailing.mas_equalTo(-16);
        make.height.mas_equalTo(40);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(58);
    }];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        [self requestData];
        [self.view endEditing:YES];
        return YES;
    }else{
        [self showErrorHUDWithTitle:@"请先输入搜索条件"];
        return NO;
    }
}

-(void)requestData
{
    if (search.text.length == 0) {
        [self.tableView.mj_header endRefreshing];
        return ;
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/marketSearch.do",BaseHttpUrl];

    NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [mDict setValue:@(1) forKey:@"currentPage"];
    [mDict setValue:@(1000) forKey:@"pageSize"];
    [mDict setValue:_fCoinType forKey:@"marketType"];
    [mDict setValue:search.text forKey:@"searchText"];
    [mDict setValue:@(2) forKey:@"searchType"];
    
    [self showLoadingMBProgressHUD];
    
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager get:urlStr appendParameters:mDict successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        BaseModel * base = [BaseModel modelWithJson:responseObject];

        [weakSelf.dataSource removeAllObjects];
        
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
            [weakSelf dealData];
            
        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

-(void)dealData{
    NSArray * array = [[SelfCollectArrayModel sharedSelfCollectArrayModel]getCollectDataByMarketType:_fCoinType];
    for (MarketHomeListModel * model in self.dataSource) {
        if ([array containsObject:model.fShortName]) {
            model.isHaveSelected = YES;
        }else{
            model.isHaveSelected = NO;
        }
    }
    [self.tableView reloadData];
    [self orderSocketMessage];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarketListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMarketListTableViewCellReuseID forIndexPath:indexPath];
    MarketHomeListModel *model = self.dataSource[indexPath.row];
    [cell setMarketModel:model isAddPage:YES];
    __weak typeof(self)weakSelf = self;
    cell.addCollectBlock = ^(NSString *name) {
        [[SelfCollectArrayModel sharedSelfCollectArrayModel]addCoin:name andMarketType:_fCoinType];
        [weakSelf dealData];
    };
    cell.removeCollectBlock = ^(NSString *name) {
        [[SelfCollectArrayModel sharedSelfCollectArrayModel]deleteDataSourceIndex:@[name] inMarketType:_fCoinType];
        [weakSelf dealData];
    };
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
//    MarketHomeListModel *model = self.dataSource[indexPath.row];
//    MarkDeatilViewController * detailVC = [[MarkDeatilViewController alloc]init];
//    detailVC.model = model;
//    detailVC.areaName = _areaName;
//    [self.navigationController pushViewController:detailVC animated:YES];
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
            make.leading.mas_equalTo(33);
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
        UILabel * labelThree = [self createLabelWithText:@"添加"];
        labelThree.textAlignment = NSTextAlignmentRight;
        [labelThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-17);
            make.centerY.mas_equalTo(_tableHeaderView.mas_centerY);
            make.height.mas_equalTo(20);
        }];
    }
    return _tableHeaderView;
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

@end
