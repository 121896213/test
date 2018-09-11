//
//  SZThemeViewController.m
//  BTCoin
//
//  Created by fanhongbin on 2018/6/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZThemeViewController.h"

@interface SZThemeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation SZThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:@"主题"];
    [self initData];
    [self tableView];
}

#pragma mark - init data
- (void)initData{
    
    self.dataArray=@[NSLocalizedString(@"白天", nil),NSLocalizedString(@"夜晚", nil)];
}


#pragma mark - tableview delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
//    NSDictionary *dic = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text=self.dataArray[indexPath.row];
    UIImageView* leftView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    if ([SZUserDefaultCenter getBoolValueWithKey:SZUserAppThemeValue]) {
        [leftView setImage:indexPath.row==1?[UIImage imageNamed:@"theme_unselect"]:[UIImage imageNamed:@"theme_select"]];
    }else{
        [leftView setImage:indexPath.row==1?[UIImage imageNamed:@"theme_select"]:[UIImage imageNamed:@"theme_unselect"]];
    }
    cell.accessoryView=leftView;
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [SZUserDefaultCenter setBoolKey:SZUserAppThemeValue andValue:YES];
    }else{
        [SZUserDefaultCenter setBoolKey:SZUserAppThemeValue andValue:NO];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ui
- (UITableView *)tableView{
    
    if (!_tableView) {
        UITableViewStyle tvStyle = [UIDevice currentDevice].systemVersion.floatValue >= 11 ? UITableViewStyleGrouped : UITableViewStylePlain;
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:tvStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.backgroundColor = [UIColor sapBackground];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;
        _tableView.sectionIndexBackgroundColor = [UIColor sapBackground];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.top.equalTo(self.headView.mas_bottom);
            make.leading.trailing.bottom.equalTo(self.view);
        }];
        
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
