//
//  PersonCenterViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/6/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPersonCenterViewController.h"
#import "SZPersonCenterHeadView.h"
#import "SZPropertyViewModel.h"
#import "SZPersonCenterViewModel.h"
#import "ATEntrustManagerViewController.h"
#import "SZPurchaseRecordViewController.h"
#import "SZIdentityInfoViewController.h"
#import "SZSecurityCenterViewController.h"
#import "SZAddressListViewController.h"
#import "BusinessRecordViewController.h"
#import "SZIdentityResultViewController.h"

#import "SZSettingViewController.h"
#import "SZAboutViewController.h"
#import "SZRecommendViewController.h"

#import "PhoneRegisterViewController.h"
#import "LoginViewController.h"
#import "MePageTableViewCell.h"
#import "SZUserInfoViewController.h"
#import "SZC2CAdListViewController.h"
#import "SZOrderManagerViewController.h"
#import "ChangeLoginPwdViewController.h"
@interface SZPersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong)  SZPersonCenterHeadView* headerView;
@property(nonatomic, copy) NSArray *dataArr;
@property(nonatomic, copy) NSArray *imagesArr;
@property(nonatomic,strong) SZPersonCenterViewModel* viewModel;
@end

@implementation SZPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr=@[@[NSLocalizedString(@"我的广告", nil),NSLocalizedString(@"订单管理", nil)],@[NSLocalizedString(@"委托管理", nil),NSLocalizedString(@"成交记录", nil),NSLocalizedString(@"申购记录", nil)],@[NSLocalizedString(@"推荐好友", nil),NSLocalizedString(@"关于我们", nil)],@[NSLocalizedString(@"设置", nil)]];
    self.imagesArr=@[@[@"person_identity_icon",@"person_security_icon"],@[@"person_delegate_icon",@"person_trade_icon",@"person_shengou_icon"],@[@"person_recommend_icon",@"person_about_icon"],  @[@"person_settings_icon"]];
    [self tableView];
    [self setActions];
}



-(SZPersonCenterViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZPersonCenterViewModel new];
    }
    return _viewModel;
}
-(void)setActions{
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self hideMBProgressHUD];
        [self.headerView setInfo:[UserInfo sharedUserInfo]];
        self.tableView.tableHeaderView=self.headerView;
        if (![UserInfo sharedUserInfo].isTradePassword || [UserInfo sharedUserInfo].idAuthStatus == 2) {
            self.headerView.height=FIT(115)+NavigationStatusBarHeight+FIT(43);
            [self.tableView beginUpdates];
            [self.tableView setTableHeaderView:self.headerView];
            [self.tableView endUpdates];
        }
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];

    
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MainBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = FIT3(48);
        _tableView.sectionFooterHeight = FIT3(0);
        [_tableView registerNib:[UINib nibWithNibName:@"MePageTableViewCell" bundle:nil] forCellReuseIdentifier:kMePageTableViewCellReuseID];
        _tableView.tableHeaderView = [self tableHeaderView];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.leading.trailing.bottom.equalTo(self.view);
        }];
    }
    return _tableView;
}

- (SZPersonCenterHeadView *)tableHeaderView {
    if (!_headerView) {
        _headerView = [[SZPersonCenterHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT(115)+NavigationStatusBarHeight)];
        @weakify(self);
        [[_headerView.loginBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:loginNav animated:YES completion:nil];
        }];
        [[_headerView.rightBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            SZUserInfoViewController* userInfoVC=[SZUserInfoViewController new];
            [self.navigationController pushViewController:userInfoVC animated:YES];
         }];
        
        [[self.headerView.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            self.headerView.height=FIT(115)+NavigationStatusBarHeight;
            [self.headerView.promptView setHidden:YES];
            [self.tableView beginUpdates];
            [self.tableView setTableHeaderView:self.headerView];
            [self.tableView endUpdates];
            
        }];
        
        [[self.headerView.handleBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            if (![[UserInfo sharedUserInfo] isIdAuthStatus]) {
                SZIdentityInfoViewController* infoVC=[SZIdentityInfoViewController new];
                [self.navigationController pushViewController:infoVC animated:YES];
            }
            else if (![UserInfo sharedUserInfo].isTradePassword) {
                ChangeLoginPwdViewController *vc = [[ChangeLoginPwdViewController alloc] init];
                vc.pwdType = kPwdSetBargaining;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }else{

        
    }
    
    
    return _headerView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [UserInfo isLogin]?self.dataArr.count:self.dataArr.count-1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArr[section] count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  FIT3(146);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMePageTableViewCellReuseID forIndexPath:indexPath];
    if (!cell) {
        cell= [[MePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMePageTableViewCellReuseID];
    }

    cell.leftImageView.image=[UIImage imageNamed:self.imagesArr[indexPath.section][indexPath.row]];
    cell.titleLabel.text=self.dataArr[indexPath.section][indexPath.row];
    cell.titleLabel.font=[UIFont systemFontOfSize:FIT(14.0)];
    cell.remindImageView.hidden=YES;
    cell.titleLabel.textColor=UIColorFromRGB(0X333333);

    if (indexPath.section == 2 && indexPath.row == 0 ) {
        [cell.remindImageView setImage:[UIImage imageNamed:@"recommend_right"]];
        cell.remindImageView.hidden=NO;

    }
   
    return cell;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([UserInfo sharedUserInfo].bIsLogin) {
        
        if (indexPath.section == 0) {
            if (indexPath.row ==0){
                 SZC2CAdListViewController *vc = [[SZC2CAdListViewController alloc] init];
                  [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row ==1){
                SZOrderManagerViewController *vc = [[SZOrderManagerViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.section == 1){
            
            if(![[UserInfo sharedUserInfo] isIdAuthStatus]){
            
                
                if ([UserInfo sharedUserInfo].idAuthStatus == 1) {
                   
                    SZUserInfoViewController* userInfoVC=[SZUserInfoViewController new];
                    [self.navigationController pushViewController:userInfoVC animated:YES];
                }else{
                    JCAlertController *alert = [JCAlertController alertWithTitle:@"温馨提示" message:@"您还未进行身份认证，请先认证"];
                    [alert addButtonWithTitle:@"取消" type:JCButtonTypeCancel clicked:^{
                        
                    }];
                    [alert addButtonWithTitle:@"去认证" type:JCButtonTypeNormal clicked:^{
                        SZIdentityInfoViewController *vc = [[SZIdentityInfoViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }];
                    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
                    
                }
            }else{
                if (indexPath.row == 0) {
                    ATEntrustManagerViewController *vc = [[ATEntrustManagerViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (indexPath.row ==1){
                    BusinessRecordViewController *vc = [[BusinessRecordViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    
                    SZPurchaseRecordViewController *vc = [[SZPurchaseRecordViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
          
       
            
        }else if (indexPath.section == 2){
            
            if (indexPath.row == 0) {
                if(![[UserInfo sharedUserInfo] isIdAuthStatus]){
                    JCAlertController *alert = [JCAlertController alertWithTitle:@"温馨提示" message:@"您还未进行身份认证，请先认证"];
                    [alert addButtonWithTitle:@"取消" type:JCButtonTypeCancel clicked:^{
                        
                    }];
                    [alert addButtonWithTitle:@"去认证" type:JCButtonTypeNormal clicked:^{
                        if ([UserInfo sharedUserInfo].idAuthStatus == 2) {
                            SZIdentityInfoViewController *vc = [[SZIdentityInfoViewController alloc] init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }else{
                            SZUserInfoViewController* userInfoVC=[SZUserInfoViewController new];
                            [self.navigationController pushViewController:userInfoVC animated:YES];
                        }
                    }];
                    
                    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
                    
                }else{
                    SZRecommendViewController *vc = [[SZRecommendViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
               
            }else if (indexPath.row ==1){
                SZAboutViewController *vc = [[SZAboutViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.section == 3){
            
            if (indexPath.row == 0) {
                SZSettingViewController *vc = [[SZSettingViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
      
       
    } else {
        if (indexPath.section == 2 && indexPath.row == 2) {
            
            SZAboutViewController *vc = [[SZAboutViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }else{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:loginNav animated:YES completion:nil];
        }
       
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.headView setHidden:YES];
    if ([UserInfo isLogin]) {
        [self.viewModel getSecurityInfo:nil];
    }else{
        [self.headerView setInfo:[UserInfo sharedUserInfo]];
        self.headerView.height=FIT(115)+NavigationStatusBarHeight;
        [self.tableView beginUpdates];
        [self.tableView setTableHeaderView:self.headerView];
        [self.tableView endUpdates];
    }
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.headView setHidden:NO];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //图片高度
//    CGFloat imageHeight = [self tableHeaderView].frame.size.height;
//    //图片宽度
//    CGFloat imageWidth = kScreenWidth;
//    //图片上下偏移量
//    CGFloat imageOffsetY = scrollView.contentOffset.y;//上移
//    if (imageOffsetY < 0) {
//        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
//        CGFloat f = totalOffset / imageHeight;
//        [self tableHeaderView].backgroundImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
//    }
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
