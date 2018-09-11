//
//  SZBbPropertyCell.m
//  BTCoin
//
//  Created by Shizi on 2018/5/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBbPropertyCell.h"
@interface SZBbPropertyCell ()
@property (nonatomic,strong) UILabel* propertyTypeLabel;
@property (nonatomic,strong) UILabel* ableAcountLabel;
@property (nonatomic,strong) UILabel* unableAcountLabel;

@property (nonatomic,strong)UILabel* ableLabel;
@property (nonatomic,strong)UILabel* unableLabel;
@end


@implementation SZBbPropertyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews
{
    UILabel* propertyTypeLabel=[[UILabel alloc]init];
    [propertyTypeLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [propertyTypeLabel setTextColor:UIColorFromRGB(0x333333)];
    [propertyTypeLabel setText:@"ABT"];
    [self addSubview:propertyTypeLabel];
    [propertyTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);;
        make.left.mas_equalTo(FIT2(30));
        make.width.mas_equalTo(FIT2(100));
        make.height.mas_equalTo(SZBbPropertyCellHeight);
    }];
    self.propertyTypeLabel=propertyTypeLabel;
    
    UILabel* ableAcountLabel=[[UILabel alloc]init];
    [ableAcountLabel setFont:[UIFont boldSystemFontOfSize:FIT2(28)]];
    [ableAcountLabel setTextColor:UIColorFromRGB(0x333333)];
    [ableAcountLabel setText:@"0.0000000"];
    [self addSubview:ableAcountLabel];
    [ableAcountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT2(25));;
        make.left.equalTo(propertyTypeLabel.mas_right).offset(FIT2(30));
        make.width.mas_equalTo(FIT2(257));
        make.height.mas_equalTo(FIT2(28));
    }];
    self.ableAcountLabel=ableAcountLabel;
    
    UILabel* ableLabel=[[UILabel alloc]init];
    [ableLabel setFont:[UIFont boldSystemFontOfSize:9]];
    [ableLabel setTextColor:UIColorFromRGB(0x999999)];
    [ableLabel setText:NSLocalizedString(@"可用", nil)];
    [self addSubview:ableLabel];
    self.ableLabel=ableLabel;
    [ableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ableAcountLabel.mas_bottom).offset(FIT3(42));;
        make.left.equalTo(propertyTypeLabel.mas_right).offset(FIT2(30));
        make.width.mas_equalTo(FIT2(257));
        make.height.mas_equalTo(FIT2(18));
    }];

    UILabel* unableAcountLabel=[[UILabel alloc]init];
    [unableAcountLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [unableAcountLabel setTextColor:UIColorFromRGB(0x333333)];
    [unableAcountLabel setText:@"0.0000000"];
    [self addSubview:unableAcountLabel];
    self.unableAcountLabel=unableAcountLabel;
    [unableAcountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT2(25));;
        make.left.equalTo(ableLabel.mas_right).offset(FIT2(30));
        make.width.mas_equalTo(FIT2(257));
        make.height.mas_equalTo(FIT2(28));
    }];
    
    UILabel* unableLabel=[[UILabel alloc]init];
    [unableLabel setFont:[UIFont boldSystemFontOfSize:9]];
    [unableLabel setTextColor:UIColorFromRGB(0x999999)];
    [unableLabel setText:NSLocalizedString(@"冻结", nil)];
    self.unableLabel=unableLabel;
    [self addSubview:unableLabel];
    [unableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(unableAcountLabel.mas_bottom).offset(FIT3(42));;
        make.left.equalTo(ableLabel.mas_right).offset(FIT2(30));
        make.width.mas_equalTo(FIT2(257));
        make.height.mas_equalTo(FIT2(18));
    }];
    
 
    UIImageView* detailImageView=[UIImageView new];
    [detailImageView setImage:[UIImage imageNamed:@"property_detail_icon"]];
    detailImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:detailImageView];
    
    [detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-FIT(15));
        make.height.width.mas_equalTo(FIT3(45));
        make.top.mas_equalTo(FIT3(77.5));
    }];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setViewModel:(SZPropertyCellViewModel *)viewModel{
    if (viewModel.c2cPropertyModel) {
        self.propertyTypeLabel.text=viewModel.c2cPropertyModel.fvirtualcointypeName;
        self.ableAcountLabel.text=viewModel.c2cPropertyModel.ftotal;
        self.unableAcountLabel.text=viewModel.c2cPropertyModel.ffrozen;
    }
    
    if (viewModel.bbPropertyModel) {
        self.propertyTypeLabel.text=viewModel.bbPropertyModel.fvirtualcointypeName;
        self.ableAcountLabel.text=viewModel.bbPropertyModel.ftotal;
        self.unableAcountLabel.text=viewModel.bbPropertyModel.frozen;
    }
    

}
@end
