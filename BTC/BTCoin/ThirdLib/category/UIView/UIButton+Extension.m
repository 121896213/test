//
//  UIButton+YSKit.m
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

#import "UIButton+Extension.h"
#import "UIImage+Extension.h"

@implementation UIButton (Extension)

static char eventKey;

/**
 *  UIButton添加UIControlEvents事件的block
 *
 *  @param event 事件
 *  @param action block代码
 */
- (void)handleControlEvent:(UIControlEvents)event withBlock:(void (^)())action {
    objc_setAssociatedObject(self, &eventKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &eventKey);
    if (block) {
        block();
    }
}

// ******************************当前系统使用***********************************

/**
 *  登录、注册、vip购买、修改昵称等通用样式
 */
+ (instancetype _Nonnull)initWithSubmitFrame:(CGRect)frame title:(NSString * _Nullable)title {
    
    
    UIButton *button = [UIButton initWithFrame:frame title:title backgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xffbd5b)] highlightedBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xea971c)]];
    
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    [button.titleLabel setFont:Font_16];
    [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xffdead)] forState:UIControlStateDisabled];
    [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateDisabled];
    
    return button;
}

+ (instancetype _Nonnull)initWithVerificationCodeFrame:(CGRect)frame {
    
    UIButton *button = [UIButton initWithFrame:frame title:NSLocalizedString(@"重发验证码",nil)];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = UIColorFromRGB(0xbcbcbc).CGColor;
    [button.titleLabel setFont:Font_16];
    [button setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x0000) forState:UIControlStateHighlighted];
    [button setTitleColor:COLOR_Text_BC_Disable forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageWithColor:COLOR_Bg_F9_Disable] forState:UIControlStateDisabled];
    return button;
}

// *****************************************************************

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame {
    return [UIButton initWithFrame:frame title:nil];
}

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame title:(NSString * _Nullable)title {
    return [UIButton initWithFrame:frame title:title backgroundImage:nil];
}

+ (instancetype _Nonnull )initWithFrame:(CGRect)frame title:(NSString * _Nullable)title backgroundImage:(UIImage * _Nullable)backgroundImage {
    return [UIButton initWithFrame:frame title:title  backgroundImage:backgroundImage highlightedBackgroundImage:nil];
}

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame title:(NSString * _Nullable)title backgroundImage:(UIImage * _Nullable)backgroundImage highlightedBackgroundImage:(UIImage * _Nullable)highlightedBackgroundImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    
    return button;
}

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame title:(NSString * _Nullable)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundImage:(UIImage * _Nullable)backgroundImage highlightedBackgroundImage:(UIImage * _Nullable)highlightedBackgroundImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:frame];
	[button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor];
    [button.titleLabel setFont:titleFont];
	[button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
	[button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    
	return button;
}

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame image:(UIImage * _Nonnull)image {
    return [UIButton initWithFrame:frame image:image highlightedImage:nil];
}

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame image:(UIImage * _Nonnull)image highlightedImage:(UIImage * _Nullable)highlightedImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    
    return button;
}

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title
                            titleColor:(UIColor *)titleColor
                             titleFont:(UIFont *)titleFont
                       backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button =  [UIButton initWithFrame:frame title:title backgroundImage:nil];
    button.backgroundColor = backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor];
    [button.titleLabel setFont:titleFont];
    
    return button;
}

- (void)setTitleColor:(UIColor * _Nonnull)color {
    [self setTitleColor:color highlightedColor:[color colorWithAlphaComponent:0.4]];
}

- (void)setTitleColor:(UIColor * _Nonnull)color highlightedColor:(UIColor * _Nullable)highlightedColor {
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
}

- (void)setTitleFont:(UIFont * _Nonnull)font fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.currentTitle];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(fromIndex, toIndex - fromIndex)];
    
    [self setAttributedTitle:attributedString forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor * _Nonnull)color fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.currentTitle];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(fromIndex, toIndex - fromIndex)];
    
    [self setAttributedTitle:attributedString forState:UIControlStateNormal];
}

/**
 创建快速注册类试的按钮
 
 @param frame 区域
 @param title 标题
 
 @return 返回按钮
 */
+ (instancetype _Nonnull)createRegButton:(CGRect)frame title:(NSString *)title
{
    UIButton *btnReg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReg.frame = frame;
    [btnReg setTitle:title forState:UIControlStateNormal];
    [btnReg setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    btnReg.titleLabel.font = XCFONT(15);
    return btnReg;
}

@end
