//
//  SZPopView.m
//  BTCoin
//
//  Created by Shizi on 2018/5/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPopView.h"

@interface SZPopView()
@property (nonatomic,assign) CGFloat contentHeight;
@property (nonatomic,assign) CGRect contentFrame;

@end
@implementation SZPopView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self initContentWithFrame:frame];
        self.contentHeight=frame.size.height;
        self.contentFrame=frame;
    }
    
    return self;
}

- (void)initContentWithFrame:(CGRect)frame
{

    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.userInteractionEnabled = YES;
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (!_contentView)
    {
        
        _contentView = [[UIView alloc]initWithFrame:frame];
        NSLog(@"_contentView.frame:%@",NSStringFromCGRect(_contentView.frame));
        _contentView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_contentView];
    }
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        //取得键盘弹出时间
        CGFloat duration = [((NSNotification*)x).userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        //取得键盘高度
        CGRect keyboardFrame = [((NSNotification*)x).userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardHeight = keyboardFrame.size.height;
        //option的值设置为7 << 16会让view跟键盘弹出效果同步
        NSLog(@"keyboardHeight:%lf",keyboardHeight);
        [UIView animateWithDuration:duration delay:0 options:7 << 16 animations:^{
            self.contentView.transform = CGAffineTransformMakeTranslation(0, -FIT(80));
        } completion:nil];
        
    }];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        CGFloat duration = [((NSNotification*)x).userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:duration delay:0 options:7 << 16 animations:^{
            self.contentView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}

- (void)loadMaskView
{
    
    
}
//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view  directionType:(SZPopViewFromDirectionType) directionType
{
    if (!view){
        return;
    }
    [view addSubview:self];
    _directionType=directionType;
    if (_directionType == SZPopViewFromDirectionTypeCenter) {
        
       [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
        [UIView animateWithDuration:1.0 animations:^{
            
            [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX);
                make.centerY.equalTo(self.mas_centerY);
                make.width.mas_equalTo(self.contentFrame.size.width);
                make.height.mas_equalTo(self.contentFrame.size.height);
            }];
            [_contentView updateConstraints];

        } completion:nil];
    }else if (_directionType == SZPopViewFromDirectionTypeTop) {
        [self setY: NavigationStatusBarHeight+FIT(43)];
        [_contentView setFrame:CGRectMake(0,0,ScreenWidth,0)];
        [UIView animateWithDuration:0.0 animations:^{
            _contentView.frame=CGRectMake(0,0, ScreenWidth, self.contentHeight);
        } completion:nil];
    }else{
        [_contentView setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, self.contentHeight)];
        [UIView animateWithDuration:0.3 animations:^{
            [_contentView setFrame:CGRectMake(0, ScreenHeight-self.contentHeight, ScreenWidth, self.contentHeight)];
        } completion:nil];
    }

}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    if (_directionType == SZPopViewFromDirectionTypeCenter) {
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(self.contentFrame.size.width);
            make.height.mas_equalTo(self.contentFrame.size.height);
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX);
                make.centerY.equalTo(self.mas_centerY);
                make.width.mas_equalTo(0);
                make.height.mas_equalTo(0);
            }];
            
        } completion:^(BOOL finished) {
            [_contentView removeFromSuperview];
            [self removeFromSuperview];

        }];
    }else if (_directionType == SZPopViewFromDirectionTypeTop) {
        [_contentView setFrame:CGRectMake(0, 0, ScreenWidth,self.contentHeight)];
        [UIView animateWithDuration:0.0f animations:^{
            [_contentView setFrame:CGRectMake(0, 0, ScreenWidth,0)];
        }completion:^(BOOL finished){
            [_contentView removeFromSuperview];
            [self removeFromSuperview];

        }];
    }else{
        [_contentView setFrame:CGRectMake(0, ScreenHeight - self.contentHeight, ScreenWidth, 0)];
        [UIView animateWithDuration:0.3f animations:^{
            [_contentView setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, self.contentHeight)];
        }completion:^(BOOL finished){
            [_contentView removeFromSuperview];
            [self removeFromSuperview];

        }];
    }
 

}
@end
