//
//  MarkDeatilViewController.m
//  BTCoin
//
//  Created by zzg on 2018/4/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "MarkDeatilViewController.h"
#import "Masonry.h"
#import "Y_StockChartView.h"
#import "NetWorking.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"
#import "AppDelegate.h"
#import "MarketDeatilHeadView.h"
#import "NSDictionary+Custom.h"
#import "RealTimeModel.h"
#import "ApplyViewController.h"
#import <MJExtension.h>
#import "SelfCollectArrayModel.h"

#define SCREEN_MAX_LENGTH (MAX(UIScreenWidth, UIScreenHeight))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define BottomHeight 60

@interface MarkDeatilViewController ()<Y_StockChartViewDataSource>{
    CGFloat _rotaedLeft_x;
    CGFloat _rotaedProti_boom;
    UIView * boomLine;//底部三个按钮上方的线
}

@property (nonatomic, strong) Y_StockChartView *stockChartView;
@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;
@property (nonatomic, copy) NSString *type;
@property (nonatomic,strong) UIButton * changeWhiteBlackButton;


@property (nonatomic, strong) MarketDeatilHeadView  *detailHeadView;    //盘口

@property (nonatomic,strong) UIView  *boomSuperView;//底部父视图，方便旋转时，隐藏
@property (nonatomic,strong) UIButton * buyButton;
@property (nonatomic,strong) UIButton * selButton;

@property (nonatomic,strong) UIButton * addCollectButton;


@property (nonatomic,copy) NSNumber * lastVol;


@end

@implementation MarkDeatilViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    appDelegate.isCanRota = YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self getData];
    [[SZSocket sharedSZSocket]orderMessage:_model.fCoinType];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMarketDataNotifaction:) name:kGetMarketDataNotifaction object:nil];
}


-(void)getMarketDataNotifaction:(NSNotification *)noti{
    NSDictionary * dict = noti.userInfo;
//    NSInteger stockId = [dict[@"stockId"] integerValue];
    NSInteger stockId = [dict[@"ID"] integerValue];
    if ([_model.fCoinType integerValue] == stockId) {
        [_model refreshDataWithDict:dict];
        [self.detailHeadView setEqualRmbPrice:_model.fMarket];
        
        CGFloat changeVol = 0.0;
        if ([self.detailHeadView.twenty_fourPrice.text isEqualToString:@"--"]) {
            self.lastVol = dict[@"V"];
        }else{
            changeVol = [dict[@"V"] floatValue] - self.lastVol.floatValue;
            self.lastVol = dict[@"V"];
        }
        
        RealTimeModel * model = [[RealTimeModel alloc]init];
        [model setValueWithJsonString:dict andPointModel:_model];
        [self.detailHeadView setViewWithModel:model];
        
        [self onTimeRefreshKline:dict changeValue:changeVol];
    }
}

-(void)onTimeRefreshKline:(NSDictionary *)dict changeValue:(CGFloat)changeValue
{
    if ([self.modelsDict objectForKey:self.type])
    {
        NSMutableArray * mArr = [NSMutableArray arrayWithArray:[self.modelsDict objectForKey:self.type].models];
        Y_KLineModel * model = [mArr lastObject];
        NSInteger newTime = [dict[@"T"] integerValue];
        NSInteger oldTime = [model.Date integerValue];
        NSNumber * gsqNumber = dict[@"C"];
        if (newTime - oldTime < [self timeUnitForType]) {
            if (gsqNumber.floatValue > model.High.floatValue) {
                model.High = gsqNumber;
            }
            if (gsqNumber.floatValue < model.Low.floatValue) {
                model.Low = gsqNumber;
            }
            model.Close = gsqNumber;
            model.SumOfLastClose = @(model.Close.floatValue + model.PreviousKlineModel.SumOfLastClose.floatValue);
            model.Volume = model.Volume + changeValue;
            model.SumOfLastVolume = @(model.Volume + model.PreviousKlineModel.SumOfLastVolume.floatValue);
        }else{
            Y_KLineModel * newModel = [Y_KLineModel new];
            newModel.PreviousKlineModel = model;
            newModel.ParentGroupModel = model.ParentGroupModel;
            newModel.Date = [NSString stringWithFormat:@"%@",dict[@"T"]];
            newModel.Open = newModel.Close = newModel.High = newModel.Low = gsqNumber;
            newModel.SumOfLastClose = @(newModel.Close.floatValue + newModel.PreviousKlineModel.SumOfLastClose.floatValue);
            newModel.Volume = changeValue;
            newModel.SumOfLastVolume = @(newModel.Volume + newModel.PreviousKlineModel.SumOfLastVolume.floatValue);
            [mArr addObject:newModel];
            model.ParentGroupModel.models = mArr;
        }
        [self.stockChartView.kLineView refreshKLineModels:mArr];
        NSLog(@"%@",model);
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    appDelegate.isCanRota = NO;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IS_IPHONE_X) {
        _rotaedLeft_x = 34;
        _rotaedProti_boom = -34;
    }else{
        _rotaedLeft_x = 0;
        _rotaedProti_boom = 0;
    }
    [self configSubviews];
}

- (void)getData
{ 
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"symbol"] = _model.fCoinType;
    param[@"ID"] = _model.fCoinType;

//    NSString * urlStr = [NSString stringWithFormat:@"%@/api/v1/realquote",KLineUrlHead];
    NSString * urlStr = [NSString stringWithFormat:@"%@/api/v1/RQ",KLineUrlHead];

    __weak typeof(self)weakSelf = self;
    
    [NetWorking requestWithApi:urlStr param:param thenSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary * dict = responseObject[@"RQ"][0];
        [weakSelf.model refreshDataWithDict:dict];
        weakSelf.lastVol = dict[@"V"];
        RealTimeModel * model = [[RealTimeModel alloc]init];
        [model setValueWithJsonString:dict andPointModel:_model];
        [weakSelf.detailHeadView setViewWithModel:model];
        [weakSelf.detailHeadView setEqualRmbPrice:_model.fMarket];
    } fail:^{
        
    }];
}

- (void)configSubviews
{
    [self setTitleText:[NSString stringWithFormat:@"%@/%@",_model.fShortName,_areaName]];
    [self.headView refreshBottomLineViewColor:UIColorFromRGB(0xf5f5f5)];
    _changeWhiteBlackButton = [UIButton new];
    [_changeWhiteBlackButton setImage:kIMAGE_NAMED(@"changeBlack") forState:UIControlStateNormal];
    [_changeWhiteBlackButton setImage:kIMAGE_NAMED(@"changeWhite") forState:UIControlStateSelected];
    [_changeWhiteBlackButton addTarget:self action:@selector(changeWhiteBlackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:_changeWhiteBlackButton];
    [_changeWhiteBlackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.trailing.mas_equalTo(-10);
        make.bottom.mas_equalTo(2);
    }];
    //上部区域
    _detailHeadView = [[MarketDeatilHeadView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_detailHeadView];
    [_detailHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(0);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.height.mas_equalTo(85);
    }];
    
    //K线区域
    [self.stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(85 + StatusBarHeight + NaviBarHeight, 10, BottomHeight - _rotaedProti_boom, 10));
    }];
    self.stockChartView.backgroundColor = [UIColor backgroundColor];

    _boomSuperView =[[UIView alloc] init];
    _boomSuperView.backgroundColor = WhiteColor;
    [self.view addSubview:_boomSuperView];
    [_boomSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.stockChartView.mas_bottom);
        make.height.mas_equalTo(BottomHeight);
        make.bottom.mas_equalTo(_rotaedProti_boom);
    }];
    boomLine = [[UIView alloc] init];
    boomLine.backgroundColor = [UIColor colorWithRed:52.f/255.f green:56.f/255.f blue:67/255.f alpha:1];
    [_boomSuperView addSubview:boomLine];
    [boomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(0);
        make.leading.mas_equalTo(10);
        make.height.mas_equalTo(0.5);
    }];
    
    _addCollectButton = [UIButton new];
    [_addCollectButton addTarget:self action:@selector(addCollectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_addCollectButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -20, 0, 0)];
    [_addCollectButton setImageEdgeInsets:UIEdgeInsetsMake(-20, 20, 0, 0)];
    _addCollectButton.titleLabel.font = kFontSize(12);
    [_boomSuperView addSubview:_addCollectButton];
    [_addCollectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(60);
        make.trailing.mas_equalTo(-15);
        make.bottom.mas_equalTo(-10);
    }];
    
    CGFloat buyButtonW = kScreenWidth /2  -60;
    
    _buyButton = [self createButtonWithTitle:@"买入"];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buyButtonW);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
        make.leading.mas_equalTo(15);
    }];

    _selButton = [self createButtonWithTitle:@"卖出"];
    [_selButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(_buyButton);
        make.leading.mas_equalTo(_buyButton.mas_trailing).offset(15);
    }];
    
    if (_model.flockCurrent == 1) {
        [_buyButton setTitle:NSLocalizedString(@"申购", nil) forState:UIControlStateNormal];
    }
    
    [self refreshUIStyle];
}

/**创建类型按钮*/
-(UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton * button = [UIButton new];
    [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    button.layer.cornerRadius = 5.0f;
    button.backgroundColor = [title isEqualToString:@"买入"]?UIColorFromRGB(0x03c087):UIColorFromRGB(0xff6333);
    [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    button.titleLabel.font = kFontSize(15);
    [button addTarget:self action:@selector(boomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_boomSuperView addSubview:button];
    return button;
}
-(void)boomButtonClick:(UIButton *)button{
    if (button == _buyButton && _model.flockCurrent == 1) {
        ApplyViewController * buyVC = [[ApplyViewController alloc]init];
        buyVC.selectedModel = self.model;
        [self.navigationController pushViewController:buyVC animated:YES];
        return;
    }

    [self.tabBarController setSelectedIndex:1];
    [self.navigationController popViewControllerAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TradeCommonModel sharedTradeCommonModel].areaName = _areaName;
        [TradeCommonModel sharedTradeCommonModel].model = _model;
        [TradeCommonModel sharedTradeCommonModel].tradeVCType = button == _buyButton ?TradeVCTypeBuy : TradeVCTypeSel;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"MarkDetailJumpToTradeNotification" object:nil userInfo:nil];
    });

}

-(void)changeWhiteBlackButtonAction:(UIButton *)button{
    TheAppDel.isKLineDarkModel = !TheAppDel.isKLineDarkModel;
    [self refreshUIStyle];
}
-(void)refreshUIStyle
{
    _model.isHaveSelected =  ![[SelfCollectArrayModel sharedSelfCollectArrayModel]checkCoinCanAddCollect:_model.fShortName andMarketType:_marketCoinType];
    if (TheAppDel.isKLineDarkModel)
    {
        self.headView.backgroundColor = UIColorFromRGB(0x000000);//假导航背景
        [self.headView refreshBottomLineViewColor:UIColorFromRGB(0x535353)];//假导航的底线
        self.txtTitle.textColor = UIColorFromRGB(0xffffff);//假导航标题
        self.view.backgroundColor = self.stockChartView.backgroundColor = UIColorFromRGB(0x000000);//VC背景、K线父视图背景
        _boomSuperView.backgroundColor = UIColorFromRGB(0x000000);//底部三按钮父视图
        boomLine.backgroundColor = UIColorFromRGB(0x535353);//底部顶线
        
        [_addCollectButton setImage:(_model.isHaveSelected?kIMAGE_NAMED(@"deleteMark_Black"): kIMAGE_NAMED(@"addMarket_Black")) forState:UIControlStateNormal];
        [_addCollectButton setTitle:(_model.isHaveSelected?@"删自选":@"添加自选") forState:UIControlStateNormal];
        [_addCollectButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    }else{
        self.headView.backgroundColor = UIColorFromRGB(0xffffff);
        [self.headView refreshBottomLineViewColor:UIColorFromRGB(0xb4bdd3)];
        self.txtTitle.textColor = UIColorFromRGB(0x333333);
        self.view.backgroundColor = self.stockChartView.backgroundColor = WhiteColor;
        _boomSuperView.backgroundColor = WhiteColor;
        boomLine.backgroundColor = UIColorFromRGB(0xb4bdd3);
        
        [_addCollectButton setImage:(_model.isHaveSelected?kIMAGE_NAMED(@"deleteMark"):kIMAGE_NAMED(@"addMarket")) forState:UIControlStateNormal];
        [_addCollectButton setTitle:(_model.isHaveSelected?@"删自选":@"添加自选") forState:UIControlStateNormal];
        [_addCollectButton setTitleColor:MainThemeColor forState:UIControlStateNormal];
    }
    self.changeWhiteBlackButton.selected = self.addCollectButton.selected = TheAppDel.isKLineDarkModel;//切换黑白按钮、收藏按钮
    [self.detailHeadView setIsBlack:TheAppDel.isKLineDarkModel];//顶部行情样式
    [self.stockChartView.segmentView refreshUI];//K线菜单区
    [self.stockChartView.kLineView refreshUI];//K线区域所有子视图背景切换
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)addCollectButtonAction:(UIButton *)button{
    if (_model.isHaveSelected) {
        [[SelfCollectArrayModel sharedSelfCollectArrayModel]deleteDataSourceIndex:@[_model.fShortName] inMarketType:_marketCoinType];
        [UIViewController showPromptHUDWithTitle:NSLocalizedString(@"删除自选成功！", nil)];

    }else{
        [[SelfCollectArrayModel sharedSelfCollectArrayModel]addCoin:_model.fShortName andMarketType:_marketCoinType];
        [UIViewController showPromptHUDWithTitle:NSLocalizedString(@"添加自选成功！", nil)];
    }
    [self refreshUIStyle];
}

- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}

#pragma mark --------- K线 deleget -----------
-(id) stockDatasWithIndex:(NSInteger)index
{
    NSString *type;
    switch (index) {
        case 0:
            type = @"MIN5";
            break;
        case 1:
            type = @"MIN5";
            break;
        case 2:
            type = @"MIN15";
            break;
        case 3:
            type = @"MIN30";
            break;
        case 4:
            type = @"HOUR";
            break;
        case 5:
            type = @"DAY";
            break;
        case 6:
            type = @"DAY";
            break;
        default:
            break;
    }
    
    self.type = type;
    if(![self.modelsDict objectForKey:type])
    {
        [self.modelsDict removeAllObjects];//清理其他菜单项的数据
        [self reloadData];
    } else {
        Y_KLineGroupModel* dic = [self.modelsDict objectForKey:type];
        return [self.modelsDict objectForKey:type].models;//请求后delegate返回数据给KLine，或者重复点按相同菜单项
    }
    return nil;
}

-(NSInteger)timeUnitForType{
    if ([self.type isEqualToString:@"MIN5"]) {
        return 300;
    }else if ([self.type isEqualToString:@"MIN15"]){
        return 900;
    }
    else if ([self.type isEqualToString:@"MIN30"]){
        return 1800;
    }
    else if ([self.type isEqualToString:@"HOUR"]){
        return 3600;
    }
    else if ([self.type isEqualToString:@"DAY"]){
        return 86400;
    }

    return 300;
}

- (void)reloadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"interval"] = self.type;
//    param[@"symbol"] = _model.fCoinType;
//    param[@"limit"] = @"1000";
//
//    NSString * urlStr = [NSString stringWithFormat:@"%@/api/v1/klines",KLineUrlHead];
    param[@"interval"] = self.type;
    param[@"ID"] = _model.fCoinType;
    param[@"limit"] = @"1000";
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/api/v1/KL",KLineUrlHead];
    __weak typeof(self)weakSelf = self;

    [self showLoadingMBProgressHUD];
    
    [NetWorking requestWithApi:urlStr param:param thenSuccess:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject];
        [weakSelf.modelsDict setObject:groupModel forKey:weakSelf.type];
        [weakSelf.stockChartView reloadData];
        
    } fail:^{
        [weakSelf hideMBProgressHUD];
    }];
}

- (Y_StockChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"15分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"30分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"小时" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"日线" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"指标" type:Y_StockChartcenterViewTypeOther]
                                       ];
        _stockChartView.dataSource = self;
        [self.view addSubview:_stockChartView];
    }
    return _stockChartView;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
- (BOOL)shouldAutorotate
{
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation ==UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor backgroundColor];
        _boomSuperView.hidden = NO;
        [self setHeadViewHidden:NO];
        _detailHeadView.hidden = NO;
        [_stockChartView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(85 + StatusBarHeight + NaviBarHeight, 0, BottomHeight - _rotaedProti_boom, 0));
        }];
    }else{
        self.view.backgroundColor = [UIColor backgroundColor];
        _boomSuperView.hidden = YES;
        [self setHeadViewHidden:YES];
        _detailHeadView.hidden = YES;
        [_stockChartView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, _rotaedLeft_x, 0, 0));
        }];
    }
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.stockChartView.kLineView refreshUI];//K线区域所有子视图背景切换

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return TheAppDel.isKLineDarkModel ?UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

@end
