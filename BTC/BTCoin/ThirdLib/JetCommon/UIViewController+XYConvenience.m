//
//  UIViewController+XYConvenience.m
//  WisePal
//
//  Created by sunon002 on 15-4-29.
//  Copyright (c) 2015年 Jet.Luo. All rights reserved.
//

#import "UIViewController+XYConvenience.h"
#import "UIView+XYConvenience.h"
#import "NSObject+XYConvenience.h"
#import <objc/runtime.h>

@implementation UIViewController (XYConvenience)

//获取当前屏幕显示的viewcontroller
- (UIViewController *)currentViewControllerOnScreen
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark - 添加属性
- (CGFloat)kKeyboardOpenViewOriginally_YValue
{
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, @selector(kKeyboardOpenViewOriginally_YValue));
    return [number intValue];
}
- (void)setKKeyboardOpenViewOriginally_YValue:(CGFloat)kKeyboardOpenViewOriginally_YValue {
    objc_setAssociatedObject(self, @selector(kKeyboardOpenViewOriginally_YValue), [NSNumber numberWithInt:kKeyboardOpenViewOriginally_YValue], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - AlertView
- (void)alertViewTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
           affirmTitle:(NSString *)affirmTitle
             withBlock:(void (^)(BOOL isAffirm))block {
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        if(cancelTitle) {
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                block(NO);
            }];
            [alert addAction:actionCancel];
        }
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:affirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(YES);
        }];
        [alert addAction:actionOK];
        [self presentViewController:alert animated:YES completion:NULL];
    } else {
        [self alertViewTitle:title messge:message cancelText:cancelTitle affirmText:affirmTitle withBlock:block];
    }
}

//分割线顶格设置
- (void)configSeparatorAlignmentWith:(_Nonnull id)TableOrCell
{
    if ([TableOrCell respondsToSelector:@selector(setSeparatorInset:)]) {
        [TableOrCell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([TableOrCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [TableOrCell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - 找键盘
- (UIView *)findKeyboard
{
    UIView *keyboardView = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in [windows reverseObjectEnumerator])//逆序效率更高，因为键盘总在上方
    {
        keyboardView = [self findKeyboardInView:window];
        if (keyboardView)
        {
            return keyboardView;
        }
    }
    return nil;
}
- (UIView *)findKeyboardInView:(UIView *)view
{
    for (UIView *subView in [view subviews])
    {
        if (strstr(object_getClassName(subView), "UIKeyboard"))
        {
            return subView;
        }
        else
        {
            UIView *tempView = [self findKeyboardInView:subView];
            if (tempView)
            {
                return tempView;
            }
        }
    }
    return nil;
}

/*
#pragma mark - 键盘弹出处理
- (UIView *)kKeyboardRespondView {
    return objc_getAssociatedObject(self, @selector(kKeyboardRespondView));
}
- (void)setKKeyboardRespondView:(UIView * _Nullable)kKeyboardRespondView {
    objc_setAssociatedObject(self, @selector(kKeyboardRespondView), kKeyboardRespondView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)addCancelKeyboardGesttureRecognizer {
    UITapGestureRecognizer *cancelKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xyCancelKeyboardDown:)];
    cancelKeyboard.numberOfTapsRequired = 1;
    cancelKeyboard.numberOfTouchesRequired = 1;
    cancelKeyboard.cancelsTouchesInView =NO;
    [self.view addGestureRecognizer:cancelKeyboard];
    return cancelKeyboard;
}
- (void)removeCancelKeyboardGesttureRecognizer {
    UIGestureRecognizer *removeGestrue = nil;
    for(UIGestureRecognizer *gestures in self.view.gestureRecognizers) {
        if([gestures isMemberOfClass:[UITapGestureRecognizer class]]) {
            if([gestures respondsToSelector:@selector(xyCancelKeyboardDown:)]) {
                removeGestrue = gestures;
                break;
            }
        }
    }
    if(removeGestrue != nil) {
        [self.view removeGestureRecognizer:removeGestrue];
    }
}
- (void)xyCancelKeyboardDown:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openTheKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shutTheKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationWillChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
- (void)statusBarOrientationWillChange:(NSNotification *)notification {
    [self.view endEditing:YES];
}
- (void)resetCurrentViewFrame {//-- 重置Frame
    if ([self respondsToSelector:@selector(resetSelfViewFrame)]) {
        
        [self resetSelfViewFrame];
        
    } else if(self.kKeyboardOpenViewOriginally_YValue != 0) {
        
        CGRect frame = self.view.frame;
        frame.origin.y += self.kKeyboardOpenViewOriginally_YValue;
        frame.size.height += self.kKeyboardOpenViewOriginally_YValue;
        self.view.frame = frame;
        self.kKeyboardOpenViewOriginally_YValue = 0;
    }
}
- (void)openTheKeyboard:(NSNotification *)notification {
    [self resetCurrentViewFrame];
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if ([self respondsToSelector:@selector(settingSelfViewFrame:)]) {
        
        [self settingSelfViewFrame:rect.size.height];
        
    } else {
        
        CGFloat offset_y = 0;
        if([self respondsToSelector:@selector(offsetVerticalKeybord)]) {
            offset_y = [self offsetVerticalKeybord];
        }
        __unused CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        UIView *firstResponder = [self.view findFirstResponderOfTheView];
        CGRect nowFrame = [firstResponder.superview convertRect:firstResponder.frame toView:self.view];
        if(CGRectGetMaxY(nowFrame) > CGRectGetHeight(self.view.frame)) {
            nowFrame.origin.y -= CGRectGetMaxY(nowFrame)-CGRectGetHeight(self.view.frame);
        }
        CGFloat frMaxY = CGRectGetMaxY(nowFrame)+offset_y;
        CGFloat keyboardMinY = CGRectGetHeight(self.view.frame)-rect.size.height;
        if(frMaxY > keyboardMinY) {
            CGFloat nowY = frMaxY-keyboardMinY;//计算view上移多少点
            self.kKeyboardOpenViewOriginally_YValue = nowY;//-- 保存view上移多少点
            CGRect frame = self.view.frame;
            frame.origin.y -= nowY;
            self.view.frame = frame;
            [UIView animateWithDuration:keyboardDuration animations:^{
                [self.view layoutIfNeeded];
            }];
        }
        if([self respondsToSelector:@selector(doSomethingAfterShowKeyboard:)]) {
            [self doSomethingAfterShowKeyboard:notification];
        }
    }
}
- (void)shutTheKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    __unused CGFloat keyboardDuration =[userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self resetCurrentViewFrame];
    if([self respondsToSelector:@selector(doSomethingAfterHidsKeyboard:)]) {
        [self doSomethingAfterHidsKeyboard:notification];
    }
}
 */

@end
