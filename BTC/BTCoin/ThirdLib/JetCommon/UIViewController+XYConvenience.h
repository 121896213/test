//
//  UIViewController+XYConvenience.h
//  WisePal
//
//  Created by sunon002 on 15-4-29.
//  Copyright (c) 2015年 Jet.Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XYConvenience)

//-- 未定
- (UIViewController *_Nullable)currentViewControllerOnScreen;

//分割线顶格设置
- (void)configSeparatorAlignmentWith:(_Nonnull id)TableOrCell;

#pragma mark - AlertView
- (void)alertViewTitle:(NSString * _Nullable)title
               message:(NSString * _Nonnull)message
           cancelTitle:(NSString * _Nullable)cancelTitle
           affirmTitle:(NSString * _Nonnull)affirmTitle
             withBlock:(void (^ _Nonnull)(BOOL isAffirm))block;

/*
#pragma mark - 键盘弹出处理
@property (nonatomic,assign,readonly) CGFloat kKeyboardOpenViewOriginally_YValue;

//-- 添加键盘通知
- (void)addKeyboardNotification;
- (void)removeKeyboardNotification;
- (UITapGestureRecognizer * _Nonnull)addCancelKeyboardGesttureRecognizer;
- (void)removeCancelKeyboardGesttureRecognizer;
 */
@end
/*
@interface UIViewController ()

- (CGFloat)offsetVerticalKeybord; //-- 返回键盘高度的差值,假设你的响应view想离键盘的距离为10，就返回10
- (void)doSomethingAfterShowKeyboard:(NSNotification *_Nonnull)notification;//键盘弹出时，你想做的事
- (void)doSomethingAfterHidsKeyboard:(NSNotification *_Nonnull)notification;

//自定义
- (void)resetSelfViewFrame;
- (void)settingSelfViewFrame:(CGFloat)keyboard_hight;

@end
*/
