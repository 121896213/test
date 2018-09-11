//
//  MarketHomeViewController.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "MarketHomeViewController.h"
#import "MarketHomeSubViewController.h"
#import "BigAreaModel.h"
#import "AddSelfSelectViewController.h"
#import "SelfSelectEditViewController.h"

@interface MarketHomeViewController ()<VTMagicViewDelegate,VTMagicViewDataSource>{
    BOOL _isShowSelfSelect;//显示自选
    UIButton * leftMenu; //编辑
    UIButton * rightMenu;
}

//@property (nonatomic,strong)VTMagicView * magicView;
@property (nonatomic,strong)UIButton * marketButton;//行情
@property (nonatomic,strong)UIButton * selfSelButton;//自选

@property (nonatomic,strong)NSMutableArray * menuList;
@property (nonatomic,strong)UIButton * retryBtn;


@end

@implementation MarketHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self configMagicView];
    [self requestData];
}

-(void)requestData
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/blockCointype.do",BaseHttpUrl];

    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager get:urlStr appendParameters:nil successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            NSArray * array = responseObject[@"list"];
            [[SZBase sharedSZBase]dealModelWithArray:array];
            weakSelf.menuList = [SZBase sharedSZBase].areaNameArr;
            [weakSelf configMagicViewsHeaderSubViews];
            [weakSelf.magicView reloadData];
            [weakSelf hideRetryButton];
        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
            [weakSelf showRetryButton];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        [weakSelf showRetryButton];
    }];
}
#pragma mark -------- MagicView deleget --------------
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return self.menuList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [menuItem setTitleColor:HomeLightColor forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    NSUInteger recomIdIndex = pageIndex;
    if (_isShowSelfSelect) {
        recomIdIndex = recomIdIndex + self.menuList.count;
    }
    NSString *recomId = FormatString(@"recom.identifier%lu",(unsigned long)recomIdIndex);
    MarketHomeSubViewController *homeSubViewController = [magicView dequeueReusablePageWithIdentifier:recomId];
    if (!homeSubViewController) {
        homeSubViewController = [[MarketHomeSubViewController alloc] init];
    }
    homeSubViewController.areaName = self.menuList[pageIndex];
    BigAreaModel * bigModel = [SZBase sharedSZBase].areaModelArr[pageIndex];
    homeSubViewController.fCoinType = bigModel.fid;
    homeSubViewController.isSelfSelect = _isShowSelfSelect;
    return homeSubViewController;
}

-(void)configMagicView{
    
    self.magicView.navigationColor = WhiteColor;
    self.magicView.sliderColor = HomeLightColor;
    self.magicView.layoutStyle = VTLayoutStyleDivide;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.dataSource = self;
    self.magicView.delegate = self;

    [self.magicView setHeaderHidden:NO];
    [self.magicView setHeaderHeight:NaviBarHeight + StatusBarHeight];
    self.magicView.headerView.backgroundColor = WhiteColor;

//    self.magicView.sliderWidth = 60;
//    self.magicView.sliderOffset = -5;
}
-(void)configMagicViewsHeaderSubViews
{
    UIView *  _superForMenuView = [[UIView alloc] init];
    _superForMenuView.layer.borderColor = HomeLightColor.CGColor;
    _superForMenuView.layer.borderWidth = 1.0f;
    _superForMenuView.layer.cornerRadius = 2.0f;
    _superForMenuView.clipsToBounds = YES;
    [self.magicView.headerView addSubview:_superForMenuView];
    [_superForMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-7);
        make.centerX.mas_equalTo(self.magicView.headerView);
    }];
    NSArray * array = @[@"行情",@"自选"];
    CGFloat each_w = 80;
    for (int i = 0; i< array.count; i++) {
        NSString * area = [array objectAtIndex:i];
        area = NSLocalizedString(area, nil);
        UIButton * button = [[UIButton alloc]init];
        [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
        [button setTitleColor:HomeLightColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:area forState:UIControlStateNormal];
        [_superForMenuView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.leading.mas_equalTo(each_w * i);
            make.width.mas_equalTo(each_w);
        }];
        if (i == 0) {
            self.marketButton = button;
            button.selected = YES;
            button.backgroundColor = HomeLightColor;
            _isShowSelfSelect = NO;
        }else{
            self.selfSelButton = button;
        }
    }
    
    leftMenu = [[UIButton alloc]init];
    [leftMenu setImage:kIMAGE_NAMED(@"editSelfSel") forState:UIControlStateNormal];
    [leftMenu setTitle:NSLocalizedString(@"编辑", nil) forState:UIControlStateNormal];
    [leftMenu setTitleColor:UIColorFromRGB(0x838A9A) forState:UIControlStateNormal];
    leftMenu.titleLabel.font = kFontSize(13);
    [leftMenu setTitleEdgeInsets:UIEdgeInsetsMake(0, 9, 0, 0)];
    [leftMenu addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.magicView.headerView addSubview:leftMenu];
    [leftMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(5);
        make.bottom.mas_equalTo(-2);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(56);
    }];
    
    rightMenu = [[UIButton alloc]init];
    [rightMenu setImage:kIMAGE_NAMED(@"search") forState:UIControlStateNormal];
    [rightMenu setTitleColor:UIColorFromRGB(0x838A9A) forState:UIControlStateNormal];
    [rightMenu addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightMenu setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.magicView.headerView addSubview:rightMenu];
    [rightMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.bottom.mas_equalTo(-2);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    leftMenu.hidden = YES;
}
-(void)menuAction:(UIButton *)sender
{
    if (sender == _marketButton )
    {
        leftMenu.hidden = YES;
        _marketButton.selected = YES;
        _selfSelButton.selected = NO;
        _marketButton.backgroundColor = HomeLightColor;
        _selfSelButton.backgroundColor = WhiteColor;
        _isShowSelfSelect = NO;
        [self.magicView reloadData];
    }else if (sender == _selfSelButton)
    {
        leftMenu.hidden = NO;
        _marketButton.selected = NO;
        _selfSelButton.selected = YES;
        _marketButton.backgroundColor =  WhiteColor;
        _selfSelButton.backgroundColor =  HomeLightColor;
        _isShowSelfSelect = YES;
        [self.magicView reloadData];
    }else if (sender == leftMenu){
        SelfSelectEditViewController * editVC = [[SelfSelectEditViewController alloc]init];
        [self.navigationController pushViewController:editVC animated:YES];
    }else if (sender == rightMenu){
        AddSelfSelectViewController * addVC = [[AddSelfSelectViewController alloc]init];
        [self.navigationController pushViewController:addVC animated:YES];
    }
}
-(void)showRetryButton{
    [self.view addSubview:self.retryBtn];
    [self.view bringSubviewToFront:self.retryBtn];
    [self.retryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.leading.mas_greaterThanOrEqualTo(15);
        make.trailing.mas_lessThanOrEqualTo(-15);
        make.height.mas_equalTo(50);

    }];
}

-(void)hideRetryButton{
    [self.retryBtn removeFromSuperview];
}

-(UIButton *)retryBtn{
    if (!_retryBtn) {
        _retryBtn = [UIButton new];
        [_retryBtn setTitleColor:MainThemeColor forState:UIControlStateNormal];
        [_retryBtn setTitle:NSLocalizedString(@"网络异常，请点击重试", nil) forState:UIControlStateNormal];
        _retryBtn.titleLabel.font = kFontSize(15);
        [_retryBtn addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryBtn;
}

-(NSMutableArray *)menuList{
    if (!_menuList) {
        _menuList = [NSMutableArray array];
    }
    return _menuList;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
