//
//  CustomTextField.m
//  SliderMenuView
//
//  Created by 刘海东 on 16/4/13.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "RegisterTextField.h"

@interface RegisterTextField ()

@property (nonatomic, strong) UIImageView *leftImageView;
/**是否显示密码*/
@property (nonatomic, strong) UIButton *showPwdBtn;

@end

@implementation RegisterTextField
- (instancetype)init {
    if (self = [super init]) {
        self.moveToTheRight = 10;        
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.moveToTheRight = 10;
        self.leftImageView = [[UIImageView alloc]init];
        CGFloat imageWidth = 25;
        self.leftImageView.frame = (CGRect){0, 0, imageWidth, imageWidth};
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.showPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.showPwdBtn.frame = (CGRect){0, 0, 55, 55};
        [self.showPwdBtn setImage:[UIImage imageNamed:@"icon_eye_close"] forState:UIControlStateNormal];
        [self.showPwdBtn setImage:[UIImage imageNamed:@"icon_eye_open"] forState:UIControlStateSelected];
        [self.showPwdBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}


-(void)setLeftViewImageName:(NSString *)leftViewImageName{
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = self.leftImageView;
    self.leftImageView.image = [UIImage imageNamed:leftViewImageName];
}

-(void)setIsShowTextBool:(BOOL)isShowTextBool{
    
    _isShowTextBool = isShowTextBool;
    
    if (isShowTextBool) {
        self.rightView = self.showPwdBtn;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.secureTextEntry = isShowTextBool;
    }
    self.showPwdBtn.hidden = !isShowTextBool;
}

-(void)btnClickAction:(UIButton *)btn{
    
    if (btn.isSelected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
    self.secureTextEntry = !btn.selected;
}


// 改变文字位置
-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super textRectForBounds:bounds];
    iconRect.origin.x += self.moveToTheRight;
    return iconRect;
}
// 改变编辑时文字位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super editingRectForBounds:bounds];
    iconRect.origin.x += self.moveToTheRight;
    return iconRect;
}




@end
