//
//  SZWithdrawPasswordCell.m
//  BTCoin
//
//  Created by Shizi on 2018/5/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWithdrawPasswordCell.h"
#import "RegisterTextField.h"
@interface SZWithdrawPasswordCell()
@property (nonatomic,strong) UITextField* tradePwdTextField;
@property (nonatomic,strong) UIButton*  showPwdBtn;
@end
@implementation SZWithdrawPasswordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=MainBackgroundColor;
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews
{
    
    
    
    UILabel* rechargeAddressLabel=[UILabel new];
    [rechargeAddressLabel setText:NSLocalizedString(@"交易密码", nil)];
    [rechargeAddressLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [rechargeAddressLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:rechargeAddressLabel];
    [rechargeAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(178));
    }];
    
    UIView* textFieldView=[UIView new];
    textFieldView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:textFieldView];
    [textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeAddressLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    UITextField* addressTextField=[UITextField new];
    addressTextField.placeholder=NSLocalizedString(@"请输入交易密码", nil);
    addressTextField.textColor=[UIColor blackColor];
    addressTextField.font=[UIFont systemFontOfSize:14.0f];
    addressTextField.keyboardType=UIKeyboardTypeNumberPad;
    [addressTextField setSecureTextEntry:YES];
    self.tradePwdTextField=addressTextField;
    [textFieldView addSubview:addressTextField];
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeAddressLabel.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    UIButton* showPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showPwdBtn setImage:[UIImage imageNamed:@"icon_eye_close"] forState:UIControlStateNormal];
    [showPwdBtn setImage:[UIImage imageNamed:@"icon_eye_open"] forState:UIControlStateSelected];
    showPwdBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [textFieldView addSubview:showPwdBtn];
    self.showPwdBtn=showPwdBtn;
    [showPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeAddressLabel.mas_bottom);
        make.right.mas_equalTo(FIT3(-48));
        make.width.mas_equalTo(FIT3(73));
        make.height.mas_equalTo(FIT3(146));
    }];
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT3(-1.5));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    [self addActions];

    
}

-(void)addActions{
    
    
    @weakify(self);
    [[self.tradePwdTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(id x) {
        @strongify(self);
        self.withdrawViewModel.currentPassword=self.tradePwdTextField.text;
        [(RACSubject *) self.withdrawViewModel.otherSignal sendNext:SZWithdrawPasswordCellTextFieldDidChanged];
        NSLog(@"textFiledChange:%@",self.tradePwdTextField.text);
    }];
    
    
    [[self.showPwdBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        if (self.showPwdBtn.isSelected) {
            self.showPwdBtn.selected = NO;
        }else{
            self.showPwdBtn.selected = YES;
        }
        self.tradePwdTextField.secureTextEntry = !self.showPwdBtn.selected;
    }];
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
