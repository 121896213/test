//
//  SZPromotionRecordCell.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPromotionRecordCell.h"


@interface SZPromotionRecordCell()
@property (nonatomic,strong)UILabel* timeValueLab;
@property (nonatomic,strong)UILabel* berewardValueLab;
@property (nonatomic,strong)UILabel* tradeCoinTypeValueLab;
@property (nonatomic,strong)UILabel* rewardCountValueLab;
@end

@implementation SZPromotionRecordCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UILabel* timeLab=[UILabel new];
    timeLab.text= NSLocalizedString(@"时间", nil) ;
    timeLab.font=[UIFont systemFontOfSize:12.0f];
    timeLab.textColor=UIColorFromRGB(0xACACAC);
    [self addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(FIT3(45));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(34));
        
    }];
    
    UILabel* timeValueLab=[UILabel new];
    timeValueLab.text=@"2017-05-06 15:25:36";
    timeValueLab.textColor=UIColorFromRGB(0xACACAC);
    timeValueLab.font=[UIFont systemFontOfSize:12.0f];
    timeValueLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:timeValueLab];
    [timeValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(timeLab.mas_top);
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLab.mas_bottom).offset(FIT3(18));
        make.left.equalTo(timeLab.mas_left);
        make.width.mas_equalTo(ScreenWidth-FIT3(48)*2);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    
    UILabel* berewardLab=[UILabel new];
    berewardLab.text=NSLocalizedString(@"被推荐人", nil);
    berewardLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:berewardLab];
    [berewardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLab.mas_left);
        make.top.equalTo(lineView).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* berewardValueLab=[UILabel new];
    berewardValueLab.text=@"fanhongbin@btkrade.com";
    berewardValueLab.font=[UIFont systemFontOfSize:12.0f];
    berewardValueLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:berewardValueLab];
    [berewardValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(berewardLab.mas_top);
        make.width.mas_equalTo(FIT3(600));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* tradeCoinTypeLab=[UILabel new];
    tradeCoinTypeLab.text=NSLocalizedString(@"交易币种", nil) ;
    tradeCoinTypeLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeCoinTypeLab];
    [tradeCoinTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(berewardLab.mas_left);
        make.top.mas_equalTo(berewardLab.mas_bottom).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* tradeCoinTypeValueLab=[UILabel new];
    tradeCoinTypeValueLab.text=@"BTC";
    tradeCoinTypeValueLab.font=[UIFont systemFontOfSize:12.0f];
    tradeCoinTypeValueLab.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:tradeCoinTypeValueLab];
    [tradeCoinTypeValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(berewardValueLab.mas_right);
        make.top.mas_equalTo(tradeCoinTypeLab.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    
    
    UILabel* rewardCountLabel=[UILabel new];
    rewardCountLabel.text=NSLocalizedString(@"奖励", nil) ;
    rewardCountLabel.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:rewardCountLabel];
    [rewardCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(berewardLab.mas_left);
        make.top.mas_equalTo(tradeCoinTypeValueLab.mas_bottom).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* rewardCountValueLabel=[UILabel new];
    rewardCountValueLabel.text=@"2.00000010";
    rewardCountValueLabel.font=[UIFont systemFontOfSize:12.0f];
    rewardCountValueLabel.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:rewardCountValueLabel];
    [rewardCountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(berewardValueLab.mas_right);
        make.top.mas_equalTo(rewardCountLabel.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    self.timeValueLab=timeValueLab;
    self.berewardValueLab=berewardValueLab;
    self.tradeCoinTypeValueLab=tradeCoinTypeValueLab;
    self.rewardCountValueLab=rewardCountValueLabel;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setViewModel:(SZPromotionRecordCellViewModel *)viewModel{
    self.timeValueLab.text=[AppUtil datetimeStrFormatter:FormatString(@"%ld",[viewModel.model.orderDealTime integerValue]/1000)   formatter:@"yyyy-MM-dd HH:mm:ss"];
    self.berewardValueLab.text=viewModel.model.userRealName;
    self.tradeCoinTypeValueLab.text=viewModel.model.virtualCurrency;
    self.rewardCountValueLab.text=viewModel.model.grantRewardAmount;

}
@end
