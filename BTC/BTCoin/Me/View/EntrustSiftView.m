//
//  EntrustSiftView.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/4/29.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "EntrustSiftView.h"
#import "CGXPickerView.h"
#import "NSDate+SZDate.h"
#import "BigAreaModel.h"

@interface EntrustSiftView(){
    UIView * whiteBack; //白底
    UIView * areaSurperView;    //大区父view
    UIView * mutableView;   //根据Type，设定不同的筛选项
    NSInteger _coinType;
    TradeState _tradeState;
    TradeVCType _tradeType;
    NSString * _beginDate;
    NSString * _endDate;
    CGFloat boomLine_offX;
}

@property (nonatomic,strong)UIView * moveLine;//滑动光标

@property (nonatomic,strong)UIButton * allButton;//全部
@property (nonatomic,strong)UIButton * buyButton;//买入、用户撤单
@property (nonatomic,strong)UIButton * selButton;//卖出、已成交

@property (nonatomic,strong)UIButton * beginDateButton;//开始日期
@property (nonatomic,strong)UIButton * endDateButton;//截止日期

@property (nonatomic,strong)UIButton * resetButton;//重置
@property (nonatomic,strong)UIButton * ensureButton;//确定
@end

@implementation EntrustSiftView

-(instancetype)initWithSiftType:(EntrustSiftType)type{
    if (self = [super init]) {
        _siftType = type;
        [self configSubViews];
        [self setDefaultState];
    }
    return self;
}

//大区选择
-(void)areaButtonClick:(UIButton *)button
{
    for (UIButton * view in areaSurperView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.selected = view == button ? YES : NO;
        }
    }
    BigAreaModel * model = [SZBase sharedSZBase].areaModelArr[button.tag -200201];
    _coinType = [model.fid integerValue];
    [_moveLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(25 +boomLine_offX+ (button.tag - 200201)* button.width);
    }];
    [self layoutIfNeeded];
}
//all-buy-sell  or all-cancel-success
-(void)typeButtonClick:(UIButton *)button
{
    _allButton.selected = _buyButton.selected = _selButton.selected = NO;
    if (button == _allButton) {
        _allButton.selected = YES;
        _siftType == EntrustSiftTypeToday ? (_tradeType = TradeVCTypeAll) : (_tradeState = TradeStateAll);
    }else if (button == _buyButton){
        _buyButton.selected = YES;
        _siftType == EntrustSiftTypeToday ? (_tradeType = TradeVCTypeBuy) : (_tradeState = TradeStateUserCancel);
    }else if (button == _selButton){
        _selButton.selected = YES;
        _siftType == EntrustSiftTypeToday ? (_tradeType = TradeVCTypeSel) : (_tradeState = TradeStateAllOver);
    }
    
}
//历史记录 选择日期
-(void)selectDateButtonClick:(UIButton *)button
{
    if (button == _beginDateButton) {
        [CGXPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:_beginDate MinDateStr:@"" MaxDateStr:@"" IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            [_beginDateButton setTitle:selectValue forState:UIControlStateNormal];
            _beginDate=selectValue;
        }];
    }else{
        [CGXPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:_endDate MinDateStr:@"" MaxDateStr:@"" IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            [_endDateButton setTitle:selectValue forState:UIControlStateNormal];
            _endDate=selectValue;
        }];
    }
}
//重置 or 确定
-(void)boomButtonClick:(UIButton *)button
{
    if (button == _resetButton) {
        [self setDefaultState];
    }else{
        if (self.finishSiftBlock) {
            NSMutableDictionary * mDict = [NSMutableDictionary dictionary];
            [mDict setValue:@(_coinType) forKey:@"coinType"];
            
            switch (_siftType) {
                case EntrustSiftTypeToday:
                    [mDict setValue:@(_tradeType) forKey:@"entrusType"];
                    break;
                case EntrustSiftTypeHistory:
                {
                    [mDict setValue:_beginDate forKey:@"begindate"];
                    [mDict setValue:_endDate forKey:@"enddate"];
                    
                    if ([_beginDate compare:_endDate] != NSOrderedAscending) {
                        [UIViewController showErrorHUDWithTitle:@"截止日期必须大于起始日期"];
                        return;
                    }
                }
                    break;
                case EntrustSiftTypeRecordToday:
                    [mDict setValue:@(_tradeState) forKey:@"status"];
                    break;
                default:
                    break;
            }

            
            self.finishSiftBlock(mDict);
            [self removeFromSuperview];
          
            
        }
    }
}
#pragma mark -- 设置默认状态
-(void)setDefaultState
{
    for (UIButton * view in areaSurperView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.selected = (view.tag == 200201 ? YES : NO);
        }
    }
    BigAreaModel * model = [SZBase sharedSZBase].areaModelArr[0];
    _coinType = [model.fid integerValue];
    [_moveLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(25+boomLine_offX);
    }];
    
    switch (_siftType) {
        case EntrustSiftTypeToday:
        {
            [self typeButtonClick:_allButton];
            _tradeType = TradeVCTypeAll;
        }
            break;
        case EntrustSiftTypeHistory:
        {
            _beginDate = [NSDate getTheFirstDayOfThisMonth];
            _endDate = [NSDate getTodayString];
            [_beginDateButton setTitle:_beginDate forState:UIControlStateNormal];
            [_endDateButton setTitle:_endDate forState:UIControlStateNormal];
        }
            break;
        case EntrustSiftTypeRecordToday:
        {
            [self typeButtonClick:_allButton];
            _tradeState = TradeStateAll;

        }
            break;
        default:
            break;
    }

}
#pragma mark -- 创建子视图
-(void)configSubViews
{
    self.backgroundColor = [UIColor clearColor];
    
    whiteBack = [UIView new];
    whiteBack.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteBack];
    [whiteBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(0);
    }];
    
    areaSurperView = [UIView new];
    areaSurperView.backgroundColor = MainBackgroundColor;
    [whiteBack addSubview:areaSurperView];
    [areaSurperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    CGFloat width = (kScreenWidth - 50);
    if ([SZBase sharedSZBase].areaModelArr.count > 0)
    {
        width = (kScreenWidth - 50)/[SZBase sharedSZBase].areaModelArr.count;
        for (int i = 0; i < [SZBase sharedSZBase].areaModelArr.count; i++)
        {
            UIButton * button = [self createButtonWithTitle:[SZBase sharedSZBase].areaNameArr[i] andTag:200201 + i];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(25 + width * i);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(7);
            }];
        }
    }
    CGFloat boomLineWidth = 60;
    boomLine_offX = (width - boomLineWidth )/2;
    _moveLine = [UIView new];
    _moveLine.backgroundColor = MainThemeColor;
    [areaSurperView addSubview:_moveLine];
    [_moveLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(25 +boomLine_offX);
        make.width.mas_equalTo(boomLineWidth);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(-7);
    }];
    //设计可变区域
    mutableView = [UIView new];
    mutableView.backgroundColor = UIColorFromRGB(0xffffff);
    [whiteBack addSubview:mutableView];
    [mutableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(areaSurperView.mas_bottom);
    }];
    
    CGFloat mutableH = 0;
    if (_siftType == EntrustSiftTypeToday || _siftType == EntrustSiftTypeRecordToday)
    {
        if (_siftType == EntrustSiftTypeToday)
        {
            CGFloat typeButtonW =  60;
            _allButton = [self createTypeButtonWithTitle:@"全部"];
            [_allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(25 + boomLine_offX);
                make.width.mas_equalTo(typeButtonW);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(5);
                make.bottom.mas_equalTo(-5);
            }];
        
            _buyButton = [self createTypeButtonWithTitle:_siftType == EntrustSiftTypeToday ?@"买入":@"用户撤单"];
            [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(_allButton.mas_trailing).offset(21);
                make.width.height.top.mas_equalTo(_allButton);
            }];
        
            _selButton = [self createTypeButtonWithTitle:_siftType == EntrustSiftTypeToday ?@"卖出" :@"已成交"];
            [_selButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(_buyButton.mas_trailing).offset(21);
                make.width.height.top.mas_equalTo(_allButton);
            }];
            mutableH = 40;
        }
    }
    else
    {
        CGFloat timeAreaW = (kScreenWidth - 50 - 26)/2.0;
        UILabel * beginTimeLab = [self createLabelWithText:@"起始日期"];
        [beginTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(25);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(timeAreaW);
        }];
        
        UILabel * endTimeLab = [self createLabelWithText:@"截止日期"];
        [endTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-25);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(timeAreaW);
        }];
        beginTimeLab.textAlignment = endTimeLab.textAlignment = NSTextAlignmentCenter;
        
        _beginDateButton = [self createSelectDateButtonWithTitle:@"2018-04-01"];
        [_beginDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(25);
            make.width.mas_equalTo(timeAreaW);
            make.top.mas_equalTo(beginTimeLab.mas_bottom).offset(15);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(-15);
        }];
        _endDateButton = [self createSelectDateButtonWithTitle:@"2018-04-24"];
        [_endDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.top.mas_equalTo(_beginDateButton);
            make.trailing.mas_equalTo(-25);
        }];
        
        mutableH = 90;
    }
    [mutableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(mutableH);
        make.top.mas_equalTo(areaSurperView.mas_bottom);
    }];
    
    _resetButton = [self createBoomButtonWithTitle:@"重置" isLeft:YES];
    [_resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.mas_equalTo(0);
        make.top.mas_equalTo(mutableView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    _ensureButton = [self createBoomButtonWithTitle:@"确定" isLeft:NO];
    [_ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(mutableView.mas_bottom);
        make.leading.mas_equalTo(_resetButton.mas_trailing);
        make.width.height.mas_equalTo(_resetButton);
    }];
    
    UIView * boom = [UIView new];
    boom.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [self addSubview:boom];
    [boom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(whiteBack.mas_bottom);
        make.bottom.leading.trailing.mas_equalTo(0);
    }];
    
}
#pragma mark -- 创建功能类似控件
/**创建分区按钮*/
-(UIButton *)createButtonWithTitle:(NSString *)title andTag:(NSInteger)tag
{
    title = [title stringByAppendingString:NSLocalizedString(@"区", nil)];
    UIButton * button = [UIButton new];
    [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [button setTitleColor:MainThemeColor forState:UIControlStateSelected];
    [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    button.titleLabel.font = kFontSize(15);
    [button addTarget:self action:@selector(areaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [areaSurperView addSubview:button];
    return button;
}

/**创建类型按钮*/
-(UIButton *)createTypeButtonWithTitle:(NSString *)title
{
    UIButton * button = [UIButton new];
    [button setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
//    [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    [button setImage:kIMAGE_NAMED(@"entrust_unsel") forState:UIControlStateNormal];
    [button setImage:kIMAGE_NAMED(@"entrust_sel") forState:UIControlStateSelected];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    button.titleLabel.font = kFontSize(15);
    [button addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mutableView addSubview:button];
    return button;
}

/**创建选日期按钮*/
-(UIButton *)createSelectDateButtonWithTitle:(NSString *)title
{
    UIButton * button = [UIButton new];
    button.backgroundColor = MainBackgroundColor;
    [button setTitleColor:UIColorFromRGB(0xacacac) forState:UIControlStateNormal];
    [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    button.titleLabel.font = kFontSize(14);
    [button addTarget:self action:@selector(selectDateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mutableView addSubview:button];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    UIImageView * image = [[UIImageView alloc]initWithImage:kIMAGE_NAMED(@"dateSelectImage")];
    [button addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(button);
        make.trailing.mas_equalTo(-6);
        make.width.height.mas_equalTo(20);
    }];
    return button;
}

/**创建底部功能按钮*/
-(UIButton *)createBoomButtonWithTitle:(NSString *)title isLeft:(BOOL)isLeft;
{
    UIButton * button = [UIButton new];
    button.backgroundColor = isLeft ? UIColorFromRGB(0xffffff): MainThemeColor;
    [button setTitleColor:isLeft ? UIColorFromRGB(0x666666): UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    button.titleLabel.font = kFontSize(15);
    [button addTarget:self action:@selector(boomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (isLeft) {
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = MainThemeColor.CGColor;
    }
    [whiteBack addSubview:button];
    return button;
}

/**创建label*/
-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel * label = [UILabel new];
    label.text = NSLocalizedString(text, nil);
    label.font = kFontSize(14);
    [mutableView addSubview:label];
    return label;
}
@end
