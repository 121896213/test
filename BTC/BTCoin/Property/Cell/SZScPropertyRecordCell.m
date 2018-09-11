//
//  SZScPropertyRecordCell.m
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZScPropertyRecordCell.h"
#import "SZScpropertyRecordCellViewModel.h"

@interface SZScPropertyRecordCell()
@property (nonatomic,strong)UILabel* tradeTimeValueLab;
@property (nonatomic,strong)UILabel* tradeTimeLab;

@property (nonatomic,strong)UILabel* tradeAmountValueLab;
@property (nonatomic,strong)UILabel* tradeAmountLab;

@property (nonatomic,strong)UILabel* tradeTypeValueLab;
@property (nonatomic,strong)UILabel* tradeTypeLab;

@end

@implementation SZScPropertyRecordCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}


-(void)setSubView{
    
    UILabel* tradeTimeLab=[UILabel new];
    tradeTimeLab.text=@"变动时间";
    tradeTimeLab.font=[UIFont systemFontOfSize:12.0f];
    tradeTimeLab.textColor=[UIColor blackColor];
    [self addSubview:tradeTimeLab];
    [tradeTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(FIT3(45));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(34));
        
    }];
    
    UILabel* tradeTimeValueLab=[UILabel new];
    tradeTimeValueLab.text=@"2017-05-06 15:25:36";
    tradeTimeValueLab.textColor=UIColorFromRGB(0xACACAC);
    tradeTimeValueLab.font=[UIFont systemFontOfSize:12.0f];
    tradeTimeValueLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:tradeTimeValueLab];
    [tradeTimeValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(tradeTimeLab.mas_top);
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tradeTimeLab.mas_bottom).offset(FIT3(18));
        make.left.equalTo(tradeTimeLab.mas_left);
        make.width.mas_equalTo(ScreenWidth-FIT3(48)*2);
        make.height.mas_equalTo(FIT3(1.5));
    }];
    
    UILabel* tradeAmountLab=[UILabel new];
    tradeAmountLab.text=@"变动金额";
    tradeAmountLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeAmountLab];
    [tradeAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeTimeLab.mas_left);
        make.top.equalTo(lineView).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* tradeAmountValueLab=[UILabel new];
    tradeAmountValueLab.text=@"2.5222";
    tradeAmountValueLab.font=[UIFont systemFontOfSize:12.0f];
    tradeAmountValueLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:tradeAmountValueLab];
    [tradeAmountValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT3(-48));
        make.top.equalTo(tradeAmountLab.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* tradeTypeLab=[UILabel new];
    tradeTypeLab.text=NSLocalizedString(@"变动类型", nil) ;
    tradeTypeLab.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:tradeTypeLab];
    [tradeTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tradeAmountLab.mas_left);
        make.top.mas_equalTo(tradeAmountLab.mas_bottom).offset(FIT3(43));
        make.width.mas_equalTo(FIT3(500));
        make.height.mas_equalTo(FIT3(36));
    }];
    
    UILabel* tradeTypeValueLab=[UILabel new];
    tradeTypeValueLab.text=NSLocalizedString(@"买入", nil);
    tradeTypeValueLab.font=[UIFont systemFontOfSize:12.0f];
    tradeTypeValueLab.textAlignment=NSTextAlignmentRight;

    [self addSubview:tradeTypeValueLab];
    [tradeTypeValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tradeAmountValueLab.mas_right);
        make.top.mas_equalTo(tradeTypeLab.mas_top);
        make.width.mas_equalTo(FIT3(300));
        make.height.mas_equalTo(FIT3(36));
    }];

    
    self.tradeTimeValueLab=tradeTimeValueLab;
    self.tradeTimeLab=tradeTimeLab;
    
    self.tradeAmountValueLab=tradeAmountValueLab;
    self.tradeAmountLab=tradeAmountLab;

    self.tradeTypeValueLab=tradeTypeValueLab;
    self.tradeTypeLab=tradeTypeLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(void)setViewModel:(SZScPropertyRecordCellViewModel *)viewModel{
    
    if (viewModel.model) {
        NSString* createTime=viewModel.model.createTime;
        NSString* changeType=viewModel.model.changeType;
        NSString* changeAmount=viewModel.model.changeAmount;
        changeAmount= [NSString reviseString:changeAmount];
        
        self.tradeTimeValueLab.text=[AppUtil datetimeStrFormatter:FormatString(@"%ld",[createTime integerValue]/1000)   formatter:@"yyyy-MM-dd HH:mm:ss"];
        if ([changeType integerValue] == 10) {
            self.tradeTypeValueLab.text= NSLocalizedString(@"买入", nil);
        }else if ([changeType integerValue] == 20 ){
            self.tradeTypeValueLab.text= NSLocalizedString(@"利息", nil);
        }else{
            self.tradeTypeValueLab.text= NSLocalizedString(@"解锁", nil);
        }
        self.tradeAmountValueLab.text=FormatString(@"%@",changeAmount);
    }

    if (viewModel.c2cRecordModel) {
        
        NSString* createTime=viewModel.c2cRecordModel.fUpdateTime;
        NSString* fTransSeq=viewModel.c2cRecordModel.fTransSeq;
        NSString* fTransNumber=viewModel.c2cRecordModel.fTransNumber;
        
        self.tradeTimeValueLab.text=[AppUtil datetimeStrFormatter:FormatString(@"%ld",[createTime integerValue]/1000)   formatter:@"yyyy-MM-dd HH:mm:ss"];
        if ([fTransSeq integerValue] == 1) {
            self.tradeTypeValueLab.text= NSLocalizedString(@"买入", nil);
        }else if ([fTransSeq integerValue] == 2 ){
            self.tradeTypeValueLab.text= NSLocalizedString(@"卖出", nil);
        }else if ([fTransSeq integerValue] == 4 ) {
            self.tradeTypeValueLab.text= NSLocalizedString(@"转入", nil);
        }else if ([fTransSeq integerValue] == 3){
            self.tradeTypeValueLab.text= NSLocalizedString(@"转出", nil);
        }else{
            self.tradeTypeValueLab.text= NSLocalizedString(@"未知", nil);
        }
        self.tradeAmountValueLab.text=FormatString(@"%@",fTransNumber);
        self.tradeAmountLab.text=NSLocalizedString(@"变动额度", nil);
    }
   
    _viewModel=viewModel;
}
@end
