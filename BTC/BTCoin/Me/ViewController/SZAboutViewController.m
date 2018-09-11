//
//  SZAboutViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/6/8.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZAboutViewController.h"
#import "SZWithdrawAddressCell.h"
#import "SZIntroduceViewController.h"
@interface SZAboutViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, copy)   NSArray *dataArr;
@property(nonatomic, copy)   NSArray *detailDataArr;
@end

@implementation SZAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleText:NSLocalizedString(@"关于我们", nil)];
//    self.dataArr=@[@[NSLocalizedString(@"平台介绍", nil)],@[NSLocalizedString(@"技术支持邮箱", nil),NSLocalizedString(@"用户服务邮箱", nil)]];
//    self.detailDataArr=@[@[NSLocalizedString(@"", nil)],@[NSLocalizedString(@"support@btktrade.com", nil),NSLocalizedString(@"service@btktrade.com", nil)]];
    
    self.dataArr=@[@[NSLocalizedString(@"平台介绍", nil)],@[NSLocalizedString(@"服务邮箱", nil)]];
    self.detailDataArr=@[@[NSLocalizedString(@"", nil)],@[NSLocalizedString(@"service@btktrade.com", nil)]];
    
    UIImageView* aboutImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"about_background"]];
    [self.view addSubview:aboutImageView];
    [aboutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(FIT3(380));
    }];
    
    
    UILabel* versionLab=[UILabel new];
    versionLab.text=NSLocalizedString(FormatString(@"当前版本号:%@",app_Version), nil);
    versionLab.font=[UIFont systemFontOfSize:12.0f];
    versionLab.textColor=[UIColor whiteColor];
    [aboutImageView addSubview:versionLab];
    [versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(aboutImageView.mas_centerX);
        make.bottom.mas_equalTo(FIT3(-53));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight-NavigationStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[SZWithdrawAddressCell class] forCellReuseIdentifier:SZWithdrawAddressCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=MainBackgroundColor;
    self.tableView.height=SZWithdrawAddressCellHeight;
    self.tableView.sectionHeaderHeight=FIT3(48);
    self.tableView.sectionFooterHeight=FIT3(0);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(aboutImageView.mas_bottom);
        
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZWithdrawAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:SZWithdrawAddressCellReuseIdentifier forIndexPath:indexPath];
    
    cell.coinTypeLab.text=self.dataArr[indexPath.section][indexPath.row];
    cell.coinTypeCountLab.text=self.detailDataArr[indexPath.section][indexPath.row];
    [cell setAboutUSCellStyle:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        SZIntroduceViewController* introduceVC=[SZIntroduceViewController new];
        [self.navigationController pushViewController:introduceVC animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FIT3(48);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!headerView) {
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, headerView.height)];
        subFootView.backgroundColor=MainBackgroundColor;
        [headerView addSubview:subFootView];
    }
    return headerView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    self.headView.backgroundColor=NavBarColor;
    [self.headView addBottomLineViewColor:NavBarColor];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.headView.backgroundColor=MainNavBarColor;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
