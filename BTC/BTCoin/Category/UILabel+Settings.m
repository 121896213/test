//
//  UILabel+Settings.m
//  BTCoin
//
//  Created by sumrain on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "UILabel+Settings.h"

@implementation UILabel (Settings)

-(void)setLabelParagraphStyle {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing =  FIT(5); //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.text attributes:dic];
    self.attributedText = attributeStr;
}

-(CGFloat)getLabelParagraphStyleHeightWithWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = FIT(5);
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                          };
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(width, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
}

-(void)setAttributedTextWithBeforeString:(NSString*)beforeString beforeColor:(UIColor*) beforeColor beforeFont:(UIFont*) beforeFont afterString:(NSString*)afterString afterColor:(UIColor*) afterColor afterFont:(UIFont*) afterFont
{
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:self.text];
    [content addAttribute:NSForegroundColorAttributeName value:beforeColor range:NSMakeRange(0, beforeString.length)];
    [content addAttribute:NSForegroundColorAttributeName value:afterColor range:NSMakeRange(beforeString.length, afterString.length)];
    [content addAttribute:NSFontAttributeName value:beforeFont range:NSMakeRange(0, beforeString.length)];
    [content addAttribute:NSFontAttributeName value:afterFont range:NSMakeRange(beforeString.length, afterString.length)];
    self.attributedText=content;
}

-(void)setAttributedTextColorWithBeforeString:(NSString*)beforeString beforeColor:(UIColor*) beforeColor afterString:(NSString*)afterString afterColor:(UIColor*) afterColor
{
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:self.text];
    [content addAttribute:NSForegroundColorAttributeName value:beforeColor range:NSMakeRange(0, beforeString.length)];
    [content addAttribute:NSForegroundColorAttributeName value:afterColor range:NSMakeRange(beforeString.length, afterString.length)];
    self.attributedText=content;
}

-(void)setAttributedTextFontWithBeforeString:(NSString*)beforeString beforeFont:(UIFont*) beforeFont afterString:(NSString*)afterString afterFont:(UIFont*) afterFont
{
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:self.text];
    [content addAttribute:NSFontAttributeName value:beforeFont range:NSMakeRange(0, beforeString.length)];
    [content addAttribute:NSFontAttributeName value:afterFont range:NSMakeRange(beforeString.length, afterString.length)];
    self.attributedText=content;
}
@end
