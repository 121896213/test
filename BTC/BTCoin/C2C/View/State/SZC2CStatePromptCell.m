//
//  SZC2CStatePromptCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStatePromptCell.h"

@implementation SZC2CStatePromptCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=MainC2CBackgroundColor;
        
    }
    return self;
}


-(void)setSubView{
    UIView* promptView=[UIView new];
    promptView.backgroundColor=UIColorFromRGB(0xF2F4F9);
    [self addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(10));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(184));
    }];
    
    UILabel* promptLab=[UILabel new];
    promptLab.text=NSLocalizedString(@"交易提醒\n1、您的汇款将直接进入卖家账户，交易过程中卖方出售的数字资产由平台托管保护。\n2、请在规定时间内完成付款，并务必点击我已付款，卖方确认收款后，系统会将数字资产划转到您的账户。\n3、买方当日连接3笔或累计6笔取消，广告方当日取消率超过30%，会限制当天的买入功能。\n", nil) ;
    promptLab.font=[UIFont systemFontOfSize:FIT(12.0)];
    promptLab.textColor=MainLabelGrayColor;
    promptLab.numberOfLines=0;
    [promptView addSubview:promptLab];
    [promptLab setLabelParagraphStyle];
    CGFloat height=[promptLab getLabelParagraphStyleHeightWithWidth:ScreenWidth-FIT(32)]+promptLab.font.lineHeight;
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(height);
        
    }];
    NSLog(@"height:%lf",height);

}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
