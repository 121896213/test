//
//  JPickerViewManager.h
//  BTCoin
//
//  Created by Shizi on 2018/4/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JPickerViewController.h"

typedef void (^JPickerManagerBlock)(int indexs, id value , int twoIndex , id twoValue);

@interface JPickerViewManager : NSObject


@end
