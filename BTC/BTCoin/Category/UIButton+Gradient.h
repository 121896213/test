//
//  UIButton+Gradient.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Gradient)

/**按钮背景设置渐变色<加了约束的按钮，需在约束设置完后调用此方法>*/
- (void)setGradientBackGround;


- (void)removeGradientBackGround;

@end
