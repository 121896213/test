//
//  CommonPickView.h
//  99Gold
//
//  Created by LionIT on 25/04/2017.
//  Copyright © 2017 xia zhonglin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong) UIPickerView * pickerView;
@property (nonatomic,copy) CommonStringBlock block;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)source parentView:(UIView *)view;
- (void)movePickerView;
- (void)updateDataSource:(NSArray *)source;
- (void)updateDataSource:(NSArray *)source index:(NSInteger)index;
@end
