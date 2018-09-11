//
//  CommonPickView.m
//  99Gold
//
//  Created by LionIT on 25/04/2017.
//  Copyright © 2017 xia zhonglin . All rights reserved.
//

#import "CommonPickView.h"
#import "UIButton+Extension.h"

#define kPickbgViewHeight   240.f

@interface CommonPickView ()
@property (nonatomic,copy) NSArray * codeArray;
@property (nonatomic, copy) UIView *dimBackgroundView;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation CommonPickView {
    UIView * pickbgView;
    __block BOOL isAnimationFinished;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)source parentView:(UIView *)view {
    
    self = [self initWithFrame:frame];
    
    self.codeArray = source;
    
    [view addSubview:self];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        isAnimationFinished = YES;
        
        //背景
        UIView * bgView = [[UIView alloc] initWithFrame:Rect(0, 0, RectWidth(frame), RectHeight(frame))];
//        bgView.backgroundColor = color_d2d2d2;
//        bgView.alpha = 0.5;
        [self addSubview:bgView];
        
        [bgView addSubview:self.dimBackgroundView];
        
        //pickView 背景
        pickbgView = [[UIView alloc] initWithFrame:Rect(0, RectHeight(frame), RectWidth(frame), kPickbgViewHeight)];
        pickbgView.backgroundColor = COLOR_Bg_White;
        [self addSubview:pickbgView];
        
        //pickView header
        UIView * pickHeaderView = [[UIView alloc] initWithFrame:Rect(0, 0, RectWidth(frame), 44.0)];
        pickHeaderView.backgroundColor = UIColorFromRGB(0xF4F2F8);
        [pickbgView addSubview:pickHeaderView];
        
        @WeakObj(self)
        UIButton * cancelBtn = [UIButton initWithFrame:Rect(5, 5, 44, 40) title:@"取消"];
        [cancelBtn setTitleColor:UIColorFromRGB(0xffbd5b) forState:UIControlStateNormal];
        [cancelBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [selfWeak movePickerView];
        }];
        [pickHeaderView addSubview:cancelBtn];
        
        UIButton * confirmBtn = [UIButton initWithFrame:Rect(RectWidth(frame)-5-44, 5, 44, 40) title:@"确定"];
        [confirmBtn setTitleColor:UIColorFromRGB(0xffbd5b) forState:UIControlStateNormal];
        [confirmBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            @StrongObj(self)
            [self movePickerView];
            if (self.block && self.selectedIndex < self.codeArray.count) {
                self.block(self.codeArray[self.selectedIndex]);
            }
        }];
        [pickHeaderView addSubview:confirmBtn];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:Rect(0, CGRectGetMaxY(pickHeaderView.frame), RectWidth(frame), RectHeight(pickbgView)-CGRectGetMaxY(pickHeaderView.frame))];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [pickbgView addSubview:_pickerView];
    }
    
    return self;
}

- (void)dealloc {
    DLog(@"");
}

#pragma mark - public methods
- (void)movePickerView {
    if (!isAnimationFinished) {
        return;
    }
    
    isAnimationFinished = NO;
    if (self.hidden) {
        self.hidden = NO;
        [UIView animateWithDuration:0.5f animations:^{
            CGRect rect = CGRectOffset(pickbgView.frame, 0, -kPickbgViewHeight);
            pickbgView.frame = rect;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            isAnimationFinished = finished;
        }];
    } else {
        [UIView animateWithDuration:0.5f animations:^{
            CGRect rect = CGRectOffset(pickbgView.frame, 0, kPickbgViewHeight);
            pickbgView.frame = rect;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.hidden = YES;
            isAnimationFinished = finished;
        }];
    }
}

- (void)updateDataSource:(NSArray *)source {
    self.selectedIndex = 0;
    [self updateDataSource:source index:self.selectedIndex];
}

- (void)updateDataSource:(NSArray *)source index:(NSInteger)index {
    self.selectedIndex = index;
    self.codeArray = source;
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:self.selectedIndex inComponent:0 animated:YES];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.codeArray.count;
}

#pragma mark - UIPickerViewDelegate
// 返回pickerView的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.codeArray.count > row? self.codeArray[row]:@"";
}

// 选中行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedIndex = row;
}

#pragma mark - Getters and Setters
- (UIView *)dimBackgroundView {
    if(!_dimBackgroundView) {
        _dimBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [_dimBackgroundView setTranslatesAutoresizingMaskIntoConstraints:YES];
        _dimBackgroundView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movePickerView)];
        [_dimBackgroundView addGestureRecognizer:tap];
    }
    return _dimBackgroundView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
