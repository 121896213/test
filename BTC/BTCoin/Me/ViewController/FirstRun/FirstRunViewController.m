//
//  FirstRunViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/4/28.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "FirstRunViewController.h"
#import "TabBarController.h"
#import "AppDelegate.h"

@interface FirstRunViewController ()

@end

@implementation FirstRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubViews];
}
-(void)configSubViews{
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    for (int i=0; i<3; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        NSString * imageUrl = [NSString stringWithFormat:@"introducePage%d",i];
        imageView.image = kIMAGE_NAMED(imageUrl);
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
        if (i == 2) {
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterAPP)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
        }
    }
    scrollView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight);
}
-(void)enterAPP{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = [TabBarController singletonTabBarController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
