//
//  LoginTextField.h
//  99SVR
//
//  Created by 邹宇彬 on 15/12/21.
//  Copyright (c) 2015年 xia zhonglin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextField : UITextField
/**左边的提示*/
@property(nonatomic, copy) NSString *leftViewImageName;
/**是否开启安全密码模式*/
@property(nonatomic, assign) BOOL isShowTextBool;


//文字向右移动(默认为10)
@property (nonatomic, assign) CGFloat moveToTheRight;

/**
 *  登录及注册通用TextField
 *
 *  @param pointY        距离顶部的Y值
 *  @param imageName     左边图片名称
 *  @param placeholder   提示文字
 *
 *  @return 登录及注册通用TextField
 */
+ (instancetype)loginTextFieldWithPointY:(CGFloat)pointY imageName:(NSString *)imageName placeholder:(NSString *)placeholder;

/**
 *  登录及注册通用TextField
 *
 *  @param pointY        距离顶部的Y值
 *  @param imageName     左边图片名称
 *  @param placeholder   提示文字
 *  @param isPwdShowText 是否开启密码可见
 *
 *  @return 登录及注册通用TextField
 */
+ (instancetype)loginTextFieldWithPointY:(CGFloat)pointY imageName:(NSString *)imageName placeholder:(NSString *)placeholder isPwdShowText:(BOOL)isPwdShowText;

/**
 *  验证码输入框，不带底部横线，需要手动添加
 *
 *  @param pointY        距离顶部的Y值
 *  @param width         宽度
 *  @param imageName     左边图片名称
 *  @param placeholder   提示文字
 *
 *  @return 验证码输入框
 */
+ (instancetype)codeTextFieldWithPointY:(CGFloat)pointY width:(CGFloat)width imageName:(NSString *)imageName placeholder:(NSString *)placeholder;
@end
