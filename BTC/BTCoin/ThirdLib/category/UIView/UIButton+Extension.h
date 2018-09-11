//
//  UIButton+YSKit.h
//  YSKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 - 2018 Jiangys. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

/**
 *  按钮点击事件
 */
typedef void (^ActionBlock)();
    
/**
 *  This category adds some useful methods to UIButton
 */
@interface UIButton (Extension)

/**
 UIButton 添加UIControlEvents时间的block

 @param controlEvent 传输VC
 @param action       block方法
*/
- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock _Nullable)action;

/**
 *  登录、注册、vip购买、修改昵称等通用样式
 */
+ (instancetype _Nonnull)initWithSubmitFrame:(CGRect)frame title:(NSString * _Nullable)title;

/**
 *  验证码Button
 */
+ (instancetype _Nonnull)initWithVerificationCodeFrame:(CGRect)frame;

/**
 *  Create an UIButton in a frame
 *
 *  @param frame Button's frame
 *
 *  @return Returns the UIButton instance
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame;

/**
 *  Create an UIButton in a frame with a title and a clear color
 *
 *  @param frame Button's frame
 *  @param title Button's title, the title color will be white
 *
 *  @return Returns the UIButton instance
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title;

/**
 *  Create an UIButton in a frame with a title and a background image
 *
 *  @param frame           Button's frame
 *  @param title           Button's title
 *  @param backgroundImage Button's background image
 *
 *  @return Returns the UIButton instance
 */

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title
                       backgroundImage:(UIImage * _Nullable)backgroundImage;

/**
 *  Create an UIButton in a frame with a title, a background image and highlighted background image
 *
 *  @param frame                      Button's frame
 *  @param title                      Button's title
 *  @param backgroundImage            Button's background image
 *  @param highlightedBackgroundImage Button's highlighted background image
 *
 *  @return Returns the UIButton instance
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title
                       backgroundImage:(UIImage * _Nullable)backgroundImage
            highlightedBackgroundImage:(UIImage * _Nullable)highlightedBackgroundImage;

/**
 *  Create an UIButton in a frame with a title, a background image and highlighted background image
 *
 *  @param frame                      Button's frame
 *  @param title                      Button's title
 *  @param backgroundImage            Button's background image
 *  @param highlightedBackgroundImage Button's highlighted background image
 *
 *  @return Returns the UIButton instance
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title
                            titleColor:(UIColor * _Nullable)titleColor
                             titleFont:(UIFont * _Nullable)titleFont
                       backgroundImage:(UIImage * _Nullable)backgroundImage
            highlightedBackgroundImage:(UIImage * _Nullable)highlightedBackgroundImage;


/**
 *  Create an UIButton in a frame with an image
 *
 *  @param frame Button's frame
 *  @param image Button's image
 *
 *  @return Returns the UIButton instance
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 image:(UIImage * _Nonnull)image;

/**
 *  Create an UIButton in a frame with an image
 *
 *  @param frame            Button's frame
 *  @param image            Button's image
 *  @param highlightedImage Button's highlighted image
 *
 *  @return Returns the UIButton instance
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 image:(UIImage * _Nonnull)image
                      highlightedImage:(UIImage * _Nullable)highlightedImage;

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title
                            titleColor:(UIColor * _Nullable)titleColor
                             titleFont:(UIFont * _Nullable)titleFont
                       backgroundColor:(UIColor * _Nullable)backgroundColor;

/**
 *  Set the title color
 *
 *  @param color Font color, the highlighted color will be automatically created
 */
- (void)setTitleColor:(UIColor * _Nonnull)color;

/**
 *  Set the title color and highlighted color
 *
 *  @param color            Button's color
 *  @param highlightedColor Button's highlighted color
 */
- (void)setTitleColor:(UIColor * _Nonnull)color
     highlightedColor:(UIColor * _Nullable)highlightedColor;

- (void)setTitleFont:(UIFont * _Nonnull)font fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

- (void)setTitleColor:(UIColor * _Nonnull)color fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
/**
 创建快速注册类试的按钮

 @param frame 区域
 @param title 标题

 @return 返回按钮
 */
+ (instancetype _Nonnull)createRegButton:(CGRect)frame title:(NSString *)title;



@end
