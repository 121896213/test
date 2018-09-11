//
//  CustomViewController.m
//  FreeCar
//
//  Created by xiongchi on 15/8/1.
//  Copyright (c) 2015年 xiongchi. All rights reserved.
//

#import "CustomViewController.h"
#import "UIView+Extension.h"
#import "UINavigationController+StatusBarStyle.h"
#define LeftButtonTag 997

@interface CustomViewController (){
    UIView* _noResultView;
}
@end

@implementation CustomViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=MainBackgroundColor;
    [self.view addSubview:self.headView];
    
    _txtTitle = [[UILabel alloc] initWithFrame:Rect(44,NaviBarHeight+StatusBarHeight-32,kScreenWidth-88, 20)];
    [_txtTitle setFont:[UIFont boldSystemFontOfSize:15]];
    [self.headView addSubview:_txtTitle];
    [_txtTitle setTextAlignment:NSTextAlignmentCenter];
//    [_txtTitle setTextColor:[UIColor whiteColor]];
    [_txtTitle setTextColor:MainLabelBlackColor];
    
    UIButton *btnLeft = [CustomViewController itemWithTarget:self action:@selector(MarchBackLeft) image:@"back" highImage:@"back"];
    btnLeft.tag = LeftButtonTag;
    [btnLeft setEnlargeEdgeWithTop:FIT3(48) right:FIT3(48) bottom:FIT3(48) left:FIT3(48)];
    [self setLeftBtn:btnLeft];
//    [self.headView addSubview:btnLeft];
//    [btnLeft setFrame:Rect(0,StatusBarHeight,44,44)];
    
//    @weakify(self);
//    [RACObserve(TheAppDel.rootTabBarController, nowStatus) subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        if (TheAppDel.rootTabBarController.nowStatus == NotReachable) {
//            [self showNoResultView];
//        }else{
//            [self hideNoResultView];
//        }
//        NSLog(@"viewDidLoad属性的改变：%@", x); // x 是监听属性的改变结果
//
//    }];
    
    
}
#pragma mark - Pop、Dismiss
- (void)MarchBackLeft{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)navBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 创建UIBUtton
+ (UIButton *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    UIImage *img = [UIImage imageNamed:image];
//    [btn setImage:img forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    UIImageView * centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(17, 14, 10, 16)];
    centerImage.image = img;
    centerImage.contentMode=UIViewContentModeScaleAspectFit;
    [btn addSubview:centerImage];
    return btn;
}

+ (UIButton *)itemWithTarget:(id)target action:(SEL)action title:(NSString*)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

#pragma mark - getter & setter
- (UIView *)headView {
    if (nil == _headView) {
        _headView  = [[UIView alloc] initWithFrame:Rect(0, 0,kScreenWidth,NaviBarHeight+StatusBarHeight)];
        _headView.backgroundColor = MainNavBarColor;
        [self.headView addBottomLineView];
    }
    
    return _headView;
}

#pragma mark 设置headView不可用、背景颜色
- (void)setUserInter
{
    self.headView.userInteractionEnabled = NO;
}

- (void)setHeadBackGroup:(UIColor *)color
{
    [self.headView setBackgroundColor:color];
}

-(void)setViewBgColor:(UIColor *)bgColor
{
    [self.headView setBackgroundColor:bgColor];
}

#pragma mark 设置导航标题、左右按钮
-(void)setTitleText:(NSString *)strText
{
    [_txtTitle setText:strText];
    if ([NSLocalizedString(@"关于我们", nil) isEqualToString: strText]) {
        [_txtTitle setTextColor:[UIColor whiteColor]];
    }
}

-(void)setLeftBtn:(UIButton *)btnLeft
{
    UIButton * button = [self.headView viewWithTag:LeftButtonTag];
    [button removeFromSuperview];
    _btnLeft = btnLeft;
    _btnLeft.frame = Rect(0, StatusBarHeight, 44, 44);
    _btnLeft.titleLabel.font = XCFONT(16);
    _btnLeft.titleLabel.textColor=MainLabelBlackColor;
    [self.headView addSubview:_btnLeft];
}

-(void)setRightBtn:(UIButton *)btnRight
{
    _btnRight = btnRight;
    _btnRight.frame = Rect(self.headView.width-btnRight.frame.size.width-8, StatusBarHeight, btnRight.frame.size.width, btnRight.frame.size.height);
    _btnRight.titleLabel.font = [UIFont systemFontOfSize:FIT(15)];
    _btnRight.titleLabel.textColor=MainLabelBlackColor;
    [_btnRight setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];

    [self.headView addSubview:_btnRight];
}

#pragma mark - 隐藏或显示headView
-(void)setHeadViewHidden:(BOOL)bFlag
{
    self.headView.hidden = bFlag;
}

#pragma mark - 添加默认的headView
- (void)addDefaultHeader:(NSString *)title
{
    _txtTitle.text = title;
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView addSubview:exitBtn];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(50, 44));
        make.left.equalTo(self.headView);
        make.bottom.equalTo(self.headView);
    }];
}

#pragma mark 隐藏左按钮
- (void)hideLeftBtn {
    UIButton * button = [self.headView viewWithTag:LeftButtonTag];
    button.hidden = YES;
    
    self.btnLeft.hidden = YES;
}
#pragma mark - rotation
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)showNoResultView
{
    
    if(!_noResultView)
    {
        UIView* noResultView=[UIView new];
        _noResultView=noResultView;
        [self.view addSubview:noResultView];
        [noResultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
            make.width.mas_equalTo(FIT2(300));
            make.height.mas_equalTo(FIT2(300));
        }];
        UIImageView* imageView=[UIImageView new];
        if (TheAppDel.rootTabBarController.nowStatus == NotReachable) {
            [imageView setImage:[UIImage imageNamed:@"noNetwork_icon"]];
        }else{
            [imageView setImage:[UIImage imageNamed:@"noResult_icon"]];
        }
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [noResultView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.equalTo(noResultView.mas_centerX);
            make.width.mas_equalTo(FIT2(200));
            make.height.mas_equalTo(FIT2(200));
        }];
        
        UILabel* label=[UILabel new];
        [label setFont:[UIFont systemFontOfSize:FIT(16)]];
        if (TheAppDel.rootTabBarController.nowStatus == NotReachable) {
            [label setText:NSLocalizedString(@"网络走丢了",nil)];
        }else{
            [label setText:NSLocalizedString(@"暂无数据",nil)];
        }
        [label setTextColor:UIColorFromRGB(0x999999)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [noResultView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(noResultView.mas_centerX);
            make.top.equalTo(imageView.mas_bottom).offset(FIT(26));
            make.width.mas_equalTo(FIT2(300));
            make.height.mas_equalTo(FIT(16));
//            make.center.equalTo(noResultView);
        }];
        
        [self.view bringSubviewToFront:noResultView];
    }
    else
    {
        [_noResultView setHidden:NO];
    }
}

-(void)hideNoResultView{
    [_noResultView setHidden:YES];
    [_noResultView removeFromSuperview];
    _noResultView =nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
