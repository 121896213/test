//
//  UIAlertController+Block.m
//  99Gold
//
//  Created by LionIT on 11/10/2017.
//  Copyright © 2017 xia zhonglin . All rights reserved.
//

#import "UIAlertController+Block.h"
#import <objc/runtime.h>

@implementation UIAlertController (Block)

+(void)createAlertViewWithTitle:(NSString *)title withViewController:(UIViewController *)viewController withCancleBtnStr:(NSString *)cancelStr withOtherBtnStr:(NSString *)otherBthStr withMessage:(NSString *)message completionCallback:(void (^)(NSInteger index))completionCallback{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //取消按钮
    if (cancelStr)
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (completionCallback) {
                completionCallback(0);
            }
        }];
        //获取所有变量
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([cancelAction class], &outCount);
        for (int i=0; i!=outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            if ([ivarName isEqualToString:@"_titleTextColor"]) {//找到这个变量才进行kvc赋值
                [cancelAction setValue:COLOR_Text_Gay forKey:@"_titleTextColor"];
            }
        }
        [alertVC addAction:cancelAction];
    }
    //其它按钮
    if (otherBthStr)
    {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherBthStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (completionCallback) {
                completionCallback(1);
            }
        }];
        [alertVC addAction:otherAction];
    }
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+(void)createPFOrderAlertViewWithTitle:(NSString *)title withViewController:(UIViewController *)viewController withCancleBtnStr:(NSString *)cancelStr withOtherBtnStr:(NSString *)otherBthStr withMessage:(NSString *)message completionCallback:(void (^)(NSInteger index))completionCallback {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (message) {
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentLeft;
        style.lineSpacing = 8;
        style.firstLineHeadIndent = 60;
        NSAttributedString * messageAttr = [[NSAttributedString alloc] initWithString:message attributes:@{NSParagraphStyleAttributeName:style}];
        [alertVC setValue:messageAttr forKey:@"attributedMessage"];
    }
    
    //取消按钮
    if (cancelStr)
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (completionCallback) {
                completionCallback(0);
            }
        }];
        //获取所有变量
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([cancelAction class], &outCount);
        for (int i=0; i!=outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            if ([ivarName isEqualToString:@"_titleTextColor"]) {//找到这个变量才进行kvc赋值
                [cancelAction setValue:COLOR_Text_Gay forKey:@"_titleTextColor"];
            }
        }
        [alertVC addAction:cancelAction];
    }
    //其它按钮
    if (otherBthStr)
    {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherBthStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (completionCallback) {
                completionCallback(1);
            }
        }];
        [alertVC addAction:otherAction];
    }
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

@end
