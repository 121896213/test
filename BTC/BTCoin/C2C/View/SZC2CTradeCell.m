//
//  SZC2CTradeCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CTradeCell.h"

@implementation SZC2CTradeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.backgroundColor=MainC2CBackgroundColor;
    }
    return self;
}

-(void)setSubView{
    
    UIView* borderView=[UIView new];
    borderView.backgroundColor=[UIColor whiteColor];
    [self addSubview:borderView];
    [borderView setCircleBorderWidth:FIT(1) bordColor:borderView.backgroundColor radius:FIT(3)];
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(SZC2CTradeCellHeight);
    }];
    UIImageView *headerImageView = [[UIImageView alloc] init];
    [headerImageView setImage:[UIImage imageNamed:@"c2c_header_default"]];
    [borderView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(13));
        make.top.mas_equalTo(FIT(14));
        make.height.mas_equalTo(FIT(24));
        make.width.mas_equalTo(FIT(25));
    }];

    UIImageView *lineImageView = [[UIImageView alloc] init];
    [lineImageView setImage:[UIImage imageNamed:@"c2c_online"]];
    [headerImageView addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(FIT(11));
        make.width.mas_equalTo(FIT(11));
    }];
    
    
    UILabel* trueNameLab=[UILabel new];
    trueNameLab.text=NSLocalizedString(@"张**", nil);
    trueNameLab.font=[UIFont systemFontOfSize:FIT(16)];

    [borderView addSubview:trueNameLab];
    [trueNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerImageView.mas_right).offset(FIT(10));
        make.top.mas_equalTo(FIT(18));
        make.width.mas_equalTo(FIT(33));
        make.height.mas_equalTo(FIT(15));

    }];
    
    UIImageView *identificationTagImageView = [[UIImageView alloc] init];
    [identificationTagImageView setImage:[UIImage imageNamed:@"c2c_identity_yes"]];
    [borderView addSubview:identificationTagImageView];
    [identificationTagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(trueNameLab.mas_right).offset(FIT(8));
        make.top.mas_equalTo(FIT(19));
        make.height.mas_equalTo(FIT(13));
        make.width.mas_equalTo(FIT(17));
    }];
    
    
    UILabel* countLab=[UILabel new];
    countLab.text=NSLocalizedString(@"数量", nil);
    [borderView addSubview:countLab];
    countLab.font=[UIFont systemFontOfSize:FIT(12)];
    countLab.textColor=MainLabelGrayColor;

    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(14));
        make.top.equalTo(headerImageView.mas_bottom).offset(FIT(11));
        make.width.mas_equalTo(FIT(30));
        make.height.mas_equalTo(FIT(12));
        
    }];
    
    UILabel* countValuetLab=[UILabel new];
    countValuetLab.text=@"0.10633233";
    countValuetLab.font=[UIFont systemFontOfSize:FIT(10)];
    [borderView addSubview:countValuetLab];
    [countValuetLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countLab.mas_right).offset(FIT(9));
        make.top.equalTo(countLab.mas_top);
        make.width.mas_equalTo(FIT(65));
        make.height.mas_equalTo(FIT(10));
        
    }];
    
    UILabel* limimtLab=[UILabel new];
    limimtLab.text=NSLocalizedString(@"限额", nil);
    limimtLab.font=[UIFont systemFontOfSize:FIT(12)];
    limimtLab.textColor=MainLabelGrayColor;
    [borderView addSubview:limimtLab];
    [limimtLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(14));
        make.top.equalTo(countLab.mas_bottom).offset(FIT(7));
        make.width.mas_equalTo(FIT(30));
        make.height.mas_equalTo(FIT(12));
        
    }];
    
    UILabel* limimtValueLab=[UILabel new];
    limimtValueLab.text=@"0.10633233";
    limimtValueLab.font=[UIFont systemFontOfSize:FIT(10)];
    [borderView addSubview:limimtValueLab];
    [limimtValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(limimtLab.mas_right).offset(FIT(9));
        make.top.equalTo(limimtLab.mas_top);
        make.width.mas_equalTo(FIT(65));
        make.height.mas_equalTo(FIT(10));
        
    }];
    UIButton *bankBtn = [[UIButton alloc] init];
    [bankBtn setTitle:NSLocalizedString(@"工商银行", nil) forState:UIControlStateNormal];
    [bankBtn setTitleColor:MainThemeColor forState:UIControlStateNormal];
    bankBtn.titleLabel.font=[UIFont systemFontOfSize:FIT(12)];
    [borderView addSubview:bankBtn];
    [bankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(limimtLab.mas_left);
        make.top.equalTo(limimtLab.mas_bottom).offset(FIT(15));
        make.width.mas_equalTo(FIT(69));
        make.height.mas_equalTo(FIT(18));
    }];
    [bankBtn setCircleBorderWidth:1 bordColor:MainThemeColor radius:2];
    
    UIImageView* aliplayImageView = [[UIImageView alloc] init];
    [aliplayImageView setImage:[UIImage imageNamed:@"c2c_alipay"]];
    [borderView addSubview:aliplayImageView];
    [aliplayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bankBtn.mas_right).offset(FIT(8));
        make.top.equalTo(bankBtn.mas_top);
        make.width.mas_equalTo(FIT(18));
        make.height.mas_equalTo(FIT(18));
    }];
    
    UIImageView* weChatplayImageView = [[UIImageView alloc] init];
    [weChatplayImageView setImage:[UIImage imageNamed:@"c2c_wechat"]];

    [borderView addSubview:weChatplayImageView];
    [weChatplayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aliplayImageView.mas_right).offset(FIT(8));
        make.top.equalTo(aliplayImageView.mas_top);
        make.width.mas_equalTo(FIT(18));
        make.height.mas_equalTo(FIT(18));
    }];
    
  
    
    
    UILabel* priceLab=[UILabel new];
    priceLab.text=NSLocalizedString(@"价格", nil);
    priceLab.font=[UIFont systemFontOfSize:FIT(12)];
    priceLab.textColor=MainLabelGrayColor;
    [borderView addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-13));
        make.top.mas_equalTo(FIT(15));
        make.width.mas_equalTo(FIT(30));
        make.height.mas_equalTo(FIT(12));
        
    }];
    
    
    UILabel* priceValueLab =[UILabel new];
    priceValueLab.text=@"0.10633233";
    priceValueLab.font=[UIFont boldSystemFontOfSize:FIT(16)];
    priceValueLab.textColor=MainThemeColor;
    priceValueLab.textAlignment=NSTextAlignmentRight;
    [borderView addSubview:priceValueLab];
    [priceValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLab.mas_bottom).offset(FIT(15));
        make.right.mas_equalTo(FIT(-13));
        make.width.mas_equalTo(FIT(100));
        make.height.mas_equalTo(FIT(16));
        
    }];
    
    UILabel* unitLab =[UILabel new];
    unitLab.text=@"USDT";
    unitLab.font=[UIFont systemFontOfSize:FIT(10)];
    unitLab.textColor=MainThemeColor;
    [borderView addSubview:unitLab];
    [unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceValueLab.mas_bottom);
        make.right.mas_equalTo(FIT(-13));
        make.width.mas_equalTo(FIT(31));
        make.height.mas_equalTo(FIT(10));
        
    }];
    
    UIButton* buyBtn = [[UIButton alloc]init];
    buyBtn.backgroundColor = MainThemeBlueColor;
    [buyBtn setTitle:NSLocalizedString(@"买入", nil) forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [buyBtn setCircleBorderWidth:FIT(1) bordColor:[UIColor clearColor] radius:FIT(3)];
    [buyBtn setEnlargeEdgeWithTop:FIT(10) right:FIT(10) bottom:FIT(10) left:FIT(10)];
    [borderView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(unitLab.mas_bottom).offset(FIT(16));
        make.right.mas_equalTo(FIT(-13));
        make.width.mas_equalTo(FIT(83));
        make.height.mas_equalTo(FIT(30));
    }];
    @weakify(self);
    [[buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        if (self.action) {
            self.action(buyBtn);
 
        }
    }];
//    [buyBtn setGradientBackGround];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
