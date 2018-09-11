//
//  SZAddressDetailCell.m
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZAddressDetailCell.h"

@implementation SZAddressDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews
{
    self.imageView.image=[UIImage imageNamed:@"address_icon"];
    self.textLabel.text=@"BTC-Address1";
    self.textLabel.font=[UIFont systemFontOfSize:14.0f];
    
    self.detailTextLabel.text=@"agjasjfajfljxceojfkszvlzxjvxzcjvlxcjlvjcxlvjxljvljvljvl";
    self.detailTextLabel.font=[UIFont systemFontOfSize:12.0f];
    self.detailTextLabel.textColor=UIColorFromRGB(0xacacac);
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT3(-1.5));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(1.5));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setViewModel:(SZAddressDetailCellViewModel *)viewModel
{
    self.textLabel.text=viewModel.model.fremark;
    self.detailTextLabel.text=viewModel.model.fadderess ;
    _viewModel=viewModel;
    
}
@end
