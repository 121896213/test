//
//  TradeSevenTableViewCell.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/4.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "TradeSevenTableViewCell.h"

@interface TradeSevenTableViewCell()
@property (nonatomic,strong)UILabel * leftLabel;
@property (nonatomic,strong)UILabel * rightLabel;
@end

@implementation TradeSevenTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        _leftLabel = [UILabel new];
        _leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
        [self.contentView addSubview:_leftLabel];
        
        _rightLabel = [UILabel new];
        _rightLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLabel];
        _leftLabel.adjustsFontSizeToFitWidth = _rightLabel.adjustsFontSizeToFitWidth = YES;
        
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.leading.mas_equalTo(0);
        }];
    
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.trailing.mas_equalTo(0);
            make.leading.mas_equalTo(_leftLabel.mas_trailing).offset(5);
            make.width.mas_equalTo(_leftLabel.mas_width);
        }];
    }
    return self;
}

-(void)setCellType:(TradeSevenTableViewCellType)cellType{
    _cellType = cellType;
    self.contentView.backgroundColor = [UIColor clearColor];

    _rightLabel.textColor = UIColorFromRGB(0x666666);
    switch (cellType) {
        case TradeSevenTableViewCellTypeBuy:
            {
                _leftLabel.textColor = UIColorFromRGB(0x03c087);
            }
            break;
        case TradeSevenTableViewCellTypeSel:
            {
                _leftLabel.textColor = UIColorFromRGB(0xff6333);
            }
            break;
        case TradeSevenTableViewCellTypeTitle:
            {
                _leftLabel.textColor = _rightLabel.textColor = UIColorFromRGB(0x999999);
                _leftLabel.text = NSLocalizedString(@"价格", nil);
                _rightLabel.text = NSLocalizedString(@"数量", nil);
            }
            break;
        default:
            break;
    }
}
-(void)setMarket:(NSString *)market andCoinName:(NSString *)coinName{
    if (_cellType == TradeSevenTableViewCellTypeTitle) {
        _leftLabel.text = FormatString(@"%@(%@)", NSLocalizedString(@"价格", nil),market);
        _rightLabel.text = FormatString(@"%@(%@)",NSLocalizedString(@"数量", nil),coinName);
    }
}

-(void)setCellWithModel:(SevenBuyOrSelDataModel *)model{
    _leftLabel.text = model.price;
    _rightLabel.text = model.volume;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
