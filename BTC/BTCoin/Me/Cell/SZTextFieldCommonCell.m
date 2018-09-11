//
//  SZTextFieldCommonCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZTextFieldCommonCell.h"

@implementation SZTextFieldCommonCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, FIT(100), SZTextFieldCommonCellHeight)];
    titleLabel.text= NSLocalizedString(@"持卡人:", nil) ;
    titleLabel.font=[UIFont systemFontOfSize:FIT(16)];
    titleLabel.textColor=MainLabelBlackColor;
    self.titleLab=titleLabel;
    

    UIButton* rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, FIT(12), FIT(12))];
    [rightBtn setImage:[UIImage imageNamed:@"meCenterArrowDown"] forState:UIControlStateNormal];
    [rightBtn setHidden:YES];
    self.rightBtn=rightBtn;
    

    UITextField* textField=[UITextField new];
    self.textField=textField;
    textField.placeholder=@"请输入银行卡号";
    textField.font=[UIFont systemFontOfSize:FIT(16)];
    textField.textColor=MainLabelBlackColor;
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.rightViewMode=UITextFieldViewModeAlways;

    textField.leftView=titleLabel;
    textField.rightView=rightBtn;
    textField.textAlignment=NSTextAlignmentLeft;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));

    }];
    

    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
