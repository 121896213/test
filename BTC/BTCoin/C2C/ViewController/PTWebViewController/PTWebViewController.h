//
//  PTUserAgreementVController.h
//  PT_VRBrowser
//
//  Created by GuoShengyong on 17/5/27.
//  Copyright © 2017年 bql. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "CustomViewController.h"
@class PTWebViewController;

/*
 
 UINavigationController+KINWebBrowserWrapper category enables access to casted KINWebBroswerViewController when set as rootViewController of UINavigationController
 
 */
@interface UINavigationController(PTWebBrowser)

// Returns rootViewController casted as PTWebViewController
- (PTWebViewController *)rootWebBrowser;

@end

@protocol PTWebBrowserDelegate <NSObject>
@optional
- (void)webBrowser:(PTWebViewController *)webBrowser didStartLoadingURL:(NSURL *)URL;
- (void)webBrowser:(PTWebViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL;
- (void)webBrowser:(PTWebViewController *)webBrowser didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)webBrowserViewControllerWillDismiss:(PTWebViewController*)viewController;
@end


@interface PTWebViewController : CustomViewController <WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate,WKScriptMessageHandler>

#pragma mark - Public Properties

@property (nonatomic, weak) id <PTWebBrowserDelegate> delegate;

// The main and only UIProgressView
@property (nonatomic, strong) UIProgressView *progressView;

// The web views
// Depending on the version of iOS, one of these will be set
@property (nonatomic, strong) WKWebView *wkWebView;

// load url
@property (nonatomic, strong) NSURL *webUrl;

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration NS_AVAILABLE_IOS(8_0);

#pragma mark - Static Initializers

/*
 Initialize a basic PTWebViewController instance for push onto navigation stack
 
 Ideal for use with UINavigationController pushViewController:animated: or initWithRootViewController:
 
 Optionally specify PTWebBrowser options or WKWebConfiguration
 */

+ (PTWebViewController *)webBrowser;
+ (PTWebViewController *)webBrowserWithConfiguration:(WKWebViewConfiguration *)configuration NS_AVAILABLE_IOS(8_0);

/*
 Initialize a UINavigationController with a PTWebViewController for modal presentation.
 
 Ideal for use with presentViewController:animated:
 
 Optionally specify PTWebBrowser options or WKWebConfiguration
 */

+ (UINavigationController *)navigationControllerWithWebBrowser;
+ (UINavigationController *)navigationControllerWithWebBrowserWithConfiguration:(WKWebViewConfiguration *)configuration NS_AVAILABLE_IOS(8_0);

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, assign) BOOL showsURLInNavigationBar;
@property (nonatomic, assign) BOOL showsPageTitleInNavigationBar;

//Allow for custom activities in the browser by populating this optional array
@property (nonatomic, strong) NSArray *customActivityItems;

#pragma mark - Public Interface


// Load a NSURLURLRequest to web view
// Can be called any time after initialization
- (void)loadRequest:(NSURLRequest *)request;

// Load a NSURL to web view
// Can be called any time after initialization
- (void)loadURL:(NSURL *)URL;

// Loads a URL as NSString to web view
// Can be called any time after initialization
- (void)loadURLString:(NSString *)URLString;


// Loads an string containing HTML to web view
// Can be called any time after initialization
- (void)loadHTMLString:(NSString *)HTMLString;

@end
