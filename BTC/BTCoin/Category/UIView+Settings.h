//
//  UIView+Settings.h
//  BTCoin
//
//  Created by sumrain on 2018/6/19.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Settings)
-(void)setCircleBorderWidth:(CGFloat)width bordColor:(UIColor*)color radius:(CGFloat)radius;
-(void)addBottomLineView;
-(void)addBottomLineViewColor:(UIColor*)color;
-(void)addBottomLineView:(CGFloat)lineWidth;
-(void)setShadowToView;
-(void)removeBoomLine;
-(void)refreshBottomLineViewColor:(UIColor*)color;
-(void)addBottomLineWithMinY:(CGFloat)minY;
@end
