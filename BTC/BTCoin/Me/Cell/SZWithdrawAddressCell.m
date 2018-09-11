//
//  SZWithdrawAddressCell.m
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWithdrawAddressCell.h"

@interface SZWithdrawAddressCell()
@property (nonatomic,strong)  UIButton* rightBtn;

@end;

@implementation SZWithdrawAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews
{
    self.coinTypeLab=[UILabel new];
    [self.coinTypeLab setText:NSLocalizedString(@"BTC", nil)];
    [self.coinTypeLab setFont:[UIFont systemFontOfSize:14.0f]];
    [self.coinTypeLab setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:self.coinTypeLab];
    [self.coinTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(SZWithdrawAddressCellHeight);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UIButton* rightBtn=[UIButton new];
    [rightBtn setImage:[UIImage imageNamed:@"cell_right_icon"] forState:UIControlStateNormal];
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT2(-30));
//        make.top.mas_equalTo((SZWithdrawAddressCellHeight-FIT3(75))/2);
        make.height.mas_equalTo(FIT3(75));
        make.width.mas_equalTo(FIT3(75));
        make.centerY.equalTo(self.mas_centerY);

    }];
    self.rightBtn=rightBtn;
    
    
    self.coinTypeCountLab=[UILabel new];
    [self.coinTypeCountLab setText:NSLocalizedString(@"0个", nil)];
    [self.coinTypeCountLab setFont:[UIFont systemFontOfSize:12.0f]];
    [self.coinTypeCountLab setTextColor:UIColorFromRGB(0xacacac)];
    [self.coinTypeCountLab setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.coinTypeCountLab];
    [self.coinTypeCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(FIT2(-10-30)-FIT3(75));
        make.right.equalTo(rightBtn.mas_left).offset(FIT(-16));
        make.height.mas_equalTo(FIT(25));
        make.width.mas_equalTo(FIT(200));
        make.centerY.equalTo(self.mas_centerY);

    }];

    
    UITextField* textFiled=[UITextField new];
    textFiled.placeholder=NSLocalizedString(@"请输入数量", nil);
    textFiled.textAlignment=NSTextAlignmentRight;
    textFiled.font=[UIFont systemFontOfSize:FIT(16)];
    [self.contentView addSubview:textFiled];
    [textFiled setHidden:YES];
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
//        make.top.mas_equalTo((SZWithdrawAddressCellHeight-FIT3(75))/2);
        make.height.mas_equalTo(FIT(25));
        make.width.mas_equalTo(FIT(100));
        make.centerY.equalTo(self.mas_centerY);

    }];
    self.textFiled=textFiled;
    [self addBottomLineView];
    

}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setViewModel:(SZAddressListCellViewModel *)viewModel
{
    self.coinTypeLab.text=viewModel.model.fShortName;
    self.coinTypeCountLab.text=FormatString(@"%ld",(long)[viewModel.model.faddressCount integerValue]) ;
    _viewModel=viewModel;
    
}


-(void)setAmountTradeCellStyle:(NSIndexPath*)indexPath{
    if (indexPath.row != 2) {
        [self.rightBtn setHidden:YES];
        [self.coinTypeCountLab setTextColor:MainLabelBlackColor];
        [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(0));
            make.width.mas_equalTo(FIT(0));

        }];
        [self.coinTypeCountLab updateConstraints];
    }else{
        [self.textFiled setHidden:NO];
        [self.coinTypeCountLab setHidden:YES];
        [self.rightBtn setHidden:YES];

    }
}


-(void)setAboutUSCellStyle:(NSIndexPath*)indexPath{
    if (indexPath.row == 0 && indexPath.section == 1) {
        [self.rightBtn setHidden:YES];
        [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(0));
            make.width.mas_equalTo(FIT(0));
            
        }];
        [self.coinTypeCountLab updateConstraints];
    }else{
        [self.textFiled setHidden:YES];
        [self.coinTypeCountLab setHidden:YES];
        [self.rightBtn setHidden:NO];
        
    }
}
@end
