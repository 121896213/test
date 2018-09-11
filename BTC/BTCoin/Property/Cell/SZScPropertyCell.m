//
//  SZScPropertyCell.m
//  BTCoin
//
//  Created by sumrain on 2018/6/29.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZScPropertyCell.h"
@interface SZScPropertyCell ()
@property (nonatomic,strong) UILabel* propertyTypeLab;
@property (nonatomic,strong) UILabel* lockAcountLab;
@property (nonatomic,strong) UILabel* lockAcountValueLab;

@property (nonatomic,strong)UILabel* feeLab;
@property (nonatomic,strong)UILabel* feeValueLab;


@property (nonatomic,strong)UILabel* gainLab;
@property (nonatomic,strong)UILabel* gainValueLab;
@end
@implementation SZScPropertyCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews
{
    UILabel* propertyTypeLab=[[UILabel alloc]init];
    [propertyTypeLab setFont:[UIFont boldSystemFontOfSize:14]];
    [propertyTypeLab setTextColor:UIColorFromRGB(0x333333)];
    [propertyTypeLab setText:@"ABT"];
    [self addSubview:propertyTypeLab];
    [propertyTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(114));;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(FIT3(264));
        make.height.mas_equalTo(FIT3(38));
    }];
    self.propertyTypeLab=propertyTypeLab;
    
    UILabel* lockAcountLab=[[UILabel alloc]init];
    [lockAcountLab setFont:[UIFont systemFontOfSize:12]];
    [lockAcountLab setTextColor:UIColorFromRGB(0x000000)];
    [lockAcountLab setText:NSLocalizedString(@"锁定", nil) ];
    [self addSubview:lockAcountLab];
    [lockAcountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(50));;
        make.left.equalTo(propertyTypeLab.mas_right);
        make.width.mas_equalTo(FIT3(414));
        make.height.mas_equalTo(FIT3(36));
    }];
    self.lockAcountLab=lockAcountLab;
    
    
    
    UILabel* lockAcountValueLab=[[UILabel alloc]init];
    [lockAcountValueLab setFont:[UIFont systemFontOfSize:14]];
    [lockAcountLab setTextColor:UIColorFromRGB(0x000000)];
    [lockAcountValueLab setText:@"0.730306.030"];
    [self addSubview:lockAcountValueLab];
    self.lockAcountValueLab=lockAcountValueLab;
    [lockAcountValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lockAcountLab.mas_top);;
        make.left.equalTo(lockAcountLab.mas_right);
        make.width.mas_equalTo(FIT3(391));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    
    UILabel* feeLab=[[UILabel alloc]init];
    [feeLab setFont:[UIFont systemFontOfSize:12]];
    [feeLab setTextColor:UIColorFromRGB(0x000000)];
    [feeLab setText:NSLocalizedString(@"已发利息", nil)];
    [self addSubview:feeLab];
    self.feeLab=feeLab;
    [feeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lockAcountLab.mas_bottom).offset(FIT3(39));;
        make.left.equalTo(lockAcountLab.mas_left);
        make.width.equalTo(lockAcountLab.mas_width);
        make.height.equalTo(lockAcountLab.mas_height);
    }];
    

    
    UILabel* feeValueLab=[[UILabel alloc]init];
    [feeValueLab setFont:[UIFont systemFontOfSize:14]];
    [feeValueLab setTextColor:UIColorFromRGB(0x000000)];
    [feeValueLab setText:NSLocalizedString(@"30306.030", nil)];
    self.feeValueLab=feeValueLab;
    [self addSubview:feeValueLab];
    [feeValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feeLab.mas_top);;
        make.left.equalTo(feeLab.mas_right);
        make.width.equalTo(lockAcountValueLab.mas_width);
        make.height.equalTo(lockAcountValueLab.mas_height);
    }];
    
    
    
    UILabel* gainLab=[[UILabel alloc]init];
    [gainLab setFont:[UIFont systemFontOfSize:12]];
    [gainLab setTextColor:UIColorFromRGB(0x000000)];
    [gainLab setText:NSLocalizedString(@"盈亏", nil)];
    [self addSubview:gainLab];
    self.gainLab=gainLab;
    [gainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feeLab.mas_bottom).offset(FIT3(39));;
        make.left.equalTo(lockAcountLab.mas_left);
        make.width.equalTo(lockAcountLab.mas_width);
        make.height.equalTo(lockAcountLab.mas_height);
    }];
    
    
    
    UILabel* gainValueLab=[[UILabel alloc]init];
    [gainValueLab setFont:[UIFont systemFontOfSize:14]];
    [gainValueLab setTextColor:UIColorFromRGB(0x03C087)];
    [gainValueLab setText:NSLocalizedString(@"+30306.030", nil)];
    self.gainValueLab=gainValueLab;
    [self addSubview:gainValueLab];
    [gainValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gainLab.mas_top);;
        make.left.equalTo(gainLab.mas_right);
        make.width.mas_equalTo(lockAcountValueLab.mas_width);
        make.height.mas_equalTo(lockAcountValueLab.mas_height);
    }];
    
    
    UIImageView* detailImageView=[UIImageView new];
    [detailImageView setImage:[UIImage imageNamed:@"property_detail_icon"]];
    detailImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:detailImageView];
    
    [detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-FIT3(48));
        make.height.width.mas_equalTo(FIT3(45));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
}

- (void)setViewModel:(SZPropertyCellViewModel *)viewModel{

    self.propertyTypeLab.text=viewModel.scPropertyModel.shortName;
    self.lockAcountValueLab.text=viewModel.scPropertyModel.assets;
    self.feeValueLab.text=viewModel.scPropertyModel.sumGrantRate;
    if ([viewModel.scPropertyModel.profitLoss floatValue] > 0.0000000) {
        self.gainValueLab.text=[@"+"stringByAppendingString:viewModel.scPropertyModel.profitLoss];
        [self.gainValueLab setTextColor:UIColorFromRGB(0x03C087)];

    }else if ([viewModel.scPropertyModel.profitLoss floatValue] == 0.000000){
        self.gainValueLab.text=viewModel.scPropertyModel.profitLoss;
        [self.gainValueLab setTextColor:UIColorFromRGB(0x000000)];

    }else{
        self.gainValueLab.text=viewModel.scPropertyModel.profitLoss;
        [self.gainValueLab setTextColor:UIColorFromRGB(0xFF63333)];

    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
