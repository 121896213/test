//
//  SelfSelectEditSubViewController.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SelfSelectEditSubViewController.h"
#import "MarketEditTableViewCell.h"
#import "SelfCollectArrayModel.h"

@interface SelfSelectEditSubViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton * selectAllButton;
}

@property (nonatomic,strong) UIView * tableHeaderView;
@property (nonatomic,strong) UIView * tableFooterView;//展示自选时可用
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataSource; //数据
@property (nonatomic,copy) NSArray *localDataSource; //数据

@end

@implementation SelfSelectEditSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    [self requestData];
}

-(void)configSubViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(0);
        make.bottom.mas_equalTo(-66);
    }];
    [self.view addSubview:self.tableFooterView];
    [self.tableFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(66);
        make.leading.trailing.bottom.mas_equalTo(0);
    }];
}

-(void)requestData
{
    _localDataSource = [[SelfCollectArrayModel sharedSelfCollectArrayModel]getCollectDataByMarketType:_fCoinType];
    [self.dataSource removeAllObjects];
    for (int i = 0; i < _localDataSource.count; i++) {
        [self.dataSource addObject:[NSNumber numberWithBool:NO]];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarketEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMarketEditTableViewCellReuseID forIndexPath:indexPath];
    [cell setCellWithTitle:_localDataSource[indexPath.row] isSel:[self.dataSource[indexPath.row]boolValue]];
    __weak typeof(self)weakSelf = self;
    cell.goTopBlock = ^{
        [weakSelf moveIndexToTop:indexPath.row];
    };
    cell.setSelBlock = ^(BOOL isSelect) {
        [weakSelf.dataSource replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:isSelect]];
        [weakSelf.tableView reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.tableHeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[SelfCollectArrayModel sharedSelfCollectArrayModel]exChangeSourceIndex:sourceIndexPath.row toDestinaIndex:destinationIndexPath.row inMarketType:_fCoinType];
    _localDataSource = [[SelfCollectArrayModel sharedSelfCollectArrayModel] getCollectDataByMarketType:_fCoinType];
    
    NSNumber * number = self.dataSource[sourceIndexPath.row];
    [self.dataSource removeObjectAtIndex:sourceIndexPath.row];
    [self.dataSource insertObject:number atIndex:destinationIndexPath.row];

    [self.tableView reloadData];
}

-(void)moveIndexToTop:(NSInteger)index{
    NSNumber * number = self.dataSource[index];
    [self.dataSource removeObjectAtIndex:index];
    [self.dataSource insertObject:number atIndex:0];
    [[SelfCollectArrayModel sharedSelfCollectArrayModel]moveSourceIndex:index toTopInMarketType:_fCoinType];
    _localDataSource = [[SelfCollectArrayModel sharedSelfCollectArrayModel] getCollectDataByMarketType:_fCoinType];
    [self.tableView reloadData];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = WhiteColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setEditing:YES animated:NO];
        [_tableView registerClass:[MarketEditTableViewCell class] forCellReuseIdentifier:kMarketEditTableViewCellReuseID];
    }
    return _tableView;
}

-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        _tableHeaderView.backgroundColor = UIColorFromRGB(0xf5f5f5);
        
        UILabel * labelOne = [self createLabelWithText:@"名称/代码"];
        [labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(40);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_tableHeaderView.mas_centerY);
        }];
        UILabel * labelTwo = [self createLabelWithText:@"置顶"];
        labelTwo.textAlignment = NSTextAlignmentCenter;
        [labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_tableHeaderView.mas_centerY);
            make.centerX.mas_equalTo(_tableHeaderView.mas_centerX).offset(40);

        }];
        UILabel * labelThree = [self createLabelWithText:@"拖动"];
        labelThree.textAlignment = NSTextAlignmentLeft;
        [labelThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(52);
            make.trailing.mas_equalTo(0);
            make.centerY.mas_equalTo(_tableHeaderView.mas_centerY);
            make.height.mas_equalTo(20);
        }];
    }
    return _tableHeaderView;
}

-(UIView *)tableFooterView{
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 66)];
        _tableFooterView.backgroundColor = WhiteColor;
        
        selectAllButton = [UIButton new];
        [selectAllButton setImage:kIMAGE_NAMED(@"editMarketUnSel") forState:UIControlStateNormal];
        [selectAllButton setImage:kIMAGE_NAMED(@"editMarketSel") forState:UIControlStateSelected];
        [selectAllButton addTarget:self action:@selector(selectAllButtonClick:) forControlEvents:UIControlEventTouchUpInside];        [selectAllButton setTitle:NSLocalizedString(@" 全选", nil) forState:UIControlStateNormal];
        selectAllButton.titleLabel.font = kFontSize(14);
        [selectAllButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_tableFooterView addSubview:selectAllButton];
        [selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(13);
            make.height.mas_equalTo(40);
        }];
        
        UIButton * delButton = [UIButton new];
        [delButton addTarget:self action:@selector(delButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [delButton setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
        [delButton setTitleColor:UIColorFromRGB(0x83ACFF) forState:UIControlStateNormal];
        [_tableFooterView addSubview:delButton];
        [delButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.trailing.mas_equalTo(-24);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(40);
        }];
    }
    return _tableFooterView;
}
-(void)selectAllButtonClick:(UIButton *)button{
    if (_localDataSource.count == 0) {
        return;
    }
    button.selected = !button.selected;
    [self.dataSource removeAllObjects];
    for (int i = 0; i < _localDataSource.count; i++) {
        [self.dataSource addObject:[NSNumber numberWithBool:button.selected]];
    }
    [self.tableView reloadData];
}

-(void)delButtonClick
{
    NSMutableArray * mArr = [NSMutableArray array];
    for (NSInteger i = self.dataSource.count -1; i >=0; i--) {
        NSNumber * number = self.dataSource[i];
        NSString * string = _localDataSource[i];
        if ([number boolValue]) {
            [mArr addObject:string];
            [self.dataSource removeObjectAtIndex:i];
        }
    }
    if (mArr.count == 0) {
        [self showErrorHUDWithTitle:@"请先选择一条数据"];

    }else{
        [[SelfCollectArrayModel sharedSelfCollectArrayModel]deleteDataSourceIndex:mArr inMarketType:_fCoinType];
        _localDataSource = [[SelfCollectArrayModel sharedSelfCollectArrayModel] getCollectDataByMarketType:_fCoinType];
        [self.tableView reloadData];
    }
    selectAllButton.selected = NO;
}

/**创建label*/
-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel * label = [UILabel new];
    label.text = NSLocalizedString(text, nil);
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = UIColorFromRGB(0x666666);
    [_tableHeaderView addSubview:label];
    return label;
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


@end
