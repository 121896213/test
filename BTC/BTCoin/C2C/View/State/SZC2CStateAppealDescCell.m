//
//  SZC2CStateAppealDescCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStateAppealDescCell.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>

@implementation SZC2CStateAppealDescCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=MainC2CBackgroundColor;
        
    }
    return self;
}

-(void)setSubView{
    
    UILabel*  titleLab=[UILabel new];
    titleLab.text=NSLocalizedString(@"申诉描述", nil);
    titleLab.textColor=MainLabelBlackColor;
    titleLab.font = [UIFont systemFontOfSize:FIT(16)];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(78));
        make.height.mas_equalTo(titleLab.font.lineHeight);
        make.left.mas_equalTo(FIT(0));
        make.top.mas_equalTo(FIT(11));
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.placeholder = NSLocalizedString(@"可输入申诉描述，500字符以内", nil);
    textView.placeholderColor = MainLabelGrayColor;
    textView.font=[UIFont systemFontOfSize:FIT(14)];
    [textView setCircleBorderWidth:FIT(1) bordColor:LineColor radius:FIT(3)];
    [self addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(titleLab.mas_left);
        make.top.equalTo(titleLab.mas_bottom).offset(FIT(11));
        make.right.mas_equalTo(FIT(0));
        make.height.mas_equalTo(FIT(103));
        
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
