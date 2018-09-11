//
//  SZWithdrawServiceFeeCell.m
//  BTCoin
//
//  Created by Shizi on 2018/5/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZWithdrawServiceFeeCell.h"
#import "SZWithdrawCountCell.h"
@interface SZWithdrawServiceFeeCell()
    
@property (nonatomic,strong)  UILabel* acountCountLabel;
@property (nonatomic,strong) UILabel* servicefeeCountLabel;
@end


@implementation SZWithdrawServiceFeeCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
        self.backgroundColor=MainBackgroundColor;

    }
    return self;
}

-(void)setSubViews
{
    UILabel* servicefeeLabel=[UILabel new];
    [servicefeeLabel setText:NSLocalizedString(@"手续费", nil)];
    [servicefeeLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [servicefeeLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:servicefeeLabel];
    [servicefeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(FIT3(48));
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(178));
    }];
    
    
    UILabel* servicefeeCountLabel=[UILabel new];
    [servicefeeCountLabel setText:NSLocalizedString(@"0.00100000000  BTC", nil)];
    [servicefeeCountLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [servicefeeCountLabel setTextColor:[UIColor blackColor]];
    servicefeeCountLabel.textAlignment=NSTextAlignmentRight;

    [self.contentView addSubview:servicefeeCountLabel];
    self.servicefeeCountLabel=servicefeeCountLabel;
    [servicefeeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(servicefeeLabel.mas_top);
        make.right.mas_equalTo(FIT3(-48));
        make.width.mas_equalTo(FIT3(400));
        make.height.mas_equalTo(FIT3(178));
    }];
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(servicefeeCountLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    
    
    UILabel* acountLabel=[UILabel new];
    [acountLabel setText:NSLocalizedString(@"到账数量", nil)];
    [acountLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [acountLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:acountLabel];
    [acountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(FIT3(145));
        make.width.mas_equalTo(FIT3(400));

    }];
    
    UILabel* acountCountLabel=[UILabel new];
    [acountCountLabel setText:NSLocalizedString(@"0.00000000 BTC", nil)];
    [acountCountLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [acountCountLabel setTextColor:UIColorFromRGB(0xff6333)];
    acountCountLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:acountCountLabel];
    self.acountCountLabel=acountCountLabel;
    [acountCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(acountLabel.mas_top);
        make.height.mas_equalTo(FIT3(145));
        make.width.mas_equalTo(FIT3(600));
        
    }];
    
 
    UIView* lineView2=[UIView new];
    [lineView2 setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT3(-1.5));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(1.5));
    }];
}
- (void)setViewModel:(SZPropertyCellViewModel *)viewModel{

    self.acountCountLabel.text=  [NSString stringWithFormat:@"%@  %@",@"0.0000000",viewModel.bbPropertyModel.fvirtualcointypeName];
    _viewModel=viewModel;
}

-(void)setWithdrawViewModel:(SZPropertyWithdrawViewModel *)withdrawViewModel{

    
    self.servicefeeCountLabel.text=[(isEmptyString(withdrawViewModel.withdrawFee)?@"0.000000":withdrawViewModel.withdrawFee) stringByAppendingString:FormatString(@"  %@",self.viewModel.bbPropertyModel.fvirtualcointypeName)];
    double acount= [withdrawViewModel.currentCoinCount doubleValue]-[withdrawViewModel.currentCoinCount doubleValue]* [_withdrawViewModel.withdrawFee doubleValue];
    self.acountCountLabel.text=  [NSString stringWithFormat:@"%lf  %@",acount,self.viewModel.bbPropertyModel.fvirtualcointypeName];
    self.withdrawViewModel.reachCoinCount=FormatString(@"%lf",acount);
    _withdrawViewModel=withdrawViewModel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
@end
