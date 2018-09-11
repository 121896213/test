//
//  SZPayTypeViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPayTypeViewController.h"
#import "SZUserInfoCommonCell.h"
#import "SZSetPayTypeViewController.h"
@interface SZPayTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, copy)   NSArray       *dataArray;
@end

@implementation SZPayTypeViewController


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"支付设置", nil)];
    self.dataArray=@[@[NSLocalizedString(@"银行卡", nil),NSLocalizedString(@"支付宝", nil),NSLocalizedString(@"微信账号", nil)]];
    [self tableView];
    
    
    
}
- (NSArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
}

#pragma mark - tableview delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return FIT(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        if (indexPath.row ==0) {
            SZSetPayTypeViewController* payTypeVC=[SZSetPayTypeViewController new];
            payTypeVC.viewModel.payType=SZPayTypeBank;
            [self.navigationController pushViewController:payTypeVC animated:YES];
        }else if (indexPath.row == 1){
            SZSetPayTypeViewController* payTypeVC=[SZSetPayTypeViewController new];
            payTypeVC.viewModel.payType=SZPayTypeAlipay;
            [self.navigationController pushViewController:payTypeVC animated:YES];
        }else if (indexPath.row == 2){
            SZSetPayTypeViewController* payTypeVC=[SZSetPayTypeViewController new];
            payTypeVC.viewModel.payType=SZPayTypeWechat;
            [self.navigationController pushViewController:payTypeVC animated:YES];
        }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZUserInfoCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:SZUserInfoCommonCellReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell= [[SZUserInfoCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SZUserInfoCommonCellReuseIdentifier];
    }
    cell.titleLabel.text=self.dataArray[indexPath.section][indexPath.row];

    if (indexPath.row == 0) {
        [cell.detailBtn setTitle:NSLocalizedString(@"去绑定", nil) forState:UIControlStateNormal];
        [cell.detailBtn setTitleColor:MainThemeBlueColor forState:UIControlStateNormal];
    }else if (indexPath.row == 1){
        [cell.detailBtn setTitle:NSLocalizedString(@"去绑定", nil) forState:UIControlStateNormal];
        [cell.detailBtn setTitleColor:MainThemeBlueColor forState:UIControlStateNormal];
    }else{
        [cell.detailBtn setTitle:NSLocalizedString(@"去绑定", nil) forState:UIControlStateNormal];
        [cell.detailBtn setTitleColor:MainThemeBlueColor forState:UIControlStateNormal];
    }
    return cell ;
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
        subFootView.backgroundColor=MainBackgroundColor;
        [headerView addSubview:subFootView];
    }
    return headerView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
    
}

#pragma mark - ui
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SZUserInfoCommonCell class] forCellReuseIdentifier:SZUserInfoCommonCellReuseIdentifier];
        _tableView.sectionHeaderHeight=FIT(16);
        _tableView.sectionFooterHeight=FIT(0);
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom);
            make.leading.trailing.bottom.equalTo(self.view);
        }];
        
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
