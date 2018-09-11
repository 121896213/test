//
//  NSString+Size.h
//  Weibo
//
//  Created by jiangys on 15/10/24.
//  Copyright © 2015年 Jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  获取文字所占的尺寸大小
 */
@interface NSString (Size)

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  计算文字的宽高
 *  使用方法 [strText sizeMakeWithFont:[UIFont systemFontOfSize:12]];
 *
 *  @param font 字体大小
 *  @param maxW 字体所在的范围的宽度
 *
 *  @return 返回字体所在的范围宽度下的高度。即知道宽，计算高
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font maxW:(CGFloat)width;

/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 @brief 计算文字的大小

 @param font 字体(默认为系统字体)
 @param size 约束大小
 @param mode lineBreakMode
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;

/**
 @brief 计算文字的大小

 @param font 字体(默认为系统字体)
 @param size 约束大小
 @param attributes
 */
- (CGSize)sizeMakeWithFont:(UIFont *)font constrainedToSize:(CGSize)size attributes:(nullable NSDictionary<NSString *, id> *)attributes;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;

//根据文字大小返回宽度
-(CGFloat)widthOfStringFont:(UIFont*)font;
@end
