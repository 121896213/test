//
//  AppDelegate.m
//  BTCoin
//
//  Created by LionIT on 22/02/2018.
//  Copyright © 2018 LionIT. All rights reserved.
#import "AppDelegate.h"
#import "FirstRunViewController.h"
#import "LoginViewController.h"
#define kHadRunKey @"kHadRunKey"

@interface AppDelegate ()
@property (nonatomic,assign) BOOL isNeedAlertUpdate;//
@property (nonatomic,strong) NSURL * updateUrl;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //友盟appkey 5b29f783f29d987304000016
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [[languages objectAtIndex:0] substringToIndex:2];
    if ([currentLanguage isEqualToString:@"zh"]) {
        language_sys = @"zh";
    }else{
        language_sys = @"en";
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    BOOL ret = [[NSUserDefaults standardUserDefaults]boolForKey:kHadRunKey];
    if (ret) {
        self.rootTabBarController=[TabBarController singletonTabBarController];
        self.window.rootViewController =self.rootTabBarController;
    }else{
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kHadRunKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.window.rootViewController = [[FirstRunViewController alloc]init];
    }
    [self.window makeKeyAndVisible];
    @weakify(self);
    SZHTTPSReqManager.presentLoginVC = ^(id responseObject) {
        @strongify(self);
        LoginViewController* loginVC=[LoginViewController new];
        GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
        [self.window.rootViewController presentViewController:loginNav animated:YES completion:^{
        }];
    };
    [self checkHaveUpdate];
    return YES;
}
-(void)checkHaveUpdate{
    NSString * str = [NSString stringWithFormat:@"%@/app/version.do",BaseHttpUrl];
    WeakSelf(self);
    [SZHTTPSReqManager SZPostRequestWithUrlString:str appendParameters:@{@"type":@"2"} bodyParameters:nil successBlock:^(id responseObject) {
        if ([responseObject[@"code"] integerValue]==0) {
            if (![responseObject[@"msg"] isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            NSString *vison2 = responseObject[@"msg"][@"fversion"];
            NSString *urlStr = responseObject[@"msg"][@"furl"];
            _updateUrl = [NSURL URLWithString:urlStr];
            if ([weakSelf compareVersion:vison2]){
                weakSelf.isNeedAlertUpdate = YES;
                [weakSelf showAlert];
            }
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提醒", nil)
                                                                   message:NSLocalizedString(@"BTK有新的版本可以更新", nil) preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
//    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"去更新", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        if ([[UIApplication sharedApplication]canOpenURL:_updateUrl]) {
            [[UIApplication sharedApplication]openURL:_updateUrl];
        }
    }];
//    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

-(BOOL)compareVersion:(NSString *)sqlVersion
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *vison = infoDict[@"CFBundleShortVersionString"];
    NSArray *v1Array = [vison componentsSeparatedByString:@"."];
    NSArray *v2Array = [sqlVersion componentsSeparatedByString:@"."];
    // 取字段最少的，进行循环比较
    NSInteger smallCount = (v1Array.count > v2Array.count) ? v2Array.count : v1Array.count;
    for (int i = 0; i < smallCount; i++) {
        NSInteger value1 = [[v1Array objectAtIndex:i] integerValue];
        NSInteger value2 = [[v2Array objectAtIndex:i] integerValue];
        if (value1 > value2) {
            return NO;
        } else if (value1 < value2) {
            return YES;
        }
    }
    // 版本可比较字段相等，则字段多的版本高于字段少的版本。
    if (v1Array.count >= v2Array.count) {
        return NO;
    } else{
        return YES;
    }
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if(self.isCanRota) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[SZSocket sharedSZSocket]destroyWebsocket];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    [[SZSocket sharedSZSocket]openSocket];
    if (self.isNeedAlertUpdate && self.updateUrl) {
        [self showAlert];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[SZSocket sharedSZSocket]destroyWebsocket];
}

@end
