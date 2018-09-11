//
//  SZUserInfoCommonCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZUserInfoCommonCell.h"
@interface SZUserInfoCommonCell()

@end;

@implementation SZUserInfoCommonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UILabel* titleLabel=[UILabel new];
    titleLabel.text= NSLocalizedString(@"昵称", nil) ;
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
     [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.top.mas_equalTo((SZUserInfoCommonCellHeight-FIT(20))/2);
        make.height.mas_equalTo(FIT(20));
        make.width.mas_equalTo(FIT(20));
        
    }];
    self.rightBtn=rightBtn;
    
    UIButton* detailBtn=[UIButton new];
    [detailBtn setTitleColor:MainLabelGrayColor forState:UIControlStateNormal];
    [detailBtn setTitle:@"长得帅" forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(14)];
    detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    detailBtn.userInteractionEnabled=NO;
    [self addSubview:detailBtn];
    self.detailBtn=detailBtn;
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(200));
        make.height.mas_equalTo(FIT(25));
        make.right.equalTo(rightBtn.mas_left);
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
