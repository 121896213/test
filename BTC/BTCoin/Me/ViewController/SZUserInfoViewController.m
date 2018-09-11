//
//  SZUserInfoViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/7/26.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZUserInfoViewController.h"
#import "SZUserInfoViewModel.h"
#import "SZUserHeaderCell.h"
#import "SZUserInfoCommonCell.h"
#import "SZEditNickNameViewController.h"
#import "SZEditHeadImageViewController.h"
#import "SZIdentityInfoViewController.h"
#import "SZIdentityPhotosViewController.h"
#import "SZBindEmailViewController.h"
#import "SZBindMobileViewController.h"
#import "ChangeLoginPwdViewController.h"

@interface SZUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong) SZUserInfoViewModel* viewModel;

@end

@implementation SZUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self setTitleText:NSLocalizedString(@"账户资料", nil)];

}


-(SZUserInfoViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZUserInfoViewModel new];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MainBackgroundColor;
        _tableView.sectionHeaderHeight=FIT(16);
        _tableView.sectionFooterHeight=FIT(0);
        [_tableView registerClass:[SZUserHeaderCell class] forCellReuseIdentifier:SZUserHeaderCellReuseIdentifier];
        [_tableView registerClass:[SZUserInfoCommonCell class] forCellReuseIdentifier:SZUserInfoCommonCellReuseIdentifier];

        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(NavigationStatusBarHeight);
            make.leading.trailing.bottom.equalTo(self.view);
        }];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.viewModel.titleArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel.titleArr[section] count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return  FIT(100);
    } else {
        return  FIT(50);
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        SZUserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:SZUserHeaderCellReuseIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell= [[SZUserHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SZUserHeaderCellReuseIdentifier];
        }
        cell.titleLabel.text=self.viewModel.titleArr[indexPath.section][indexPath.row];
      
        return cell;
    } else {
        SZUserInfoCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:SZUserInfoCommonCellReuseIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell= [[SZUserInfoCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SZUserInfoCommonCellReuseIdentifier];
        }
        
        cell.titleLabel.text=self.viewModel.titleArr[indexPath.section][indexPath.row];
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                [cell.detailBtn setTitle:[UserInfo sharedUserInfo].nickName forState:UIControlStateNormal];
            }else if (indexPath.row == 2){
                [cell.detailBtn setTitle:[UserInfo sharedUserInfo].loginName forState:UIControlStateNormal];
                [cell.rightBtn setHidden:YES];

                [cell.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(FIT(4));
                }];
                [cell.detailBtn updateConstraints];
            }else if(indexPath.row == 3){
                [cell.detailBtn setTitle:[UserInfo sharedUserInfo].registerTime forState:UIControlStateNormal];
                [cell.rightBtn setHidden:YES];
                [cell.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(FIT(4));
                }];
                [cell.detailBtn updateConstraints];

            }
        }else if (indexPath.section == 1){
            if (indexPath.row == 0) {
                if ([UserInfo sharedUserInfo].idAuthStatus == 2) {
                    [cell.detailBtn setTitle:NSLocalizedString(@"去认证", nil) forState:UIControlStateNormal];
                    [cell.detailBtn setTitleColor:MainThemeBlueColor forState:UIControlStateNormal];

                }else if([UserInfo sharedUserInfo].idAuthStatus == 1){
                    [cell.detailBtn setTitle:NSLocalizedString(@"审核中", nil) forState:UIControlStateNormal];
                    [cell.detailBtn setImage:[UIImage imageNamed:@"id_reviewing"] forState:UIControlStateNormal];
                    [cell.detailBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:FIT(5)];
                    [cell.rightBtn setHidden:YES];

                }else if([UserInfo sharedUserInfo].idAuthStatus == 0){
                    [cell.detailBtn setTitle:NSLocalizedString(@"已认证", nil) forState:UIControlStateNormal];
                    [cell.detailBtn setImage:[UIImage imageNamed:@"id_review_success"] forState:UIControlStateNormal];
                    [cell.detailBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:FIT(5)];
                    [cell.rightBtn setHidden:YES];
                    [cell.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(FIT(4));
                    }];
                    [cell.detailBtn updateConstraints];
                }
            }else if (indexPath.row == 1){
                if ([UserInfo sharedUserInfo].isBindTelephone) {
                    [cell.detailBtn setTitle:[UserInfo sharedUserInfo].telNumber forState:UIControlStateNormal];
                    [cell.rightBtn setHidden:YES];
                    [cell.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(FIT(4));
                    }];
                    [cell.detailBtn updateConstraints];
                }else{
                    [cell.detailBtn setTitle:NSLocalizedString(@"去绑定", nil) forState:UIControlStateNormal];
                    [cell.detailBtn setTitleColor:MainThemeBlueColor forState:UIControlStateNormal];

                }
            }else if(indexPath.row == 2){
                if ([UserInfo sharedUserInfo].isBindEmail) {
                    [cell.detailBtn setTitle:[UserInfo sharedUserInfo].email forState:UIControlStateNormal];
                    [cell.rightBtn setHidden:YES];
                    [cell.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(FIT(4));
                    }];
                    [cell.detailBtn updateConstraints];
                }else{
                    [cell.detailBtn setTitle:NSLocalizedString(@"去绑定", nil) forState:UIControlStateNormal];
                    [cell.detailBtn setTitleColor:MainThemeBlueColor forState:UIControlStateNormal];

                }
                
            }
            
        }
        return cell;
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
    if (indexPath.section == 0 ) {
        
        if (indexPath.row == 0) {
            SZEditHeadImageViewController* headerImageVC=[SZEditHeadImageViewController new];
            [self.navigationController pushViewController:headerImageVC animated:YES];
            
        }else if (indexPath.row == 1){
            
            SZEditNickNameViewController* nickNameVC=[SZEditNickNameViewController new];
            [self.navigationController pushViewController:nickNameVC animated:YES];
        }
       
    }else if (indexPath.section ==1){
        if (indexPath.row == 0) {
            if ([UserInfo sharedUserInfo].idAuthStatus == 2) {
                SZIdentityInfoViewController* iDInfoVC=[SZIdentityInfoViewController new];
                [self.navigationController pushViewController:iDInfoVC animated:YES];
            }
        }else if (indexPath.row == 1){
            if (![UserInfo sharedUserInfo].isBindTelephone) {
                SZBindMobileViewController* iDInfoVC=[SZBindMobileViewController new];
                [self.navigationController pushViewController:iDInfoVC animated:YES];
            }
        }else if (indexPath.row == 2){
            if (![UserInfo sharedUserInfo].isBindEmail) {
                SZBindEmailViewController* iDInfoVC=[SZBindEmailViewController new];
                [self.navigationController pushViewController:iDInfoVC animated:YES];
            }
        }
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
