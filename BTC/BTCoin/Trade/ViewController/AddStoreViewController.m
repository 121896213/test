//
//  AddStoreViewController.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/23.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "AddStoreViewController.h"
#import "MyWalletModel.h"
#import "SZPropertyRechargeViewController.h"
#import "NSString+Regex.h"
#import "SZTradePasswordView.h"

#define kAddStoreActionButtonBeginTag 200303

@interface AddStoreViewController ()<UITextFieldDelegate>{
    UIAlertAction * _ensureAction;//输入交易密码后，点确定
}
@property (nonatomic,strong)UILabel * limitTimeLabel;
@property (nonatomic,strong)UILabel * coinNameLabel;
@property (nonatomic,strong)UILabel * priceLabel;
@property (nonatomic,strong)UILabel * rmbPriceLabel;
@property (nonatomic,strong)UILabel * tipsLabel;
@property (nonatomic,strong)UITextField * numberTF;
@property (nonatomic,strong)UILabel * unitLabel;
@property (nonatomic,strong)UILabel * realAmountTitleLabel;//"交易额"label
@property (nonatomic,strong)UILabel * realAmountLabel;//交易额 数值 label

@property (nonatomic,strong)MyWalletModel * myWallet;


@end

@implementation AddStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    [self getMyBalance];
}

-(void)getMyBalance
{
    if (!_model) {
        return;
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/trade/userWallet.do",BaseHttpUrl];
    
    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:@{@"symbol":_model.ftrademapping} bodyParameters:nil successBlock:^(id responseObject) {
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

#pragma mark ------- TextfieldDelegate
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
                if (pointStr.length > _model.fcount2)
                {
                    NSString * tip = [NSString stringWithFormat:@"%@ %ld %@",NSLocalizedString(@"最多允许", nil),_model.fcount2,NSLocalizedString(@"位小数", nil)];
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
    
    double totalMoney = 0;
    
    totalMoney = [_model.dealPrice doubleValue] *[_numberTF.text doubleValue];
    
    NSString *format = [NSString stringWithFormat:@"%%.%df %%@",USDT_MAX_Points];
    NSString * coninType = _model.fvirtualcointypeName1;
    _realAmountLabel.text = [NSString stringWithFormat:format,totalMoney,coninType];
    
    if (!_myWallet) {
        return;
    }
    
    double maxValue = [_myWallet.ftotalType doubleValue];
    
    if (totalMoney > maxValue) {
        [self showPromptHUDWithTitle:NSLocalizedString(@"交易额大于您的余额，请重新输入!", nil)];
        _numberTF.text = @"";
        _realAmountLabel.text = @"";
    }
    
}

#pragma mark -------- 构建页面
-(void)configSubViews
{
    self.view.backgroundColor = WhiteColor;
    
    [self setTitleText:NSLocalizedString(@"加仓", nil)];
    self.txtTitle.textColor = UIColorFromRGB(0xffffff);
    self.txtTitle.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [self.headView addBottomLineViewColor:UIColorFromRGB(0x274287)];
    self.headView.backgroundColor = UIColorFromRGB(0x274287);
    
    UIView * top = [UIView new];
    top.backgroundColor = UIColorFromRGB(0x274287);
    [self.view addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.height.mas_equalTo(220);
    }];
    
    UIView * shadowView = [UIView new];
    shadowView.backgroundColor = UIColorFromRGB(0xffffff);
    shadowView.alpha = 0.1;
    [self.view addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.height.mas_equalTo(37);
    }];
    
    _limitTimeLabel = [self createLabelWithTextColor:UIColorFromRGB(0xffffff) font:kFontSize(14)];
    _limitTimeLabel.text = FormatString(@"%@: %@",NSLocalizedString(@"该币加仓截止日期", nil),[_model limitTimeString]);
    [self.view addSubview:_limitTimeLabel];
    [_limitTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(shadowView.mas_centerY);
        make.leading.mas_equalTo(16);
    }];
    
    _coinNameLabel = [self createLabelWithTextColor:UIColorFromRGB(0xffffff) font:[UIFont fontWithName:@"PingFang-SC-Medium" size:14]];
    _coinNameLabel.text = FormatString(@"%@/%@",_model.fvirtualcointypeName2,_model.fvirtualcointypeName1);
    [self.view addSubview:_coinNameLabel];
    [_coinNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shadowView.mas_bottom).offset(14);
        make.leading.mas_equalTo(16);
    }];
    
    _priceLabel = [self createLabelWithTextColor:UIColorFromRGB(0xffffff) font:[UIFont boldSystemFontOfSize:40]];
    NSMutableAttributedString * mAttString = [[NSMutableAttributedString alloc]initWithString:_model.dealPrice attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:40]}];
    [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:FormatString(@" %@",_model.fvirtualcointypeName1) attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:18]}]];
    
    _priceLabel.attributedText = mAttString;
    [self.view addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(shadowView.mas_bottom).offset(60);
        make.height.mas_equalTo(30);
    }];
    
    _rmbPriceLabel = [self createLabelWithTextColor:UIColorFromRGB(0xffffff) font:kFontSize(12)];
    _rmbPriceLabel.text = FormatString(@"≈%.2fCNY",[_model.cnyPrice floatValue]);
    [self.view addSubview:_rmbPriceLabel];
    [_rmbPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_priceLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(10);
    }];
    
    _tipsLabel = [self createLabelWithTextColor:UIColorFromRGB(0xffffff) font:kFontSize(12)];
    _tipsLabel.text = @"加仓买入价格为第一笔申购价";
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.layer.cornerRadius = 14;
    _tipsLabel.clipsToBounds = YES;
    _tipsLabel.backgroundColor = UIColorFromRGBWithAlpha(0xffffff, 0.1);
    [self.view addSubview:_tipsLabel];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_rmbPriceLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(215);
    }];
    
    UIView * center = [UIView new];
    center.backgroundColor = UIColorFromRGB(0xF0F1F5);
    [self.view addSubview:center];
    [center mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(top.mas_bottom);
        make.height.mas_equalTo(16);
    }];
    
    UILabel * buyVolTitleLab = [self createLabelWithTextColor:UIColorFromRGB(0x333333) font:[UIFont fontWithName:@"PingFang-SC-Medium" size:16]];
    buyVolTitleLab.text = NSLocalizedString(@"买入量", nil); 
    [self.view addSubview:buyVolTitleLab];
    [buyVolTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(center.mas_bottom).offset(19);
        make.leading.mas_equalTo(16);
        make.height.mas_equalTo(15);
    }];
    
    _numberTF  = [[UITextField alloc]init];
    _numberTF.textColor = UIColorFromRGB(0x333333);
    _numberTF.placeholder =NSLocalizedString(@"请输入买入量", nil);
    _numberTF.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:20];
    _numberTF.keyboardType = UIKeyboardTypeDecimalPad;
    _numberTF.delegate = self;
    [self.view addSubview:_numberTF];
    [_numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buyVolTitleLab.mas_bottom).offset(18);
        make.leading.mas_equalTo(16);
        make.height.mas_equalTo(20);
    }];
    
    _unitLabel = [self createLabelWithTextColor:UIColorFromRGB(0x333333) font:[UIFont fontWithName:@"PingFang-SC-Medium" size:16]];
    _unitLabel.text = _model.fvirtualcointypeName2;
    [self.view addSubview:_unitLabel];
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buyVolTitleLab.mas_bottom).offset(18);
        make.trailing.mas_equalTo(-16);
        make.height.mas_equalTo(20);
    }];
    
    UIView * line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xE1E2E6);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.trailing.mas_equalTo(0);
        make.top.mas_equalTo(_numberTF.mas_bottom).offset(19);
        make.height.mas_equalTo(1);
    }];
    
    CGFloat buttonW = 40;
    NSArray * array = @[@"全仓",@"半仓",@"1/3",@"1/5"];
    for (int i = 0; i < 4; i++) {
        UIButton * button = [[UIButton alloc]init];
        [button addTarget:self action:@selector(selectStoreAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.font = kFontSize(12);
        [button setTitle:NSLocalizedString(array[i], nil) forState:UIControlStateNormal];
        button.tag = kAddStoreActionButtonBeginTag + i;
        button.layer.cornerRadius = 3.0f;
        button.layer.borderWidth = 0.5f;
        button.layer.borderColor = UIColorFromRGB(0xBABFCC).CGColor;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(16 + (buttonW + 15)*i);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(buttonW);
            make.top.mas_equalTo(_numberTF.mas_bottom).offset(36);
        }];
    }
    
    _realAmountTitleLabel = [self createLabelWithTextColor:UIColorFromRGB(0x999999) font:[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
    _realAmountTitleLabel.text = NSLocalizedString(@"交易额: ", nil);
    [self.view addSubview:_realAmountTitleLabel];
    [_realAmountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(_numberTF.mas_bottom).offset(72);
    }];
    
    _realAmountLabel = [self createLabelWithTextColor:UIColorFromRGB(0x333333) font:[UIFont fontWithName:@"PingFang-SC-Medium" size:12]];
    [self.view addSubview:_realAmountLabel];
    [_realAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_realAmountTitleLabel.mas_trailing);
        make.top.mas_equalTo(_realAmountTitleLabel.mas_top);
    }];
    
    UIButton * addStoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addStoreButton addTarget:self action:@selector(addStoreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    addStoreButton.layer.cornerRadius = 5.0f;
    [addStoreButton setTitle:NSLocalizedString(@"加仓", nil) forState:UIControlStateNormal];
    addStoreButton.backgroundColor = UIColorFromRGB(0x4E6AAE);
    [self.view addSubview:addStoreButton];
    [addStoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-16);
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(_realAmountLabel.mas_bottom).offset(50 * kScale);
        make.height.mas_equalTo(50 * kScale);
    }];
}

#pragma mark -------- step3/2 选择仓存
-(void)selectStoreAction:(UIButton *)button{
    for (NSInteger i = 0; i< 4; i++) {
        UIButton * but =  [self.view viewWithTag:(kAddStoreActionButtonBeginTag + i)];
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
    
    double totalMoney =[_myWallet.ftotalType doubleValue] ;
    double num = totalMoney / [_model.dealPrice doubleValue];
    
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
    formatter.maximumFractionDigits = _model.fcount2;
    formatter.minimumIntegerDigits = 1;
    _numberTF.text = [formatter stringFromNumber:@(num)];

    double useMoney = [_model.dealPrice doubleValue] * [_numberTF.text doubleValue];
    NSString * coinName = _model.fvirtualcointypeName1;
    NSString *format = [NSString stringWithFormat:@"%%.%df %%@",USDT_MAX_Points];
    _realAmountLabel.text = [NSString stringWithFormat:format,useMoney,coinName];
    
}


-(void)addStoreBtnAction:(id)sender{
    if ([self checkCanGoNext]) {
//        [self inputTradePassWord];
        SZTradePasswordView* tradePasswordView=[[SZTradePasswordView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,FIT(250))];
        __weak typeof(self)weakSelf = self;
        tradePasswordView.confirmBlock = ^(NSString *password) {
            [weakSelf packParametersWithPWD:password];
            
        };
        [tradePasswordView showInView:self.view directionType:SZPopViewFromDirectionTypeBottom];
    }
}

-(BOOL)checkCanGoNext
{
    if (_numberTF.text.length == 0) {//设定了数量
        [self showPromptHUDWithTitle:NSLocalizedString(@"请输入数量", nil)];
        return NO;
    }
    if (![_numberTF.text isValidFloat]) {
        [self showPromptHUDWithTitle:NSLocalizedString(@"请输入正确的数值!", nil)];
        dispatch_async(dispatch_get_main_queue(), ^{
            _numberTF.text = @"";
            [_numberTF becomeFirstResponder];
        });
        return NO;
    }
    double totalMoney =  [_myWallet.ftotalType doubleValue];
    double useMoney =  [_model.dealPrice doubleValue] *[_numberTF.text doubleValue];
    if (useMoney > totalMoney) {
        [self showPromptHUDWithTitle:NSLocalizedString(@"交易额大于您的余额，请重新输入!", nil)];
        _realAmountLabel.text = @"";
        _numberTF.text = @"";
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
    [mDict setValue:_model.ftrademapping forKey:@"ftrademapping"];
    [mDict setValue:_model.dealPrice forKey:@"price"];
    [mDict setValue:_numberTF.text forKey:@"count"];
    [mDict setValue:[AppUtil md5:passWord] forKey:@"tradePwd"];
    [mDict setValue:@(20) forKey:@"buyType"];
    [mDict setValue:_model.orderId forKey:@"firstOrderId"];
    [mDict setValue:@(20) forKey:@"type"];
    
    [self buyCoinWithPara:mDict];
}

-(void)buyCoinWithPara:(NSDictionary *)para
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/lock/order.do",BaseHttpUrl];
    
    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:para bodyParameters:nil successBlock:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            [weakSelf showErrorHUDWithTitle:base.msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf goToRecordPage];
            });
        }else{
            [weakSelf showErrorHUDWithTitle:base.errorMessage];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        
    }];
}

-(void)goToRecordPage{
    [self.navigationController popViewControllerAnimated:YES];
}

/**创建label*/
-(UILabel *)createLabelWithTextColor:(UIColor *)color font:(UIFont *)font
{
    UILabel * label = [UILabel new];
    label.font = font;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = color;
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
