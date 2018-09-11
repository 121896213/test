//
//  UIColor+SapColor.h
//  SAP
//
//  Created by lixinglou on 16/7/28.
//  Copyright © 2016年 sap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SapColor)

#pragma mark - 重要
///#c63b38用于特别需要强调和突出的文字、按钮、按钮描边、icon
+ (UIColor *)sapRed;
///#333333用于重要文字信息，内容标题信息，用户名等
+ (UIColor *)sapBlack;
///#666666用于重要文字信息，副标题信息
+ (UIColor *)sapSoftBlack;

//内容 #8e8e8e 142,142,142
+ (UIColor *)sap8e8e8eOr142Color;

#pragma mark - 一般
///#999999用于辅助、次要的文字信息,如文字提示
+ (UIColor *)sapGray;
/// #41a0ff系统蓝色
+ (UIColor *)sapBlue;

#pragma mark - 较弱
///#c8c7cc用于分割线
+ (UIColor *)sapSeprate;
///#c8c7cc用于占位颜色
+ (UIColor *)sapPlaceholder;
///#efeff4用于主要背景
+ (UIColor *)sapBackground;
///#f7f7f8 90%用于菜单栏背景
+ (UIColor *)sapBackgroundMenuBar;
///#f7f7f8 95%用于标题栏底色
+ (UIColor *)sapBackgroundTitleBar;

#pragma mark - other
//126 126 126
+ (UIColor *)sapMidGray;
///102 102 102
+ (UIColor *)sapDarkGray;
///默认按钮颜色（sapRed）
+ (UIColor *)sapBtnColor;
///默认按钮高亮颜色（按下时，sapRed+0.9）
+ (UIColor *)sapBtnHighlightedColor;
///粉红254 123 0 FE7B00
+ (UIColor *)sapPink;

//从RGB中获取颜色值
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
@end
