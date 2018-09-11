//
//  UIView+EmptyViewTips.h
//  99SVR
//
//  Created by jiangys on 16/5/17.
//  Copyright © 2016年 xia zhonglin . All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TouchHanleBlock)(void);
#import "UIView+EmptyViewTips.h"

@interface UIView (EmptyViewTips)

+ (UIView *)initWithFrame:(CGRect)frame message:(NSString *)message;

+ (UIView *)initWithFrame:(CGRect)frame message:(NSString *)message pointY:(CGFloat)pointY;

+ (UIView *)initWithFrame:(CGRect)frame imageName:(NSString *)imageName message:(NSString *)message pointY:(CGFloat)pointY;

- (void)showEmptyViewInView:(UIView *)targetView height:(CGFloat)height withMsg:(NSString *)msg withImageName:(NSString *)imageName touchHanleBlock:(TouchHanleBlock)hanleBlock;

- (void)showErrorViewInView:(UIView *)targetView height:(CGFloat)imgY withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock;

- (void)showEmptyViewInView:(UIView *)targetView height:(CGFloat)imgY withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock;


/**
 *  提示空白的View
 *
 *  @param targetView 添加在哪个view
 *  @param msg        提示信息
 *  @param originY    Y轴的偏移量
 *  @param hanleBlock 点击回调处理
 */
- (void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg withOriginY:(CGFloat)originY touchHanleBlock:(TouchHanleBlock)hanleBlock;
/**
 *  提示空白的View
 *
 *  @param targetView  添加在哪个view
 *  @param msg        提示信息
 *  @param hanleBlock 点击回调处理
 */
- (void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock;

/**
 *  提示网络错误的View
 *
 *  @param targetView  添加在哪个view
 *  @param msg        提示信息
 *  @param hanleBlock 点击回调处理
 */
- (void)showErrorViewInView:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock;


/**
 *  隐藏提示的view
 *
 *  @param targetView 在哪个view
 */
- (void)hideEmptyViewInView:(UIView *)targetView;

/**
 *  推荐视频没有的时候加载
 */
- (void)showNilRecommendVideo:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock;

- (void)showNoNetworkRecommendVideo:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock;

@end
