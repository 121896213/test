//
//  SZSecurityCenterViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSecurityCenterViewController.h"
#import "SZWithdrawAddressCell.h"
#import "SZBindEmailViewController.h"
#import "SZBindMobileViewController.h"
#import "ChangeLoginPwdViewController.h"
@interface SZSecurityCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,copy)  NSArray* currentData;
@end

@implementation SZSecurityCenterViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor=MainBackgroundColor;
        [self setSubviews];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setSubviews{
    
    self.currentData=[[NSArray alloc]init];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight-NavigationStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[SZWithdrawAddressCell class] forCellReuseIdentifier:SZWithdrawAddressCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=MainBackgroundColor;

    [self.view addSubview:self.tableView];
    
    [self setTitleText:NSLocalizedString(@"安全中心", nil)];
   [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];

    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZWithdrawAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:SZWithdrawAddressCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row ==0){
        cell.coinTypeLab.text= NSLocalizedString(@"登录密码", nil);
        cell.coinTypeCountLab.text=NSLocalizedString(@"修改", nil);
//        cell.backgroundColor=[UIColor whiteColor];
    }else if (indexPath.row == 1){
        cell.coinTypeLab.text=NSLocalizedString(@"交易密码", nil);
        cell.coinTypeCountLab.text=[UserInfo sharedUserInfo].isTradePassword?NSLocalizedString(@"重置", nil):NSLocalizedString(@"设置", nil);
//        cell.backgroundColor=MainBackgroundColor;
    }
    if (indexPath.row ==2){
        cell.coinTypeLab.text= NSLocalizedString(@"手机绑定", nil);
        cell.coinTypeCountLab.text=[[UserInfo sharedUserInfo] isBindTelephone]?[[UserInfo sharedUserInfo].telNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]:NSLocalizedString(@"未绑定", nil);
//        cell.backgroundColor=[UIColor whiteColor];
    }else if (indexPath.row == 3){
        cell.coinTypeLab.text=NSLocalizedString(@"邮箱绑定", nil);
        cell.coinTypeCountLab.text=[[UserInfo sharedUserInfo] isBindEmail]?[[UserInfo sharedUserInfo].email stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]:NSLocalizedString(@"未绑定", nil);
//        cell.backgroundColor=MainBackgroundColor;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
    
        ChangeLoginPwdViewController *vc = [[ChangeLoginPwdViewController alloc] init];
        vc.pwdType = kPwdChangeLogin;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1) {
        ChangeLoginPwdViewController *vc = [[ChangeLoginPwdViewController alloc] init];
        if (![UserInfo sharedUserInfo].isTradePassword){
            vc.pwdType = kPwdSetBargaining;
        }else{
            vc.pwdType = kPwdChangeBargaining;
        }
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row == 2){
        if (![[UserInfo sharedUserInfo] isBindTelephone]){
            SZBindMobileViewController* bindMobileVC=[SZBindMobileViewController new];
            [self.navigationController pushViewController:bindMobileVC animated:YES];
        }
    }else if (indexPath.row == 3){
        if (![[UserInfo sharedUserInfo] isBindEmail]){
            SZBindEmailViewController* bindEmailVC=[SZBindEmailViewController new];
            [self.navigationController pushViewController:bindEmailVC animated:YES];
        }
    }
   
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
