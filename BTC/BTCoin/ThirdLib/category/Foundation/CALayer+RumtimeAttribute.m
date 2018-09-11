//
//  CALayer+RumtimeAttribute.m
//  InvestNanny
//
//  Created by LionIT on 7/21/16.
//  Copyright © 2016 tracy. All rights reserved.
//

#import "CALayer+RumtimeAttribute.h"

@implementation CALayer (RumtimeAttribute)
- (void)setBorderIBColor:(UIColor*)borderIBColor {
    self.borderColor = borderIBColor.CGColor;
}

- (UIColor*)borderIBColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
