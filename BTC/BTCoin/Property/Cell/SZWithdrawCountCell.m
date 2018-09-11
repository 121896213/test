

//
//  SZWithdrawCountCell.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWithdrawCountCell.h"

@interface SZWithdrawCountCell()

@property (nonatomic,strong) UIButton* BTCTypeBtn;
@property (nonatomic,strong) UIButton* totalBtn;
@property (nonatomic,strong) UITextField* countTextField;
@end




@implementation SZWithdrawCountCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
        self.backgroundColor=MainBackgroundColor;

    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setSubViews
{
    UILabel* rechargeCountLabel=[UILabel new];
    [rechargeCountLabel setText:NSLocalizedString(@"数量", nil)];
    [rechargeCountLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [rechargeCountLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:rechargeCountLabel];
    [rechargeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(0));
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(178));
    }];
    
    
    UIView* textFieldView=[UIView new];
    textFieldView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:textFieldView];
    [textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeCountLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    UITextField* countTextField=[UITextField new];
    countTextField.placeholder=NSLocalizedString(@"最小提币数量0.01", nil);
    countTextField.textColor=[UIColor blackColor];
    countTextField.keyboardType=UIKeyboardTypeNumberPad;
//    countTextField.delegate=self;
    countTextField.font=[UIFont systemFontOfSize:14.0f];
    [textFieldView addSubview:countTextField];
    [countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeCountLabel.mas_bottom);
        make.left.equalTo(rechargeCountLabel.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    self.countTextField=countTextField;
    
    
    
    UIButton* totalButton=[UIButton new];
    [totalButton setTitle:NSLocalizedString(@"全部", nil) forState:UIControlStateNormal];
    [totalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [totalButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [totalButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [textFieldView addSubview:totalButton];
    self.totalBtn=totalButton;
    [totalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT2(-30));
        make.top.equalTo(countTextField.mas_top);
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(120));
        
    }];
    
    UIView* lineViewY=[UIView new];
    [textFieldView addSubview:lineViewY];
    lineViewY.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [lineViewY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totalButton.mas_left).offset(FIT2(-22));
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(3));
        make.top.equalTo(countTextField.mas_top);
    }];
    
    
    UIButton* BTCButton=[UIButton new];
    self.BTCTypeBtn=BTCButton;
    [BTCButton setTitle:NSLocalizedString(@"BTC", nil) forState:UIControlStateNormal];
    [BTCButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [BTCButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [BTCButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:BTCButton];
    [BTCButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totalButton.mas_left).offset(FIT2(-50));
        make.top.equalTo(totalButton.mas_top);
        make.height.mas_equalTo(FIT3(146));
        make.width.mas_equalTo(FIT3(120));
    }];
    
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT3(-1.5));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    [self setActions];
}

-(void)setActions{
    
    [[self.totalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.countTextField.text=self.viewModel.bbPropertyModel.ftotal;
        self.withdrawViewModel.currentCoinCount=self.countTextField.text;
        [(RACSubject *) self.withdrawViewModel.otherSignal sendNext:SZWithdrawCountCellTextFieldDidChanged];
    }];
    
    @weakify(self);
    [[self.countTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(id x) {
        @strongify(self);
        self.withdrawViewModel.currentCoinCount=self.countTextField.text;
        [(RACSubject *) self.withdrawViewModel.otherSignal sendNext:SZWithdrawCountCellTextFieldDidChanged];
        NSLog(@"textFiledChange:%@",self.countTextField.text);
    }];
    
    
    
}

- (void)setViewModel:(SZPropertyCellViewModel *)viewModel{
    
    [self.BTCTypeBtn setTitle:viewModel.bbPropertyModel.fvirtualcointypeName forState:UIControlStateNormal];
    _viewModel=viewModel;
    
}
-(void)setWithdrawViewModel:(SZPropertyWithdrawViewModel *)withdrawViewModel{
    _withdrawViewModel=withdrawViewModel;
    
}

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//
//    self.withdrawViewModel.currentCoinCount=self.countTextField.text;
//    [(RACSubject *) self.withdrawViewModel.otherSignal sendNext:SZWithdrawCountCellTextFieldDidChanged];
//    NSLog(@"textFiledChange:%@",self.countTextField.text);
//
//}

@end
