//
//  TradeChoiceCoinTableViewCell.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "TradeChoiceCoinTableViewCell.h"

@interface TradeChoiceCoinTableViewCell()

@property (nonatomic,strong)UILabel * leftLabel;
@property (nonatomic,strong)UIImageView * hotImageView;
@property (nonatomic,strong)UILabel * centerLabel;
@property (nonatomic,strong)UILabel * rightLabel;

@end

@implementation TradeChoiceCoinTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat margin = 32 * kScale;
        CGFloat width = (kScreenWidth - 90 * kScale - margin - 20)/3;
        
        _leftLabel = [UILabel new];
        _leftLabel.font = kFontSize(14);
        _leftLabel.textColor = UIColorFromRGB(0x666666);
        [self.contentView addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.leading.mas_equalTo(margin);
//            make.width.mas_equalTo(width);
        }];
        
        _hotImageView = [[UIImageView alloc]initWithImage:kIMAGE_NAMED(@"market_lock")];
        [self.contentView addSubview:_hotImageView];
        [_hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_leftLabel.mas_top).offset(3);
            make.leading.mas_equalTo(_leftLabel.mas_trailing).offset(3);
            make.size.mas_equalTo(CGSizeMake(17, 6));
        }];
        
        
        _centerLabel = [UILabel new];
        _centerLabel.font = kFontSize(14);
        _centerLabel.textColor = UIColorFromRGB(0x666666);
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_centerLabel];
        [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(margin + width);
            make.centerY.mas_equalTo(_leftLabel.mas_centerY);
            make.width.mas_equalTo(width);
        }];
        
        _rightLabel = [UILabel new];
        _rightLabel.font = kFontSize(14);
        _rightLabel.textColor = UIColorFromRGB(0x666666);
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(margin + width*2);
            make.centerY.mas_equalTo(_leftLabel.mas_centerY);
            make.width.mas_equalTo(width);
        }];
        
        UIView * line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xdbdbdb);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(margin);
            make.bottom.trailing.mas_equalTo(0);
            make.height.mas_equalTo(0.7);
        }];
    }
    return self;
}

-(void)setMarketModel:(MarketHomeListModel *)model
{
    self.leftLabel.text = model.fShortName;
    _hotImageView.hidden = !model.flockCurrent;
    self.centerLabel.text = model.fNewDealPrice;
    self.rightLabel.text = [NSString stringWithFormat:@"%.2f%%",[model.fTodayRiseFall doubleValue] *100 ];
    
    CGFloat zdf = [model.fTodayRiseFall floatValue];
    if (zdf > 0.00000000) {
        self.rightLabel.text = [NSString stringWithFormat:@"+%.2f%%",[model.fTodayRiseFall doubleValue] *100 ];
        self.rightLabel.textColor = UIColorFromRGB(0x03c087);
    }else if (zdf < 0.0000000) {
        self.rightLabel.textColor = UIColorFromRGB(0xff6333);
    }else{
        self.rightLabel.textColor =  UIColorFromRGB(0xAFB3BF);
    }
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
