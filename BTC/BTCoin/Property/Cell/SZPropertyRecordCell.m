//
//  SZPropertyRecordCell.m
//  BTCoin
//
//  Created by Shizi on 2018/5/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPropertyRecordCell.h"
@interface SZPropertyRecordCell()
@property (nonatomic,strong) UILabel* tradeTimeLab;
@property (nonatomic,strong) UILabel* tradeTypeLab;
@property (nonatomic,strong) UILabel* tradeAmountLab;
@property (nonatomic,strong) UILabel* tradeFeeLab;
@property (nonatomic,strong) UILabel* tradeStatusLab;
@end


@implementation SZPropertyRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UILabel* tradeTypeLab=[UILabel new];
    tradeTypeLab.text=@"买入";
    tradeTypeLab.font=[UIFont systemFontOfSize:14.0f];
    tradeTypeLab.textColor=MainThemeColor;
    [self addSubview:tradeTypeLab];
    [tradeTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(FIT3(44));
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(42));
        
    }];

    UILabel* tradeTimeLab=[UILabel new];
    tradeTimeLab.text=@"2017-05-06 15:25:36";
    tradeTimeLab.textColor=UIColorFromRGB(0xACACAC);
    tradeTimeLab.font=[UIFont systemFontOfSize:12.0f];
    tradeTimeLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:tradeTimeLab];
    [tradeTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(tradeTypeLab.mas_top);
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:MainThemeColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tradeTypeLab.mas_bottom).offset(FIT3(13));
        make.left.equalTo(tradeTypeLab.mas_left);
        make.width.mas_equalTo(ScreenWidth-FIT3(48)*2);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    
    UILabel* tradeAmountLab=[UILabel new];
    tradeAmountLab.text=@"金额";
    tradeAmountLab.font=[UIFont systemFontOfSize:10.0f];
    [self addSubview:tradeAmountLab];
    [tradeAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeTypeLab.mas_left);
        make.top.equalTo(lineView).offset(FIT3(44));
        make.width.mas_equalTo(FIT3(154));
        make.bottom.mas_equalTo(FIT3(-43));
    }];
    
    UILabel* tradeAmountValueLab=[UILabel new];
    tradeAmountValueLab.text=@"2.5222";
    tradeAmountValueLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeAmountValueLab];
    [tradeAmountValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeAmountLab.mas_right);
        make.top.equalTo(tradeAmountLab.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.bottom.mas_equalTo(FIT3(-43));
    }];
    
    UILabel* tradeFeeLab=[UILabel new];
    tradeFeeLab.text=@"手续费";
    tradeFeeLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeFeeLab];
    [tradeFeeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeAmountValueLab.mas_right);
        make.top.mas_equalTo(tradeAmountValueLab.mas_top);
        make.width.mas_equalTo(FIT3(154));
        make.bottom.mas_equalTo(FIT3(-43));
    }];
    
    UILabel* tradeFeeValueLab=[UILabel new];
    tradeFeeValueLab.text=@"1.88888";
    tradeFeeValueLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeFeeValueLab];
    [tradeFeeValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeFeeLab.mas_right);
        make.top.mas_equalTo(tradeFeeLab.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.bottom.mas_equalTo(FIT3(-43));
    }];
    
    UILabel* tradeStatusLab=[UILabel new];
    tradeStatusLab.text=@"已成交";
    tradeStatusLab.font=[UIFont systemFontOfSize:10.0f];
    tradeStatusLab.adjustsFontSizeToFitWidth=YES;
    tradeStatusLab.textAlignment=NSTextAlignmentRight;

    [self addSubview:tradeStatusLab];
    [tradeStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeFeeValueLab.mas_right);
        make.top.mas_equalTo(tradeFeeValueLab.mas_top);
        make.right.mas_equalTo(FIT3(-48));
        make.bottom.mas_equalTo(FIT3(-43));
    }];
    
  
    
    self.tradeTimeLab=tradeTimeLab;
    self.tradeTypeLab=tradeTypeLab;
    self.tradeAmountLab=tradeAmountValueLab;
    self.tradeFeeLab=tradeFeeValueLab;
    self.tradeStatusLab=tradeStatusLab;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


-(void)setViewModel:(SZPropertyRecordCellViewModel *)viewModel{
    NSDictionary* fCreateTime=viewModel.model.fCreateTime;
    NSString* tecType=viewModel.model.tecType;
    NSString* fType=viewModel.model.fType;
    NSString* ffees=viewModel.model.ffees;
    NSString* fAmount=viewModel.model.fAmount;
    NSString* fStatus=viewModel.model.fStatus;
    
    self.tradeTimeLab.text=[AppUtil datetimeStrFormatter:FormatString(@"%ld",[fCreateTime[@"time"]integerValue]/1000)   formatter:@"yyyy-MM-dd HH:mm:ss"];
    if ([tecType integerValue] == 1) {
        self.tradeTypeLab.text= [fType integerValue] == 1?NSLocalizedString(@"充币", nil):NSLocalizedString(@"提币", nil);
    }else if ([tecType integerValue] == 2 ){
        self.tradeTypeLab.text= [fType integerValue] == 1?NSLocalizedString(@"转入", nil):NSLocalizedString(@"转出", nil);
    }
    self.tradeAmountLab.text=FormatString(@"%lf",[fAmount doubleValue]);
    self.tradeFeeLab.text=FormatString(@"%lf",[ffees doubleValue]);
    if ([tecType integerValue] == 1) {
        if ([fStatus integerValue] == 1) {
            self.tradeStatusLab.text=NSLocalizedString(@"等待提现", nil);
        }else if ([fStatus integerValue] == 2) {
            self.tradeStatusLab.text=NSLocalizedString(@"正在处理", nil);
        }else if ([fStatus integerValue] == 3) {
            self.tradeStatusLab.text=NSLocalizedString(@"提现成功", nil);
        }else if ([fStatus integerValue] == 4) {
            self.tradeStatusLab.text=NSLocalizedString(@"用户撤销", nil);
        }
    }else if ([tecType integerValue] == 2 ){
        if ([fStatus integerValue] == 1) {
            self.tradeStatusLab.text=NSLocalizedString(@"成功", nil);
        }else if ([fStatus integerValue] == 2) {
            self.tradeStatusLab.text=NSLocalizedString(@"失败", nil);
        }else if ([fStatus integerValue] == 3) {
            self.tradeStatusLab.text=NSLocalizedString(@"等待", nil);
        }else if ([fStatus integerValue] == 4) {
            self.tradeStatusLab.text=NSLocalizedString(@"失效", nil);
        }
    }
    _viewModel=viewModel;
}



@end
