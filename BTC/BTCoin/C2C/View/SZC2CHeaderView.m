//
//  SZC2CHeaderView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/23.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CHeaderView.h"
@interface SZC2CHeaderView()


@end
@implementation SZC2CHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}



-(void)setSubView{
    
    UIButton* selectTypeBtn=[UIButton new];
    [selectTypeBtn setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [selectTypeBtn setTitle:NSLocalizedString(@"USDT/普通交易区", nil) forState:UIControlStateNormal];
    [selectTypeBtn setImage:[UIImage imageNamed:@"c2c_unfold"] forState:UIControlStateNormal];
    selectTypeBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(16)];
    [selectTypeBtn setImagePositionWithType:SSImagePositionTypeRight spacing:5.f];
    selectTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:selectTypeBtn];
    self.selectTypeBtn=selectTypeBtn;
    [selectTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(160));
        make.height.mas_equalTo(FIT(43));
        make.left.mas_equalTo(FIT(16));
        make.top.mas_equalTo(FIT(0));
    }];
 
    
    UIButton* filterBtn=[UIButton new];
    [filterBtn setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [filterBtn setTitle:NSLocalizedString(@"只看在线商家", nil) forState:UIControlStateNormal];
    [filterBtn setImage:[UIImage imageNamed:@"c2c_radio_select"] forState:UIControlStateNormal];
    [filterBtn setImage:[UIImage imageNamed:@"c2c_radio_normal"] forState:UIControlStateSelected];

    filterBtn.titleLabel.font = [UIFont systemFontOfSize:FIT(14)];
    [filterBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:5.f];
    filterBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:filterBtn];
    self.filterBtn=filterBtn;
    [filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(150));
        make.height.mas_equalTo(FIT(43));
        make.right.mas_equalTo(FIT(-16));
        make.top.mas_equalTo(FIT(0));
    }];
    
    
    
    
}


@end
