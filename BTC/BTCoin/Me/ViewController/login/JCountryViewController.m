//
//  JCountryViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/4/20.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "JCountryViewController.h"
#import "JCountryModel.h"
#import "JMeNetHelper.h"

@interface JCountryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JCountryListModel *countryListModel;//本地
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JCountryViewController

- (void)hids {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"选择国家/地区", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[kIMAGE_NAMED(@"back")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(hids)];
    [self loadCountryData];
}
- (void)loadCountryData{
    
    self.countryListModel = nil;//从本地获取
    if (![self.countryListModel isKindOfClass:[JCountryListModel class]]
        || [self.countryListModel.list count] < 1) {
        //从服务端拉取
        [self showLoadingMBProgressHUD];
        @weakify(self);
        [JMeNetHelper GetCountryCodeSuccess:^(id responseObject) {
            @strongify(self);
            [self hideMBProgressHUD];
            JCountryListModel * listModel = [[JCountryListModel alloc] initWithDictionary:responseObject error:nil];
            NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:listModel.list.count];
            JCountryModel * model = nil;
            for (NSDictionary *dictModel in listModel.list) {
                model = [[JCountryModel alloc] initWithDictionary:dictModel error:nil];
                [mArray addObject:model];
            }
            listModel.list = mArray;
            self.countryListModel = listModel;
            [self reloadAndToSelectedCell];
        } fail:^(NSError *error) {
            @strongify(self);
            [self hideMBProgressHUD];
        }];
    }else{
        [self.tableView reloadData];
    }
}

- (void)reloadAndToSelectedCell {
    [self.tableView reloadData];
    if (self.currCountryModel && [self.currCountryModel.phoneCode length] > 1) {
        NSInteger index = 0;
        for (JCountryModel *model in self.countryListModel.list) {
            if ([model.phoneCode isEqualToString:self.currCountryModel.phoneCode]) {
                break;
            }
            index++;
        }
        NSIndexPath *ip = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

#pragma mark - tableview delegete

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.countryListModel.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    JCountryModel *model = self.countryListModel.list[indexPath.row];
    cell.textLabel.text = model.countrycn;
    
    /*
    UILabel *codeLbl = [UILabel new];
    codeLbl.textColor = [UIColor sapGray];
    codeLbl.font = Font_14;
    codeLbl.text = model.phoneCode;
    [codeLbl sizeToFit];
    
    cell.accessoryView = codeLbl;*/
    
    if ([model.phoneCode isEqualToString:self.currCountryModel.phoneCode]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.CountryBlock) {
        JCountryModel *model = self.countryListModel.list[indexPath.row];
        self.CountryBlock(model);
        [self hids];
    }
}

#pragma mark - ui
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.backgroundColor = [UIColor sapBackground];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _tableView.sectionIndexBackgroundColor = [UIColor sapBackground];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(StatusBarHeight + 44, 0, 0, 0));
        }];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

@end
