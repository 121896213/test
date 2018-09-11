//
//  SZMineRecommendCell.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZMineRecommendCell.h"
@interface SZMineRecommendCell()

@property (nonatomic,strong)UILabel* registerTimeValueLab;
@property (nonatomic,strong)UILabel* beRecommendValueLab;
@property (nonatomic,strong)UILabel* isRealNameValueLab;
@property (nonatomic,strong)UILabel* recommendCountValueLab;

@end


@implementation SZMineRecommendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UILabel* registerTimeLab=[UILabel new];
    registerTimeLab.text= NSLocalizedString(@"注册时间", nil) ;
    registerTimeLab.font=[UIFont systemFontOfSize:12.0f];
    registerTimeLab.textColor=[UIColor blackColor];
    [self addSubview:registerTimeLab];
    [registerTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(FIT3(45));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(34));
        
    }];
    
    UILabel* registerTimeValueLab=[UILabel new];
    registerTimeValueLab.text=@"2017-05-06 15:25:36";
    registerTimeValueLab.textColor=UIColorFromRGB(0xACACAC);
    registerTimeValueLab.font=[UIFont systemFontOfSize:12.0f];
    registerTimeValueLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:registerTimeValueLab];
    [registerTimeValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(registerTimeLab.mas_top);
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerTimeLab.mas_bottom).offset(FIT3(18));
        make.left.equalTo(registerTimeLab.mas_left);
        make.width.mas_equalTo(ScreenWidth-FIT3(48)*2);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    
    UILabel* beRecommendLab=[UILabel new];
    beRecommendLab.text=NSLocalizedString(@"被推荐人", nil);
    beRecommendLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:beRecommendLab];
    [beRecommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(registerTimeLab.mas_left);
        make.top.equalTo(lineView).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* beRecommendValueLab=[UILabel new];
    beRecommendValueLab.text=@"fanhongbin@btkrade.com";
    beRecommendValueLab.font=[UIFont systemFontOfSize:12.0f];
    beRecommendValueLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:beRecommendValueLab];
    [beRecommendValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(beRecommendLab.mas_top);
        make.width.mas_equalTo(FIT3(600));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* isRealNameLab=[UILabel new];
    isRealNameLab.text=NSLocalizedString(@"是否实名", nil) ;
    isRealNameLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:isRealNameLab];
    [isRealNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(beRecommendLab.mas_left);
        make.top.mas_equalTo(beRecommendLab.mas_bottom).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* isRealNameValueLab=[UILabel new];
    isRealNameValueLab.text=NSLocalizedString(@"是", nil);
    isRealNameValueLab.font=[UIFont systemFontOfSize:12.0f];
    isRealNameValueLab.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:isRealNameValueLab];
    [isRealNameValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(beRecommendValueLab.mas_right);
        make.top.mas_equalTo(isRealNameLab.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    
    
    UILabel* recommendCountLabel=[UILabel new];
    recommendCountLabel.text=NSLocalizedString(@"推荐人数", nil) ;
    recommendCountLabel.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:recommendCountLabel];
    [recommendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(beRecommendLab.mas_left);
        make.top.mas_equalTo(isRealNameValueLab.mas_bottom).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* recommendCountValueLabel=[UILabel new];
    recommendCountValueLabel.text=NSLocalizedString(@"5", nil);
    recommendCountValueLabel.font=[UIFont systemFontOfSize:12.0f];
    recommendCountValueLabel.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:recommendCountValueLabel];
    [recommendCountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(beRecommendValueLab.mas_right);
        make.top.mas_equalTo(recommendCountLabel.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    self.registerTimeValueLab=registerTimeValueLab;
    self.beRecommendValueLab=beRecommendValueLab;
    self.isRealNameValueLab=isRealNameValueLab;
    self.recommendCountValueLab=recommendCountValueLabel;
    
}


-(void)setViewModel:(SZMineRecommendCellViewModel *)viewModel{
    
    self.registerTimeValueLab.text=[AppUtil datetimeStrFormatter:FormatString(@"%ld",[viewModel.model.recommendTime integerValue]/1000)   formatter:@"yyyy-MM-dd HH:mm:ss"];
    self.beRecommendValueLab.text=viewModel.model.account;
    self.isRealNameValueLab.text=viewModel.model.isValid;
    self.recommendCountValueLab.text=FormatString(@"%ld",(long)viewModel.model.recommendCount) ;
    _viewModel=viewModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
