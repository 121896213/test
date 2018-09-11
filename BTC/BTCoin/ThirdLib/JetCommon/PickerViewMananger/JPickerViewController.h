//
//  JPickerViewController.h
//  BTCoin
//
//  Created by Shizi on 2018/4/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPickerModel;

@interface JPickerViewController : UIViewController

@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,copy) NSArray<JPickerModel *> *dataArray;
@property (nonatomic,assign) NSInteger columns;

@end

@interface JPickerModel : NSObject

@property (nonatomic,copy) NSArray<NSString *> *names;

@end
