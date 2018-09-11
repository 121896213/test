//
//  LoginTextField.m
//  99SVR
//
//  Created by Jiangys on 15/12/21.
//  Copyright (c) 2015年 xia zhonglin . All rights reserved.
//

#import "LoginTextField.h"

@interface LoginTextField()

@property (nonatomic, strong) UIImageView *leftImageView;
/**是否显示密码*/
@property (nonatomic, strong) UIButton *showPwdBtn;

@end

// 图片宽高
static CGFloat const imageWidth = 17;

@implementation LoginTextField

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
        self.leftImageView.frame = (CGRect){0, 0, imageWidth, imageWidth};
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textColor = COLOR_Text_Black;
        self.font = Font_15;
        self.clearButtonMode = UITextFieldViewModeAlways;
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self setKeyboardType:UIKeyboardTypeASCIICapable];
        
        self.showPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.showPwdBtn.frame = (CGRect){0, 0, 30, self.height};
        [self.showPwdBtn setImage:[UIImage imageNamed:@"hidePwd"] forState:UIControlStateNormal];
        [self.showPwdBtn setImage:[UIImage imageNamed:@"showPwd"] forState:UIControlStateSelected];
        self.showPwdBtn.imageView.size = (CGSize){imageWidth,imageWidth};
        [self.showPwdBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



+ (instancetype)loginTextFieldWithPointY:(CGFloat)pointY imageName:(NSString *)imageName placeholder:(NSString *)placeholder
{
    return [self loginTextFieldWithPointY:pointY imageName:imageName placeholder:placeholder isPwdShowText:NO];
}

+ (instancetype)loginTextFieldWithPointY:(CGFloat)pointY imageName:(NSString *)imageName placeholder:(NSString *)placeholder isPwdShowText:(BOOL)isPwdShowText
{
    LoginTextField *textField = [[LoginTextField alloc] initWithFrame:CGRectMake(kLoginMargin, pointY,kScreenWidth - 2 * kLoginMargin, 40)];
    textField.leftViewImageName = imageName;
    textField.isShowTextBool = isPwdShowText;
    [textField setPlaceholder:placeholder];
    if ([app_BundleId isEqualToString:@"com.shiziSoft.BTCoin"]) {
        
    }
    // 添加底部线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, textField.height - 0.5, textField.width, 0.5)];
    line.backgroundColor = COLOR_Line_Small_Gay;
    [textField addSubview:line];
    
    return textField;
}

// 验证码
+ (instancetype)codeTextFieldWithPointY:(CGFloat)pointY width:(CGFloat)width imageName:(NSString *)imageName placeholder:(NSString *)placeholder
{
    LoginTextField *textField = [[LoginTextField alloc] initWithFrame:CGRectMake(kLoginMargin, pointY,width, 40)];
    textField.leftViewImageName = imageName;
    [textField setPlaceholder:placeholder];
    return textField;
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
    iconRect.origin.x+=self.moveToTheRight;
    return iconRect;
}

// 改变编辑时文字位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super editingRectForBounds:bounds];
    iconRect.origin.x+=self.moveToTheRight;
    return iconRect;
}

@end
