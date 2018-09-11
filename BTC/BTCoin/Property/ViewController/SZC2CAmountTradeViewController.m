//
//  SZC2CAmountTradeViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/7/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAmountTradeViewController.h"
#import "SZWithdrawAddressCell.h"
#import "SZTradePasswordView.h"
@interface SZC2CAmountTradeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,copy)  NSArray* currentData;
@property (nonatomic,strong) UILabel*  remainAmountLab;
@end

@implementation SZC2CAmountTradeViewController

-(SZC2CAmountTradeViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZC2CAmountTradeViewModel new];
    }
    return _viewModel;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if (self.viewModel.amountTradeType == SZC2CAmountTradeTypeIn) {
        [self setTitleText:NSLocalizedString(@"转入", nil)];
        self.currentData=@[NSLocalizedString(@"币种", nil),NSLocalizedString(@"转出账户", nil),NSLocalizedString(@"输入数量", nil)];
        
    }else{
        [self setTitleText:NSLocalizedString(@"转出", nil)];
        self.currentData=@[NSLocalizedString(@"币种", nil),NSLocalizedString(@"转入账户", nil),NSLocalizedString(@"输入数量", nil)];
        
    }
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setSubviews];
    
}

-(void)setSubviews{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, FIT(166)) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[SZWithdrawAddressCell class] forCellReuseIdentifier:SZWithdrawAddressCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight=FIT(50);
    
    [self.view addSubview:self.tableView];
    
    UILabel*  remainAmountLab=[UILabel new];
    remainAmountLab.text=FormatString(@"剩余可用可转金额: %@  USDT",self.viewModel.cellViewModel.c2cPropertyModel.ftotal);
    remainAmountLab.font=[UIFont systemFontOfSize:FIT(12)];
    remainAmountLab.textColor=MainLabelBlackColor;
    remainAmountLab.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:remainAmountLab];
    [remainAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.top.equalTo(self.tableView.mas_bottom).offset(FIT(10));;
        make.width.mas_equalTo(FIT(500));
        make.height.mas_equalTo(remainAmountLab.font.lineHeight);
    }];
    self.remainAmountLab=remainAmountLab;
    
    
    UIButton* tradeBtn=[UIButton new];
    [tradeBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(18)]];
    [tradeBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [tradeBtn setTitle:NSLocalizedString(@"立即划转", nil) forState:UIControlStateNormal];
    [tradeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:tradeBtn];
    [tradeBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.equalTo(remainAmountLab.mas_bottom).offset(FIT(87));
        make.height.mas_equalTo(FIT(50));
        make.width.mas_equalTo(ScreenWidth-FIT(16)*2);
        
    }];
    [tradeBtn setGradientBackGround];

    
    
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showPromptHUDWithTitle:x];
        [[SZSundriesCenter instance] delayExecutionInMainThread:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }];
    [self.viewModel.otherSignal subscribeNext:^(id x) {
        @strongify(self);
        [self hideMBProgressHUD];

        if (!isEmptyObject(self.viewModel.bbPropertyModel)) {
            self.remainAmountLab.text=FormatString(@"剩余可转金额: %@  USDT",self.viewModel.bbPropertyModel.ftotal);
        }
    }];
    [self.viewModel.failureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self showErrorHUDWithTitle:x];
        if (isEmptyObject(self.viewModel.bbPropertyModel)) {
            self.remainAmountLab.text=FormatString(@"剩余可转金额: 0.00000000  USDT");
        }
    }];

    
    if (self.viewModel.amountTradeType == SZC2CAmountTradeTypeIn) {
        [self showLoadingMBProgressHUD];
        [self.viewModel requestUserWalletWithParameter:nil];
    }
 
    
    [[tradeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        if (isEmptyString(self.viewModel.tradeAmount)) {
              [self showPromptHUDWithTitle:NSLocalizedString(@"请输入划转的数量", nil)];
        }else{
            
            
            if (([self.viewModel.tradeAmount floatValue] > [self.viewModel.cellViewModel.c2cPropertyModel.ftotal floatValue] && self.viewModel.amountTradeType==SZC2CAmountTradeTypeOut) ||([self.viewModel.tradeAmount floatValue] > [self.viewModel.bbPropertyModel.ftotal floatValue] && self.viewModel.amountTradeType==SZC2CAmountTradeTypeIn)) {
                [self showPromptHUDWithTitle:NSLocalizedString(@"您的余额不足", nil)];

            }else{
                if ([self.viewModel.tradeAmount floatValue] <= 0.000000f) {
                    [self showPromptHUDWithTitle:NSLocalizedString(@"您的划转额度不合法", nil)];
                    return ;
                }
                SZTradePasswordView* tradePasswordView=[[SZTradePasswordView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,FIT(250))];
                [tradePasswordView showInView:self.view directionType:SZPopViewFromDirectionTypeBottom];
//                RAC(self.viewModel, tradePassword) = tradePasswordView.passwordTextField.rac_textSignal;
//                RAC(tradePasswordView.passwordTextField, text) = RACObserve(self.viewModel, tradePassword);
                //1、(监听model的变化将变化映射到textView)这种写法其实已经是双向绑定的写法了，但是由于是textView的原因只能绑定model.text的变化到影响textView.text的值的变化的这个单向通道
                RACChannelTo(tradePasswordView,passwordTextField.text) = RACChannelTo(self.viewModel,tradePassword);
                //2、(监听View的变化将view的内容映射到model中)在这里对textView的text changed的信号重新订阅一下，以实现上面channel未实现的另外一个绑定通道.
                @weakify(self);
                [tradePasswordView.passwordTextField.rac_textSignal subscribeNext:^(id x) {
                    @strongify(self);
                    self.viewModel.tradePassword = x;
                }];
                
         
                [[tradePasswordView.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                    @strongify(self);
                    if (isEmptyString(self.viewModel.tradePassword)) {
                        [self showPromptHUDWithTitle:NSLocalizedString(@"请输入交易密码", nil)];
                    }else{
                        
                        [self showLoadingMBProgressHUD];
                        [self.viewModel requestC2CBBTransfersWithParameter:nil];
                        [tradePasswordView disMissView];
                        self.viewModel.tradePassword=@"";
                    }
                }];
            }
        }
       
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZWithdrawAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:SZWithdrawAddressCellReuseIdentifier forIndexPath:indexPath];
    [cell setAmountTradeCellStyle:indexPath];
    cell.coinTypeLab.text=self.currentData[indexPath.row];
    if (indexPath.row == 0) {
        cell.coinTypeCountLab.text=self.viewModel.cellViewModel.c2cPropertyModel.fvirtualcointypeName;
    }else if (indexPath.row ==1){
        cell.coinTypeCountLab.text=NSLocalizedString(@"币币账户", nil);
    }
    if (indexPath.row == 2) {
//        RAC(self.viewModel, tradeAmount) = cell.textFiled.rac_textSignal;
//        RAC(cell.textFiled, text) = RACObserve(self.viewModel, tradeAmount);
        RACChannelTo(cell,textFiled.text) = RACChannelTo(self.viewModel,tradeAmount);
        //2、(监听View的变化将view的内容映射到model中)在这里对textView的text changed的信号重新订阅一下，以实现上面channel未实现的另外一个绑定通道.
        @weakify(self);
        [cell.textFiled.rac_textSignal subscribeNext:^(id x) {
            @strongify(self);
            self.viewModel.tradeAmount = x;
        }];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!footView) {
        footView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, footView.height)];
        subFootView.backgroundColor=MainBackgroundColor;
        [footView addSubview:subFootView];
    }
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return FIT(16);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
