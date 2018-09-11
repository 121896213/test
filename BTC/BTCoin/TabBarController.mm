//
//  TabBarController.m
//  99SVR
//
//  Created by Jiangys on 16/3/14.
//  Copyright © 2016年 Jiangys . All rights reserved.

#import "TabBarController.h"
#import "GFNavigationController.h"
#import "UIAlertController+Block.h"
#import "AppDelegate.h"
#import "SZPropertyViewController.h"
#import "SZWalletViewController.h"
#import "SZPersonCenterViewController.h"
#import "MarketHomeViewController.h"
#import "LoginViewController.h"
#import "SZC2CViewController.h"
#import "PTWebViewController.h"
#import "TradeMainViewController.h"

#define NetworkErrorViewDelay       10.0f
@interface TabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) Reachability *hostReach;
/**tabbar背景图*/
@property (nonatomic , strong) UIImageView *tabbarBackImageView;
@property(nonatomic,assign) NSUInteger selectedLastIndex;

@end

@implementation TabBarController


static TabBarController *tabbarController = nil;

+(TabBarController *)singletonTabBarController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
    ^{
        tabbarController = [[TabBarController alloc] init];
        [tabbarController setConfiguration];
    });
    
    return tabbarController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBar.backgroundColor = [UIColor clearColor];
        self.tabBar.translucent = NO;
//        [self.tabBar setBarTintColor:NavBarColor];
        [self.tabBar setBarTintColor:[UIColor whiteColor]];
        [self setConfiguration];
    }
    return self;
}

#pragma mark - 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)versionUpdate
{
    for (UIViewController *viewController in self.viewControllers)
    {
        [viewController removeFromParentViewController];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setUpAllChildViewControllers];
    });
}

#pragma mark 配置
- (void)setConfiguration
{
    [self.view setBackgroundColor:UIColorFromRGB(0xffffff)];
   
    // 网络检测
    _hostReach = [Reachability reachabilityWithHostName:@"www.163.com"];
    [[NSNotificationCenter defaultCenter] addObserver:tabbarController
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    //开启网络通知
    [_hostReach startNotifier];
    // 统一设置Item的文字属性
    [self setUpItemTextAttrs];
    // 添加所以子控制器
    [self setUpAllChildViewControllers];
}

#pragma mark 配置控制器
- (void)setUpAllChildViewControllers
{
    MarketHomeViewController* marketVC = [[MarketHomeViewController alloc] init];
//    MarketViewController * marketVC = [[MarketViewController alloc] init];
    GFNavigationController * marketNav = [[GFNavigationController alloc] initWithRootViewController:marketVC];
    
//    TradeViewController * tradeVC = [[TradeViewController alloc] init];
//    TradeHomeViewController * tradeVC = [[TradeHomeViewController alloc] init];
    TradeMainViewController * tradeVC = [[TradeMainViewController alloc] init];
    GFNavigationController *tradeNav = [[GFNavigationController alloc] initWithRootViewController:tradeVC];
    
//      SZC2CViewController* c2cVC=[[SZC2CViewController alloc]init];
    PTWebViewController* c2cVC=[[PTWebViewController alloc]init];
    c2cVC.webUrl = [NSURL URLWithString:SZC2CH5Url];
    GFNavigationController * c2cVCNav = [[GFNavigationController alloc] initWithRootViewController:c2cVC];
//
//    SZPropertyViewController* propertyVC=[[SZPropertyViewController alloc]init];
//    GFNavigationController * propertyNav = [[GFNavigationController alloc] initWithRootViewController:propertyVC];
    SZWalletViewController* walletVC=[[SZWalletViewController alloc]init];
    GFNavigationController * propertyNav = [[GFNavigationController alloc] initWithRootViewController:walletVC];
    
    SZPersonCenterViewController * personCenterVC = [[SZPersonCenterViewController alloc] init];
    GFNavigationController *personCenterNav = [[GFNavigationController alloc] initWithRootViewController:personCenterVC];
    self.viewControllers = @[marketNav,tradeNav,c2cVCNav,propertyNav,personCenterNav];
    
//    NSArray * titleArray = @[@"行情",@"交易",@"C2C",@"钱包",@"我"];
    NSArray * titleArray = @[@"行情",@"币币",@"C2C",@"钱包",@"我"];

    NSArray * normalImageArray = @[@"nav_home_n",@"nav_market_n",@"nav_c2c_n",@"nav_transaction_n",@"nav_my_n"];
    NSArray * selectImageArray = @[@"nav_home_h",@"nav_market_h",@"nav_c2c_h",@"nav_transaction_h",@"nav_my_h"];
    
    for (int i=0; i!=self.viewControllers.count; i++)
    {
        UIViewController *viewcontroller = self.viewControllers[i];
        [self setUpOneViewController:viewcontroller title:titleArray[i] image:normalImageArray[i] selectImage:selectImageArray[i]];
    }
    self.selectedLastIndex=0;
    self.delegate=self;
}

/**
 *  添加一个子控制器
 */
- (void)setUpOneViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    vc.title = NSLocalizedString(title, nil);
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xbcbec6)} forState:UIControlStateNormal];
//    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainThemeColor} forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x9B9FB3)} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x355191)} forState:UIControlStateSelected];
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
}

/**
 *  统一设置Item文字的属性
 */
- (void)setUpItemTextAttrs{
    // 统一设置Item文字的属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x919191);
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    // 选中状态
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0xFFBD5B);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    
}

-(UIImageView *)tabbarBackImageView{
    
    if (!_tabbarBackImageView) {
        
        _tabbarBackImageView = [[UIImageView alloc]initWithFrame:(CGRect){CGPointZero,self.tabBar.frame.size}];
    }
    return _tabbarBackImageView;
}

#pragma mark - 通知回调处理
/**
 *  网络更改通知
 */
-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable)
    {
        DLog(@"网络状态:中断");
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        __weak UIWindow *__windows = app.window;
        dispatch_async(dispatch_get_main_queue(),
        ^{
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NetworkErrorViewDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
               if (NotReachable == [curReach currentReachabilityStatus]) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                       [UIAlertController createAlertViewWithTitle:@"提示" withViewController:__windows.rootViewController withCancleBtnStr:@"取消" withOtherBtnStr:@"设置" withMessage:@"网络连接失败，请点击设置去检查网络" completionCallback:^(NSInteger index) {
                           
                           if (1 == index) {
                               NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                               
                               if (DeviceValue < 10.0) {
                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Setting"]];
                               } else {
                                   if([[UIApplication sharedApplication] canOpenURL:url]) {
                                       [[UIApplication sharedApplication] openURL:url];
                                   }
                               }
                           }
                       }];
                   });
                   
//                   [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_NETWORK_ERR_VC object:nil];
                   
                    self.nowStatus = NotReachable;
//                   KUserSingleton.nowNetwork = 0;
               }
           });
        });
        
        return ;
    }
    else if(status == ReachableViaWiFi)
    {
        self.nowStatus = status;
//        KUserSingleton.nowNetwork = 1;
//        [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_NETWORK_OK_VC object:nil];
    }
    else if(status == ReachableViaWWAN)
    {
         self.nowStatus = status;
//        KUserSingleton.nowNetwork = 2;
//        [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_NETWORK_OK_VC object:nil];
    }
}

#pragma mark - 横坚屏限定
- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

#pragma mark 皮肤切换
//-(void)changeThemeSkin:(NSNotification *)notfication{
//    DLog(@"切换皮肤");
//    @WeakObj(tabbarController);
//    dispatch_async(dispatch_get_main_queue(),
//    ^{
//        tabbarControllerWeak.tabbarBackImageView.backgroundColor = ThemeSkinManagers.tabbarBackColor;
//        for (int i=0; i!=tabbarController.viewControllers.count; i++) {
//            UIViewController *viewcontroller = tabbarController.viewControllers[i];
//            [tabbarControllerWeak setUpOneViewController:viewcontroller title:ThemeSkinManagers.titleArray[i] image:ThemeSkinManagers.normalImageArray[i] selectImage:ThemeSkinManagers.selectImageArray[i]];
//        }
//        [tabbarControllerWeak setUpItemTextAttrs];
//    });
//}
#pragma mark - public methods
- (UIViewController *)getNavControl
{
    UINavigationController *nav=
    (UINavigationController*)[self.childViewControllers objectAtIndex:self.selectedIndex];
    UIViewController *controll = [nav visibleViewController];
    return controll;
}
- (void)selectedIndex:(NSUInteger)sIndex ToRoot:(BOOL)toroot {
    [self setSelectedIndex:sIndex];
    if (toroot) {
        UINavigationController *nav= (UINavigationController*)[self.childViewControllers objectAtIndex:self.selectedIndex];
        [nav popToRootViewControllerAnimated:YES];
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

    self.selectedLastIndex=tabBarController.selectedIndex;
//    if (tabBarController.selectedIndex == 3 || tabBarController.selectedIndex == 2) {
//        if (![UserInfo isLogin]) {
//
//            LoginViewController* loginVC=[[LoginViewController alloc]init];
//            GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
//            [self presentViewController:loginNav animated:YES completion:^{
//
//            }];
//        }
//    }
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
    if ([viewController.childViewControllers[0] isKindOfClass:[PTWebViewController class]] || [viewController.childViewControllers[0] isKindOfClass:[SZWalletViewController class]]) {
        if (![UserInfo isLogin]) {
            
            LoginViewController* loginVC=[[LoginViewController alloc]init];
            GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:loginNav animated:YES completion:^{
    
            }];
            @weakify(self);
            loginVC.boolBlock = ^(BOOL boolValue) {
                @strongify(self);
                if (!boolValue) {
                     [tabBarController setSelectedIndex:self.selectedLastIndex];
                }else{
                    [[SZSundriesCenter instance] pushTaskToMainThreadQueue:^{
                        if ([viewController.childViewControllers[0] isKindOfClass:[PTWebViewController class]]) {
                            [tabBarController setSelectedIndex:2];
                        } else {
                            [tabBarController setSelectedIndex:3];
                        }
                    }];
                  
                    
                }
            };
            return NO;
        }
    }
    NSUInteger shouldSelectIndex = [tabBarController.viewControllers indexOfObject:viewController];

    CATransition *animation = [CATransition animation];
    animation.duration = 0.10F;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    if (tabBarController.selectedIndex > shouldSelectIndex) {
        animation.subtype = kCATransitionFromLeft;
    } else {
        animation.subtype = kCATransitionFromRight;
    }
    // 与百度上一般文章不一样
    [[[tabBarController valueForKey:@"_viewControllerTransitionView"] layer] addAnimation:animation forKey:@"animation"];

    return YES;
    
};

@end
