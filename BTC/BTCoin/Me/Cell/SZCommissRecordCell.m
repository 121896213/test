//
//  SZCommissRecordCell.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZCommissRecordCell.h"
@interface SZCommissRecordCell()

@property (nonatomic,strong)UILabel* commissionTimeValueLab;
@property (nonatomic,strong)UILabel* recommendValueLab;
@property (nonatomic,strong)UILabel* isRealNameValueLab;
@property (nonatomic,strong)UILabel* rewardTypeValueLabel;
@property (nonatomic,strong)UILabel* rewardCountValueLabel;
@end

@implementation SZCommissRecordCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UILabel* commissionTimeLab=[UILabel new];
    commissionTimeLab.text= NSLocalizedString(@"返佣时间", nil) ;
    commissionTimeLab.font=[UIFont systemFontOfSize:12.0f];
    commissionTimeLab.textColor=UIColorFromRGB(0xACACAC);
    [self addSubview:commissionTimeLab];
    [commissionTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(FIT3(45));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(34));
        
    }];
    
    UILabel* commissionTimeValueLab=[UILabel new];
    commissionTimeValueLab.text=@"2017-05-06 15:25:36";
    commissionTimeValueLab.textColor=UIColorFromRGB(0xACACAC);
    commissionTimeValueLab.font=[UIFont systemFontOfSize:12.0f];
    commissionTimeValueLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:commissionTimeValueLab];
    [commissionTimeValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(commissionTimeLab.mas_top);
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commissionTimeLab.mas_bottom).offset(FIT3(18));
        make.left.equalTo(commissionTimeLab.mas_left);
        make.width.mas_equalTo(ScreenWidth-FIT3(48)*2);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    
    UILabel* recommendLab=[UILabel new];
    recommendLab.text=NSLocalizedString(@"邀请人", nil);
    recommendLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:recommendLab];
    [recommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commissionTimeLab.mas_left);
        make.top.equalTo(lineView).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* recommendValueLab=[UILabel new];
    recommendValueLab.text=@"fanhongbin@btkrade.com";
    recommendValueLab.font=[UIFont systemFontOfSize:12.0f];
    recommendValueLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:recommendValueLab];
    [recommendValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(recommendLab.mas_top);
        make.width.mas_equalTo(FIT3(600));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* isRealNameLab=[UILabel new];
    isRealNameLab.text=NSLocalizedString(@"是否实名", nil) ;
    isRealNameLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:isRealNameLab];
    [isRealNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recommendLab.mas_left);
        make.top.mas_equalTo(recommendLab.mas_bottom).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* isRealNameValueLab=[UILabel new];
    isRealNameValueLab.text=NSLocalizedString(@"是", nil);
    isRealNameValueLab.font=[UIFont systemFontOfSize:12.0f];
    isRealNameValueLab.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:isRealNameValueLab];
    [isRealNameValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(recommendValueLab.mas_right);
        make.top.mas_equalTo(isRealNameLab.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    
    
    UILabel* rewardTypeLabel=[UILabel new];
    rewardTypeLabel.text=NSLocalizedString(@"奖励类型", nil) ;
    rewardTypeLabel.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:rewardTypeLabel];
    [rewardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recommendLab.mas_left);
        make.top.mas_equalTo(isRealNameValueLab.mas_bottom).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* rewardTypeValueLabel=[UILabel new];
    rewardTypeValueLabel.text=NSLocalizedString(@"5", nil);
    rewardTypeValueLabel.font=[UIFont systemFontOfSize:12.0f];
    rewardTypeValueLabel.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:rewardTypeValueLabel];
    [rewardTypeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(recommendValueLab.mas_right);
        make.top.mas_equalTo(rewardTypeLabel.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    
    UILabel* rewardCountLabel=[UILabel new];
    rewardCountLabel.text=NSLocalizedString(@"奖励金额", nil) ;
    rewardCountLabel.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:rewardCountLabel];
    [rewardCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rewardTypeLabel.mas_left);
        make.top.mas_equalTo(rewardTypeLabel.mas_bottom).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* rewardCountValueLabel=[UILabel new];
    rewardCountValueLabel.text=NSLocalizedString(@"5", nil);
    rewardCountValueLabel.font=[UIFont systemFontOfSize:12.0f];
    rewardCountValueLabel.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:rewardCountValueLabel];
    [rewardCountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rewardTypeValueLabel.mas_right);
        make.top.mas_equalTo(rewardCountLabel.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    self.commissionTimeValueLab=commissionTimeValueLab;
    self.recommendValueLab=recommendValueLab;
    self.isRealNameValueLab=isRealNameValueLab;
    self.rewardTypeValueLabel=rewardTypeValueLabel;
    self.rewardCountValueLabel=rewardCountValueLabel;
    
}

-(void)setViewModel:(SZCommissionRecordCellViewModel *)viewModel{
    
    self.commissionTimeValueLab.text=[AppUtil datetimeStrFormatter:FormatString(@"%ld",[viewModel.model.rebateTime integerValue]/1000)   formatter:@"yyyy-MM-dd HH:mm:ss"];
    self.recommendValueLab.text=viewModel.model.account;
    self.isRealNameValueLab.text=viewModel.model.isValid;
    self.rewardTypeValueLabel.text=viewModel.model.rebateType;
    self.rewardCountValueLabel.text=viewModel.model.feesUSDT;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
@end
