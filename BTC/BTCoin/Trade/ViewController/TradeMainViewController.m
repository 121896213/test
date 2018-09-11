//
//  TradeSubPageViewController.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "TradeMainViewController.h"
#import "TradeCoinMessageView.h"
#import "TradeSevenTableViewCell.h"
#import <SRWebSocket.h>
#import "LoginViewController.h"
#import "MyWalletModel.h"
#import "NSString+Regex.h"
#import "SZPropertyRechargeViewController.h"
#import "MarketHomeListModel.h"
#import "TradeTypeButton.h"
#import "TradeWalletView.h"
#import "TradeChoiceCoinView.h"
#import "ApplyViewController.h"
#import "SZTradePasswordView.h"

#define kSelectStoreActionButtonBeginTag 7828

@interface TradeMainViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SRWebSocketDelegate>{
    UIAlertAction * _ensureAction;//输入交易密码后，点确定
}
 
//关键标识符
@property (nonatomic,assign)BOOL isBuy;//YES为买，NO为卖
@property (nonatomic,assign)BOOL isLimit;//YES为限价交易，NO为市价交易

//websocket
@property (nonatomic,strong)SRWebSocket * webSocket;  //webSocket
@property (nonatomic,strong)NSTimer * heartBeat;//webSocket心跳
@property (nonatomic,assign)NSTimeInterval reConnectTime;//重连次数

//顶部
@property (nonatomic,strong)UIButton * buyButton;//买入
@property (nonatomic,strong)UIButton * selButton;//卖出

//币种基本信息
@property (nonatomic,strong)TradeCoinMessageView * topView;//显示币种信息
@property (nonatomic,strong)TradeChoiceCoinView * choiceCoinView;//下拉选择币种
@property (nonatomic,strong)MarketHomeListModel * selectedModel;//已选择的币币model

@property (nonatomic,strong)UIScrollView * scrollView;  //底层可滑动

//左侧控件
@property (nonatomic,strong)UIView * leftSuperView;  //左边父视图
@property (nonatomic,strong)TradeTypeButton * limitTradeButton;  //限价交易类型按钮
@property (nonatomic,strong)TradeTypeButton * marketTadeButton;  //市价交易类型按钮
@property (nonatomic,strong)UITextField * priceTF;  //价格输入框
@property (nonatomic,strong)UIButton * priceTF_left_Button;//价格输入框——减
@property (nonatomic,strong)UIButton * priceTF_right_Button;//价格输入框——加
@property (nonatomic,strong)UITextField * numberTF;  //数量输入框
@property (nonatomic,strong)UILabel * realAmountTitleLabel;//"交易额"label
@property (nonatomic,strong)UILabel * realAmountLabel;//交易额 数值 label
@property (nonatomic,strong)UIButton * buyOrSelButton;//买入、卖出（根据不同的条件切换）

//左侧底部钱包信息
@property (nonatomic,strong)TradeWalletView * walletView;
@property (nonatomic,strong)MyWalletModel * myWallet;//我的钱包（包含基准币、交易币的信息），登录并选择币币类型后，获取

//又侧控件
@property (nonatomic,strong)UITableView * tableView;   //右边tableview，展示七档信息
@property (nonatomic,strong)TradeSevenTableViewCell * firstSectionHeaderView;// first section headerView
@property (nonatomic,strong)UIView * secSectionHeaderView;// second section headerView
@property (nonatomic,strong)NSMutableArray * dataSource;//tableview DataSource（来源于websocket）

@end

@implementation TradeMainViewController

#pragma mark ----- 页面消失、程序进入后台、激活
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self destroyWebsocket];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(destroyWebsocket) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reConnect) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    if (KUserSingleton.bIsLogin){
        [self getMyBalance];
    }else{
        self.myWallet = nil;
        [self.walletView refreshWalletViewWithModel:_myWallet :_isBuy :_selectedModel];
    }

    [self destroyWebsocket];
    [self.webSocket open];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMarketDataNotifaction:) name:kGetMarketDataNotifaction object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listenMarkDetailJumpToHere:) name:@"MarkDetailJumpToTradeNotification" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(listenPropertyDetailJumpToHere:) name:@"SZPropertyDetailToTradeNotification" object:nil];
    
    _isLimit = YES;
    self.isBuy = YES;
    self.dataSource = (NSMutableArray *)[SevenBuyOrSelDataModel getDefaultNodata];
    [self.tableView reloadData];
    [self requestData];
}

-(void)getMarketDataNotifaction:(NSNotification *)noti
{
    if (!_selectedModel) {
        return;
    }
    NSDictionary * dict = noti.userInfo;
    NSInteger stockId = [dict[@"ID"] integerValue];

    if ([_selectedModel.fCoinType integerValue] == stockId) {
        [_selectedModel refreshDataWithDict:dict];
        [self.topView refreshViewWithModel:_selectedModel];
    }
}

-(void)listenMarkDetailJumpToHere:(NSNotification *)noti
{
    if ([TradeCommonModel sharedTradeCommonModel].tradeVCType == TradeVCTypeBuy) {
        self.isBuy = YES;
    }else{
        self.isBuy = NO;
    }
    self.selectedModel = [TradeCommonModel sharedTradeCommonModel].model;
    [self.topView refreshViewWithModel:self.selectedModel];
}
//-(void)listenPropertyDetailJumpToHere:(NSNotification *)noti{
//
//}


#pragma mark  -------获取我的钱包余额
-(void)getMyBalance
{
    if (!_selectedModel) {
        return;
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/userWallet.do",BaseHttpUrl];
    
//    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:@{@"symbol":_selectedModel.fCoinType} bodyParameters:nil successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            NSDictionary * dict = responseObject[@"data"];
            MyWalletModel * model = [MyWalletModel new];
            [model mj_setKeyValues:dict];
            weakSelf.myWallet = model;
        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        
    }];
}

-(void)setMyWallet:(MyWalletModel *)myWallet{
    _myWallet = myWallet;
    [self.walletView refreshWalletViewWithModel:_myWallet :_isBuy :_selectedModel];

    if (!_myWallet) {
        _realAmountLabel.text = @"";
        return;
    }
    double maxValue = 0;
    if (_isBuy) {
        maxValue = [_myWallet.ftotalType doubleValue];
    }else{
        maxValue = [_myWallet.ftotal doubleValue];
    }
    if (_realAmountLabel.text.length > 0) {
        if ([_realAmountLabel.text doubleValue] > maxValue) {
            _numberTF.text = @"";
            _realAmountLabel.text = @"";
        }
    }
}

-(void)requestData
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/market.do",BaseHttpUrl];
    
    NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [mDict setValue:@(1) forKey:@"currentPage"];
    [mDict setValue:@"USDT" forKey:@"fShortName"];
    [mDict setValue:@(2) forKey:@"typeFid"];
    
    [self showLoadingMBProgressHUD];
    
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager get:urlStr appendParameters:mDict successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            NSArray * array = responseObject[@"list"];
            double  quotes = [responseObject[@"quotes"] doubleValue];
            if (array.count > 0) {
                NSDictionary * dict = array[0];
                MarketHomeListModel * model = [[MarketHomeListModel alloc]init];
                [model mj_setKeyValues:dict];
                model.quotes = quotes;
                model.areaName = @"USDT";
                weakSelf.selectedModel =model;
                [weakSelf.topView refreshViewWithModel:model];
            }
        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
    }];
}


#pragma mark -------- step1 选择买/卖
-(void)menuAction:(UIButton *)button
{
    if (button == self.buyButton) {
        self.isBuy = YES;
    }else{
        self.isBuy = NO;
    }
}

- (void)setIsBuy:(BOOL)isBuy{
    _isBuy = isBuy;
    self.selButton.backgroundColor = _isBuy ? WhiteColor:HomeLightColor;
    self.buyButton.backgroundColor = _isBuy ? HomeLightColor:WhiteColor;
    self.selButton.selected = !_isBuy;
    self.buyButton.selected = _isBuy;
    _buyOrSelButton.backgroundColor = _isBuy ? UIColorFromRGB(0x03c087):UIColorFromRGB(0xFF6333);
    [_buyOrSelButton setTitle:NSLocalizedString((_isBuy ?@"买入":@"卖出"), nil) forState:UIControlStateNormal];
    self.isLimit = self.isLimit;
    
    [self.walletView refreshWalletViewWithModel:_myWallet :_isBuy :_selectedModel];
}
#pragma mark -------- step2 选择币种（socket更新最新价、买卖七档数据）
//在_topView的block事件中
-(void)setSelectedModel:(MarketHomeListModel *)selectedModel{
    _selectedModel = selectedModel;
    self.isLimit = self.isLimit;
    _dataSource = [NSMutableArray arrayWithArray:[SevenBuyOrSelDataModel getDefaultNodata]];
    [self.tableView reloadData];
    [self selectStoreAction:nil];

    if (_selectedModel && self.webSocket.readyState == SR_OPEN) {
//        NSDictionary * dict = @{@"symd":@{@"stockId":@([_selectedModel.fCoinType intValue])}};
        NSDictionary * dict = @{@"symd":@{@"ID":@([_selectedModel.fCoinType intValue])}};
        NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
        [self sendData:data];
        
        [[SZSocket sharedSZSocket]orderMessage:_selectedModel.fCoinType];
    }
    if (KUserSingleton.bIsLogin) {
        [self getMyBalance];
    }
}
#pragma mark -------- step3 选择交易类型
-(void)changeTradeTypeAction:(UIButton *)button{
    if (button == _marketTadeButton) {
        self.isLimit = NO;
    }else{
        self.isLimit = YES;
    }
}

-(void)setIsLimit:(BOOL)isLimit{
    _isLimit = isLimit;
    if (_isLimit) {
        if (!_priceTF_left_Button) {
            _priceTF_left_Button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 43)];
            [_priceTF_left_Button addTarget:self action:@selector(changePriceAction:) forControlEvents:UIControlEventTouchUpInside];
            [_priceTF_left_Button setImage:kIMAGE_NAMED(@"price_jian") forState:UIControlStateNormal];
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(39, 0, 1, 43)];
            line.backgroundColor = UIColorFromRGB(0xBABFCC);
            [_priceTF_left_Button addSubview:line];
            
            _priceTF_right_Button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 43)];
            [_priceTF_right_Button addTarget:self action:@selector(changePriceAction:) forControlEvents:UIControlEventTouchUpInside];
            [_priceTF_right_Button setImage:kIMAGE_NAMED(@"price_jia") forState:UIControlStateNormal];
            UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 43)];
            line2.backgroundColor = UIColorFromRGB(0xBABFCC);
            [_priceTF_right_Button addSubview:line2];
        }
        _priceTF.leftView = _priceTF_left_Button;
        _priceTF.leftViewMode = UITextFieldViewModeAlways;
        _priceTF.rightView = _priceTF_right_Button;
        _priceTF.rightViewMode = UITextFieldViewModeAlways;
        _priceTF.textAlignment = NSTextAlignmentCenter;
        
        _marketTadeButton.selected = NO;
        _limitTradeButton.selected = YES;
        _realAmountTitleLabel.hidden = NO;
        _realAmountLabel.hidden = NO;
    }else{
        _priceTF.rightViewMode = UITextFieldViewModeNever;
        UIView * placeholdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 1)];
        _priceTF.leftView = placeholdView;
        _priceTF.leftViewMode = UITextFieldViewModeAlways;
        _priceTF.textAlignment = NSTextAlignmentLeft;
        
        _marketTadeButton.selected = YES;
        _limitTradeButton.selected = NO;
        _realAmountTitleLabel.hidden = YES;
        _realAmountLabel.hidden = YES;
    }
    
    NSString * string = _isBuy ? @"买入":@"卖出";
    if (_isLimit) {
        _priceTF.placeholder = NSLocalizedString(@"价格",nil);
        _priceTF.text = _selectedModel.fNewDealPrice;
        _numberTF.placeholder = NSLocalizedString(FormatString(@"%@量",string),nil);
    }else{
        _priceTF.text = NSLocalizedString(FormatString(@"以市场最优价格%@",string),nil);
        _numberTF.placeholder = NSLocalizedString(_isBuy ? @"交易额":@"卖出量",nil);
    }
    _numberTF.text = @"";
    _priceTF.enabled = _isLimit;
    _realAmountLabel.text = @"";
    [self selectStoreAction:nil];
}

#pragma mark -------- step3 检测输入数据 TextfieldDelegate
-(void)changePriceAction:(UIButton *)button//价格微调
{
    [self selectStoreAction:nil];

    if (_priceTF.text.length == 0) {
        return;
    }
    NSDecimalNumber * sourceDecimalNumber = [[NSDecimalNumber alloc]initWithString:_priceTF.text];
    NSDecimalNumber * decimalNumber = [[NSDecimalNumber alloc]initWithString:@"1"];
    decimalNumber = [decimalNumber decimalNumberByMultiplyingByPowerOf10:(-_selectedModel.fcount1)];
    
    if (button == _priceTF_left_Button) {//-
        if ([sourceDecimalNumber compare:decimalNumber] != NSOrderedDescending) {
            _priceTF.text = @"";
            return ;
        }else{
            sourceDecimalNumber = [sourceDecimalNumber decimalNumberBySubtracting:decimalNumber];
        }
    }else{//+
        sourceDecimalNumber = [sourceDecimalNumber decimalNumberByAdding:decimalNumber];
    }
    _priceTF.text = sourceDecimalNumber.stringValue;
    [self dealValueChangeTwo];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
 
    
    [self selectStoreAction:nil];

    NSMutableString *futureString = [NSMutableString stringWithString:textField.text];
    [futureString insertString:string atIndex:range.location];
    
    if (futureString.length > 0) {
        if (![futureString isValidFloat]) {
            [self showPromptHUDWithTitle:NSLocalizedString(@"请输入正确的数值!", nil)];
            dispatch_async(dispatch_get_main_queue(), ^{
                textField.text = @"";
                [textField becomeFirstResponder];
            });
            return NO;
        }else{
            NSArray * arr = [futureString componentsSeparatedByString:@"."];
            if (arr.count == 2) {
                NSString * pointStr = arr[1];
                if (textField == _numberTF )
                {
                    //买入-限价，数量输入的是金额
                    if (_isBuy && !_isLimit && pointStr.length > _selectedModel.fcount1) {
                        NSString * tip = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"最多允许", nil),_selectedModel.fcount1,NSLocalizedString(@"位小数", nil)];
                        [self showPromptHUDWithTitle:tip];
                        return NO;
                    }else if (pointStr.length > _selectedModel.fcount2)
                    {
                        NSString * tip = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"最多允许", nil),_selectedModel.fcount2,NSLocalizedString(@"位小数", nil)];
                        [self showPromptHUDWithTitle:tip];
                        return NO;
                    }
                }
                else if (textField == _priceTF && pointStr.length > _selectedModel.fcount1)
                {
                    NSString * tip = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"最多允许", nil),_selectedModel.fcount1,NSLocalizedString(@"位小数", nil)];
                    [self showPromptHUDWithTitle:tip];
                    return NO;
                }
            }
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dealValueChangeTwo];
    });
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        if (![textField.text isValidFloat]) {
            [self showPromptHUDWithTitle:NSLocalizedString(@"请输入正确的数值!", nil)];
            dispatch_async(dispatch_get_main_queue(), ^{
                textField.text = @"";
                [textField becomeFirstResponder];
            });
        }else{
            [self dealValueChangeTwo];
        }
    }
}

-(void)dealValueChangeTwo
{
    _realAmountLabel.text = @"";
    
    if (!_selectedModel || _priceTF.text.length == 0 || _numberTF.text.length == 0)//没用选择具体币，或者没有输入价格/数量
    {
        return;
    }
    
    double totalMoney = 0;
    double totalNum = 0;
    
    if (!_isLimit) {
        totalNum = totalMoney = [_numberTF.text doubleValue];
    }else{
        totalMoney = [_priceTF.text doubleValue] *[_numberTF.text doubleValue];
        if (_isBuy) {
            totalNum = totalMoney;
        }else{
            totalNum = [_numberTF.text doubleValue];
        }
    }
    
//    NSString *format = [NSString stringWithFormat:@"%%.%df %%@",_selectedModel.fcount1];
    NSString *format = [NSString stringWithFormat:@"%%.%df %%@",USDT_MAX_Points];

    NSString * coninType = _selectedModel.areaName;
    _realAmountLabel.text = [NSString stringWithFormat:format,totalMoney,coninType];
    
    if (!_myWallet) {
        return;
    }
    
    double maxValue = 0;
    if (_isBuy) {
        maxValue = [_myWallet.ftotalType doubleValue];
    }else{
        maxValue = [_myWallet.ftotal doubleValue];
    }
    if (totalNum > maxValue) {
        [self showPromptHUDWithTitle:NSLocalizedString(@"交易额大于您的余额，请重新输入!", nil)];
        _numberTF.text = @"";
        _realAmountLabel.text = @"";
    }else{
        
    }
}

#pragma mark -------- step3/2 选择仓存
-(void)selectStoreAction:(UIButton *)button{
    for (NSInteger i = 0; i< 4; i++) {
        UIButton * but =  [self.leftSuperView viewWithTag:(kSelectStoreActionButtonBeginTag + i)];
        if (but == button) {
            but.selected = YES;
            but.backgroundColor = HomeLightColor;
            [self dealData:i];
        }else{
            but.selected = NO;
            but.backgroundColor = WhiteColor;
        }
    }
}

-(void)dealData:(StorePercent)storePercent{
    if (!_myWallet) {
        [self selectStoreAction:nil];
        return;
    }
    CGFloat num = 0;
    NSInteger maxPoint = _selectedModel.fcount2;
    if (_isLimit){
        if (_isBuy){
            if (_priceTF.text.length <= 0 || [_priceTF.text doubleValue] < 0.000001) {
                [self showErrorHUDWithTitle:@"请输入价格"];
                [self selectStoreAction:nil];
                return;
            }else{
                num =  [_myWallet.ftotalType doubleValue] / [_priceTF.text doubleValue];
            }
        }else{
            num = [_myWallet.ftotal doubleValue];
        }
    }
    else{
        num =  _isBuy ? [_myWallet.ftotalType doubleValue] : [_myWallet.ftotal doubleValue];
        if (_isBuy) {
            maxPoint = _selectedModel.fcount1;
        }
    }
    
    switch (storePercent) {
        case StorePercentAll:
            break;
        case StorePercentHalf:
            num = num /2.0;
            break;
        case StorePercentOneForThird:
            num = num /3.0;
            break;
        case StorePercentOneForFive:
            num = num /5.0;
            break;
        default:
            break;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = maxPoint;
    formatter.minimumIntegerDigits = 1;
    _numberTF.text = [formatter stringFromNumber:@(num)];
    
    double useMoney = [_priceTF.text doubleValue] * [_numberTF.text doubleValue];
    NSString * coinName = _selectedModel.areaName;
//    NSString *format = [NSString stringWithFormat:@"%%.%df %%@",_selectedModel.fcount1];
    NSString *format = [NSString stringWithFormat:@"%%.%df %%@",USDT_MAX_Points];
    _realAmountLabel.text = [NSString stringWithFormat:format,useMoney,coinName];
}

#pragma mark -------- step4 买/卖
-(void)buyOrSelButtonDidClicked:(UIButton *)button{
    [self.view endEditing:YES];
    //买卖步骤： 是否登录-->是否通过身份认证-->选择及输入相关交易信息-->输入交易密码-->调用买卖接口
    if (KUserSingleton.bIsLogin) {
        if (KUserSingleton.idAuthStatus == 0) {
            if ([self checkCanGoNext]) {
//                [self inputTradePassWord];
                SZTradePasswordView* tradePasswordView=[[SZTradePasswordView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,FIT(250))];
                __weak typeof(self)weakSelf = self;
                tradePasswordView.confirmBlock = ^(NSString *password) {
                    [weakSelf packParametersWithPWD:password];

                };
                [tradePasswordView showInView:TheAppDel.window.rootViewController.view directionType:SZPopViewFromDirectionTypeBottom];
            }
        }else{
            [UIViewController showPromptHUDWithTitle:NSLocalizedString(@"温馨提示：您还未进行身份认证，请先认证！", nil)];
            [self.tabBarController setSelectedIndex:4];
        }
    }
    else
    {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        GFNavigationController * loginNav = [[GFNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNav animated:YES completion:nil];
    }
}

#pragma mark ---- 检测输入
-(BOOL)checkCanGoNext
{
    if (!_selectedModel) {//选择了币币交易的种类
        [self showPromptHUDWithTitle:NSLocalizedString(@"请选择币种", nil)];
        return NO;
    }
    if (_isLimit && self.priceTF.text.length ==0) {//限价交易，设定了价格
        [self showPromptHUDWithTitle:NSLocalizedString(@"请输入价格", nil)];
        return NO;
    }
    if (_numberTF.text.length == 0) {//设定了数量
        [self showPromptHUDWithTitle:NSLocalizedString(@"请输入数量", nil)];
        return NO;
    }
    return YES;
}

-(void)inputTradePassWord{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"请输入交易密码", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = YES;
        [textField addTarget:self action:@selector(inputValueDidChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    UIAlertAction * action = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    _ensureAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField * tf =  alert.textFields.firstObject;
        [self packParametersWithPWD:tf.text];
    }];
    _ensureAction.enabled = NO;
    [alert addAction:action];
    [alert addAction:_ensureAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)inputValueDidChange:(UITextField *)textField{
    if (textField.text.length >= 6) {
        _ensureAction.enabled = YES;
    }else{
        _ensureAction.enabled = NO;
    }
}

-(void)packParametersWithPWD:(NSString * )passWord
{
    NSMutableDictionary * mDict = [NSMutableDictionary dictionary];
    [mDict setValue:[AppUtil md5:passWord]forKey:@"tradePwd"];
    [mDict setValue:_numberTF.text forKey:@"tradeAmount"];
    [mDict setValue:(_isLimit ? _priceTF.text:@(0)) forKey:@"tradeCnyPrice"];
    [mDict setValue:(_isLimit ? @(0):@(1)) forKey:@"limited"];
    [mDict setValue:_selectedModel.fCoinType forKey:@"symbol"];
    
    _isBuy ?[self buyCoinWithPara:mDict]: [self selCoinWithPara:mDict];
}

-(void)buyCoinWithPara:(NSDictionary *)para
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/buyBtcSubmit.do",BaseHttpUrl];
    
    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:para bodyParameters:nil successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            [weakSelf showErrorHUDWithTitle:base.msg];
        }else{
            [weakSelf showErrorHUDWithTitle:base.errorMessage];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf getMyBalance];
        });
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        
    }];
}

-(void)selCoinWithPara:(NSDictionary *)para
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/sellBtcSubmit.do",BaseHttpUrl];
    
    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:para bodyParameters:nil successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            [weakSelf showErrorHUDWithTitle:base.msg];
        }else{
            [weakSelf showErrorHUDWithTitle:base.errorMessage];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf getMyBalance];
        });
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        
    }];
}

#pragma mark -------- 构建页面
-(void)configSubViews
{
    [self.btnLeft removeFromSuperview];
    [self.headView removeBoomLine];
    UIView *  _superForMenuView = [[UIView alloc] init];
    _superForMenuView.layer.borderColor = HomeLightColor.CGColor;
    _superForMenuView.layer.borderWidth = 1.0f;
    _superForMenuView.layer.cornerRadius = 2.0f;
    _superForMenuView.clipsToBounds = YES;
    [self.headView addSubview:_superForMenuView];
    [_superForMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-7);
        make.centerX.mas_equalTo(self.headView.mas_centerX);
    }];
    
    NSArray * array = @[@"买入",@"卖出"];
    CGFloat each_w = 80;
    for (int i = 0; i< array.count; i++) {
        NSString * area = [array objectAtIndex:i];
        area = NSLocalizedString(area, nil);
        UIButton * button = [[UIButton alloc]init];
        [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
        [button setTitleColor:HomeLightColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:area forState:UIControlStateNormal];
        [_superForMenuView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.leading.mas_equalTo(each_w * i);
            make.width.mas_equalTo(each_w);
        }];
        if (i == 0) {
            self.buyButton = button;
            button.selected = YES;
            button.backgroundColor = HomeLightColor;
        }else{
            self.selButton = button;
        }
    }
    
    _topView = [[TradeCoinMessageView alloc]init];
    __weak typeof(self)weakSelf = self;
    _topView.changeCoinBlock = ^{
        if (weakSelf.choiceCoinView.superview) {
            [weakSelf.choiceCoinView removeSelf];
        }else{
            [weakSelf.choiceCoinView showInView:weakSelf.view];
        }
    };
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.height.mas_equalTo(53);
    }];
    
    UIColor * currentBackColor = [UIColor whiteColor];
    //底层Scroll
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = currentBackColor;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    
    UIView * scrollContentView = [UIView new];
    [_scrollView addSubview:scrollContentView];
    scrollContentView.backgroundColor = currentBackColor;
    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.top.mas_equalTo(0);
//        make.height.mas_equalTo(540);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    //左边父视图
    CGFloat leftW = kScreenWidth/2.0 + 0;
    _leftSuperView = [UIView new];
    _leftSuperView.backgroundColor = currentBackColor;
    [scrollContentView addSubview:_leftSuperView];
    [_leftSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(leftW);
//        make.height.mas_equalTo(540);
    }];
    
    //选择交易方式《快速交易、限价委托》
    CGFloat buttonW = leftW / 2 - 18;
    _limitTradeButton = [self createButton:@"限价交易"];
    [_limitTradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(buttonW);
        make.height.mas_equalTo(30);
    }];
    
    _marketTadeButton = [self createButton:@"市价交易"];
    [_marketTadeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.limitTradeButton.mas_trailing).offset(20);
        make.top.height.width.mas_equalTo(self.limitTradeButton);
    }];

    //输入价格、线条、输入数量、币种、线条、可用余币
    _priceTF = [self createTextFieldWithPlaceholder:@"价格"];
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.marketTadeButton.mas_bottom).offset(10);
        make.height.mas_equalTo(43);
    }];
    
    _numberTF = [self createTextFieldWithPlaceholder:@"数量"];
    [_numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.mas_equalTo(self.priceTF);
        make.top.mas_equalTo(self.priceTF.mas_bottom).offset(20);
    }];
    buttonW = leftW /4.0 - 15;
//    NSArray *
    array = @[@"全仓",@"半仓",@"1/3",@"1/5"];
    for (int i = 0; i < 4; i++) {
        UIButton * button = [[UIButton alloc]init];
        [button addTarget:self action:@selector(selectStoreAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.font = kFontSize(12);
        [button setTitle:NSLocalizedString(array[i], nil) forState:UIControlStateNormal];
        button.tag = kSelectStoreActionButtonBeginTag + i;
        button.layer.cornerRadius = 3.0f;
        button.layer.borderWidth = 0.5f;
        button.layer.borderColor = UIColorFromRGB(0xBABFCC).CGColor;
        [_leftSuperView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(16 + (buttonW + 15)*i);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(buttonW);
            make.top.mas_equalTo(_numberTF.mas_bottom).offset(20);
        }];
    }
    
    _realAmountTitleLabel = [self createLabelWithTextColor:UIColorFromRGB(0x999999) font:[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
    _realAmountTitleLabel.text = NSLocalizedString(@"交易额: ", nil);
    [_leftSuperView addSubview:_realAmountTitleLabel];
    [_realAmountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(_numberTF.mas_bottom).offset(60);
    }];
    
    _realAmountLabel = [self createLabelWithTextColor:UIColorFromRGB(0x333333) font:[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
    [_leftSuperView addSubview:_realAmountLabel];
    [_realAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_realAmountTitleLabel.mas_trailing);
        make.top.mas_equalTo(_realAmountTitleLabel.mas_top);
    }];
    
    _buyOrSelButton = [[UIButton alloc]init];
    _buyOrSelButton.layer.cornerRadius = 3.0f;
    [_buyOrSelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buyOrSelButton addTarget:self action:@selector(buyOrSelButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_leftSuperView addSubview:_buyOrSelButton];
    [_buyOrSelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_realAmountTitleLabel.mas_bottom).offset(20);
        make.leading.mas_equalTo(16);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(43);
    }];
    
    _walletView = [[TradeWalletView alloc]init];
    [_leftSuperView addSubview:_walletView];
    [_walletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(_buyOrSelButton.mas_bottom).offset(10);
        make.height.mas_equalTo(260);
    }];
    
    [scrollContentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_leftSuperView.mas_trailing).offset(24);
        make.top.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.height.mas_equalTo(470);
//        make.width.mas_equalTo(kScreenWidth/2.0-16);
    }];
    _scrollView.contentSize = CGSizeMake(kScreenWidth,580);
}

#pragma mark ----- 快捷、共用 创建视图
-(TradeTypeButton *)createButton:(NSString *)title
{
    TradeTypeButton * button = [[TradeTypeButton alloc]init];
    [button addTarget:self action:@selector(changeTradeTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:kIMAGE_NAMED(@"tradeTypeUnSel") forState:UIControlStateNormal];
    [button setImage:kIMAGE_NAMED(@"tradeTypeSel") forState:UIControlStateSelected];
    [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateSelected];
    [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    [_leftSuperView addSubview:button];
    return button;
}

/**创建label*/
-(UILabel *)createLabelWithTextColor:(UIColor *)color font:(UIFont *)font
{
    UILabel * label = [UILabel new];
    //    label.text = NSLocalizedString(text, nil);
    label.font = font;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = color;
    return label;
}

-(UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField * tf = [[UITextField alloc]init];
    tf.textColor = UIColorFromRGB(0x333333);
    tf.placeholder =NSLocalizedString(placeholder, nil);
    tf.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    tf.keyboardType = UIKeyboardTypeDecimalPad;
    tf.adjustsFontSizeToFitWidth = YES;
    tf.layer.cornerRadius = 3.0f;
    tf.minimumFontSize = 8;
    tf.layer.borderWidth = 0.5f;
    tf.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    tf.delegate = self;
    UIView * placeholdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 1)];
    tf.leftView = placeholdView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    [_leftSuperView addSubview:tf];
    return tf;
}

#pragma mark ----- WebSocketDelegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"Received \"%@\"", message);
    if (!_selectedModel) {
        return;
    }
    self.dataSource = [NSMutableArray arrayWithArray:[SevenBuyOrSelDataModel dealDataFromSocket:message compareModel:_selectedModel]];
    [self.tableView reloadData];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    _reConnectTime = 0;
    [self init_heartBeat];
    if (_selectedModel) {
//        NSDictionary * dict = @{@"symd":@{@"stockId":@([_selectedModel.fCoinType intValue])}};
        NSDictionary * dict = @{@"symd":@{@"ID":@([_selectedModel.fCoinType intValue])}};
        NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
        [self sendData:data];
    }
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"Received \"%@\"", error);
    [self reConnect];
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    _webSocket.delegate = nil;
    _webSocket = nil;
    [self destory_heartBeat];
}
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply===%@",reply);
}

-(void)destroyWebsocket{
    if (_webSocket) {
        _webSocket.delegate = nil;
        [_webSocket close];
        _webSocket = nil;
    }
    [self destory_heartBeat];
}

#pragma mark -------webSocket重连等相关
- (void)reConnect
{
    [self destroyWebsocket];
    if (_reConnectTime > 64) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _webSocket = nil;
        [self.webSocket open];
    });
    
    if (_reConnectTime == 0) {
        _reConnectTime = 2;
    }else{
        _reConnectTime *= 2;
    }
}

-(void)sendPingMessage{
    [self sendData:@"heart"];
}
- (void)sendData:(id)data
{
    __weak typeof(self)weakSelf = self;
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    dispatch_async(queue, ^{
        if (weakSelf.webSocket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法，不然要崩
            if (weakSelf.webSocket.readyState == SR_OPEN) {
                if ([[data class]isKindOfClass:[NSString class]]) {
                    [weakSelf.webSocket sendPing:nil];
                }else{
                    [weakSelf.webSocket send:data];    // 发送数据
                }
            } else if (weakSelf.webSocket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                [self reConnect];
            } else if (weakSelf.webSocket.readyState == SR_CLOSING || weakSelf.webSocket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                [self reConnect];
            }
        } else {
            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
        }
    });
}

- (void)init_heartBeat
{
    dispatch_main_async_safe(^{
        [self destory_heartBeat];
        _heartBeat = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(sendPingMessage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_heartBeat forMode:NSRunLoopCommonModes];
    })
}
//取消心跳
- (void)destory_heartBeat
{
    dispatch_main_async_safe(^{
        if (_heartBeat) {
            [_heartBeat invalidate];
            _heartBeat = nil;
        }
    })
}

#pragma mark ----- 买卖七档 TableViewDelegate/DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TradeSevenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTradeSevenTableViewCellReusedID forIndexPath:indexPath];
    [cell setCellType:indexPath.section == 0 ?TradeSevenTableViewCellTypeSel: TradeSevenTableViewCellTypeBuy];
    [cell setCellWithModel:_dataSource[indexPath.section][indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SevenBuyOrSelDataModel * model = self.dataSource[indexPath.section][indexPath.row];
    if (![model.price isEqualToString:@"--"] && _isLimit) {
        [self selectStoreAction:nil];
        self.priceTF.text = model.price;
        [self dealValueChangeTwo];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        [self.firstSectionHeaderView setMarket:_selectedModel.areaName andCoinName:_selectedModel.fShortName];
        return self.firstSectionHeaderView;
    }else{
        return self.secSectionHeaderView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 20 : 30;
}

#pragma mark -------切换币种View
-(TradeChoiceCoinView *)choiceCoinView{
    if (!_choiceCoinView) {
        _choiceCoinView = [[TradeChoiceCoinView alloc]init];
        __weak typeof(self)weakSelf = self;
        _choiceCoinView.finishChoiceBlock = ^(MarketHomeListModel *model) {
            if (model.flockCurrent == 1 && _isBuy) {
                ApplyViewController * buyVC = [[ApplyViewController alloc]init];
                buyVC.selectedModel = model;
                [weakSelf.navigationController pushViewController:buyVC animated:YES];
                return ;
            }
            weakSelf.selectedModel = model;
            [weakSelf.topView refreshViewWithModel:model];
        };
        _choiceCoinView.removeBlock = ^{
            [[SZSocket sharedSZSocket]orderMessage:weakSelf.selectedModel.fCoinType];
        };
    }
    return _choiceCoinView;
}

#pragma mark -------以下皆为懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[TradeSevenTableViewCell class] forCellReuseIdentifier:kTradeSevenTableViewCellReusedID];
    }
    return _tableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(TradeSevenTableViewCell *)firstSectionHeaderView{
    if (!_firstSectionHeaderView) {
        _firstSectionHeaderView = [[TradeSevenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _firstSectionHeaderView.cellType = TradeSevenTableViewCellTypeTitle;
    }
    return _firstSectionHeaderView;
}

-(UIView *)secSectionHeaderView{
    if (!_secSectionHeaderView) {
        _secSectionHeaderView = [UIView new];
        _secSectionHeaderView.backgroundColor = [UIColor whiteColor];
        
        UIView * line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xe3e4e6);
        [_secSectionHeaderView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.leading.trailing.mas_equalTo(0);
            make.centerY.mas_equalTo(self.secSectionHeaderView);
        }];
    }
    return _secSectionHeaderView;
}

-(SRWebSocket *)webSocket{
    if (!_webSocket) {
        _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:SocketUrlForSeven]]];
        _webSocket.delegate = self;
    }
    return _webSocket;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
