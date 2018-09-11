//
//  SZOrderManagerViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/8/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZOrderManagerViewController.h"
#import "SZOrderListViewController.h"
#import "VTMagicController.h"

@interface SZOrderManagerViewController ()<VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) SHSegmentControl* segmentControl;
@property (nonatomic,strong) VTMagicController* magicController;
@property (nonatomic,assign) BOOL isAdOrder;



@end

@implementation SZOrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"我的广告", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
   
    
    [self segmentControl];
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    [_magicController.magicView reloadData];
    
    
}

-(SHSegmentControl *)segmentControl{
    
    if (!_segmentControl) {
        
        SHSegmentControl* segMentControl= [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, FIT(16), FIT(200), 30) items:@[NSLocalizedString(@"个人订单", nil),NSLocalizedString(@"广告订单", nil)]];
        segMentControl.titleNormalColor= MainThemeBlueColor;
        segMentControl.titleSelectColor= UIColorFromRGB(0xFFFFFF);
        segMentControl.viewSelectBackgroundColor=MainThemeBlueColor;
        segMentControl.viewNormalBackgroundColor=[UIColor whiteColor];
        segMentControl.backgroundColor = MainThemeBlueColor;
        [segMentControl setCircleBorderWidth:1 bordColor:MainThemeBlueColor radius:2];
        [segMentControl reloadViews];
        [self.headView addSubview:segMentControl];
        [segMentControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headView.mas_centerX);
            make.bottom.mas_equalTo(-(44-30)/2);
            make.width.mas_equalTo(FIT(200));
            make.height.mas_equalTo(30);
            
        }];
        @weakify(self);
        segMentControl.curClick = ^(NSInteger index) {
            @strongify(self);

            self.isAdOrder=index?YES:NO;
            
        };
        
        _segmentControl=segMentControl;
    }
    return  _segmentControl;
}
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.frame=CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight);
        _magicController.magicView.sliderColor = MainThemeColor;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 50.f;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.sliderWidth = 60;
        _magicController.magicView.sliderOffset = -5;
    
    }
    return _magicController;
}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return @[NSLocalizedString(@"未付款", nil),NSLocalizedString(@"已付款", nil),NSLocalizedString(@"已完成", nil),NSLocalizedString(@"已取消", nil),NSLocalizedString(@"申诉", nil)];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:UIColorFromRGB(0x666565) forState:UIControlStateNormal];
        [menuItem setTitleColor:MainThemeColor forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    static NSString *recomId =@"recom.indetifier";
    recomId=FormatString(@"recom.identifier:%lu",(unsigned long)pageIndex) ;
    NSLog(@"viewcontroller pageIndex:%ld",pageIndex);
    
    
    SZOrderListViewController *commissionVC = [magicView dequeueReusablePageWithIdentifier:recomId];
    if (!commissionVC) {
        commissionVC = [[SZOrderListViewController alloc] init];
        [commissionVC.headView setHidden:YES];
    }
    commissionVC.viewModel.orderStateType=pageIndex;
    commissionVC.viewModel.isAdOrder=self.isAdOrder;


    return commissionVC;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
