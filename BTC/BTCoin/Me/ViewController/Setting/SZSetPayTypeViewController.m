//
//  SZSetPayTypeViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSetPayTypeViewController.h"
#import "SZTextFieldCommonCell.h"
@interface SZSetPayTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, copy)   NSArray       *dataArray;
@property (nonatomic, copy)   NSArray       *placeholdArray;

@end

@implementation SZSetPayTypeViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    if (self.viewModel.payType == SZPayTypeBank) {
        [self setTitleText:NSLocalizedString(@"设置银行卡", nil)];
        self.dataArray=@[NSLocalizedString(@"持卡人:", nil),NSLocalizedString(@"银行名称:", nil),NSLocalizedString(@"所属分行:", nil),NSLocalizedString(@"银行卡号:", nil)];
        self.placeholdArray=@[NSLocalizedString(@"请输入持卡人姓名", nil),NSLocalizedString(@"请选择", nil),NSLocalizedString(@"请输入所属分行", nil),NSLocalizedString(@"请输入银行卡号", nil)];

    }else if (self.viewModel.payType == SZPayTypeAlipay) {
        [self setTitleText:NSLocalizedString(@"设置支付宝", nil)];
        self.dataArray=@[NSLocalizedString(@"真实姓名:", nil),NSLocalizedString(@"支付宝账号:", nil)];
        self.placeholdArray=@[NSLocalizedString(@"请输入真实姓名", nil),NSLocalizedString(@"请输入支付宝账号", nil)];

    } else {
        [self setTitleText:NSLocalizedString(@"设置微信", nil)];
        self.dataArray=@[NSLocalizedString(@"真实姓名:", nil),NSLocalizedString(@"微信账号:", nil)];
        self.placeholdArray=@[NSLocalizedString(@"请输入真实姓名", nil),NSLocalizedString(@"请输入微信账号", nil)];

    }
    [self tableView];
    


    if (self.viewModel.payType !=SZPayTypeBank) {
        UIButton* uploadBtn=[UIButton new];
        [uploadBtn setImage:[UIImage imageNamed:@"payType_upload"] forState:UIControlStateNormal];
        [self.view addSubview:uploadBtn];
        [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView.mas_bottom).offset(FIT(16));
            make.width.mas_equalTo(FIT(100));
            make.left.mas_equalTo(FIT(16));
            make.height.mas_equalTo(FIT(100));
        }];
        
        UILabel* uploadLab=[UILabel new];
        uploadLab.text=NSLocalizedString(@"上传收款码", nil);
        uploadLab.textColor=UIColorFromRGB(0x666666);
        uploadLab.font=[UIFont systemFontOfSize:FIT(16)];
        uploadLab.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:uploadLab];
        [uploadLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(uploadBtn.mas_left);
            make.right.equalTo(uploadBtn.mas_right);
            make.top.equalTo(uploadBtn.mas_bottom).offset(FIT(16));
            make.height.mas_equalTo(uploadLab.font.lineHeight);
        }];
        
    }
    UIButton* commitBtn=[UIButton new];
    [commitBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [commitBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [commitBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ShareFunction setCircleBorder:commitBtn];
    [self.view addSubview:commitBtn];
    [commitBtn setBackgroundColor:MainThemeBlueColor];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(FIT(-304));
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(FIT(50));
    }];
}
- (NSArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
}
-(SZSetPayTypeViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZSetPayTypeViewModel new];
    }
    return _viewModel;
}
#pragma mark - tableview delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SZTextFieldCommonCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZTextFieldCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:SZTextFieldCommonCellReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell= [[SZTextFieldCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SZTextFieldCommonCellReuseIdentifier];
    }
    cell.titleLab.text=self.dataArray[indexPath.row];
    cell.textField.placeholder=self.placeholdArray[indexPath.row];
    if (self.viewModel.payType == SZPayTypeBank && indexPath.row == 1) {
        [cell.rightBtn setHidden:NO];
    }
    return cell ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FIT(16);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!headerView) {
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FIT(16))];
        subFootView.backgroundColor=MainBackgroundColor;
        [headerView addSubview:subFootView];
    }
    return headerView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

#pragma mark - ui
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SZTextFieldCommonCell class] forCellReuseIdentifier:SZTextFieldCommonCellReuseIdentifier];
        _tableView.sectionHeaderHeight=FIT(16);
        _tableView.sectionFooterHeight=FIT(0);
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom);
            make.leading.trailing.equalTo(self.view);
            make.height.mas_equalTo(FIT(16)+self.dataArray.count*SZTextFieldCommonCellHeight);
        }];
        
    }
    return _tableView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
