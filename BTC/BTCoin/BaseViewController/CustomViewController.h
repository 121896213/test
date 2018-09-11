//
//  CustomViewController.h
//  FreeCar
//
//  Created by xiongchi on 15/8/1.
//  Copyright (c) 2015年 xiongchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFBaseViewController.h"
@interface CustomViewController : GFBaseViewController 

@property (nonatomic,strong) UILabel *txtTitle;//导航标题
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIButton *btnLeft;
@property (nonatomic,strong) UIButton *btnRight;

- (void)setHeadViewHidden:(BOOL)bFlag;
- (void)setViewBgColor:(UIColor *)bgColor;
- (void)setTitleText:(NSString *)strText;
- (void)setLeftBtn:(UIButton *)btnLeft;
- (void)setRightBtn:(UIButton *)btnRight;
- (void)setUserInter;
- (void)setHeadBackGroup:(UIColor *)color;
- (void)addDefaultHeader:(NSString *)title;
- (void)hideLeftBtn;
- (void)MarchBackLeft;
- (void)navBack;

+ (UIButton *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
+ (UIButton *)itemWithTarget:(id)target action:(SEL)action title:(NSString*)title;
-(void)showNoResultView;
-(void)hideNoResultView;
@end
