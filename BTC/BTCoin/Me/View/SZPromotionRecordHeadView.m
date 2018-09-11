//
//  SZPromotionRecordHeadView.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPromotionRecordHeadView.h"
#import "SZSelectCoinTypeView.h"
@interface SZPromotionRecordHeadView ()
@property(nonatomic, strong)UILabel* totalRewardLab;


@end

@implementation SZPromotionRecordHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self setSubView];
    }
    return self;
}
-(void)setSubView{
    
    
    UIButton* selectCoinTypeBtn=[UIButton new];
    selectCoinTypeBtn.backgroundColor=UIColorFromRGB(0xFFFFFF);
    selectCoinTypeBtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [selectCoinTypeBtn setTitle:@"ALL" forState:UIControlStateNormal];
    [selectCoinTypeBtn setImage:[UIImage imageNamed:@"meCenterArrowDown"] forState:UIControlStateNormal];
    [selectCoinTypeBtn setTitleColor:UIColorFromRGB(0xACACAC) forState:UIControlStateNormal];
    [selectCoinTypeBtn setImagePositionWithType:SSImagePositionTypeRight spacing:60.f];
    [selectCoinTypeBtn setCircleBorderWidth:FIT3(3) bordColor:UIColorFromRGB(0xCCCCCCC) radius:FIT3(8.f)];
    [self addSubview:selectCoinTypeBtn];
    [selectCoinTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(47));
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(FIT3(402));
        make.height.mas_equalTo(FIT3(88));
    }];
    self.selectCoinTypeBtn=selectCoinTypeBtn;
    
    
    UILabel* totalRewardLab=[UILabel new];
    totalRewardLab.text=FormatString(@"%@0.000000",NSLocalizedString(@"共计 :  ", nil));
    totalRewardLab.textAlignment=NSTextAlignmentRight;
    [totalRewardLab setFont:[UIFont systemFontOfSize:12.0f]];
    [totalRewardLab setAttributedTextWithBeforeString:NSLocalizedString(@"共计 :  ",nil) beforeColor:totalRewardLab.textColor beforeFont:totalRewardLab.font afterString:@"0.000000" afterColor:MainThemeColor afterFont:[UIFont systemFontOfSize:16.0f]];

    [self addSubview:totalRewardLab];
    [totalRewardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-FIT3(48));
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(FIT3(600));
        make.height.mas_equalTo(FIT3(38));
    }];
    self.totalRewardLab=totalRewardLab;
    

}
-(void)setListModel:(SZPromotionRecordListModel *)listModel{
    self.totalRewardLab.text=FormatString(@"%@%@",NSLocalizedString(@"共计 :  ",nil),listModel.totalAmount);
    [self.totalRewardLab setAttributedTextWithBeforeString:NSLocalizedString(@"共计 :  ",nil) beforeColor:self.totalRewardLab.textColor beforeFont:self.totalRewardLab.font afterString:listModel.totalAmount afterColor:MainThemeColor afterFont:[UIFont systemFontOfSize:16.0f]];
    
    _listModel=listModel;
}
@end
