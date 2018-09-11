//
//  SZC2CStateHandelCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStateHandelCell.h"

@interface SZC2CStateHandelCell()
@property (nonatomic,strong) UIButton* handleBtn;

@end
@implementation SZC2CStateHandelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=MainC2CBackgroundColor;
        
    }
    return self;
}


-(void)setSubView{
    
    UIButton* handleBtn=[UIButton new];
    [handleBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(14.0)]];
    [handleBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [handleBtn setTitle:NSLocalizedString(@"提醒买家付款", nil) forState:UIControlStateNormal];
    [handleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:handleBtn];
    [handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(10));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(50));
    }];
//    [handleBtn setGradientBackGround];
    self.handleBtn=handleBtn;
    
}

-(void)setHandleBtnTitle:(NSString*)title{
    
    if ([title containsString:NSLocalizedString(@"提醒买家付款", nil)] || [title containsString:NSLocalizedString(@"确认收款", nil)] || [title containsString:NSLocalizedString(@"提交", nil)] || [title containsString:NSLocalizedString(@"提醒卖家", nil)]  ||  [title containsString:NSLocalizedString(@"确认付款", nil)]) {
        [self.handleBtn setTitle:title forState:UIControlStateNormal];
        [self.handleBtn setBackgroundImage:[UIImage imageWithColor:MainThemeBlueColor] forState:UIControlStateNormal];
        [self.handleBtn setBackgroundImage:[UIImage imageWithColor:MainThemeHighlightColor] forState:UIControlStateHighlighted];
        self.handleBtn.userInteractionEnabled=YES;
        [self.handleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.handleBtn setCircleBorderWidth:FIT(1) bordColor:MainThemeBlueColor radius:FIT(3)];

    }else if ([title containsString:NSLocalizedString(@"买家正在付款中", nil)] || [title containsString:NSLocalizedString(@"已完成", nil)]|| [title containsString:NSLocalizedString(@"已取消", nil)]|| [title containsString:NSLocalizedString(@"卖家正在发布中", nil)] || [title containsString:NSLocalizedString(@"申诉中", nil)] || [title containsString:NSLocalizedString(@"申诉成功", nil)]){
        
        [self.handleBtn setTitle:title forState:UIControlStateNormal];
        [self.handleBtn setBackgroundImage:[UIImage imageWithColor:MainLabelGrayColor] forState:UIControlStateNormal];
        self.handleBtn.userInteractionEnabled=NO;
        [self.handleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.handleBtn setCircleBorderWidth:FIT(1) bordColor:MainLabelGrayColor radius:FIT(3)];

    }else if ([title containsString:NSLocalizedString(@"取消交易", nil)] || [title containsString:NSLocalizedString(@"我要申诉", nil)]){
        [self.handleBtn setTitle:title forState:UIControlStateNormal];
        [self.handleBtn setTitleColor:MainC2CBlueColor forState:UIControlStateNormal];

        [self.handleBtn setBackgroundImage:[UIImage imageWithColor:MainC2CBackgroundColor] forState:UIControlStateNormal];
        self.handleBtn.userInteractionEnabled=NO;
        
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
