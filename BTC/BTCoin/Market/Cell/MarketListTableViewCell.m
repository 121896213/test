//
//  MarketListTableViewCell.m
//  BTCoin
//
//  Created by zzg on 2018/4/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "MarketListTableViewCell.h"
#import <YYKit/UIImageView+YYWebImage.h>

@interface MarketListTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countFor24HLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *equalRMBLabel;
@property (weak, nonatomic) IBOutlet UILabel *upDownLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lockImageView;
@property (weak, nonatomic) IBOutlet UIButton *addCollectButton;

@property (nonatomic,strong)MarketHomeListModel * model;

@end

@implementation MarketListTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setMarketModel:(MarketHomeListModel *)model isAddPage:(BOOL)isAddPage{
    _model = model;
    _lockImageView.hidden = !model.flockCurrent;
    self.nameLabel.text = model.fShortName;
    [self.iconImageView setImageURL:[NSURL URLWithString:model.furl]];

    self.countFor24HLabel.text = [NSString stringWithFormat:@"%@%ld",NSLocalizedString(@"量(24H)", nil),(NSInteger)round([model.H24Volume doubleValue])];
    self.nowPriceLabel.text = model.fNewDealPrice;
    
    self.upDownLabel.textColor = [UIColor whiteColor];
    self.upDownLabel.text = [NSString stringWithFormat:@"%.2f%%",[model.fTodayRiseFall doubleValue] *100 ];

    CGFloat zdf = [model.fTodayRiseFall floatValue];
    if (zdf > 0.00000000) {
        self.upDownLabel.text = [NSString stringWithFormat:@"+%.2f%%",[model.fTodayRiseFall doubleValue] *100 ];

        self.nowPriceLabel.textColor = self.equalRMBLabel.textColor = self.upDownLabel.backgroundColor = UIColorFromRGB(0x03c087);
    }else if (zdf < 0.0000000) {
        self.nowPriceLabel.textColor = self.equalRMBLabel.textColor = self.upDownLabel.backgroundColor = UIColorFromRGB(0xff6333);
    }else{
        self.nowPriceLabel.textColor = self.equalRMBLabel.textColor = self.upDownLabel.backgroundColor = UIColorFromRGB(0xAFB3BF);
    }
    self.equalRMBLabel.text = model.fMarket;
   
    if (model.isHaveSelected) {
        [self.addCollectButton setImage:kIMAGE_NAMED(@"haveAddMarket") forState:UIControlStateNormal];
//        self.addCollectButton.enabled = NO;
    }else{
        [self.addCollectButton setImage:kIMAGE_NAMED(@"addMarket") forState:UIControlStateNormal];
//        self.addCollectButton.enabled = YES;
    }
    self.addCollectButton.hidden = !isAddPage;
    self.upDownLabel.hidden = isAddPage;
}

- (IBAction)addCollectButtonClick:(id)sender {
    if (_model.isHaveSelected) {
        if (self.removeCollectBlock) {
            self.removeCollectBlock(_nameLabel.text);
        }
    }
    else{
        if (self.addCollectBlock) {
            self.addCollectBlock(_nameLabel.text);
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
