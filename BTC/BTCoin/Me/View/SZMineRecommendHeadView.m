//
//  SZMineRecommendHeadView.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZMineRecommendHeadView.h"

@interface SZMineRecommendHeadView ()
@property(nonatomic, strong)UILabel* directCountLab;
@property(nonatomic, strong)UILabel* indirectCountLab;


@end


@implementation SZMineRecommendHeadView

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
    
    
    UIImageView* directImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"recommend_direct"]];
    [directImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:directImageView];
    [directImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(41));
        make.height.mas_equalTo(FIT3(75));
        make.width.mas_equalTo(FIT3(150));
        make.left.mas_equalTo(FIT3(170));
    }];
    
    UILabel* directLab=[UILabel new];
    directLab.text=NSLocalizedString(@"我的推荐", nil);
    directLab.font=[UIFont boldSystemFontOfSize:FIT3(36)];
    [self addSubview:directLab];
    [directLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(directImageView.mas_bottom).offset(FIT3(14));
        make.height.mas_equalTo(FIT3(36));
        make.width.mas_equalTo(FIT3(150));
        make.left.mas_equalTo(FIT3(170));
    }];
    
    UILabel* directCountLab=[UILabel new];
    directCountLab.text=@"5";
    directCountLab.font=[UIFont systemFontOfSize:24.0f];
    directCountLab.textColor=UIColorFromRGB(0x688DE8);
    [self addSubview:directCountLab];
    self.directCountLab=directCountLab;
    [directCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(FIT3(72));
        make.width.mas_equalTo(FIT3(150));
        make.left.equalTo(directLab.mas_right).offset(FIT3(76));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    
    UIImageView* indirectImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"recommend_indirect"]];
    [indirectImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:indirectImageView];
    [indirectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(directImageView.mas_top);
        make.height.mas_equalTo(FIT3(75));
        make.width.mas_equalTo(FIT3(150));
        make.left.mas_equalTo(ScreenWidth/2+FIT3(170));
    }];
    
    UILabel* indirectLab=[UILabel new];
    indirectLab.text=NSLocalizedString(@"间接推荐", nil);
    indirectLab.font=[UIFont boldSystemFontOfSize:FIT3(36)];
    [self addSubview:indirectLab];
    [indirectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indirectImageView.mas_bottom).offset(FIT3(14));
        make.height.mas_equalTo(FIT3(36));
        make.width.mas_equalTo(FIT3(150));
        make.left.mas_equalTo(indirectImageView.mas_left);
    }];
    
    UILabel* indirectCountLab=[UILabel new];
    indirectCountLab.text=@"5";
    indirectCountLab.font=[UIFont systemFontOfSize:24.0f];
    indirectCountLab.textColor=UIColorFromRGB(0xFFC56A);
    [self addSubview:indirectCountLab];
    self.indirectCountLab=indirectCountLab;
    [indirectCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(FIT3(72));
        make.width.mas_equalTo(FIT3(150));
        make.left.equalTo(indirectLab.mas_right).offset(FIT3(76));
        make.centerY.equalTo(self.mas_centerY);
    }];
}
-(void)setListModel:(SZMineRecommendListModel *)listModel{
    
    self.directCountLab.text=FormatString(@"%ld",(long)listModel.directUserCount) ;
    self.indirectCountLab.text=FormatString(@"%ld",(long)listModel.indirectUserCount) ;
    _listModel=listModel;
}
@end
