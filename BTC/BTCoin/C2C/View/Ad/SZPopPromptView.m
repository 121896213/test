//
//  SZPopPromptView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/23.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPopPromptView.h"
@interface SZPopPromptView()
@property (nonatomic,strong) UIButton* cancelBtn;


@end
@implementation SZPopPromptView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self setSubView];
        [self addActions];
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    
    return self;
}

-(void)setSubView{
    
    UILabel* titleLab=[UILabel new];
    titleLab.text=NSLocalizedString(@"标题", nil);
    titleLab.font=[UIFont systemFontOfSize:FIT(18)];
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:titleLab];
    self.contentView.backgroundColor=[UIColor whiteColor];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(50));
    }];
    
    UILabel* contentLab=[UILabel new];
    contentLab.text=NSLocalizedString(@"提示内容", nil);
    contentLab.font=[UIFont systemFontOfSize:FIT(18)];
    contentLab.backgroundColor=[UIColor whiteColor];
    contentLab.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:contentLab];
    self.contentView.backgroundColor=[UIColor whiteColor];
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));
        make.top.equalTo(titleLab.mas_bottom).offset(FIT(16));
        make.height.mas_equalTo(FIT(50));
    }];
    
    
    UIButton* confirmBtn=[UIButton new];
    [confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(18)]];
    [confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [confirmBtn setTitle:NSLocalizedString(@"我知道了", nil) forState:UIControlStateNormal];
    [confirmBtn setTitleColor:UIColorFromRGB(0x6790F9) forState:UIControlStateNormal];
    [self.contentView addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(0));
        make.top.equalTo(contentLab.mas_bottom).offset(FIT(25));
        make.height.mas_equalTo(FIT(50));
        make.width.mas_equalTo(ScreenWidth);
        
    }];
    self.cancelBtn=confirmBtn;
    
}
-(void)addActions{
    
    @weakify(self);
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [self disMissView];
    }];
    
}
-(void)disMissView{
    [super disMissView];
    [self removeFromSuperview];
    
}
@end
