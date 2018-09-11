//
//  UIColor+SapColor.m
//  SAP
//
//  Created by lixinglou on 16/7/28.
//  Copyright © 2016年 sap. All rights reserved.
//

#import "UIColor+SapColor.h"

@implementation UIColor (SapColor)

+ (UIColor *)sapRed{
    
    //static NSString *colorKey = @"sapRed";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:198.0/255 green:59.0/255 blue:56.0/255 alpha:1.f];
        
    }
    
    return color;
}

+ (UIColor *)sapBlack{
    
    //static NSString *colorKey = @"sapBlack";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor blackColor];
        color = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

///#666666用于重要文字信息，副标题信息
+ (UIColor *)sapSoftBlack{
    //static NSString *colorKey = @"sapSoftBlack";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor blackColor];
        color = [UIColor colorWithRed:102.f/255 green:102.f/255 blue:102.f/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

//内容 #8e8e8e 142,142,142
+ (UIColor *)sap8e8e8eOr142Color{
    //static NSString *colorKey = @"sap8e8e8eOr142Color";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor blackColor];
        color = [UIColor colorWithRed:142.f/255 green:142.f/255 blue:142.f/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)sapGray{
    
    //static NSString *colorKey = @"sapGray";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

// #41a0ff系统蓝色
+ (UIColor *)sapBlue{
    //static NSString *colorKey = @"sapBlue";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:65.f/255.f green:160.f/255.f blue:1.f alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)sapSeprate{
    
    //static NSString *colorKey = @"sapSeprate0313";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        //更改日期 2017年03月02日 由雷总要求，Perry提供颜色值
        color = [UIColor colorWithRed:232.f/255 green:233.f/255 blue:233.f/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)sapPlaceholder{
    
    //static NSString *colorKey = @"sapPlaceholder";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:200.0/255 green:199.0/255 blue:204.0/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)sapBackground{
    
    //static NSString *colorKey = @"sapBackground";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        //更改日期 2017年03月02日 由雷总要求，Perry提供颜色值
        color = [UIColor colorWithRed:248.0/255 green:249.0/255 blue:251.0/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)sapBackgroundMenuBar{
    
    //static NSString *colorKey = @"sapBackgroundMenuBar2";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:248.0/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)sapBackgroundTitleBar{
    
    //static NSString *colorKey = @"sapBackgroundTitleBar";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:248.0/255 alpha:.95f];
        //加入缓存
    }
    
    return color;
}

//126 126 126
+ (UIColor *)sapMidGray{
    //static NSString *colorKey = @"sapMidGray";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:126.f/255.f green:126.f/255.f blue:126.f/255.f alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)sapDarkGray{
    
    //static NSString *colorKey = @"sapDarkGray";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)sapBtnColor{
    
    return [self sapBlue];
}

+ (UIColor *)sapBtnHighlightedColor{
    
    return [[self sapBlue] colorWithAlphaComponent:.9f];
}

///粉红254 123 0 FE7B00
+ (UIColor *)sapPink{
    
    //static NSString *colorKey = @"sapPink";
    UIColor *color = nil; //从缓存取值
    if (!color) {
        color = [UIColor colorWithRed:254.0/255 green:123.0/255 blue:0 alpha:1.f];
        //加入缓存
    }
    
    return color;
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

@end
