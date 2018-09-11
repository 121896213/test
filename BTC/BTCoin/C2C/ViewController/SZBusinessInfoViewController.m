//
//  SZBusinessInfoViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBusinessInfoViewController.h"
#import "SZBussinessRecordCell.h"
#import "SZBusinessInfoHeadView.h"
@interface SZBusinessInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,copy)  NSArray* currentData;
@property (nonatomic,strong) SZBusinessInfoHeadView* headerView;
@end

@implementation SZBusinessInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentData=[[NSArray alloc]init];
    SZBusinessInfoHeadView* headerView=[[SZBusinessInfoHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, FIT(324)+NavigationStatusBarHeight)];
    self.headerView=headerView;
    [[self.headerView.backButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=SZBussinessRecordCellHeight;
    [self.tableView registerClass:[SZBussinessRecordCell class] forCellReuseIdentifier:SZBussinessRecordCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=MainBackgroundColor;
    [self.tableView setTableHeaderView:self.headerView];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(ScreenWidth);
        make.bottom.mas_equalTo(FIT(0));
      
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZBussinessRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:SZBussinessRecordCellReuseIdentifier forIndexPath:indexPath];
    
    //        SZPropertyRecordCellViewModel* cellViewModel=[self.viewModel recordCellViewModelAtIndexPath:indexPath];
    //        cell.viewModel=cellViewModel;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
