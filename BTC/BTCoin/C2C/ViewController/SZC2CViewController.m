//
//  SZC2CViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/7/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CViewController.h"
#import "SZC2CAdViewController.h"
#import "SZC2CTradeCell.h"
#import "SZC2CTradeListViewModel.h"
#import "SZC2CTradeStateViewController.h"
#import "SZC2CTradeViewController.h"
#import "SZC2CHeaderView.h"
#import "SZSelectTradeAreaView.h"
@interface SZC2CViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) SZC2CHeaderView* headerView;

@property (nonatomic,strong) SHSegmentControl* segmentControl;
@property (nonatomic,strong) SZC2CTradeListViewModel* viewModel;

@property (nonatomic,strong) SZSelectTradeAreaView* tradeAreaView;
@end

@implementation SZC2CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleText:NSLocalizedString(@"C2C", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    [self hideLeftBtn];

    SHSegmentControl* segMentControl= [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, 160, 30 ) items:@[@"买入",@"卖出"]];
    segMentControl.titleNormalColor= MainThemeBlueColor;
    segMentControl.titleSelectColor= UIColorFromRGB(0xFFFFFF);
    segMentControl.viewSelectBackgroundColor=MainThemeBlueColor;
    segMentControl.viewNormalBackgroundColor= UIColorFromRGB(0xFFFFFF);
    segMentControl.backgroundColor = NavBarColor;
    [segMentControl setCircleBorderWidth:1 bordColor:MainThemeBlueColor radius:2];
    [segMentControl reloadViews];
    segMentControl.curClick = ^(NSInteger index) {
//        [weakSelf.segTableView setSegmentSelectIndex:index];
        //index用于切换item
    };
    [self.headView addSubview:segMentControl];
    [segMentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headView.mas_centerX);
        make.bottom.mas_equalTo(-7);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(30);

    }];
    segMentControl.curClick = ^(NSInteger index) {
        self.viewModel.tradeType=(SZTradeType)index;
    };
    UIButton* rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, FIT3(120), 44)];
    [rightBtn setImage:[UIImage imageNamed:@"c2c_advertising"] forState:UIControlStateNormal];
    [self setRightBtn:rightBtn];
    @weakify(self);
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.tradeAreaView disMissView];
        [self.tradeAreaView removeFromSuperview];
        SZC2CAdViewController* c2cAdVC=[SZC2CAdViewController new];
        [self.navigationController pushViewController:c2cAdVC animated:YES];

    }];

    [self tableView];
    [[RACSignal combineLatest:@[RACObserve(self.viewModel, areaType),RACObserve(self.viewModel,marketType ),RACObserve(self.viewModel, tradeType),RACObserve(self.viewModel, isOnLine)]] subscribeNext:^(id x) {
        NSLog(@"四个值变了一个哦");
    }];

}
-(SZC2CTradeListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel= [SZC2CTradeListViewModel new];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        SZC2CHeaderView* headerView=[SZC2CHeaderView new];
        [self.view addSubview:headerView];
        self.headerView=headerView;
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(FIT(0));
            make.height.mas_equalTo(FIT(43));
            make.top.mas_equalTo(NavigationStatusBarHeight);
        }];

        @weakify(self);
        [[self.headerView.selectTypeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);

            [self.tradeAreaView disMissView];
            self.tradeAreaView=[[SZSelectTradeAreaView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,FIT(227))];
            [self.tradeAreaView showInView:TheAppDel.window.rootViewController.view directionType:SZPopViewFromDirectionTypeTop];
            RACChannelTo(self.tradeAreaView, tradeMarketType) = RACChannelTo(self.viewModel, marketType);
            RACChannelTo(self.tradeAreaView, tradeAreaType) = RACChannelTo(self.viewModel, areaType);
        }];

        [[self.headerView.filterBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            self.viewModel.isOnLine=((UIButton*)x).isSelected;
            [self.headerView.filterBtn setSelected:!((UIButton*)x).isSelected];

        }];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=MainC2CBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight=FIT(16);
        _tableView.sectionFooterHeight=FIT(0);
        _tableView.rowHeight=SZC2CTradeCellHeight;
        _tableView.estimatedRowHeight=SZC2CTradeCellHeight;
    
        
        [_tableView registerClass:[SZC2CTradeCell class] forCellReuseIdentifier:SZC2CTradeCellReuseIdentifier];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.mas_equalTo(FIT(0));
        }];
    
        
        
        //        @weakify(self);
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //            @strongify(self);
        //            [self showLoadingMBProgressHUD];
        //            self.viewModel.currentPage=1;
        //            [self.viewModel.baseListModel.dataList removeAllObjects];
        //            [self.tableView reloadData];
        //            [self.viewModel getCommissRecor    dList:nil];
        //        }];
        //        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //            @strongify(self);
        //            [self showLoadingMBProgressHUD];
        //            [self.viewModel getCommissRecordList:nil];
        //        }];
        //        _tableView.footRefreshState =MJFooterRefreshStateNormal;
       
        
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZC2CTradeCell *cell = [tableView dequeueReusableCellWithIdentifier:SZC2CTradeCellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.action = ^(id sender) {
        if (indexPath.section%3 ==0) {
            SZC2CTradeViewController* c2cTradeVC=[SZC2CTradeViewController new];
            c2cTradeVC.viewModel.isTradeSell=YES;
            [self.navigationController pushViewController:c2cTradeVC animated:YES];
        }else if(indexPath.section%3 ==1){
            SZC2CTradeViewController* c2cTradeVC=[SZC2CTradeViewController new];
            c2cTradeVC.viewModel.isTradeSell=NO;
            [self.navigationController pushViewController:c2cTradeVC animated:YES];
        }else{
            SZC2CTradeStateViewController* c2cTradeVC=[SZC2CTradeStateViewController new];
            c2cTradeVC.viewModel.isBuyIn=YES;
            c2cTradeVC.viewModel.orderStateType=SZC2COrderStateTypeAppeal;
            [self.navigationController pushViewController:c2cTradeVC animated:YES];
        }
    };
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FIT(16);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!headerView) {
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT(16))];
        subFootView.backgroundColor=MainC2CBackgroundColor;;
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
