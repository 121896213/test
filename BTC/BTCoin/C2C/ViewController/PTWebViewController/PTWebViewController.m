//
//  PTUserAgreementVController.m
//  PT_VRBrowser
//
//  Created by GuoShengyong on 17/5/27.
//  Copyright © 2017年 bql. All rights reserved.
//

#import "PTWebViewController.h"
#import "LoginViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

static void *KINWebBrowserContext = &KINWebBrowserContext;

@interface PTWebViewController () <UIAlertViewDelegate>

@property (nonatomic, assign) BOOL previousNavigationControllerToolbarHidden, previousNavigationControllerNavigationBarHidden;
@property (nonatomic, strong) UIBarButtonItem *backButton, *fixedCenterSeparator, *forwardButton, *refreshButton, *stopButton, *fixedSeparator;
@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, strong) UIPopoverController *actionPopoverController;
@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@property (nonatomic, strong) NSURL *URLToLaunchWithPermission;
@property (nonatomic, strong) UIAlertView *externalAppPermissionAlertView;

@property (nonatomic, strong) WKWebViewConfiguration *configuration;
@end

@implementation PTWebViewController

#pragma mark - Static Initializers

+ (PTWebViewController *)webBrowser {
    PTWebViewController *webBrowserViewController = [PTWebViewController webBrowserWithConfiguration:nil];
    return webBrowserViewController;
}

+ (PTWebViewController *)webBrowserWithConfiguration:(WKWebViewConfiguration *)configuration {
    PTWebViewController *webBrowserViewController = [[self alloc] initWithConfiguration:configuration];
    return webBrowserViewController;
}

+ (UINavigationController *)navigationControllerWithWebBrowser {
    PTWebViewController *webBrowserViewController = [[self alloc] initWithConfiguration:nil];
    return [PTWebViewController navigationControllerWithBrowser:webBrowserViewController];
}

+ (UINavigationController *)navigationControllerWithWebBrowserWithConfiguration:(WKWebViewConfiguration *)configuration {
    PTWebViewController *webBrowserViewController = [[self alloc] initWithConfiguration:configuration];
    return [PTWebViewController navigationControllerWithBrowser:webBrowserViewController];
}

+ (UINavigationController *)navigationControllerWithBrowser:(PTWebViewController *)webBrowser {
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:webBrowser action:@selector(doneButtonPressed:)];
    [webBrowser.navigationItem setRightBarButtonItem:doneButton];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webBrowser];
    return navigationController;
}

#pragma mark - Initializers

- (id)init {
    
    
    if (([[self.webUrl absoluteString] rangeOfString:@"ibcar.net"].location != NSNotFound)) {
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        NSString *javaScriptSource = @"var element=document.getElementsByClassName(\"bar bar-nav\");var header = element[0].parentNode;header.removeChild(element[0])";
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:javaScriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [userContentController addUserScript:userScript];
        // WKWebView的配置
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        
        return [self initWithConfiguration:configuration];
    }else{
        return [self initWithConfiguration:nil];
    }
}

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration {
    self = [super init];
    if(self) {
      
        self.configuration= [[WKWebViewConfiguration alloc]init];
        self.configuration.preferences = [[WKPreferences alloc] init];
        self.configuration.preferences.minimumFontSize = 10;
        self.configuration.preferences.javaScriptEnabled = YES;
        self.configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        self.configuration.userContentController = [[WKUserContentController alloc] init];
        self.configuration.processPool = [[WKProcessPool alloc] init];
        WKUserContentController* userController = [[WKUserContentController alloc]init];
        [userController addScriptMessageHandler:self name:@"login"];
        self.configuration.userContentController = userController;
        self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.configuration];
        
        self.showsURLInNavigationBar = NO;
        self.showsPageTitleInNavigationBar = YES;
        self.externalAppPermissionAlertView = [[UIAlertView alloc] initWithTitle:@"Leave this app?" message:@"This web page is trying to open an outside app. Are you sure you want to open it?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Open App", nil];

    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.previousNavigationControllerToolbarHidden = self.navigationController.toolbarHidden;
    self.previousNavigationControllerNavigationBarHidden = self.navigationController.navigationBarHidden;
    CGRect rect = CGRectMake(0, NavigationStatusBarHeight, self.view.width, self.view.height-NavigationStatusBarHeight);
    [self.wkWebView setFrame:rect];
    [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.wkWebView setNavigationDelegate:self];
    [self.wkWebView setUIDelegate:self];

    [self.wkWebView setMultipleTouchEnabled:YES];
    [self.wkWebView setAutoresizesSubviews:YES];
    [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
    [self.view addSubview:self.wkWebView];
    [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:KINWebBrowserContext];
  
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [self.progressView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-self.progressView.frame.size.height, self.view.frame.size.width, self.progressView.frame.size.height)];
    [self.progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
  
//    if(IOS9_OR_LATER){
//        NSLog(@"%@",[self.webUrl absoluteString]);
//        if (([[self.webUrl absoluteString] rangeOfString:@"ibcar.net"].location != NSNotFound)) {
//           self.wkWebView.customUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML, like Gecko) Mobile/14F89 MicroMessenger";
//        }
//    }
    NSLog(@"WKWebview URL String:%@",self.webUrl.absoluteString);
    
    if (self.webUrl) {
        [self loadURL:self.webUrl];
    }
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [[languages objectAtIndex:0] substringToIndex:2];
    NSString* language=@"CN";
    if (![currentLanguage isEqualToString:@"zh"]) {
        language=@"EN";
    }
    NSString* url=[self.webUrl.absoluteString stringByAppendingString:FormatString(@"?source=APP&lang=%@&tooken=%@",language,[UserInfo sharedUserInfo].redisTokenKey)];
    NSLog(@"C2C URL:%@",url);
    [self loadURLString:url];
    

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"SZExitSuccess" object:nil]subscribeNext:^(id x) {


        [self.wkWebView removeFromSuperview];
        self.wkWebView=nil;
        
        self.configuration= [[WKWebViewConfiguration alloc]init];
        self.configuration.preferences = [[WKPreferences alloc] init];
        self.configuration.preferences.minimumFontSize = 10;
        self.configuration.preferences.javaScriptEnabled = YES;
        self.configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        self.configuration.userContentController = [[WKUserContentController alloc] init];
        self.configuration.processPool = [[WKProcessPool alloc] init];
        WKUserContentController* userController = [[WKUserContentController alloc]init];
        [userController addScriptMessageHandler:self name:@"login"];
        self.configuration.userContentController = userController;
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.configuration];
        CGRect rect = CGRectMake(0, NavigationStatusBarHeight, self.view.width, self.view.height-NavigationStatusBarHeight);
        [self.wkWebView setFrame:rect];
        [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.wkWebView setNavigationDelegate:self];
        [self.wkWebView setUIDelegate:self];
        [self.wkWebView setMultipleTouchEnabled:YES];
        [self.wkWebView setAutoresizesSubviews:YES];
        [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
        [self.view addSubview:self.wkWebView];

        [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:KINWebBrowserContext];
     
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar addSubview:self.progressView];
    [self updateToolbarState];
    [self.headView setHidden:YES];
    
    if([UserInfo isLogin]){

        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [[languages objectAtIndex:0] substringToIndex:2];
        NSString* language=@"CN";
        if (![currentLanguage isEqualToString:@"zh"]) {
            language=@"EN";
        }
        NSString* url=[self.webUrl.absoluteString stringByAppendingString:FormatString(@"?source=APP&lang=%@&tooken=%@",language,[UserInfo sharedUserInfo].redisTokenKey)];
        NSLog(@"C2C URL:%@",url);
        [self loadURLString:url];
//        [self showPromptHUDWithTitle:url];
    }
 

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:self.previousNavigationControllerNavigationBarHidden animated:animated];
    [self.navigationController setToolbarHidden:self.previousNavigationControllerToolbarHidden animated:animated];
    [self.progressView removeFromSuperview];
    [self.headView setHidden:NO];

}

#pragma mark - Public Interface

- (void)loadRequest:(NSURLRequest *)request {
    [self.wkWebView loadRequest:request];
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

- (void)loadHTMLString:(NSString *)HTMLString {
    [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self.progressView setTintColor:tintColor];
    [self.navigationController.navigationBar setTintColor:tintColor];
    [self.navigationController.toolbar setTintColor:tintColor];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    [self.navigationController.navigationBar setBarTintColor:barTintColor];
    [self.navigationController.toolbar setBarTintColor:barTintColor];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        [self updateToolbarState];
        if([self.delegate respondsToSelector:@selector(webBrowser:didStartLoadingURL:)]) {
            [self.delegate webBrowser:self didStartLoadingURL:self.wkWebView.URL];
           
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        [self updateToolbarState];
        if([self.delegate respondsToSelector:@selector(webBrowser:didFinishLoadingURL:)]) {
            [self.delegate webBrowser:self didFinishLoadingURL:self.wkWebView.URL];
            NSLog(@"self.wkWebView.URL.absoluteString:%@",self.wkWebView.URL.absoluteString);
        }
    
        
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(webView == self.wkWebView) {
        [self updateToolbarState];
        if([self.delegate respondsToSelector:@selector(webBrowser:didFailToLoadURL:error:)]) {
            [self.delegate webBrowser:self didFailToLoadURL:self.wkWebView.URL error:error];
        }

    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    
    if(webView == self.wkWebView) {
        [self updateToolbarState];

        if([self.delegate respondsToSelector:@selector(webBrowser:didFailToLoadURL:error:)]) {
            [self.delegate webBrowser:self didFailToLoadURL:self.wkWebView.URL error:error];
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView == self.wkWebView) {
        [self updateToolbarState];
        NSLog(@"self.wkWebView.URL.absoluteString:%@",self.wkWebView.URL.absoluteString);

        NSURL *URL = navigationAction.request.URL;
        if(![self externalAppRequiredToOpenURL:URL]) {
            if(!navigationAction.targetFrame) {
                [self loadURL:URL];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
        }else if([[UIApplication sharedApplication] canOpenURL:URL]) {
            [self launchExternalAppWithURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else if ([[URL scheme] rangeOfString:@"login"].location !=NSNotFound){
            [self launchExternalAppWithURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
        }

        // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
        NSString* url =[self.wkWebView.URL.absoluteString stringByRemovingPercentEncoding];
        NSLog(@"url:%@",url);

        if ([url  rangeOfString:@"alipay://"].location !=NSNotFound) {//拦截url，截取参数，
            NSString* dataStr=[url substringFromIndex:23];
            NSLog(@"dataStr=%@",dataStr);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ NSString stringWithFormat:@"alipay://alipayclient/?%@",[dataStr URLEncodedString]]]];// 对参数进行urlencode，拼接上scheme。
        }else if ( [url  rangeOfString:@"weixin://wap/pay?"].location !=NSNotFound ) {
            NSURL *weixinURL = [NSURL URLWithString:url];
            NSLog(@"urlStr：%@",url);
            [[UIApplication sharedApplication] openURL:weixinURL];// 对参数进行urlencode，拼接上scheme。
        }
        
//        else if ( [url  rangeOfString:@"login"].location !=NSNotFound ) {
//
//            LoginViewController* loginVC=[LoginViewController new];
//            GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
//            [TheAppDel.window.rootViewController presentViewController:loginNav animated:YES completion:^{
//            }];
//
//        }
     
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
+ (NSString *) paramValueOfUrl:(NSString *) url withParam:(NSString *) param{
    
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return nil;
}
#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
#pragma mark- WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
   
    NSString *messageName = message.name;
    if ([messageName isEqualToString:@"login"]) {
        LoginViewController* loginVC=[LoginViewController new];
        GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
        [TheAppDel.window.rootViewController presentViewController:loginNav animated:YES completion:^{
        }];
    }
  

}
#pragma mark - Toolbar State

- (void)updateToolbarState {
    
    BOOL canGoBack = self.wkWebView.canGoBack;
    BOOL canGoForward = self.wkWebView.canGoForward;
    
    [self.backButton setEnabled:canGoBack];
    [self.forwardButton setEnabled:canGoForward];

    if(!self.backButton) {
        [self setupToolbarItems];
    }
    
//  NSArray *barButtonItems;
    if(self.wkWebView.loading || self.uiWebViewIsLoading) {
//        barButtonItems = @[self.backButton, self.fixedCenterSeparator, self.forwardButton, self.fixedSeparator, self.stopButton];
        if(self.showsURLInNavigationBar) {
            NSString *URLString;
            if(self.wkWebView) {
                URLString = [self.wkWebView.URL absoluteString];
            }
            URLString = [URLString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
            URLString = [URLString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
            URLString = [URLString substringToIndex:[URLString length]-1];
            self.navigationItem.title = @"C2C";//URLString;
        }
    }
    else {
//        barButtonItems = @[self.backButton, self.fixedCenterSeparator, self.forwardButton, self.fixedSeparator, self.refreshButton];
        if(self.showsPageTitleInNavigationBar) {
            if(self.wkWebView) {
                self.navigationItem.title =@"C2C"; //self.wkWebView.title;
            }
        }
    }
//    [self setToolbarItems:barButtonItems animated:YES];
    
    self.tintColor = self.tintColor;
    self.barTintColor = self.barTintColor;
    
    UIImage *backImage = [[UIImage imageNamed:@"back_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain
                                                                         target:self action:@selector(backBarButtonItemTapped:)];
    if (canGoBack) {
        UIImage *closeImage = [[UIImage imageNamed:@"nav_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *closeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(closeBarButtonItemClicked:)];
        self.navigationItem.leftBarButtonItems = @[backBarButtonItem];
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setupToolbarItems {
    self.refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed:)];
    self.stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopButtonPressed:)];
    
    UIImage *backbuttonImage = [UIImage imageNamed:@"backbutton.png"];
    self.backButton = [[UIBarButtonItem alloc] initWithImage:backbuttonImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    
    self.fixedCenterSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.fixedCenterSeparator.width = 30.0;
    
    UIImage *forwardbuttonImage = [UIImage imageNamed:@"forwardbutton.png"];
    self.forwardButton = [[UIBarButtonItem alloc] initWithImage:forwardbuttonImage style:UIBarButtonItemStylePlain target:self action:@selector(forwardButtonPressed:)];

    self.fixedSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

#pragma mark - Done Button Action

- (void)backBarButtonItemTapped:(id)sender {
    if(self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        return;
    }else{
        [self updateToolbarState];
    }
    
//    UIViewController* VC=[CommonUtility getVCWithSrcViewController:self andDesVC:NSStringFromClass([PTLoginViewController class])];
//    if (VC) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else{
//        if (![self.navigationController popViewControllerAnimated:YES]) {
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }
    
}

- (void)closeBarButtonItemClicked:(id)sender {
//    UIViewController* VC=[ShareFunction getVCWithSrcViewController:self andDesVC:NSStringFromClass([PTLoginViewController class])];
//    if (VC) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else{
//        if (![self.navigationController popViewControllerAnimated:YES]) {
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }
}

- (void)doneButtonPressed:(id)sender {
    [self dismissAnimated:YES];
}

#pragma mark - UIBarButtonItem Target Action Methods

- (void)backButtonPressed:(id)sender {
    
    if(self.wkWebView) {
        [self.wkWebView goBack];
    }
    [self updateToolbarState];
}

- (void)forwardButtonPressed:(id)sender {
    if(self.wkWebView) {
        [self.wkWebView goForward];
    }
    [self updateToolbarState];
}

- (void)refreshButtonPressed:(id)sender {
    if(self.wkWebView) {
        [self.wkWebView stopLoading];
        [self.wkWebView reload];
    }
}

- (void)stopButtonPressed:(id)sender {
    if(self.wkWebView) {
        [self.wkWebView stopLoading];
    }
}

#pragma mark - Estimated Progress KVO (WKWebView)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            @weakify(self);
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                @strongify(self);
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                @strongify(self);
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
        if (!self.wkWebView.loading) {
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - External App Support

- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
    return ![validSchemes containsObject:URL.scheme];
}

- (void)launchExternalAppWithURL:(NSURL *)URL {
    self.URLToLaunchWithPermission = URL;
    if (![self.externalAppPermissionAlertView isVisible]) {
        [self.externalAppPermissionAlertView show];
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(alertView == self.externalAppPermissionAlertView) {
        if(buttonIndex != alertView.cancelButtonIndex) {
            [[UIApplication sharedApplication] openURL:self.URLToLaunchWithPermission];
        }
        self.URLToLaunchWithPermission = nil;
    }
}

#pragma mark - Dismiss

- (void)dismissAnimated:(BOOL)animated {
    if([self.delegate respondsToSelector:@selector(webBrowserViewControllerWillDismiss:)]) {
        [self.delegate webBrowserViewControllerWillDismiss:self];
    }
    [self.navigationController dismissViewControllerAnimated:animated completion:nil];
}

#pragma mark - Interface Orientation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
#pragma mark - Dealloc

- (void)dealloc {
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    if ([self isViewLoaded]) {
        [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    }
}
- (void)closeWebView {
    
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
        
    }];
}
@end

@implementation UINavigationController(PTWebBrowser)

- (PTWebViewController *)rootWebBrowser {
    UIViewController *rootViewController = [self.viewControllers objectAtIndex:0];
    return (PTWebViewController *)rootViewController;
}

@end
