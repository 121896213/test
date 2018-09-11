//
//  SZC2CAdListCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdListCell.h"

@interface SZC2CAdListCell()


@end
@implementation SZC2CAdListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    NSArray* titlesArr=@[@"广告编号",@"广告类型",@"最小限额",@"最大限额",@"持有数量",@"剩余数量",@"广告状态",@"币种",@"订单创建时间"];
    
    for (NSInteger i=0; i<titlesArr.count; i++) {
        
        UILabel* titleLab=[UILabel new];
        titleLab.text=titlesArr[i];
        titleLab.font=[UIFont systemFontOfSize:FIT(14)];
        titleLab.textColor=MainLabelBlackColor;
        [self addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(16));
            make.top.mas_equalTo(FIT(16)*(i+1)+titleLab.font.lineHeight*i);
            make.width.mas_equalTo(FIT(120));
            make.height.mas_equalTo(titleLab.font.lineHeight);
        }];
        
        
        UILabel* contentLab=[UILabel new];
        contentLab.text=titlesArr[i];
        contentLab.textAlignment=NSTextAlignmentRight;
        contentLab.font=[UIFont systemFontOfSize:FIT(14)];
        contentLab.textColor=(i==5)?MainC2CBlueColor:MainLabelGrayColor;
        [self addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-16));
            make.top.equalTo(titleLab.mas_top);
            make.left.equalTo(titleLab.mas_right);
            make.height.mas_equalTo(contentLab.font.lineHeight);
        }];
    }
    [self addBottomLineWithMinY:FIT(317)];

    UIButton* listingBtn=[UIButton new];
    [listingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [listingBtn setBackgroundColor:MainC2CBlueColor];
    [listingBtn setTitle:NSLocalizedString(@"上架", nil) forState:UIControlStateNormal];
    listingBtn.titleLabel.font=[UIFont systemFontOfSize:FIT(16)];
    [listingBtn setCircleBorderWidth:FIT(1) bordColor:MainC2CBlueColor radius:FIT(3)];
    [self addSubview:listingBtn];
    [listingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.width.mas_equalTo(FIT(73));
        make.height.mas_equalTo(FIT(30));
        make.bottom.mas_equalTo(FIT(-9));
    }];
    
    
    UIButton* previewBtn=[UIButton new];
    [previewBtn setTitleColor:MainC2CBlueColor forState:UIControlStateNormal];
    [previewBtn setBackgroundColor:[UIColor whiteColor]];
    [previewBtn setTitle:NSLocalizedString(@"预览", nil) forState:UIControlStateNormal];
    previewBtn.titleLabel.font=[UIFont systemFontOfSize:FIT(16)];
    [self addSubview:previewBtn];
    [previewBtn setCircleBorderWidth:FIT(1) bordColor:previewBtn.titleLabel.textColor radius:FIT(3)];
    [previewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(listingBtn.mas_left).offset(FIT(-20));
        make.width.mas_equalTo(FIT(73));
        make.height.mas_equalTo(FIT(30));
        make.bottom.mas_equalTo(FIT(-9));
    }];


}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
