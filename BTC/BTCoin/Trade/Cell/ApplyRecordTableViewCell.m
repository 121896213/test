//
//  ApplyRecordTableViewCell.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "ApplyRecordTableViewCell.h"

@interface ApplyRecordTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *coinTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *volLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastDayLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCoinButton;
@property (weak, nonatomic) IBOutlet UILabel *recordTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *getOrLoseLabel;

@end

@implementation ApplyRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
//    _addCoinButton.layer.cornerRadius = 5.0f;
    [_addCoinButton setGradientBackGround];
}

-(void)setCellWithModel:(ApplyDataModel *)model
{
    _addCoinButton.hidden = (model.beginStatus == 1 ? NO : YES);
//    _coinTypeLabel.text = [NSString stringWithFormat:@"%@/%@",model.fvirtualcointypeName2,model.fvirtualcointypeName1];
    NSDictionary * dict = @{NSForegroundColorAttributeName:MainThemeColor,NSFontAttributeName:kFontSize(14)};
    NSDictionary * dict2 = @{NSForegroundColorAttributeName:MainThemeColor,NSFontAttributeName:kFontSize(10)};
    NSMutableAttributedString * mAttString = [[NSMutableAttributedString alloc]init];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:model.fvirtualcointypeName2 attributes:dict]];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:FormatString(@"/%@",model.fvirtualcointypeName1) attributes:dict2]];
    _coinTypeLabel.attributedText = mAttString;
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[model.createTime integerValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _timeLabel.text = [formatter stringFromDate: date];

//    _timeLabel.text = model.createTime;
    _recordTypeLabel.text = model.direction;
    _priceLabel.text = FormatString(@"%@ %@/%@", model.dealPrice ,model.fvirtualcointypeName1,model.fvirtualcointypeName2);
    _volLabel.text = FormatString(@"%@ %@", model.dealCount ,model.fvirtualcointypeName2);
    _feeLabel.text = FormatString(@"%@ %@", model.fees,model.fvirtualcointypeName2);
    _moneyLabel.text = FormatString(@"%@ %@", model.grantRate,model.fvirtualcointypeName2);
    _lastDayLabel.text = [NSString stringWithFormat:@"%@ %@",model.dateDifferDay ,NSLocalizedString(@"天", nil)];
    _getOrLoseLabel.text = FormatString(@"%@ %@", model.profitLoss,model.fvirtualcointypeName1);
}
- (IBAction)addCoinButtonClick:(id)sender {
    if (self.addStoreBlock) {
        self.addStoreBlock();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
