//
//  SZUserHeaderCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZUserHeaderCell.h"
@interface SZUserHeaderCell()

@end;
@implementation SZUserHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UILabel* titleLabel=[UILabel new];
    titleLabel.text= NSLocalizedString(@"头像", nil) ;
    titleLabel.font=[UIFont systemFontOfSize:FIT(16)];
    titleLabel.textColor=MainLabelBlackColor;
    [self addSubview:titleLabel];
    self.titleLabel=titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(FIT(200));
        make.height.mas_equalTo(titleLabel.font.lineHeight);
        
    }];
    
    
    UIButton* rightBtn=[UIButton new];
    [rightBtn setImage:[UIImage imageNamed:@"cell_right_icon"] forState:UIControlStateNormal];
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.top.mas_equalTo((SZUserHeaderCellHeight-FIT(20))/2);
        make.height.mas_equalTo(FIT(20));
        make.width.mas_equalTo(FIT(20));
        
    }];
    self.rightBtn=rightBtn;
    
    UIImageView* headerImageView=[UIImageView new];
    [headerImageView setImage:[UIImage imageNamed:@"c2c_header_default"]];
    headerImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:headerImageView];
    self.headerImageView=headerImageView;
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(53));
        make.height.mas_equalTo(FIT(53));
        make.right.equalTo(rightBtn.mas_left).offset(FIT(0));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
