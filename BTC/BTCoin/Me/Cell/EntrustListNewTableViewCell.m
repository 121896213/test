//
//  EntrustListNewTableViewCell.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "EntrustListNewTableViewCell.h"

@interface EntrustListNewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *entrustPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *entrustNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *sucNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderButton;

@end

@implementation EntrustListNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _topViewTopConstraint.constant = 0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _cancelOrderButton.titleLabel.adjustsFontSizeToFitWidth = YES;
}
- (IBAction)cancelOrderButtonClick:(id)sender {
    if (_cancel) {
        self.cancel();
    }
}

- (IBAction)hideTopViewAction:(id)sender {
    _topView.hidden = YES;
}

-(void)setCellWithModel:(TradeDataModel *)model isOpen:(BOOL)isOpen{
    _topView.hidden = !isOpen;
    
//    _coinNameLabel.text = FormatString(@"%@/%@",model.fvirtualcoin2,model.fvirtualcoin1);
    NSDictionary * dict = @{NSForegroundColorAttributeName:MainThemeColor,NSFontAttributeName:kFontSize(14)};
    NSDictionary * dict2 = @{NSForegroundColorAttributeName:MainThemeColor,NSFontAttributeName:kFontSize(10)};
    NSMutableAttributedString * mAttString = [[NSMutableAttributedString alloc]init];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:model.fvirtualcoin2 attributes:dict]];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:FormatString(@"/%@",model.fvirtualcoin1) attributes:dict2]];
    _coinNameLabel.attributedText = mAttString;
    
    if (model.fisLimit) {
        _entrustPriceLabel.text = NSLocalizedString(@"市价交易", nil);
    }else{
        _entrustPriceLabel.text = model.fprize;
    }
    _entrustNumLabel.text = model.fcount;
    _typeLabel.text = NSLocalizedString((model.fentrustType == TradeVCTypeBuy ? @"买入":@"卖出"),nil);
    
    NSTimeInterval interval    =[model.fcreateTime integerValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _timeLabel.text = [formatter stringFromDate: date];
    
    _avgPriceLabel.text = model.fAvgPrize;
    _sucNumLabel.text = model.fsuccessCount;
    _stateLabel.text = model.statusString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
