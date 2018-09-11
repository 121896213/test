//
//  SZCommissionRecordHeadView.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZCommissionRecordHeadView.h"
#import "CGXPickerView.h"
#import "NSDate+SZDate.h"
@interface SZCommissionRecordHeadView ()
@property(nonatomic, strong)UILabel* mineCommissionValueLab;
@property(nonatomic, strong)UILabel* directCommissionValueLab;
@property(nonatomic, strong) UILabel* indirectCommissionValueLab;

@property(nonatomic, strong) UIView* selectDateView;
@property(nonatomic, strong) UIImageView* topImageView;




@end
@implementation SZCommissionRecordHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=MainBackgroundColor;
        [self setSubView];
    }
    return self;
}
-(void)setSubView{
    
    
    UIImageView* topImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"commissionrecord_head_background"]];
    [self addSubview:topImageView];
    self.topImageView=topImageView;
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(FIT3(536));
    }];
    
    
    UILabel* mineCommissionLab=[UILabel new];
    mineCommissionLab.font=[UIFont systemFontOfSize:14.0f];
    mineCommissionLab.text=NSLocalizedString(@"我的返佣", nil);
    [topImageView addSubview:mineCommissionLab];
    [mineCommissionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(48));
        make.top.mas_equalTo(FIT3(61));
        make.width.mas_equalTo(FIT3(400));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    
    UILabel* mineCommissionValueLab=[UILabel new];
    mineCommissionValueLab.font=[UIFont systemFontOfSize:24.0f];
    mineCommissionValueLab.text=NSLocalizedString(@"0.00000000  USDT", nil);
    mineCommissionValueLab.textColor=MainThemeColor;
    [topImageView addSubview:mineCommissionValueLab];
   
    [mineCommissionValueLab setAttributedTextWithBeforeString:@"0.00000000  " beforeColor:mineCommissionValueLab.textColor beforeFont:mineCommissionValueLab.font afterString:@"USDT" afterColor:[UIColor blackColor] afterFont:[UIFont systemFontOfSize:12.0f]];
    [mineCommissionValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mineCommissionLab.mas_left);
        make.top.equalTo(mineCommissionLab.mas_bottom).offset(FIT3(52));
        make.width.mas_equalTo(FIT3(800));
        make.height.mas_equalTo(FIT3(72));
    }];
    
    
    
    UIView* directCommissionView=[UIView new];
    directCommissionView.backgroundColor=[UIColor whiteColor];
    [directCommissionView setShadowToView];
    [topImageView addSubview:directCommissionView];
    [directCommissionView setCircleBorderWidth:FIT3(3) bordColor:[UIColor groupTableViewBackgroundColor] radius:FIT3(10)];
    [directCommissionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineCommissionValueLab.mas_bottom).offset(FIT3(60));
        make.width.mas_equalTo(FIT3(550));
        make.height.mas_equalTo(FIT3(218));
        make.left.equalTo(mineCommissionValueLab.mas_left);
    }];
    
    UILabel* directLab=[UILabel new];
    directLab.font=[UIFont systemFontOfSize:14.0f];
    directLab.text=NSLocalizedString(@"直接返佣", nil);
    directLab.textColor=UIColorFromRGB(0xACACAC);
    [directCommissionView addSubview:directLab];

    [directLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(37));
        make.top.mas_equalTo(FIT3(40));
        make.width.mas_equalTo(FIT3(400));
        make.height.mas_equalTo(FIT3(36));
    }];
    UILabel* directCommissionValueLab=[UILabel new];
    directCommissionValueLab.font=[UIFont systemFontOfSize:14.0f];
    directCommissionValueLab.text=NSLocalizedString(@"0.00000000  USDT", nil);
//    directCommissionValueLab.textColor=MainThemeColor;
    [directCommissionView addSubview:directCommissionValueLab];
    [directCommissionValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(directLab.mas_left);
        make.top.equalTo(directLab.mas_bottom).offset(FIT3(40));
        make.width.mas_equalTo(FIT3(800));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    

    
    
    
    UIView* indirectCommissionView=[UIView new];
    indirectCommissionView.backgroundColor=[UIColor whiteColor];
    [indirectCommissionView setShadowToView];
    [topImageView addSubview:indirectCommissionView];
    [indirectCommissionView setCircleBorderWidth:FIT3(3) bordColor:[UIColor groupTableViewBackgroundColor] radius:FIT3(10)];
    [indirectCommissionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineCommissionValueLab.mas_bottom).offset(FIT3(60));
        make.width.mas_equalTo(FIT3(550));
        make.height.mas_equalTo(FIT3(218));
        make.right.mas_equalTo(FIT3(-48));
    }];
    
    UILabel* indirectLab=[UILabel new];
    indirectLab.font=[UIFont systemFontOfSize:14.0f];
    indirectLab.text=NSLocalizedString(@"间接返佣", nil);
    indirectLab.textColor=UIColorFromRGB(0xACACAC);

    [indirectCommissionView addSubview:indirectLab];
    [indirectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(37));
        make.top.mas_equalTo(FIT3(40));
        make.width.mas_equalTo(FIT3(400));
        make.height.mas_equalTo(FIT3(36));
    }];
    UILabel* indirectCommissionValueLab=[UILabel new];
    indirectCommissionValueLab.font=[UIFont systemFontOfSize:14.0f];
    indirectCommissionValueLab.text=NSLocalizedString(@"0.00000000  USDT", nil);
    [indirectCommissionView addSubview:indirectCommissionValueLab];
    [indirectCommissionValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(indirectLab.mas_left);
        make.top.equalTo(indirectLab.mas_bottom).offset(FIT3(40));
        make.width.mas_equalTo(FIT3(800));
        make.height.mas_equalTo(FIT3(42));
    }];
    
    self.mineCommissionValueLab=mineCommissionValueLab;
    self.indirectCommissionValueLab=indirectCommissionValueLab;
    self.directCommissionValueLab=directCommissionValueLab;

    
    [self setSelectDateView];
}
-(void)setSelectDateView{
    
    UIView* selectDateView=[UIView new];
    selectDateView.backgroundColor=[UIColor whiteColor];
    [self addSubview:selectDateView];
    self.selectDateView=selectDateView;
    [selectDateView setCircleBorderWidth:FIT3(1) bordColor:[UIColor groupTableViewBackgroundColor] radius:FIT3(10)];
    [selectDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(FIT3(48));
        make.left.right.mas_equalTo(FIT3(0));
        make.height.mas_equalTo(FIT3(229));
    }];
    
    
    
    UILabel * beginTimeLab = [self createLabelWithText:@"起始日期"];
    [beginTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT3(84));
        make.top.mas_equalTo(FIT3(45));
        make.height.mas_equalTo(beginTimeLab.font.lineHeight);
        make.width.mas_equalTo(FIT3(402));
    }];
    UIButton* beginDateButton = [self createSelectDateButtonWithTitle:[NSDate getTheFirstDayOfThisMonth]];
    [beginDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(beginTimeLab.mas_width);
        make.top.mas_equalTo(beginTimeLab.mas_bottom).offset(FIT3(15));
        make.height.mas_equalTo(FIT3(71));
        make.left.mas_equalTo(beginTimeLab.mas_left);
    }];
    [beginDateButton setCircleBorderWidth:FIT3(3) bordColor:UIColorFromRGB(0xCCCCCC) radius:FIT3(10)];
    self.beginDateButton=beginDateButton;
    
    UILabel * endTimeLab = [self createLabelWithText:@"截止日期"];
    [endTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(beginTimeLab.mas_right).offset(FIT3(71));
        make.top.equalTo(beginTimeLab.mas_top);
        make.height.mas_equalTo(endTimeLab.font.lineHeight);
        make.width.mas_equalTo(FIT3(402));
    }];
    beginTimeLab.textAlignment = endTimeLab.textAlignment = NSTextAlignmentCenter;
    
  
    UIButton* endDateButton = [self createSelectDateButtonWithTitle:[NSDate getTodayString]];
    [endDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(endTimeLab.mas_width);
        make.top.mas_equalTo(endTimeLab.mas_bottom).offset(FIT3(15));
        make.height.mas_equalTo(FIT3(71));
        make.left.mas_equalTo(endTimeLab.mas_left);
    }];
    [endDateButton setCircleBorderWidth:FIT3(3) bordColor:UIColorFromRGB(0xCCCCCC) radius:FIT3(10)];
    self.endDateButton=endDateButton;
    
    UIButton* selectBtn=[UIButton new];
    [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [selectBtn setTitle:NSLocalizedString(@"查询", nil) forState:UIControlStateNormal];
    [selectBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [selectDateView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(97));
        make.left.equalTo(endDateButton.mas_right).offset(FIT3(71));
        make.width.mas_equalTo(FIT3(200));
        make.height.mas_equalTo(FIT3(88));
    }];
    [selectBtn setGradientBackGround];
    [selectBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    [selectBtn setCircleBorderWidth:FIT3(1) bordColor:[UIColor groupTableViewBackgroundColor] radius:FIT3(10)];
    self.selectBtn=selectBtn;
    [self setActions];
}


-(void)setActions{
    @weakify(self);
    [[self.beginDateButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [CGXPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"" MaxDateStr:[NSDate getTodayString] IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            [self.beginDateButton setTitle:selectValue forState:UIControlStateNormal];
        }];
    }];
    
    [[self.endDateButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [CGXPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"" MaxDateStr:[NSDate getTodayString] IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            [self.endDateButton setTitle:selectValue forState:UIControlStateNormal];
        }];
    }];
 
}


-(void)setListModel:(SZCommissRecordListModel *)listModel{
    self.mineCommissionValueLab.text=FormatString(@"%@  USDT",listModel.sumFeesUSDT);
    [self.mineCommissionValueLab setAttributedTextWithBeforeString:listModel.sumFeesUSDT beforeColor:self.mineCommissionValueLab.textColor beforeFont:self.mineCommissionValueLab.font afterString:@"  USDT" afterColor:[UIColor blackColor] afterFont:[UIFont systemFontOfSize:12.0f]];

    self.directCommissionValueLab.text=FormatString(@"%@  USDT",listModel.directSumFeesUSDT) ;;
    self.indirectCommissionValueLab.text=FormatString(@"%@  USDT",listModel.indirectSumFeesUSDT);;;
    _listModel=listModel;
}

/**创建label*/
-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel * label = [UILabel new];
    label.text = NSLocalizedString(text, nil);
    label.font = kFontSize(14);
    [self.selectDateView addSubview:label];
    return label;
}

/**创建选日期按钮*/
-(UIButton *)createSelectDateButtonWithTitle:(NSString *)title
{
    UIButton * button = [UIButton new];
    button.backgroundColor = UIColorFromRGB(0xFFFFFF);
    [button setTitleColor:UIColorFromRGB(0xacacac) forState:UIControlStateNormal];
    [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"select_date"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [button setImagePositionWithType:SSImagePositionTypeRight spacing:15.f];

    [button setCircleBorderWidth:FIT3(3) bordColor:UIColorFromRGB(0xCCCCCCC) radius:FIT3(8.f)];
    [self.selectDateView addSubview:button];
 

    return button;
}
@end
