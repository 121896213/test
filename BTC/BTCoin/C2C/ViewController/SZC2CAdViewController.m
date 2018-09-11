//
//  SZC2CAdViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/7/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdViewController.h"
#import "SZC2CAdPayTypeCell.h"
#import "SZC2CAdPremiumCell.h"
#import "SZC2CAdPriceSwitchCell.h"
#import "SZC2CAdCommonCell.h"
#import "SZC2CAdAmountPartCell.h"
#import "SZC2CAdFooterView.h"
#import "SZC2CAdViewModel.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "SZC2CAdRuleViewController.h"
@interface SZC2CAdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SHSegmentControl* segmentControl;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) SZC2CAdViewModel* viewModel;

@end

@implementation SZC2CAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"发布广告", nil)];
    [self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    self.view.backgroundColor=MainC2CBackgroundColor;
    
    UIButton* tipBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, FIT3(120), 44)];
    [tipBtn setImage:[UIImage imageNamed:@"ad_questions"] forState:UIControlStateNormal];
    [self setRightBtn:tipBtn];
    [[tipBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        JCAlertController *alert = [JCAlertController alertWithTitle:@"创建一个广告交易" message:@"如果您经常进行交易，您可以创建自己的交易广告。如果您只是偶尔交易，我们建议您直接搜索交易广告。创建一则交易广告是免费的。若您想直接编辑已创建的广告，请查看我的广告。"];
        [alert addButtonWithTitle:@"我知道了" type:JCButtonTypeWarning clicked:nil];
        [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
        
      
    }];
    [self segmentControl];
    [self tableView];
}

- (SZC2CAdViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel=[SZC2CAdViewModel new];
    }
    return _viewModel;
    
}

-(SHSegmentControl *)segmentControl{
    
    if (!_segmentControl) {
        
        SHSegmentControl* segMentControl= [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, FIT(16), FIT(200), 30) items:@[NSLocalizedString(@"在线购买", nil),NSLocalizedString(@"在线出售", nil)]];
        segMentControl.titleNormalColor= MainThemeBlueColor;
        segMentControl.titleSelectColor= UIColorFromRGB(0xFFFFFF);
        segMentControl.viewSelectBackgroundColor=MainThemeBlueColor;
        segMentControl.viewNormalBackgroundColor=[UIColor whiteColor];
        segMentControl.backgroundColor = MainThemeBlueColor;
        [segMentControl setCircleBorderWidth:1 bordColor:MainThemeBlueColor radius:2];
        [segMentControl reloadViews];
        [self.headView addSubview:segMentControl];
        [segMentControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headView.mas_centerX);
            make.bottom.mas_equalTo(-(44-30)/2);
            make.width.mas_equalTo(FIT(200));
            make.height.mas_equalTo(30);
            
        }];
        segMentControl.curClick = ^(NSInteger index) {
            
        };
 
        _segmentControl=segMentControl;
    }
    return  _segmentControl;
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
        SZC2CAdFooterView* adFootView=[[SZC2CAdFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-FIT(32), FIT(150))];
        [adFootView.agreeBtn.titleLabel yb_addAttributeTapActionWithStrings:@[@"《交易守则》"] tapClicked:^(NSString *string, NSRange range,NSInteger index) {

            SZC2CAdRuleViewController* adRuleVC=[SZC2CAdRuleViewController new];
            [self.navigationController pushViewController:adRuleVC animated:YES];

        }];
     
        [_tableView setTableFooterView:adFootView];
        [_tableView registerClass:[SZC2CAdCommonCell class] forCellReuseIdentifier:SZC2CAdCommonCellReuseIdentifier];
        [_tableView registerClass:[SZC2CAdPriceSwitchCell class] forCellReuseIdentifier:SZC2CAdPriceSwitchCellReuseIdentifier];
        [_tableView registerClass:[SZC2CAdPremiumCell class] forCellReuseIdentifier:SZC2CAdPremiumCellReuseIdentifier];
        [_tableView registerClass:[SZC2CAdAmountPartCell class] forCellReuseIdentifier:SZC2CAdAmountPartCellReuseIdentifier];
        [_tableView registerClass:[SZC2CAdPayTypeCell class] forCellReuseIdentifier:SZC2CAdPayTypeCellReuseIdentifier];

        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(NavigationStatusBarHeight);
            make.left.mas_equalTo(FIT(16));
            make.right.mas_equalTo(FIT(-16));
            make.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  [self.viewModel.cellModelsArr count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [self.viewModel.cellModelsArr[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return FIT(50);
    }else if (indexPath.section == 1){
        return FIT(72);
    }else if (indexPath.section == 2){
        return FIT(50);
    }else if (indexPath.section == 3){
        return FIT(50);
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZAdCellModel* cellModel=self.viewModel.cellModelsArr[indexPath.section][indexPath.row];
    if (cellModel.cellType == SZAdCellTypeCommonTextFiled) {
        SZC2CAdCommonCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CAdCommonCellReuseIdentifier forIndexPath:indexPath];
        cell.cellModel=cellModel;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(cellModel.cellType == SZAdCellTypeC2cPriceSwitch ){
        
        SZC2CAdPriceSwitchCell* cell = [tableView dequeueReusableCellWithIdentifier:SZC2CAdPriceSwitchCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(cellModel.cellType == SZAdCellTypeC2cPremium ){
        
        SZC2CAdPremiumCell* cell = [tableView dequeueReusableCellWithIdentifier:SZC2CAdPremiumCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(cellModel.cellType == SZAdCellTypeC2cAmountPart ){
        
        SZC2CAdAmountPartCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CAdAmountPartCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(cellModel.cellType == SZAdCellTypeC2cPayType ){
        
        SZC2CAdPayTypeCell*  cell = [tableView dequeueReusableCellWithIdentifier:SZC2CAdPayTypeCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    //    SZCommissionRecordCellViewModel* cellViewModel=[self.viewModel commissionRecordCellViewModellAtIndexPath:indexPath];
    //    cell.viewModel=cellViewModel;
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
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
////            CGPathAddRect(pathRef, nil, bounds);
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
////        if (addLine == YES) {
////            CALayer *lineLayer = [[CALayer alloc] init];
////            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
////            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
////            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
////            [layer addSublayer:lineLayer];
////        }
//        UIView *testView = [[UIView alloc] initWithFrame:bounds];
//        [testView.layer insertSublayer:layer atIndex:0];
//        testView.backgroundColor = UIColor.clearColor;
//        cell.backgroundView = testView;
//    }


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSMutableArray *actionSheetItems = [@[FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"BTC", nil) ),
                                                  FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"USDT", nil)),
                                                  FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"ETH", nil)),     ]
                                                mutableCopy];
            FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:nil cancelTitle:NSLocalizedString(@"取消", nil) items:actionSheetItems];
            actionSheet.contentAlignment = FSContentAlignmentCenter;
            [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
                FSActionSheetItem *item = actionSheetItems[selectedIndex];
                SZAdCellModel* model=self.viewModel.cellModelsArr[indexPath.section][indexPath.row];
                model.content=item.title;
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

            }];
            
        }  if (indexPath.row == 1) {
            NSMutableArray *actionSheetItems = [@[FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"中国", nil) ),
                                                  FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"美国", nil)),]
                                                mutableCopy];
            FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:nil cancelTitle:NSLocalizedString(@"取消", nil) items:actionSheetItems];
            actionSheet.contentAlignment = FSContentAlignmentCenter;
            [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
                FSActionSheetItem *item = actionSheetItems[selectedIndex];
                SZAdCellModel* model=self.viewModel.cellModelsArr[indexPath.section][indexPath.row];
                model.content=item.title;
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
        }  if (indexPath.row == 2) {
            NSMutableArray *actionSheetItems = [@[FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"CNY", nil) ),
                                                  FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"USD", nil)),]
                                                mutableCopy];
            FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:nil cancelTitle:NSLocalizedString(@"取消", nil) items:actionSheetItems];
            actionSheet.contentAlignment = FSContentAlignmentCenter;
            [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
                FSActionSheetItem *item = actionSheetItems[selectedIndex];
                SZAdCellModel* model=self.viewModel.cellModelsArr[indexPath.section][indexPath.row];
                model.content=item.title;
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

            }];
        }

    }
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
