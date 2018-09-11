//
//  SZC2CTradeCommonCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CTradeCommonCell.h"
@interface SZC2CTradeCommonCell()
@property (nonatomic, strong) UILabel*  titleLab;

@property (nonatomic, strong)  UILabel*  unitLab;
@property (nonatomic, strong) UILabel* promptLab;
@end
@implementation SZC2CTradeCommonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.backgroundColor=[UIColor whiteColor];

    }
    return self;
}

-(void)setSubView{
    
    UILabel*  titleLab=[UILabel new];
    titleLab.text=NSLocalizedString(@"剩余可卖出数量", nil);
    titleLab.textColor=MainLabelBlackColor;
    titleLab.font=[UIFont systemFontOfSize:FIT(14.0f)];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(titleLab.font.lineHeight);
        make.top.mas_equalTo(FIT(17));
    }];
    
    UILabel* promptLab=[UILabel new];
    promptLab.textAlignment=NSTextAlignmentRight;
    promptLab.text=NSLocalizedString(@"单笔交易额：200-945.85 USDT", nil);
    promptLab.font=[UIFont systemFontOfSize:FIT(12.0f)];
    promptLab.textColor=MainLabelGrayColor;
    promptLab.textAlignment=NSTextAlignmentRight;
    promptLab.hidden=YES;
    [self addSubview:promptLab];
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.top.equalTo(titleLab.mas_top);
        make.width.mas_equalTo(FIT(200));
        make.height.mas_equalTo(promptLab.font.lineHeight);
    }];

    
    UITextField*  textField=[UITextField new];
    textField.placeholder=NSLocalizedString(@"请输入您的交易数量", nil);
    textField.font=[UIFont systemFontOfSize:FIT(18)];
    [textField setValue:[UIFont systemFontOfSize:FIT(14)] forKeyPath:@"_placeholderLabel.font"];
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLab.mas_left);
        make.right.equalTo(titleLab.mas_right);
        make.height.mas_equalTo(FIT(42));
        make.top.equalTo(titleLab.mas_bottom).offset(FIT(5));
        
    }];
    
    UILabel*  unitLab= [UILabel new];
    [unitLab setHidden:YES];
    unitLab.text=NSLocalizedString(@"USDT", nil);
    unitLab.font=[UIFont systemFontOfSize:FIT(14.0f)];
    unitLab.textAlignment=NSTextAlignmentRight;
    [textField addSubview:unitLab];
    [unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.equalTo(textField.mas_centerY);
        make.width.mas_equalTo(FIT(50));
        make.height.mas_equalTo(unitLab.font.lineHeight);
    }];
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    [textField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-0.5);
        make.height.mas_equalTo(0.5);
        
    }];
    
    self.titleLab=titleLab;
    self.textField=textField;
    self.unitLab=unitLab;
    self.promptLab=promptLab;
}

-(void)setContentStyle:(NSIndexPath*) indexPath isTradeSell:(BOOL)isTradeSell{
    
    if (isTradeSell) {
        if (indexPath.row == 0) {
            self.titleLab.text=NSLocalizedString(@"剩余可卖出数量", nil);
            self.textField.text=NSLocalizedString(@"8000000.000000 USDT", nil);
            self.textField.textColor=MainThemeColor;
            self.textField.font=[UIFont systemFontOfSize:FIT(18)];

            self.textField.userInteractionEnabled=NO;
        }else if (indexPath.row == 1) {
            [self.unitLab setHidden:NO];
            self.titleLab.text=NSLocalizedString(@"交易数量", nil);
            self.textField.placeholder=NSLocalizedString(@"请输入您的交易数量", nil);
        }else if(indexPath.row == 2) {
            [self.unitLab setHidden:NO];
            [self.promptLab setHidden:NO];
            self.titleLab.text=NSLocalizedString(@"交易金额", nil);
            self.textField.placeholder=NSLocalizedString(@"请输入您的交易金额", nil);
        }else if(indexPath.row == 3) {
            self.titleLab.text=NSLocalizedString(@"交易密码", nil);
            self.textField.placeholder=NSLocalizedString(@"请输入您的交易密码", nil);
            self.textField.secureTextEntry = YES;
        }
    }else{
        
        if (indexPath.row == 0) {
            self.titleLab.text=NSLocalizedString(@"剩余可买入数量", nil);
            self.textField.text=NSLocalizedString(@"8000000.000000 USDT", nil);
            self.textField.userInteractionEnabled=NO;
            self.textField.textColor=MainThemeColor;
            self.textField.font=[UIFont systemFontOfSize:FIT(18)];
        }else if (indexPath.row == 1) {
            [self.unitLab setHidden:NO];
            self.titleLab.text=NSLocalizedString(@"交易数量", nil);
            self.textField.placeholder=NSLocalizedString(@"请输入您的交易数量", nil);
        }else if(indexPath.row == 2) {
            [self.unitLab setHidden:NO];
            [self.promptLab setHidden:NO];
            self.titleLab.text=NSLocalizedString(@"交易金额", nil);
            self.textField.placeholder=NSLocalizedString(@"请输入您的交易金额", nil);
        }
    }

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
