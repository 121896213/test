//
//  PersonPromptCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "PersonPromptCell.h"
@interface PersonPromptCell()
@property (nonatomic,strong) UIButton* promptBtn;
@property (nonatomic,strong) UIButton* rightBtn;

@end;
@implementation PersonPromptCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UIButton* promptBtn=[UIButton new];
    [promptBtn setImage:[UIImage imageNamed:@"cell_right_icon"] forState:UIControlStateNormal];
    [self.contentView addSubview:promptBtn];
    [promptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.mas_equalTo((PersonPromptCellHeight-FIT(20))/2);
        make.height.mas_equalTo(FIT(20));
        make.width.mas_equalTo(FIT(20));
        
    }];
    self.promptBtn=promptBtn;
    
    
    UIButton* rightBtn=[UIButton new];
    [rightBtn setImage:[UIImage imageNamed:@"cell_right_icon"] forState:UIControlStateNormal];
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.top.mas_equalTo((PersonPromptCellHeight-FIT(20))/2);
        make.height.mas_equalTo(FIT(20));
        make.width.mas_equalTo(FIT(20));
        
    }];
    self.rightBtn=rightBtn;
    
 
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
