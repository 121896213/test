//
//  TradeChoiceCoinView.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "TradeChoiceCoinView.h"

@interface TradeChoiceCoinView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    NSURLSessionDataTask * task;
}

@property (nonatomic,strong)UIView * topMenuView;
@property (nonatomic,strong)UITableView * leftTableView;
@property (nonatomic,strong)UITableView * rightTableView;

@property (nonatomic,strong)UIView * bottomAlphaView;//底部遮罩
@property (nonatomic,strong)UIButton * retryBtn;
@property (nonatomic,strong)NSMutableArray * leftDataSource;
@property (nonatomic,strong)NSMutableArray * rightDataSource;
@property (nonatomic,assign)NSInteger leftSelectIndex;

@property (nonatomic,assign)NSInteger page;

@end

@implementation TradeChoiceCoinView

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.topMenuView];
        [self.topMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.mas_equalTo(0);
            make.height.mas_equalTo(33);
        }];
        [self addSubview:self.leftTableView];
        [self addSubview:self.rightTableView];
        [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.mas_equalTo(0);
            make.width.mas_equalTo(90 * kScale);
            make.top.mas_equalTo(34);

        }];
        [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.bottom.mas_equalTo(0);
            make.leading.mas_equalTo(self.leftTableView.mas_trailing);
            make.top.mas_equalTo(34);
        }];
        _leftSelectIndex = -1;
        __weak typeof(self)weakSelf = self;
        self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1;
            [weakSelf requestRightData];
        }];
        self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestRightData];
        }];
        
        _bottomAlphaView = [UIView new];
        _bottomAlphaView.backgroundColor = UIColorFromRGB(0x0F1523);
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
        [_bottomAlphaView addGestureRecognizer:tap];
        _bottomAlphaView.alpha = 0.7;
    }
    return self;
}

-(void)requestData
{
    if ([SZBase sharedSZBase].areaNameArr.count > 0) {
        self.leftDataSource = [SZBase sharedSZBase].areaNameArr;
        [self refreshRightDataWithLeftIndex:0];
        [self hideRetryButton];
        return;
    }
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/blockCointype.do",BaseHttpUrl];
    [UIViewController showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    
    [SZHTTPSReqManager get:urlStr appendParameters:nil successBlock:^(id responseObject) {
        [UIViewController hideMBProgressHUD];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            NSArray * array = responseObject[@"list"];
            [[SZBase sharedSZBase]dealModelWithArray:array];
            [weakSelf refreshRightDataWithLeftIndex:0];
            [weakSelf hideRetryButton];
        }else{
            [UIViewController showErrorHUDWithTitle:base.errorMessage];
            [weakSelf showRetryButton];
        }
    } failureBlock:^(NSError *error) {
        [UIViewController hideMBProgressHUD];
        [weakSelf showRetryButton];
        
    }];
}

-(void)refreshRightDataWithLeftIndex:(NSInteger)index{

    self.leftTableView.userInteractionEnabled = NO;
    _leftSelectIndex = index;
    [self.leftTableView reloadData];
    [self.rightDataSource removeAllObjects];
    [self.rightTableView reloadData];
    [self.rightTableView.mj_header beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.leftTableView.userInteractionEnabled = YES;

    });
}

-(void)requestRightData
{
    if (task) {
        [task cancel];
    }
    BigAreaModel * areaModel = [SZBase sharedSZBase].areaModelArr[_leftSelectIndex];
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/market.do",BaseHttpUrl];
    
    NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [mDict setValue:@(_page) forKey:@"currentPage"];
    [mDict setValue:areaModel.fShortName forKey:@"fShortName"];
    
    [mDict setValue:@([areaModel.fid integerValue]) forKey:@"typeFid"];
    
    [UIViewController showLoadingMBProgressHUD];
    
    __weak typeof(self) weakSelf = self;
    task = [SZHTTPSReqManager get:urlStr appendParameters:mDict successBlock:^(id responseObject) {
        [UIViewController hideMBProgressHUD];
        [weakSelf.rightTableView.mj_header endRefreshing];
        [weakSelf.rightTableView.mj_footer endRefreshing];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (base.currentPage == base.totalPage) {
            [weakSelf.rightTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            weakSelf.page = base.currentPage + 1;
        }
        if (base.currentPage == 1) {
            [weakSelf.rightDataSource removeAllObjects];
        }
        if (!base.errorMessage) {
            NSArray * array = responseObject[@"list"];
            double  quotes = [responseObject[@"quotes"] doubleValue];
            NSString * area = [self.leftDataSource objectAtIndex:_leftSelectIndex];
            for (NSDictionary * dict in array) {
                MarketHomeListModel * model = [[MarketHomeListModel alloc]init];
                [model mj_setKeyValues:dict];
                model.quotes = quotes;
                model.areaName = area;
                [weakSelf.rightDataSource addObject:model];
            }
            [weakSelf.rightTableView reloadData];
            [weakSelf orderSocketMessage];
        }else{
            [UIViewController showErrorHUDWithTitle:base.errorMessage];
        }
    } failureBlock:^(NSError *error) {
        [UIViewController hideMBProgressHUD];
        [weakSelf.rightTableView.mj_header endRefreshing];
        [weakSelf.rightTableView.mj_footer endRefreshing];
    }];
}

-(void)showRetryButton{
    [self addSubview:self.retryBtn];
    [self bringSubviewToFront:self.retryBtn];
    [self.retryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.leading.mas_greaterThanOrEqualTo(15);
        make.trailing.mas_lessThanOrEqualTo(-15);
        make.height.mas_equalTo(50);
        
    }];
}

-(void)hideRetryButton{
    [self.retryBtn removeFromSuperview];
}

-(UIButton *)retryBtn{
    if (!_retryBtn) {
        _retryBtn = [UIButton new];
        [_retryBtn setTitleColor:MainThemeColor forState:UIControlStateNormal];
        [_retryBtn setTitle:NSLocalizedString(@"网络异常，请点击重试", nil) forState:UIControlStateNormal];
        _retryBtn.titleLabel.font = kFontSize(15);
        [_retryBtn addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryBtn;
}

-(void)showInView:(UIView *)superView{
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(53 + NavigationStatusBarHeight);
        make.leading.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(-120);
    }];
    [self requestData];
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self.bottomAlphaView];
    [self.bottomAlphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        if (iPhoneX) {
//            make.bottom.mas_equalTo(delegate.window.mas_safeAreaLayoutGuideBottom);
            make.height.mas_equalTo(203);
        } else {
            make.height.mas_equalTo(170);
        }
    }];;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMarketDataNotifaction:) name:kGetMarketDataNotifaction object:nil];
}

-(void)getMarketDataNotifaction:(NSNotification *)noti
{
    NSDictionary * dict = noti.userInfo;
    NSInteger stockId = [dict[@"ID"] integerValue];
    for (MarketHomeListModel * model in self.rightDataSource) {
        if ([model.fCoinType integerValue] == stockId) {
            [model refreshDataWithDict:dict];
            [self.rightTableView reloadData];
            return;
        }
    }
}
-(void)removeView{
    if (self.removeBlock) {
        self.removeBlock();
    }
    [self removeSelf];
}
-(void)removeSelf{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.bottomAlphaView removeFromSuperview];
    [self removeFromSuperview];
}


#pragma mark -----TableViewDelegate/DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.leftDataSource.count;
    }
    return self.rightDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"item_left" forIndexPath:indexPath];
        cell.textLabel.text = self.leftDataSource[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.centerX = cell.contentView.centerX;
        if (indexPath.row == _leftSelectIndex) {
            cell.textLabel.textColor =  UIColorFromRGB(0x6188EA);
        }else{
            cell.textLabel.textColor =  UIColorFromRGB(0x666666);
        }
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else{
        TradeChoiceCoinTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTradeChoiceCoinTableViewCellReuseID forIndexPath:indexPath];
        [cell setMarketModel:self.rightDataSource[indexPath.row]];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        if (_leftSelectIndex == indexPath.row) {
            return;
        }
        [self refreshRightDataWithLeftIndex:indexPath.row];
    }else{
        MarketHomeListModel * model = self.rightDataSource[indexPath.row];
        if (self.finishChoiceBlock) {
            self.finishChoiceBlock(model);
        }
        [self removeSelf];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate && scrollView == self.rightTableView) {
        [self orderSocketMessage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.rightTableView) {
        [self orderSocketMessage];
    }
}

-(void)orderSocketMessage{
    if (self.rightDataSource.count == 0) {
        return;
    }
    NSMutableString * mString = [NSMutableString string];
    NSArray * array = [self.rightTableView indexPathsForVisibleRows];
    for (NSIndexPath * indexPath in array) {
        if (indexPath.row < self.rightDataSource.count) {
            MarketHomeListModel * model = self.rightDataSource[indexPath.row];
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


- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = UIColorFromRGB(0xF5F6FA);
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"item_left"];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.backgroundColor = UIColorFromRGB(0xEDF0F5);
        [_rightTableView registerClass:[TradeChoiceCoinTableViewCell class] forCellReuseIdentifier:kTradeChoiceCoinTableViewCellReuseID];
    }
    return _rightTableView;
}

-(UIView *)topMenuView{
    if (!_topMenuView) {
        _topMenuView = [UIView new];
        _topMenuView.backgroundColor = WhiteColor;
        
        UILabel * leftLabel  = [UILabel new];
        leftLabel.text = NSLocalizedString(@"币种", nil);
        leftLabel.textColor = UIColorFromRGB(0x999999);
        leftLabel.font = kFontSize(12);
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [_topMenuView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(0);
            make.centerY.mas_equalTo(_topMenuView.mas_centerY);
            make.width.mas_equalTo(90 * kScale);
        }];
        
        UIView * rightSuperView = [UIView new];
        rightSuperView.backgroundColor = WhiteColor;
        [_topMenuView addSubview:rightSuperView];
        [rightSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(leftLabel.mas_trailing);
            make.top.bottom.trailing.mas_equalTo(0);
        }];
        
        CGFloat margin = 32 * kScale;
        CGFloat width = (kScreenWidth - 90 * kScale - margin - 20)/3;
        
        NSArray * array = @[@"名称",@"现价",@"涨跌幅"];
        for (int i = 0; i < 3; i++) {
            UILabel * label  = [UILabel new];
            label.text = NSLocalizedString(array[i], nil);
            label.textColor = UIColorFromRGB(0x999999);
            label.font = kFontSize(12);

            if (i == 0) {
                label.textAlignment = NSTextAlignmentLeft ;
            }else{
                label.textAlignment = NSTextAlignmentCenter;
            }
            [rightSuperView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(margin + width * i);
                make.centerY.mas_equalTo(rightSuperView.mas_centerY);
                make.width.mas_equalTo(width);
            }];
        }
    }
    return _topMenuView;
}

-(NSMutableArray *)leftDataSource{
    if (!_leftDataSource) {
        _leftDataSource = [NSMutableArray array];
    }
    return _leftDataSource;
}

-(NSMutableArray *)rightDataSource{
    if (!_rightDataSource) {
        _rightDataSource = [NSMutableArray array];
    }
    return _rightDataSource;
}

@end
