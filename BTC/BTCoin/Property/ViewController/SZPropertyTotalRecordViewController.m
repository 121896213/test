//
//  SZPropertyTotalRecordViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyTotalRecordViewController.h"
#import "SZPropertyRecordCell.h"
#import "SZPropertyRecordHeaderView.h"

#import <FSActionSheet/FSActionSheet.h>
@interface SZPropertyTotalRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIButton* backButton;
@property (strong,nonatomic) UIButton* totalButton;
@property (strong,nonatomic) UILabel* allLabel;
@property (strong,nonatomic) UIImageView* allImageView;
@property (strong,nonatomic) UITableView* tableView;

@end

@implementation SZPropertyTotalRecordViewController
-(SZPropertyDetailViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZPropertyDetailViewModel new];
        _viewModel.recordsArr=[NSMutableArray new];
        _viewModel.currentPage=1;
        _viewModel.currentType=0;
    }
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleText:NSLocalizedString(@"财务历史记录", nil)];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    UIButton* rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, FIT3(180), 44)];
    [rightBtn setTitle:@"全部" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:FIT(15.0)];
    self.totalButton=rightBtn;
    [self setRightBtn:rightBtn];
    

    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationStatusBarHeight, kScreenWidth, kScreenHeight-NavigationStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=SZPropertyRecordCellHeight;
    self.tableView.estimatedRowHeight=150.0f;
    self.tableView.backgroundColor=MainBackgroundColor;
    [self.tableView registerClass:[SZPropertyRecordCell class] forCellReuseIdentifier:SZPropertyRecordCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(NavigationStatusBarHeight);
        make.width.mas_equalTo(ScreenWidth);
        make.bottom.mas_equalTo(0);
    }];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self showLoadingMBProgressHUD];
        [self.tableView.mj_header beginRefreshing];
        self.viewModel.currentPage=1;
        [self.viewModel requestPropertyRecords:@{@"recordType":@(self.viewModel.currentType),@"currentPage":@(self.viewModel.currentPage),@"symbol":self.viewModel.cellViewModel.bbPropertyModel.fvirtualcointypeId}];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self showLoadingMBProgressHUD];
        [self.tableView.mj_footer beginRefreshing];
        [self.viewModel requestPropertyRecords:@{@"recordType":@(self.viewModel.currentType),@"currentPage":@(self.viewModel.currentPage),@"symbol":self.viewModel.cellViewModel.bbPropertyModel.fvirtualcointypeId}];
        
    }];
    self.tableView.footRefreshState =MJFooterRefreshStateNormal;

    [self setActions];
    [self showLoadingMBProgressHUD];
   
    [self.viewModel requestPropertyRecords:@{@"recordType":@(self.viewModel.currentType),@"currentPage":@(self.viewModel.currentPage),@"symbol":self.viewModel.cellViewModel.bbPropertyModel.fvirtualcointypeId}];
    
}

-(void)setActions{
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        [self.tableView reloadData];
        if (self.viewModel.recordsArr.count == 0) {
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
    

    [[self.totalButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSMutableArray *actionSheetItems = [@[FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"全部", nil) ),                           FSActionSheetTitleItemMake(FSActionSheetTypeNormal,NSLocalizedString(@"充币", nil)),
                                              FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"提币", nil)),
                                              FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"转入", nil)),
                                              FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"转出", nil))]
                                            mutableCopy];
        FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:nil cancelTitle:NSLocalizedString(@"关闭", nil) items:actionSheetItems];
        actionSheet.contentAlignment = FSContentAlignmentCenter;
        // 展示并绑定选择回调
        [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
            FSActionSheetItem *item = actionSheetItems[selectedIndex];
            [self.totalButton setTitle:item.title forState:UIControlStateNormal];
            [self showLoadingMBProgressHUD];
            [self.viewModel requestPropertyRecords:@{@"recordType":@(selectedIndex),@"currentPage":@(1),@"symbol":self.viewModel.cellViewModel.bbPropertyModel.fvirtualcointypeId}];
        }];
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.viewModel.recordsArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZPropertyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:SZPropertyRecordCellReuseIdentifier forIndexPath:indexPath];
    SZPropertyRecordCellViewModel* cellViewModel=[self.viewModel recordCellViewModelAtIndexPath:indexPath];
    cell.viewModel=cellViewModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!footView) {
        footView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, footView.height)];
        subFootView.backgroundColor=MainBackgroundColor;
        [footView addSubview:subFootView];
    }
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return FIT3(48);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
