//
//  RecordNewTableViewCell.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "RecordNewTableViewCell.h"

@interface RecordNewTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;//币/区
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;//方向
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;//数量
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;//金额
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;//手续费

@end

@implementation RecordNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellWithModel:(RecordDataModel *)model
{
    NSDictionary * dict = @{NSForegroundColorAttributeName:MainThemeColor,NSFontAttributeName:kFontSize(14)};
    NSDictionary * dict2 = @{NSForegroundColorAttributeName:MainThemeColor,NSFontAttributeName:kFontSize(10)};
    NSMutableAttributedString * mAttString = [[NSMutableAttributedString alloc]init];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:model.currencyName attributes:dict]];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:FormatString(@"/%@",model.fUnit) attributes:dict2]];
    _coinNameLabel.attributedText = mAttString;

    _timeLabel.text = model.fCreateTime;
    _directionLabel.text = NSLocalizedString(model.fType,nil);
    _priceLabel.text = FormatString(@"%@ %@/%@", model.fPrice,model.fUnit,model.currencyName);
    _numberLabel.text = FormatString(@"%@ %@",model.fCount,model.currencyName);
    _amountLabel.text = FormatString(@"%@ %@",model.fAmount,model.fUnit);
    
    if ([model.fType isEqualToString:@"买入"]) {
        _feeLabel.text = FormatString(@"%@ %@",model.fFees,model.currencyName);
    }else{
        _feeLabel.text = FormatString(@"%@ %@",model.fFees,model.fUnit);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
