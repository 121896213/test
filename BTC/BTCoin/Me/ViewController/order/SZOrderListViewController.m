//
//  SZOrderListViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/8/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZOrderListViewController.h"
#import "SZC2COrderListCell.h"
#import "SZC2CTradeStateViewController.h"
@interface SZOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView;

@end

@implementation SZOrderListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=MainC2CBackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight=FIT(16);
    _tableView.sectionFooterHeight=FIT(0);
    _tableView.rowHeight=SZC2COrderListCellHeight;
    [_tableView registerClass:[SZC2COrderListCell class] forCellReuseIdentifier:SZC2COrderListCellReuseIdentifier];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(ScreenHeight-NavigationStatusBarHeight-40.0f);
    }];
    
}

-(SZOrderListViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZOrderListViewModel new];
    }
    return _viewModel;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZC2COrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:SZC2COrderListCellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    SZCommissionRecordCellViewModel* cellViewModel=[self.viewModel commissionRecordCellViewModellAtIndexPath:indexPath];
    //    cell.viewModel=cellViewModel;
    if (self.viewModel.orderStateType == SZC2COrderStateTypeAppeal) {
        [cell.orderStatusLab setHidden:NO];
    }
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SZC2CTradeStateViewController* tradeStateVC=[SZC2CTradeStateViewController new];
    tradeStateVC.viewModel.isBuyIn=!_viewModel.isAdOrder;
    tradeStateVC.viewModel.orderStateType=_viewModel.orderStateType;


    [self.navigationController pushViewController:tradeStateVC animated:YES];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
