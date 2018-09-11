//
//  UIView+EmptyViewTips.m
//  99SVR
//
//  Created by jiangys on 16/5/17.
//  Copyright © 2016年 xia zhonglin . All rights reserved.
//

#import "UIView+EmptyViewTips.h"
#import <objc/runtime.h>
#define EmptyViewTag 999992

static char  * TapRecognizerBlockKey;

@implementation UIView (EmptyViewTips)

+ (UIView *)initWithFrame:(CGRect)frame message:(NSString *)message
{
    return [self initWithFrame:frame imageName:@"text_blank_page" message:message pointY:0];
}

+ (UIView *)initWithFrame:(CGRect)frame message:(NSString *)message pointY:(CGFloat)pointY
{
    return [self initWithFrame:frame imageName:@"text_blank_page" message:message pointY:pointY];
}

+ (UIView *)initWithFrame:(CGRect)frame imageName:(NSString *)imageName message:(NSString *)message pointY:(CGFloat)pointY
{
    UIView *emptyView = [[UIView alloc] init];
    emptyView.frame = CGRectMake(0, 0, kScreenWidth,frame.size.height);
    emptyView.backgroundColor = COLOR_Bg_Gay;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:imageName];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    if (kiPhone4_OR_4s || kiPhone5_OR_5c_OR_5s) {
        imgView.frame = (CGRect){0,0,120,120};
    }else{
        imgView.frame = (CGRect){0,0,180,180};
    }
    imgView.center = CGPointMake(emptyView.center.x, emptyView.center.y-60);
    [emptyView addSubview:imgView];
    if (pointY > 0) {
        imgView.y = pointY;
    }
    
    UILabel *lblInfo = [[UILabel alloc] init];
    [lblInfo setFont:XCFONT(15)];
    [lblInfo setTextColor:UIColorFromRGB(0x919191)];
    [lblInfo setTextAlignment:NSTextAlignmentCenter];
    lblInfo.size = (CGSize){kScreenWidth, 20};
    lblInfo.y = CGRectGetMaxY(imgView.frame)+10;
    lblInfo.text = message;
    [emptyView addSubview:lblInfo];
    
    return emptyView;
}


- (void)showNoNetworkRecommendVideo:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showEmptyViewInView:targetView withMsg:msg withOriginY:0 withImageName:@"empty_loading_lost" touchHanleBlock:hanleBlock
                          bgColor:UIColorFromRGB(0x00) textColor:UIColorFromRGB(0x919191)];
    });
}


- (void)showErrorViewInView:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock{
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self showEmptyViewInView:targetView withMsg:msg withOriginY:0 withImageName:@"empty_loading_lost" touchHanleBlock:hanleBlock];
                   });
}

- (void)showErrorViewInView:(UIView *)targetView height:(CGFloat)imgY withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock
{
    dispatch_async(dispatch_get_main_queue(),
    ^{
        [self showEmptyViewInView:targetView height:imgY withMsg:msg withImageName:@"empty_loading_lost" touchHanleBlock:hanleBlock];
    });
}

- (void)showEmptyViewInView:(UIView *)targetView height:(CGFloat)imgY withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock
{
    dispatch_async(dispatch_get_main_queue(),
    ^{
       [self showEmptyViewInView:targetView height:imgY withMsg:msg withImageName:@"empty_loading_empty" touchHanleBlock:hanleBlock];
    });
}

- (void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg
              withImageName:(NSString *)imageName touchHanleBlock:(TouchHanleBlock)hanleBlock
                    bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor
{
    
    UIView *emptyView = [targetView viewWithTag:EmptyViewTag];
    if (emptyView) {
        [emptyView removeFromSuperview];
    }
    
    CGFloat width = targetView.frame.size.width;
    CGFloat height = targetView.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,width,height}];
    [targetView addSubview:view];
    
    view.userInteractionEnabled = YES;
    view.tag = EmptyViewTag;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]init];
    tapRecognizer.numberOfTapsRequired = 1;
    [tapRecognizer addTarget:self action:@selector(tapRecognizerAction:)];
    [view addGestureRecognizer:tapRecognizer];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:view.bounds];
    [view addSubview:bgView];
    [bgView setImage:[UIImage imageNamed:@"video_customized_bg"]];
    
    if(hanleBlock)
    {
        objc_setAssociatedObject(self, &TapRecognizerBlockKey, hanleBlock, OBJC_ASSOCIATION_COPY);
    }
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    CGFloat imgHeight = 133;
    
    if (kiPhone4_OR_4s || kiPhone5_OR_5c_OR_5s)
    {
        imgHeight = 120;
        imageView.frame = (CGRect){0,0,120,120};
    }else{
        imageView.frame = (CGRect){0,0,imgHeight,imgHeight};
    }
    
    imageView.center = CGPointMake(view.center.x, imgHeight/2);
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    UILabel *titLab = [[UILabel alloc]init];
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.numberOfLines = 0;
    titLab.textColor = textColor;
    titLab.text = msg;
    titLab.font = Font_15;
    [titLab sizeToFit];
    titLab.frame = (CGRect){0,CGRectGetMaxY(imageView.frame)+10,width,titLab.frame.size.height};
    [view addSubview:titLab];
}

- (void)showEmptyViewInView:(UIView *)targetView height:(CGFloat)imgY withMsg:(NSString *)msg withImageName:(NSString *)imageName touchHanleBlock:(TouchHanleBlock)hanleBlock
{
    UIView *emptyView = [targetView viewWithTag:EmptyViewTag];
    if (emptyView) {
        [emptyView removeFromSuperview];
    }
    
    CGFloat width = targetView.frame.size.width;
    CGFloat height = targetView.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,width,height}];
    [targetView addSubview:view];
    
    view.userInteractionEnabled = YES;
    [view setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    view.tag = EmptyViewTag;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]init];
    tapRecognizer.numberOfTapsRequired = 1;
    [tapRecognizer addTarget:self action:@selector(tapRecognizerAction:)];
    [view addGestureRecognizer:tapRecognizer];
    
    objc_setAssociatedObject(self, &TapRecognizerBlockKey, hanleBlock, OBJC_ASSOCIATION_COPY);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    CGFloat imgHeight = 133;
    
    if (kiPhone4_OR_4s || kiPhone5_OR_5c_OR_5s)
    {
        imgHeight = 120;
        imageView.frame = (CGRect){0,imgY,120,120};
    }else{
        imageView.frame = (CGRect){0,imgY,imgHeight,imgHeight};
    }
    imageView.center = CGPointMake(view.center.x, (imgY + imgHeight)/2);
    
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    UILabel *titLab = [[UILabel alloc]init];
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.numberOfLines = 0;
    titLab.textColor = UIColorFromRGB(0x919191);
    titLab.text = msg;
    titLab.font = Font_15;
    [titLab sizeToFit];
    titLab.frame = (CGRect){0,CGRectGetMaxY(imageView.frame)+10,width,titLab.frame.size.height};
    [view addSubview:titLab];
}

- (void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg withImageName:(NSString *)imageName touchHanleBlock:(TouchHanleBlock)hanleBlock
{
    dispatch_async(dispatch_get_main_queue(),
    ^{
        [self showEmptyViewInView:targetView height:0 withMsg:msg withImageName:imageName touchHanleBlock:hanleBlock];
   });
}

- (void)tapRecognizerAction:(UITapGestureRecognizer *)tap{
    TouchHanleBlock block = objc_getAssociatedObject(self, &TapRecognizerBlockKey);
    if (block)
    {
        UIView *tapView = tap.view;
        if (tapView) {
            [tapView removeFromSuperview];
        }
        block();
    }
}


- (void)hideEmptyViewInView:(UIView *)targetView{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [targetView viewWithTag:EmptyViewTag];
        if (view)
        {
            [view removeFromSuperview];
        }
        
    });
}

#pragma mark - =====
- (void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg withOriginY:(CGFloat)originY touchHanleBlock:(TouchHanleBlock)hanleBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showEmptyViewInView:targetView withMsg:msg withOriginY:originY withImageName:@"empty_loading_empty" touchHanleBlock:hanleBlock];
    });
}

- (void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showEmptyViewInView:targetView withMsg:msg withOriginY:0 withImageName:@"empty_loading_empty" touchHanleBlock:hanleBlock];
    });
}

- (void)showNilRecommendVideo:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showEmptyViewInView:targetView withMsg:msg withOriginY:0 withImageName:@"empty_loading_empty" touchHanleBlock:hanleBlock
                          bgColor:UIColorFromRGB(0x00) textColor:UIColorFromRGB(0x919191)];
    });
}


- (void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg  withOriginY:(CGFloat)originY
              withImageName:(NSString *)imageName touchHanleBlock:(TouchHanleBlock)hanleBlock{
    
    UIView *emptyView = [targetView viewWithTag:EmptyViewTag];
    if (emptyView) {
        [emptyView removeFromSuperview];
    }
    
    CGFloat width = targetView.frame.size.width;
    CGFloat height = targetView.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,width,height}];
    [targetView addSubview:view];
    
    [view setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    view.tag = EmptyViewTag;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]init];
    tapRecognizer.numberOfTapsRequired = 1;
    [tapRecognizer addTarget:self action:@selector(tapRecognizerAction:)];
    [view addGestureRecognizer:tapRecognizer];
    
    if (hanleBlock) {
        view.userInteractionEnabled = YES;
    }else{
        view.userInteractionEnabled = NO;
    }
    
    objc_setAssociatedObject(self, &TapRecognizerBlockKey, hanleBlock, OBJC_ASSOCIATION_COPY);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    if (kiPhone4_OR_4s || kiPhone5_OR_5c_OR_5s) {
        imageView.frame = (CGRect){0,0,120,120};
    }else{
        imageView.frame = (CGRect){0,0,170,170};
    }
    
    imageView.center = CGPointMake(view.center.x, view.center.y);
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    UILabel *titLab = [[UILabel alloc]init];
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.numberOfLines = 0;
    titLab.textColor = UIColorFromRGB(0xcedfec);
    titLab.text = msg;
    titLab.font = Font_15;
    [titLab sizeToFit];
    titLab.frame = (CGRect){0,CGRectGetMaxY(imageView.frame)+10,width,titLab.frame.size.height};
    [view addSubview:titLab];
}

#pragma mark - 视频房间
- (void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg
                withOriginY:(CGFloat)originY
              withImageName:(NSString *)imageName touchHanleBlock:(TouchHanleBlock)hanleBlock
                    bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor
{
    
    UIView *emptyView = [targetView viewWithTag:EmptyViewTag];
    if (emptyView) {
        [emptyView removeFromSuperview];
    }
    
    CGFloat width = targetView.frame.size.width;
    CGFloat height = targetView.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,width,height}];
    [targetView addSubview:view];
    
    view.tag = EmptyViewTag;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]init];
    tapRecognizer.numberOfTapsRequired = 1;
    [tapRecognizer addTarget:self action:@selector(tapRecognizerAction:)];
    [view addGestureRecognizer:tapRecognizer];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:view.bounds];
    [view addSubview:bgView];
    [bgView setImage:[UIImage imageNamed:@"video_customized_bg"]];
    
    if (hanleBlock) {
        view.userInteractionEnabled = YES;
    }else{
        view.userInteractionEnabled = NO;
    }
    
    
    objc_setAssociatedObject(self, &TapRecognizerBlockKey, hanleBlock, OBJC_ASSOCIATION_COPY);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    CGFloat imgHeight = 133;
    
    if (kiPhone4_OR_4s || kiPhone5_OR_5c_OR_5s)
    {
        imgHeight = 120;
        imageView.frame = (CGRect){0,0,120,120};
    }else{
        imageView.frame = (CGRect){0,0,imgHeight,imgHeight};
    }
    
    imageView.center = CGPointMake(view.center.x,view.center.y+originY);
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    UILabel *titLab = [[UILabel alloc]init];
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.numberOfLines = 0;
    titLab.textColor = textColor;
    titLab.text = msg;
    titLab.font = Font_15;
    [titLab sizeToFit];
    titLab.frame = (CGRect){0,CGRectGetMaxY(imageView.frame)+10,width,titLab.frame.size.height};
    [view addSubview:titLab];
}

@end
