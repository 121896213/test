//
//  UIView+XYConvenience.h
//  WisePal
//
//  Created by sunon002 on 15-5-4.
//  Copyright (c) 2015年 Jet.Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYConvenience)

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;
@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;
@property (nonatomic) CGFloat frameMarginVertical;
@property (nonatomic) CGFloat frameMarginHorizontal;
@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize  frameSize;

- (CGFloat)frameMaxX;//-- self.frame.size.width+self.frame.origin.x;
- (CGFloat)frameMaxY;

- (BOOL)containsSubView:(UIView * _Nonnull)subView;
- (BOOL)containsSubViewOfClassType:(nonnull Class)_class;

- (void)setViewCircle;
- (void)setViewRadius:(CGFloat)cordines;
//-- 传参nil,表示不使用阴影
- (void)setViewShadow:(UIColor * _Nonnull)shadowColor;
- (void)setViewBlackShadow;
- (void)setViewBorder0_5:(UIColor * _Nonnull)borderColor;//设置边框为0.5的粗细线条
- (void)setViewBorder:(UIColor * _Nonnull)borderColor borderWidth:(CGFloat)borderWidth;
- (void)setViewGrayBorder;


#pragma mark - 找到控制器
- (nonnull UIViewController *)accordingViewfindViewController;
- (nonnull UINavigationController *)accordingViewfindNavigationViewController;

#pragma mark - 寻找View
- (nullable UIView *)findFirstResponderOfTheView;//-- 在子视图中找到获得焦点的View
- (nullable UIView *)findSuperviewOfClasstype:(nonnull Class)cla;//-- 找到类型为cla的父视图
- (nullable UIView *)findSubViewOfClasstype:(nonnull Class)cla;//-- 找到类型为cla的子视图

#pragma mark - 添加任意一边的边框
-(nonnull UIView *)addBottomBorderWithColor:(UIColor * _Nonnull)color andWidth:(CGFloat) borderWidth leftPadding:(CGFloat)padding;
-(nonnull UIView *)addBottomBorderWithColor:(UIColor * _Nonnull)color andWidth:(CGFloat) borderWidth leftPadding:(CGFloat)padding rightPadding:(CGFloat)r_padding;
-(nonnull UIView *)addBottomBorderWithColor:(UIColor * _Nonnull)color andWidth:(CGFloat) borderWidth;
-(nonnull UIView *)addLeftBorderWithColor:(UIColor * _Nonnull)color andWidth:(CGFloat) borderWidth;
-(nonnull UIView *)addRightBorderWithColor:(UIColor * _Nonnull)color andWidth:(CGFloat) borderWidth;
-(nonnull UIView *)addTopBorderWithColor:(UIColor * _Nonnull)color andWidth:(CGFloat) borderWidth;
-(nonnull UIView *)add0_5RightBorderWithColor:(UIColor * _Nonnull)color width:(CGFloat)borderWidth paddingVertical:(CGFloat)pVertical;


-(nonnull UIView *)addRightBorderWithColor:(UIColor * _Nonnull)color andWidth:(CGFloat)border_w edge:(UIEdgeInsets)edgeinsets;

- (nonnull UIImage *)snapshotImage;
#pragma mark - 创建视图
//-- 生产一个透明的View
+ (nonnull UIView *)emptyView:(CGRect)frame;
- (nonnull UIButton *)insertBoundsNewView_image:(UIImage * _Nonnull)image withText:(NSString * _Nullable)text;
- (void)removeBoundsNewView_image;

@end


@interface XYVerticalButton : UIButton
@end


//-- UIButton 文字对齐
@interface UIButton (XYButton)

- (void)imageOnTheRight;

@end

@interface UIImage (XYImage)

- (nonnull UIImage *)circleImage;

@end

@interface XYInsetsLabel : UILabel
@property(nonatomic) UIEdgeInsets insets;
@property(nonatomic,assign) BOOL linshi;

-(nullable id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(nullable id) initWithInsets: (UIEdgeInsets) insets;

@end
