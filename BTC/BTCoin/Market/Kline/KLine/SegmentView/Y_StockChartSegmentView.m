//
//  Y_StockChartSegmentView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_StockChartSegmentView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"

static NSInteger const Y_StockChartSegmentStartTag = 2000;

//static CGFloat const Y_StockChartSegmentIndicatorViewHeight = 2;
//
//static CGFloat const Y_StockChartSegmentIndicatorViewWidth = 40;

@interface Y_StockChartSegmentView()

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) UIButton *secondLevelSelectedBtn1;

@property (nonatomic, strong) UIButton *secondLevelSelectedBtn2;

@property (nonatomic,assign)NSInteger secondLevelSelectedBtn1Tag;
@property (nonatomic,assign)NSInteger secondLevelSelectedBtn2Tag;

@end

@implementation Y_StockChartSegmentView

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        self.items = items;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.clipsToBounds = YES;
        self.backgroundColor = UIColorFromRGB(0xF2F3F5);
        _secondLevelSelectedBtn1Tag = Y_StockChartSegmentStartTag + 100;
        _secondLevelSelectedBtn2Tag = Y_StockChartSegmentStartTag + 106;
    }
    return self;
}

- (UIView *)indicatorView
{
    if(!_indicatorView)
    {
        _indicatorView = [UIView new];
        
        UIView * centerSuperView = [UIView new];
        centerSuperView.backgroundColor = TheAppDel.isKLineDarkModel ? UIColorFromRGB(0x3D4451) : UIColorFromRGB(0xffffff);
        centerSuperView.layer.cornerRadius = 3.0f;
        centerSuperView.clipsToBounds = YES;
        [_indicatorView addSubview:centerSuperView];
        [centerSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_indicatorView);
            make.width.mas_equalTo(380 * kScale);
            make.height.mas_equalTo(140);
        }];
        
        __block UILabel * label = [UILabel new];
        label.textColor = TheAppDel.isKLineDarkModel ? UIColorFromRGB(0xffffff) : UIColorFromRGB(0x333333);
        label.font = kFontSize(16);
        label.text = NSLocalizedString(@"指标设置", nil);
        [centerSuperView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(20);
            make.height.mas_equalTo(15);
        }];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage: (TheAppDel.isKLineDarkModel ?kIMAGE_NAMED(@"zhibiaoClose_W"): kIMAGE_NAMED(@"zhibiaoClose")) forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(zhibiaoCloseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [centerSuperView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.greaterThanOrEqualTo(@40);
            make.height.equalTo(@30);
            make.centerY.mas_equalTo(label.mas_centerY);
            make.right.equalTo(@(0));
        }];
//        zhibiaoClose
        
//       __block UILabel * label1 = [UILabel new];
//        label1.font = kFontSize(12);
//        label1.text = NSLocalizedString(@"副图", nil);
//        [centerSuperView addSubview:label1];
//        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(20);
//            make.top.mas_equalTo(label.mas_bottom).offset(30);
//            make.height.mas_equalTo(15);
//        }];
//
//       __block UILabel * label2 = [UILabel new];
//        label1.textColor = label2.textColor = TheAppDel.isKLineDarkModel ? UIColorFromRGB(0x999999) : UIColorFromRGB(0x333333);
//        label2.font = kFontSize(12);
//        label2.text = NSLocalizedString(@"副图", nil);
//        [centerSuperView addSubview:label2];
//        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(20);
//            make.top.mas_equalTo(label1.mas_bottom).offset(30);
//            make.height.mas_equalTo(15);
//        }];
        
        NSArray *titleArr = @[@"MACD",@"KDJ",@"",@"MA",@"EMA",@"BOLL",@""];
        __block UIButton *preBtn;
        [titleArr enumerateObjectsUsingBlock:^(NSString*  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSAttributedString * selectAttStr = [[NSAttributedString alloc]initWithString:NSLocalizedString(title, nil) attributes:@{NSForegroundColorAttributeName:(TheAppDel.isKLineDarkModel ? UIColorFromRGB(0x688DE8) :HomeLightColor),NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:(TheAppDel.isKLineDarkModel ? UIColorFromRGB(0x688DE8) :HomeLightColor),NSFontAttributeName:kFontSize(12)}];
            NSAttributedString * normalAttStr = [[NSAttributedString alloc]initWithString:NSLocalizedString(title, nil) attributes:@{NSForegroundColorAttributeName:(TheAppDel.isKLineDarkModel ? UIColorFromRGB(0xfffefe) :UIColorFromRGB(0x333333)),NSFontAttributeName:kFontSize(12)}];

            [btn setAttributedTitle:selectAttStr forState:UIControlStateSelected];
            [btn setAttributedTitle:normalAttStr forState:UIControlStateNormal];
            btn.tag = Y_StockChartSegmentStartTag + 100 + idx;
            [btn addTarget:self action:@selector(event_segmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [centerSuperView addSubview:btn];
            
            if (idx == 2 || idx == 6) {
                btn.hidden = YES;
            }
            if (idx < 3) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.greaterThanOrEqualTo(@40);
                    make.height.equalTo(@30);
                    make.top.mas_equalTo(label.mas_bottom).offset(20);
                    if(preBtn)
                    {
                        if (idx == 2) {
                            make.right.equalTo(@(-20));
                        }else{
                            make.left.equalTo(preBtn.mas_right).offset(20);
                        }
                    } else {
                        make.left.equalTo(@20);
                    }
                }];

            }else{
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.greaterThanOrEqualTo(@40);
                    make.height.equalTo(@30);
                    make.top.mas_equalTo(label.mas_bottom).offset(60);
//                    make.centerY.equalTo(label2);
                    if(idx > 3)
                    {
                        if (idx == 6) {
                            make.right.equalTo(@(-20));
                        }else{
                            make.left.equalTo(preBtn.mas_right).offset(20);
                        }
                    } else {
                        make.left.equalTo(@20);
                    }
                }];
            }
            preBtn = btn;

            if (btn.tag == _secondLevelSelectedBtn1Tag) {
                [btn setSelected:YES];
//                _secondLevelSelectedBtn1 = btn;
            }else if (btn.tag == _secondLevelSelectedBtn2Tag){
                [btn setSelected:YES];
//                _secondLevelSelectedBtn2 = btn;
            }
            preBtn = btn;
        }];

        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window addSubview:_indicatorView];
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(@0);
        }];
    }
    _indicatorView.backgroundColor =  UIColorFromRGBWithAlpha(0x000000, 0.7);

    return _indicatorView;
}

-(void)zhibiaoCloseButtonClicked{
    if (_indicatorView) {
        [_indicatorView removeFromSuperview];
        _indicatorView = nil;
    }
}


- (void)setItems:(NSArray *)items
{
    _items = items;
    if(items.count == 0 || !items)
    {
        return;
    }
    NSInteger index = 0;
    NSInteger count = items.count;
    UIButton *preBtn = nil;
    
    for (NSString *title in items)
    {
        UIButton *btn = [self private_createButtonWithTitle:title tag:Y_StockChartSegmentStartTag+index];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.width.equalTo(self).multipliedBy(1.0f/count);
            make.height.equalTo(self);
            if(preBtn)
            {
                make.left.equalTo(preBtn.mas_right).offset(0.5);
            } else {
                make.left.equalTo(self);
            }
        }];
        
        if (index == 0) {
            _bottomLine = [UIView new];
            _bottomLine.backgroundColor = MainThemeColor;
            [self addSubview:_bottomLine];
            [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom);
                make.width.equalTo(self).multipliedBy(1.0f/count);
                make.height.mas_equalTo(1);
                make.left.equalTo(btn.mas_left);
            }];
        }
        preBtn = btn;
        index++;
    }


}

#pragma mark 设置底部按钮index
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    UIButton *btn = (UIButton *)[self viewWithTag:Y_StockChartSegmentStartTag + selectedIndex];
    NSAssert(btn, @"按钮初始化出错");
    [self event_segmentButtonClicked:btn];
}

- (void)setSelectedBtn:(UIButton *)selectedBtn
{
    if(_selectedBtn == selectedBtn)
    {
        if(selectedBtn.tag != (Y_StockChartSegmentStartTag+ self.items.count -1))
        {
            return;
        } else {
            
        }
    }
    
    if(selectedBtn.tag >= 2100 && selectedBtn.tag < 2103)
    {
//        [_secondLevelSelectedBtn1 setSelected:NO];
//        [selectedBtn setSelected:YES];
//        _secondLevelSelectedBtn1 = selectedBtn;
        _secondLevelSelectedBtn1Tag = selectedBtn.tag;
    } else if(selectedBtn.tag >= 2103) {
//        [_secondLevelSelectedBtn2 setSelected:NO];
//        [selectedBtn setSelected:YES];
//        _secondLevelSelectedBtn2 = selectedBtn;
        _secondLevelSelectedBtn2Tag = selectedBtn.tag;
    } else if(selectedBtn.tag != (Y_StockChartSegmentStartTag+ self.items.count -1)){
        [_selectedBtn setSelected:NO];
        [selectedBtn setSelected:YES];
        _selectedBtn = selectedBtn;
        [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(self).multipliedBy(1.0f/_items.count);
            make.height.mas_equalTo(1);
            make.left.equalTo(_selectedBtn.mas_left);
        }];
    }

    _selectedIndex = selectedBtn.tag - Y_StockChartSegmentStartTag;
    
    if(_selectedIndex == (self.items.count -1))
    {
        self.indicatorView.hidden = NO;
    } else {
        if (_indicatorView) {
            [_indicatorView removeFromSuperview];
            _indicatorView = nil;
        }
//        self.indicatorView.hidden = YES;
    }
    [self layoutIfNeeded];
}

#pragma mark - 私有方法
#pragma mark 创建底部按钮
- (UIButton *)private_createButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [btn setTitleColor:MainThemeColor forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = tag;
    [btn addTarget:self action:@selector(event_segmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

#pragma mark 底部按钮点击事件
- (void)event_segmentButtonClicked:(UIButton *)btn
{
    self.selectedBtn = btn;
    
    if(btn.tag == Y_StockChartSegmentStartTag + self.items.count -1)
    {
        return;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(y_StockChartSegmentView:clickSegmentButtonIndex:)])
    {
        [self.delegate y_StockChartSegmentView:self clickSegmentButtonIndex: btn.tag-Y_StockChartSegmentStartTag];
    }
}

-(void)refreshUI{
    UIColor * buttonColor;
    if (TheAppDel.isKLineDarkModel) {
        self.backgroundColor = UIColorFromRGB(0x222222);
        buttonColor = UIColorFromRGB(0xBBBBBB);

    }else{
        self.backgroundColor = UIColorFromRGB(0xF2F3F5);
        buttonColor = UIColorFromRGB(0x333333);


    }
    for (UIButton * button  in self.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button setTitleColor:buttonColor forState:UIControlStateNormal];
        }
    }
}

@end
