//
//  UIAlertController+Block.h
//  99Gold
//
//  Created by LionIT on 11/10/2017.
//  Copyright © 2017 xia zhonglin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Block)

/**
 *  快速创建UIAlertView视图
 *
 *  @param title              标题
 *  @param viewController     当前控制器
 *  @param cancelStr          取消按钮
 *  @param otherBthStr        确定按钮
 *  @param message            提示信息
 *  @param completionCallback 回调事件
 */
+(void)createAlertViewWithTitle:(NSString *)title withViewController:(UIViewController *)viewController withCancleBtnStr:(NSString *)cancelStr withOtherBtnStr:(NSString *)otherBthStr withMessage:(NSString *)message completionCallback:(void (^)(NSInteger index))completionCallback;

/**
 专用于快速创建浦发下单UIAlertView视图

 @param title 标题
 @param viewController 当前控制器
 @param cancelStr 取消按钮
 @param otherBthStr 确定按钮
 @param message 提示信息
 @param completionCallback 回调事件
 */
+(void)createPFOrderAlertViewWithTitle:(NSString *)title withViewController:(UIViewController *)viewController withCancleBtnStr:(NSString *)cancelStr withOtherBtnStr:(NSString *)otherBthStr withMessage:(NSString *)message completionCallback:(void (^)(NSInteger index))completionCallback;

@end
