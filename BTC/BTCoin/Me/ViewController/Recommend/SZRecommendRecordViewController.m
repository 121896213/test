//
//  SZRecommendRecordViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRecommendRecordViewController.h"
#import "SZCommissionRecordViewController.h"
#import "SZPromotionRecordViewController.h"
@interface SZRecommendRecordViewController ()<VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic,strong) VTMagicController* magicController;
@end

@implementation SZRecommendRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"推荐奖励明细", nil)];

    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    [_magicController.magicView reloadData];
}

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.frame=CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight);
        _magicController.magicView.sliderColor = MainThemeColor;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 40.f;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.sliderWidth = 60;
       _magicController.magicView.sliderOffset = -5;
    }
    return _magicController;
}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return @[NSLocalizedString(@"返佣记录", nil),NSLocalizedString(@"推广奖励", nil)];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [menuItem setTitleColor:MainThemeColor forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    static NSString *recomId =@"recom.indetifier";
    recomId=FormatString(@"recom.identifier:%lu",(unsigned long)pageIndex) ;
    if (pageIndex == 0) {
        SZCommissionRecordViewController *commissionVC = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!commissionVC) {
            commissionVC = [[SZCommissionRecordViewController alloc] init];
            [commissionVC.headView setHidden:YES];
        }
        return commissionVC;

    } else {
        SZPromotionRecordViewController *promotionVC = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!promotionVC) {
            promotionVC = [[SZPromotionRecordViewController alloc] init];
            [promotionVC.headView setHidden:YES];

        }
        return promotionVC;
        
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
