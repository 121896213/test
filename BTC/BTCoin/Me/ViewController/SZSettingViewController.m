//
//  SZSettingViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/4/23.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSettingViewController.h"
#import "SZThemeViewController.h"
#import "ChangeLoginPwdViewController.h"
#import "SZUserDefaultCenter.h"
#import "SZWithdrawAddressCell.h"
#import "SZAboutViewController.h"
#import "LanguageManager.h"
#import "SZUserInfoCommonCell.h"
#import "SZAddressListViewController.h"
#import "ChangeLoginPwdViewController.h"
#import "SZPayTypeViewController.h"
typedef NS_ENUM(NSInteger, KSettingCellType) {
    
    KSettingLanguage,//语言
    KSettingChangeLoginPwd,//修改登录密码
    KSettingBargainingPwd,//设置交易密码
    KSettingChangeBargainingPwd,//修改交易密码
    
    KSettingLogout,//退出登录
};

#define SettingCellKey @"CellKey"
#define SettingCellValue @"CellValue"

@interface SZSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, copy)   NSArray       *dataArray;
@property (nonatomic, strong) UIButton     *exitBtn;

@end

@implementation SZSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"设置", nil)];
    self.dataArray=@[@[NSLocalizedString(@"支付设置", nil),NSLocalizedString(@"提币地址", nil),NSLocalizedString(@"交易密码", nil),NSLocalizedString(@"登录密码", nil)],@[@"语言设置"]];
    [self tableView];
    
    self.exitBtn=[UIButton new];
    [self.exitBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.exitBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.exitBtn setTitle:NSLocalizedString(@"安全退出", nil) forState:UIControlStateNormal];
    [self.exitBtn setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [self.view addSubview:self.exitBtn];
    [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(FIT(-240));
        make.left.mas_equalTo(FIT3(48));
        make.right.mas_equalTo(FIT3(-48));
        make.height.mas_equalTo(FIT3(150));
    }];
    [self.exitBtn setBackgroundColor:[UIColor whiteColor]];
    [ShareFunction setCircleBorder:self.exitBtn];
    
    @weakify(self);
    [[self.exitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        
        NSMutableArray *actionSheetItems = [@[FSActionSheetTitleItemMake(FSActionSheetTypeHighlighted, NSLocalizedString(@"确定", nil))]
                                            mutableCopy];
        FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:NSLocalizedString(@"确定要退出登录？", nil) cancelTitle:NSLocalizedString(@"取消", nil) items:actionSheetItems];
        actionSheet.contentAlignment = FSContentAlignmentCenter;
        // 展示并绑定选择回调
        [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
            
            if (selectedIndex == 0) {
                
                [self showLoadingMBProgressHUD];
                [[[SZHttpsService sharedSZHttpsService] signalLoginOut]subscribeNext:^(id responseDictionary) {
                    
                    if ([responseDictionary[@"code"] integerValue] == 0) {
                        [self hideMBProgressHUD];
                        [UserInfo sharedUserInfo].bIsLogin = NO;
                        [[NSNotificationCenter defaultCenter] postNotificationName:LISTENTOAPPLOGINNOTIFICATION object:@(NO)userInfo:@{@"isLogin":[NSNumber numberWithBool:NO]}];
                        SZHTTPSReqManager.presentLoginVC(responseDictionary);
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"SZExitSuccess" object:nil userInfo:nil];
                        
                    }else{
                        NSString* errorMsg=responseDictionary[@"msg"];
                        [self showErrorHUDWithTitle:errorMsg];
                    }
                    
                }error:^(NSError *error) {
                    [self showErrorHUDWithTitle:error.localizedDescription];
                }];
            }
           
        }];
        
     
 }];

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0) {
        if (indexPath.row ==0) {
            SZPayTypeViewController* szAddressVC=[SZPayTypeViewController new];
            [self.navigationController pushViewController:szAddressVC animated:YES];
        }else if (indexPath.row == 1){
            SZAddressListViewController* szAddressVC=[SZAddressListViewController new];
            [self.navigationController pushViewController:szAddressVC animated:YES];
        }else if (indexPath.row == 2){
            ChangeLoginPwdViewController *vc = [[ChangeLoginPwdViewController alloc] init];
            if (![UserInfo sharedUserInfo].isTradePassword){
                vc.pwdType = kPwdSetBargaining;
            }else{
                vc.pwdType = kPwdChangeBargaining;
            }
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row == 3){
            ChangeLoginPwdViewController *vc = [[ChangeLoginPwdViewController alloc] init];
            vc.pwdType = kPwdChangeLogin;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        
        if (indexPath.row ==0) {
            [UIViewController showLoadingMBProgressHUD];
            [[LanguageManager sharedInstance] changeNowLanguage];
        }
    }
   

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZUserInfoCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:SZUserInfoCommonCellReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell= [[SZUserInfoCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SZUserInfoCommonCellReuseIdentifier];
    }
    cell.titleLabel.text=self.dataArray[indexPath.section][indexPath.row];

    if (indexPath.row == 0 && indexPath.section == 1) {
        [cell.detailBtn setTitle:[[LanguageManager sharedInstance] getNowlanguage] forState:UIControlStateNormal];
    }else{
        [cell.detailBtn setHidden:YES];
    }
    return cell ;
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
        [_tableView registerClass:[SZWithdrawAddressCell class] forCellReuseIdentifier:SZWithdrawAddressCellReuseIdentifier];
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
@end
