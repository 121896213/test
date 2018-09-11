//
//  SZC2CTradeStateViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CTradeStateViewController.h"
#import "SZC2CTradeStateViewModel.h"
#import "SZC2CStateFooterView.h"

#import "SZC2CStateOrderIdCell.h"
#import "SZC2CStateItemCell.h"
#import "SZC2CTradePriceCell.h"
#import "SZC2CStateAppealCell.h"
#import "SZC2CStatePayTypeCell.h"
#import "SZC2CStateAppealDemoCell.h"
#import "SZC2CStateAppealDescCell.h"
#import "SZC2CStateHandelCell.h"
#import "SZC2CStatePromptCell.h"

#import "SZBusinessInfoViewController.h"
#import "SZC2CStateHeaderView.h"

@interface SZC2CTradeStateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;

@end

@implementation SZC2CTradeStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:self.viewModel.isBuyIn?NSLocalizedString(@"买入", nil):NSLocalizedString(@"卖出", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    self.view.backgroundColor=MainC2CBackgroundColor;

    [self tableView];
}
- (SZC2CTradeStateViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZC2CTradeStateViewModel new];
    }
    return _viewModel;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MainC2CBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView .showsVerticalScrollIndicator = NO;
        _tableView.sectionHeaderHeight=FIT(0);
        _tableView.sectionFooterHeight=FIT(16);
        [_tableView registerClass:[SZC2CStateOrderIdCell class] forCellReuseIdentifier:SZC2CStateOrderIdCellReuseIdentifier];
        [_tableView registerClass:[SZC2CStateItemCell class] forCellReuseIdentifier:SZC2CStateItemCellReuseIdentifier];
        [_tableView registerClass:[SZC2CTradePriceCell class] forCellReuseIdentifier:SZC2CTradePriceCellReuseIdentifier];
        [_tableView registerClass:[SZC2CStateAppealCell class] forCellReuseIdentifier:SZC2CStateAppealCellReuseIdentifier];
        [_tableView registerClass:[SZC2CStatePayTypeCell class] forCellReuseIdentifier:SZC2CStatePayTypeCellReuseIdentifier];
        [_tableView registerClass:[SZC2CStateHandelCell class] forCellReuseIdentifier:SZC2CStateHandelCellReuseIdentifier];
        [_tableView registerClass:[SZC2CStateAppealDescCell class] forCellReuseIdentifier:SZC2CStateAppealDescCellReuseIdentifier];
        [_tableView registerClass:[SZC2CStateAppealDemoCell class] forCellReuseIdentifier:SZC2CStateAppealDemoCellReuseIdentifier];
        [_tableView registerClass:[SZC2CStatePromptCell class] forCellReuseIdentifier:SZC2CStatePromptCellReuseIdentifier];

        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(NavigationStatusBarHeight);
            make.left.mas_equalTo(FIT(16));
            make.right.mas_equalTo(FIT(-16));
            make.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.viewModel.cellModelArr.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return [self.viewModel.cellModelArr[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZOrderStateCellModel* cellModel=self.viewModel.cellModelArr[indexPath.section][indexPath.row];
    
    if (cellModel.cellType == SZOrderStateCellTypeOrderId) {

        return SZC2CStateOrderIdCellHeight;
        
    }else if(cellModel.cellType == SZOrderStateCellTypePrice ){
        
        return SZC2CTradePriceCellHeight;
        
    }else if(cellModel.cellType == SZOrderStateCellTypeCommon ){
        
        return SZC2CStateItemCellHeight;
        
    }else if(cellModel.cellType == SZOrderStateCellTypePayType){
        
        return SZC2CStatePayTypeCellHeight;
        
    }else if(cellModel.cellType == SZOrderStateCellTypeHandleAction ){
        
        return SZC2CStateHandelCellHeight;
        
    }else if (cellModel.cellType == SZOrderStateCellTypeAppealDemo){
        
    
        return SZC2CStateAppealDemoCellHeight;
        
    }else if (cellModel.cellType == SZOrderStateCellTypeAppealDesc){

        return SZC2CStateAppealDescCellHeight;
        
    }else if (cellModel.cellType == SZOrderStateCellTypeAppealInfo){
    
        return SZC2CStateAppealCellHeight;
        
    }else if (cellModel.cellType == SZOrderStateCellTypePrompt){
    
        return SZC2CStatePromptCellHeight;
        
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    SZOrderStateCellModel* cellModel=self.viewModel.cellModelArr[indexPath.section][indexPath.row];
    
    if (cellModel.cellType == SZOrderStateCellTypeOrderId) {
        
        SZC2CStateOrderIdCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CStateOrderIdCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setContent:self.viewModel];
        return cell;
        
    }else if(cellModel.cellType == SZOrderStateCellTypePrice ){
        
        SZC2CTradePriceCell* cell = [tableView dequeueReusableCellWithIdentifier:SZC2CTradePriceCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        @weakify(self);
        cell.action = ^(id sender) {
            @strongify(self);
            SZBusinessInfoViewController* infoVC=[SZBusinessInfoViewController new];
            [self.navigationController pushViewController:infoVC animated:YES];
        };
        return cell;
        
    }else if(cellModel.cellType == SZOrderStateCellTypeCommon ){
        
        SZC2CStateItemCell* cell = [tableView dequeueReusableCellWithIdentifier:SZC2CStateItemCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.tradeItemLab.text=cellModel.title;
        return cell;
        
    }else if(cellModel.cellType == SZOrderStateCellTypePayType){
        
        SZC2CStatePayTypeCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CStatePayTypeCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(cellModel.cellType == SZOrderStateCellTypeHandleAction ){

        SZC2CStateHandelCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CStateHandelCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setHandleBtnTitle:cellModel.title];
        return cell;
    }else if (cellModel.cellType == SZOrderStateCellTypeAppealDemo){
        
        SZC2CStateAppealDemoCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CStateAppealDemoCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (cellModel.cellType == SZOrderStateCellTypeAppealDesc){
        
        SZC2CStateAppealDescCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CStateAppealDescCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (cellModel.cellType == SZOrderStateCellTypeAppealInfo){
        
        SZC2CStateAppealCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CStateAppealCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (cellModel.cellType == SZOrderStateCellTypePrompt){
        
        SZC2CStatePromptCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CStatePromptCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
 
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FIT(0);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.viewModel.cellModelArr.count == section+1 ) {
        return FIT(0);
    }else{
        return FIT(16);
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *reuseId =  @"sectionHeader";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!headerView) {
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT(16))];
        subFootView.backgroundColor=MainC2CBackgroundColor;;
        [headerView addSubview:subFootView];
    }
    return headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
