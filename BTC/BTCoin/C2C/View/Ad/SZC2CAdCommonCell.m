//
//  SZC2CAdCommonCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdCommonCell.h"

@interface SZC2CAdCommonCell()
@property (nonatomic, strong) UILabel*  titleLab;
@property (nonatomic, strong) UITextField*  textField;
@property (nonatomic, strong) UIImageView*  arrowImageView;
@end

@implementation SZC2CAdCommonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setSubView{
    
    UILabel*  titleLab=[UILabel new];
    titleLab.text=NSLocalizedString(@"最大交易额", nil);
    titleLab.textColor=MainLabelBlackColor;
    titleLab.font=[UIFont systemFontOfSize:FIT(14.0f)];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(78));
        make.height.mas_equalTo(SZC2CAdCommonCellHeight);
        make.left.mas_equalTo(FIT(16));
        make.top.mas_equalTo(0);
    }];
    
    UITextField*  textField=[UITextField new];
    textField.placeholder=NSLocalizedString(@"请输入单笔交易最小限额", nil);
    textField.font=[UIFont systemFontOfSize:FIT(14)];
    self.textField=textField;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLab.mas_right);
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(SZC2CAdCommonCellHeight);
        make.top.mas_equalTo(0);

    }];
    
    UIView* lineView=[UIView new];
    lineView.backgroundColor=LineColor;
    [textField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-0.5);
        make.height.mas_equalTo(0.5);

    }];
    
    UIImageView*  arrowImageView= [UIImageView new];
    arrowImageView.image=[UIImage imageNamed:@"c2c_show"];
    [arrowImageView setHidden:YES];
    [textField addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.equalTo(textField.mas_centerY);
        make.width.mas_equalTo(FIT(13));
        make.height.mas_equalTo(FIT(9));
    }];
    
    self.titleLab=titleLab;
    self.textField=textField;
    self.arrowImageView=arrowImageView;
}

- (void)setCellModel:(SZAdCellModel *)cellModel{
    _cellModel=cellModel;
    self.titleLab.text=cellModel.title;
    self.textField.placeholder=cellModel.placeholder;
    if (!isEmptyString(cellModel.content) ) {
        self.textField.text=cellModel.content;
    }
    self.arrowImageView.hidden=cellModel.isRightBtnHidden;
    self.textField.userInteractionEnabled=cellModel.isTextFieldEnable;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
