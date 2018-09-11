//
//  SZUserProtocolViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/5/31.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZUserProtocolViewController.h"

@interface SZUserProtocolViewController ()<UIWebViewDelegate>

@end

@implementation SZUserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleText:@"用户使用协议"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight - NavigationStatusBarHeight)];
    [webView setDelegate:self];
    [webView setOpaque:NO];//使网页透明
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.btktrade.com/#/phoneUrl"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15 ]];
    webView.backgroundColor=[UIColor whiteColor];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest");
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"ERROR%@",error.description);
    if ([error code] == NSURLErrorTimedOut)
    {
        return;
    }
    
}

@end
