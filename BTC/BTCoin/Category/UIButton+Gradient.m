//
//  UIButton+Gradient.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "UIButton+Gradient.h"


@implementation UIButton (Gradient)


- (void)setGradientBackGround
{
//    CALayer * layer = self.layer.sublayers[0];
//    if ([layer isKindOfClass:[CAGradientLayer class]]) {
//        return;
//    }
//
//    [self layoutIfNeeded];
//    self.layer.cornerRadius = 5.0f;
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.cornerRadius = 5.0f;
//    //设置开始和结束位置(设置渐变的方向)
//    gradient.startPoint = CGPointMake(0, 0);
//    gradient.endPoint = CGPointMake(1, 0);
//    gradient.frame = self.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)UIColorFromRGB(0x4e6aae).CGColor,(id)UIColorFromRGB(0x2e457b).CGColor,nil];
//    [self.layer insertSublayer:gradient atIndex:0];

    [self setBackgroundImage:[UIImage imageWithColor:MainThemeBlueColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:MainThemeHighlightColor] forState:UIControlStateHighlighted];
    [self setCircleBorderWidth:FIT(1) bordColor:MainThemeBlueColor radius:FIT(3)];
}

- (void)removeGradientBackGround{
//    CALayer * layer = self.layer.sublayers[0];
//    if (![layer isKindOfClass:[CAGradientLayer class]]) {
//        return;
//    }
//    NSMutableArray * mArr = [NSMutableArray arrayWithArray:self.layer.sublayers];
//    [mArr removeObjectAtIndex:0];
//    self.layer.sublayers = mArr;
}


@end
