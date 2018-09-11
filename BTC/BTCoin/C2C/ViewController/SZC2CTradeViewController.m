//
//  SZC2CTradeViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CTradeViewController.h"
#import "SZC2CTradeViewModel.h"

#import "SZC2CTradeFooterView.h"
#import "SZC2CTradePriceCell.h"
#import "SZC2CStateHeaderView.h"
#import "SZC2CTradeCommonCell.h"

#import "SZBusinessInfoViewController.h"
@interface SZC2CTradeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView* tableView;

@end

@implementation SZC2CTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:self.viewModel.isTradeSell?NSLocalizedString(@"卖出", nil):NSLocalizedString(@"买入", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    self.view.backgroundColor=MainC2CBackgroundColor;
    [self tableView];
}
- (SZC2CTradeViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZC2CTradeViewModel new];
    }
    return _viewModel;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MainC2CBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView .showsVerticalScrollIndicator = NO;
        _tableView.sectionHeaderHeight=FIT(16);
        _tableView.sectionFooterHeight=FIT(0);
        _tableView.rowHeight=FIT(48.3);
        _tableView.sectionHeaderHeight=FIT(150);
       
        
        UILabel* titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-FIT(32), FIT(24))];
        titleLab.textColor=MainLabelBlackColor;
        titleLab.backgroundColor=MainC2CBackgroundColor;
        titleLab.font=[UIFont systemFontOfSize:FIT(16)];
        titleLab.text= self.viewModel.isTradeSell?NSLocalizedString(@"卖出USDT", nil):NSLocalizedString(@"买入USDT", nil);
        [_tableView setTableHeaderView:titleLab];
        
        SZC2CTradeFooterView* tradeFootView=[[SZC2CTradeFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-FIT(32), FIT(100))];
        tradeFootView.backgroundColor=MainC2CBackgroundColor;
        [tradeFootView setViewStlyeWithIsTradeSell:self.viewModel.isTradeSell];
        [_tableView setTableFooterView:tradeFootView];
        
        
        [_tableView registerClass:[SZC2CTradePriceCell class] forCellReuseIdentifier:SZC2CTradePriceCellReuseIdentifier];
        [_tableView registerClass:[SZC2CTradeCommonCell class] forCellReuseIdentifier:SZTradeCommonCellReuseIdentifier];

        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(NavigationStatusBarHeight+FIT(8));
            make.left.mas_equalTo(FIT(16));
            make.right.mas_equalTo(FIT(-16));
            make.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else {
        if (self.viewModel.isTradeSell) {
            return 3;
        }else{
            return 3;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return SZC2CTradePriceCellHeight;
    }else {
        return SZTradeCommonCellHeight;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SZC2CTradePriceCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CTradePriceCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        @weakify(self);
        cell.action = ^(id sender) {
            @strongify(self);
            SZBusinessInfoViewController* infoVC=[SZBusinessInfoViewController new];
            [self.navigationController pushViewController:infoVC animated:YES];
        };
        return cell;
    }else if (indexPath.section ==1){
        SZC2CTradeCommonCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZTradeCommonCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setContentStyle:indexPath isTradeSell:self.viewModel.isTradeSell];
        if (indexPath.row == 0) {
            RACChannelTo(self.viewModel, tradeCount) = RACChannelTo(cell, textField.text);
        }else{
            RACChannelTo(self.viewModel, tradeAmount) = RACChannelTo(cell, textField.text);
        }
        return cell;
    }
    return nil;
    
    
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
        subFootView.backgroundColor=MainC2CBackgroundColor;;
        [headerView addSubview:subFootView];
    }
    return headerView;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([cell respondsToSelector:@selector(tintColor)]) {
//        CGFloat cornerRadius = 3.f;
//        cell.backgroundColor = UIColor.clearColor;
//        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//        CGMutablePathRef pathRef = CGPathCreateMutable();
//        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
//        BOOL addLine = NO;
//        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1){
//            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
//        } else if (indexPath.row == 0) {
//
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//            addLine = YES;
//
//        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//        } else {
//            //            CGPathAddRect(pathRef, nil, bounds);
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//            addLine = YES;
//        }
//        layer.path = pathRef;
//        CFRelease(pathRef);
//        //颜色修改
//        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.5f].CGColor;
//        layer.strokeColor=[UIColor whiteColor].CGColor;//[UIColor blackColor].CGColor;
//        //        if (addLine == YES) {
//        //            CALaye r *lineLayer = [[CALayer alloc] init];
//        //            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
//        //            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
//        //            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
//        //            [layer addSublayer:lineLayer];
//        //        }
//        UIView *testView = [[UIView alloc] initWithFrame:bounds];
//        [testView.layer insertSublayer:layer atIndex:0];
//        testView.backgroundColor = UIColor.clearColor;
//        cell.backgroundView = testView;
//    }
//
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
