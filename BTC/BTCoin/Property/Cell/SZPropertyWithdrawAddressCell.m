//
//  SZPropertyWithdrawAddressCell.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyWithdrawAddressCell.h"

@interface SZPropertyWithdrawAddressCell()
@property (nonatomic,strong) UITextField* addressTextField;

@end


@implementation SZPropertyWithdrawAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=MainBackgroundColor;
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews
{
    UILabel* rechargeAddressLabel=[UILabel new];
    [rechargeAddressLabel setText:NSLocalizedString(@"提币地址", nil)];
    [rechargeAddressLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [rechargeAddressLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:rechargeAddressLabel];
    [rechargeAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);;
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(178));
    }];
    
    UIView* textFieldView=[UIView new];
    textFieldView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:textFieldView];
    [textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeAddressLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    UITextField* addressTextField=[UITextField new];
    addressTextField.placeholder=NSLocalizedString(@"输入或长按粘贴地址", nil);
    addressTextField.textColor=[UIColor blackColor];
    addressTextField.font=[UIFont systemFontOfSize:14.0f];
    addressTextField.adjustsFontSizeToFitWidth = YES;
    [textFieldView addSubview:addressTextField];
    self.addressTextField=addressTextField;
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeAddressLabel.mas_bottom);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(FIT3(800));
        make.height.mas_equalTo(FIT3(146));
    }];
    
    UIButton* addressButton=[UIButton new];
    [addressButton setImage:[UIImage imageNamed:@"property_address_icon"] forState:UIControlStateNormal];
    [textFieldView addSubview:addressButton];
    self.addressButton=addressButton;
    [addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT2(-30));
        make.top.equalTo(addressTextField.mas_top);
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(100));

    }];
    
    UIButton* saoButton=[UIButton new];
    [saoButton setImage:[UIImage imageNamed:@"property_sao_icon"] forState:UIControlStateNormal];
    [self.contentView addSubview:saoButton];
    self.saoButton=saoButton;
    [saoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addressButton.mas_left).offset(FIT3(-16));
        make.top.equalTo(rechargeAddressLabel.mas_bottom);
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(100));

    }];

  
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT3(-1.5));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    [self addAcitons];
}
-(void)addAcitons{
    @weakify(self);
    [[self.addressTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(id x) {
        @strongify(self);
        self.withdrawViewModel.currentAddress=self.addressTextField.text;
        [(RACSubject *) self.withdrawViewModel.otherSignal sendNext:SZPropertyWithdrawAddressCellTextFieldDidChanged];
        NSLog(@"textFiledChange:%@",self.addressTextField.text);
    }];
    [[self.saoButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [(RACSubject *) self.withdrawViewModel.otherSignal sendNext:SZPropertyWithdrawAddressCellSaoButtonAction];
    }];
    
    [[self.addressButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [(RACSubject *) self.withdrawViewModel.otherSignal sendNext:SZPropertyWithdrawAddressCellAddressButtonAction];
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)setWithdrawViewModel:(SZPropertyWithdrawViewModel *)withdrawViewModel{
    
    self.addressTextField.text=withdrawViewModel.currentAddress;
    _withdrawViewModel=withdrawViewModel;
}

@end
