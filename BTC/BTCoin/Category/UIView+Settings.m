//
//  UIView+Settings.m
//  BTCoin
//
//  Created by sumrain on 2018/6/19.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "UIView+Settings.h"
#define TagForBoomLine 12983745 //去除BoomLine时用

@implementation UIView (Settings)
-(void)setCircleBorderWidth:(CGFloat)width bordColor:(UIColor*)color radius:(CGFloat)radius {
    
    
    self.layer.borderWidth = width;
    self.layer.borderColor=color.CGColor;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
-(void)addBottomLineWithMinY:(CGFloat)minY{
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    lineView.tag = TagForBoomLine;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(minY);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(0.5F);

    }];
    
}
-(void)addBottomLineView{
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    lineView.tag = TagForBoomLine;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-0.5F);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(0.5F);
        
    }]; 
    
}
-(void)addBottomLineViewColor:(UIColor*)color{
    UIView* lineView=[UIView new];
    lineView.backgroundColor=color;
    lineView.tag = TagForBoomLine;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-FIT(0.5F));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(0.5F));
        
    }];
    
}
-(void)addBottomLineView:(CGFloat)lineWidth{
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=[UIColor redColor];
    lineView.tag = TagForBoomLine;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(-FIT(0.5F));
        make.width.mas_equalTo(lineWidth);
        make.height.mas_equalTo(FIT(0.5F));
        
    }];
    
}

-(void)removeBoomLine{
    for (UIView * view in self.subviews) {
        if (view.tag == TagForBoomLine) {
            [view removeFromSuperview];
        }
    }
}

-(void)refreshBottomLineViewColor:(UIColor*)color{
    for (UIView * view in self.subviews) {
        if (view.tag == TagForBoomLine) {
            view.backgroundColor = color;
        }
    }
}



-(void)setShadowToView{

    self.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    self.layer.shadowOpacity = 0.25;//阴影透明度，默认为0，如果不设置的话看不到阴影，切记，这是个大坑
    self.layer.shadowOffset = CGSizeMake(0, 0);//设置偏移量
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:FIT3(10) cornerRadii:CGSizeMake(0, 0)].CGPath;
}


@end
