//
//  AddSelfSelectViewController.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "AddSelfSelectViewController.h"
#import "AddSelfSelectSubViewController.h"

@interface AddSelfSelectViewController (){
    UIButton * leftMenu;
}
@property (nonatomic,strong)NSMutableArray * menuList;

@end

@implementation AddSelfSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self configMagicView];
    [self configMagicViewsHeaderSubViews];
    self.menuList = [SZBase sharedSZBase].areaNameArr;
    [self.magicView reloadData];
}

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
        [menuItem setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [menuItem setTitleColor:HomeLightColor forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    NSUInteger recomIdIndex = pageIndex;

    NSString *recomId = FormatString(@"addSelf.identifier%lu",(unsigned long)recomIdIndex);
    AddSelfSelectSubViewController *addSelfSubViewController = [magicView dequeueReusablePageWithIdentifier:recomId];
    if (!addSelfSubViewController) {
        addSelfSubViewController = [[AddSelfSelectSubViewController alloc] init];
    }
    addSelfSubViewController.areaName = self.menuList[pageIndex];
    BigAreaModel * bigModel = [SZBase sharedSZBase].areaModelArr[pageIndex];
    addSelfSubViewController.fCoinType = bigModel.fid;
    return addSelfSubViewController;
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
}
-(void)configMagicViewsHeaderSubViews
{
    UILabel * titleLabel = [UILabel new];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = kFontSize(17);
    titleLabel.text = NSLocalizedString(@"添加自选", nil);
    [self.magicView.headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17);
        make.bottom.mas_equalTo(-13);
        make.centerX.mas_equalTo(self.magicView.headerView.mas_centerX);
    }];

    
    leftMenu = [[UIButton alloc]init];
    [leftMenu setImage:kIMAGE_NAMED(@"marketReturn") forState:UIControlStateNormal];
    [leftMenu setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [leftMenu addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.magicView.headerView addSubview:leftMenu];
    [leftMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.bottom.mas_equalTo(2);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
}
-(void)menuAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableArray *)menuList{
    if (!_menuList) {
        _menuList = [NSMutableArray array];
    }
    return _menuList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
