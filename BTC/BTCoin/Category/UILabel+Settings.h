//
//  UILabel+Settings.h
//  BTCoin
//
//  Created by sumrain on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Settings)
-(void)setLabelParagraphStyle;
-(CGFloat)getLabelParagraphStyleHeightWithWidth:(CGFloat)width;
-(void)setAttributedTextWithBeforeString:(NSString*)beforeString beforeColor:(UIColor*) beforeColor beforeFont:(UIFont*) beforeFont afterString:(NSString*)afterString afterColor:(UIColor*) afterColor afterFont:(UIFont*) afterFont;
-(void)setAttributedTextColorWithBeforeString:(NSString*)beforeString beforeColor:(UIColor*) beforeColor afterString:(NSString*)afterString afterColor:(UIColor*) afterColor;
-(void)setAttributedTextFontWithBeforeString:(NSString*)beforeString beforeFont:(UIFont*) beforeFont afterString:(NSString*)afterString afterFont:(UIFont*) afterFont;
@end
