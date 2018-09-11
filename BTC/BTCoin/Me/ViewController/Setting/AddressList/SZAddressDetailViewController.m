//
//  SZAddressDetailViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZAddressDetailViewController.h"
#import "SZAddressDetailCell.h"
#import "SZAddAddressViewController.h"
#import "SZAddressDetailViewModel.h"
#import "SZAddressDetailCellViewModel.h"
#import "SZAddressListViewController.h"
@interface SZAddressDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SZAddressEditDelegate>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,copy)  NSArray* currentData;
@property (nonatomic,strong) UIButton* addAddressBtn;
@property (nonatomic,copy) NSString* coinType;
@end

@implementation SZAddressDetailViewController

- (instancetype)initWithCoinCellViewModel:(SZAddressListCellViewModel*)viewModel
{
    self = [super init];
    if (self) {
        self.view.backgroundColor=MainBackgroundColor;
        self.viewModel.coinCellViewModel=viewModel;
        [self setSubviews];
        [self addAcitons];
    }
    return self;
}


-(SZAddressDetailViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZAddressDetailViewModel new];
    }
    return _viewModel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)setSubviews{
    
    self.currentData=[[NSArray alloc]init];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight-NavigationStatusBarHeight-FIT3(150)-FIT3(77)*2) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[SZAddressDetailCell class] forCellReuseIdentifier:SZAddressDetailCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=MainBackgroundColor;

    
    self.addAddressBtn=[UIButton new];
    [self.addAddressBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.addAddressBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.addAddressBtn setTitle:NSLocalizedString(@"添加地址", nil) forState:UIControlStateNormal];
    [self.addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.addAddressBtn];
    [self.addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT3(-77));
        make.left.mas_equalTo(FIT3(48));
        make.right.mas_equalTo(FIT3(-48));
        make.height.mas_equalTo(FIT3(150));
    }];
    [self.addAddressBtn setGradientBackGround];
    [self.addAddressBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    [ShareFunction setCircleBorder:self.addAddressBtn];
    
    
    [self setTitleText:NSLocalizedString(@"地址详情", nil)];
   [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    [self setTitleText:NSLocalizedString(FormatString(@"%@",self.viewModel.coinCellViewModel.model.fShortName), nil)];
    self.title=self.viewModel.coinCellViewModel.model.fShortName;
    
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self hideMBProgressHUD];
        [self.tableView reloadData];
        if (self.viewModel.addressDetailArr.count) {
            [self hideNoResultView];
        }else{
            [self showNoResultView];
        }
        
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];

    }];
    
    [self showLoadingMBProgressHUD];
    [self.viewModel getAddressDetail:nil];
    
}
-(void)addAcitons{
    
    @weakify(self);
    [[self.addAddressBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        SZAddAddressViewController* addAddressVC=[[SZAddAddressViewController alloc]initWithIsEdit:NO];
        addAddressVC.viewModel.listCellViewModel=self.viewModel.coinCellViewModel;
        addAddressVC.delegate=self;
        [self.navigationController pushViewController:addAddressVC animated:YES];
    
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.addressDetailArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  SZAddressDetailCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     SZAddressDetailCell *cell = [[SZAddressDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SZAddressDetailCellReuseIdentifier];
//    if (indexPath.row%2 == 1) {
//        cell.backgroundColor=MainBackgroundColor;
//    }else if (indexPath.row%2 ==0){
//        cell.backgroundColor=[UIColor whiteColor];
//    }
    SZAddressDetailCellViewModel* cellViewModel= [self.viewModel addressDetailCellViewModelAtIndexPath:indexPath];
    cell.viewModel=cellViewModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (![[AppUtil getLastVCWithSrcViewController:self] isKindOfClass:[SZAddressListViewController class]]) {
        SZAddressDetailCellViewModel* cellViewModel= [self.viewModel addressDetailCellViewModelAtIndexPath:indexPath];
        [self.delegate reader:self didSelectResult:cellViewModel.model.fadderess];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        SZAddressDetailCellViewModel* cellViewModel= [self.viewModel addressDetailCellViewModelAtIndexPath:indexPath];
        SZAddAddressViewController* addAddressVC=[[SZAddAddressViewController alloc]initWithIsEdit:YES];
        addAddressVC.viewModel.listCellViewModel=self.viewModel.coinCellViewModel;
        addAddressVC.cellViewModel=cellViewModel;
        addAddressVC.delegate=self;
        [self.navigationController pushViewController:addAddressVC animated:YES];
        
    }
    
}
-(void)editAddressSuccess:(SZAddAddressViewController *)addAddressVC{
    [self showLoadingMBProgressHUD];
    [self.viewModel getAddressDetail:nil];
}

@end
