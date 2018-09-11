//
//  UIColor+Ext.m
//  99SVR
//
//  Created by 邹宇彬 on 15/12/21.
//  Copyright (c) 2015年 xia zhonglin . All rights reserved.
//

#import "UIColor+Ext.h"
#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation UIColor (Ext)

+ (UIColor *)colorWithHex:(NSString *)hexStr
{
    return [UIColor colorWithHex:hexStr alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSString *)hexStr alpha:(CGFloat)alpha
{
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

@end