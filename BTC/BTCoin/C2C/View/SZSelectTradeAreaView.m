//
//  SZSelectTradeAreaView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSelectTradeAreaView.h"


@interface SZSelectTradeAreaView()
@property (nonatomic, copy) NSArray* marketArr;
@property (nonatomic, copy) NSArray* areaArr;
@property (nonatomic, strong)UITableView* marketTableView;
@property (nonatomic, strong)UITableView* areaTableView;
@end


@implementation SZSelectTradeAreaView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self setSubView];
        [self addActions];
    }
    
    return self;
}

-(void)setSubView{
    
    UIView* lineView=[UIView new];
    [lineView setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(0));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT(0.5));
    }];
    
    UILabel* marketLab=[UILabel new];
    marketLab.text=NSLocalizedString(@"市场", nil);
    marketLab.font=[UIFont systemFontOfSize:FIT(12)];
    marketLab.textAlignment=NSTextAlignmentCenter;
    marketLab.backgroundColor=[UIColor whiteColor];
    marketLab.textColor=MainLabelGrayColor;
    [self.contentView addSubview:marketLab];
    self.contentView.backgroundColor=[UIColor whiteColor];
    [marketLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(lineView.mas_bottom);
        make.width.mas_equalTo(ScreenWidth/2);
        make.height.mas_equalTo(FIT(33));
    }];
    
    UILabel* areaLab=[UILabel new];
    areaLab.text=NSLocalizedString(@"区域", nil);
    areaLab.font=[UIFont systemFontOfSize:FIT(12)];
    areaLab.backgroundColor=[UIColor whiteColor];
    areaLab.textAlignment=NSTextAlignmentCenter;
    areaLab.textColor=MainLabelGrayColor;
    [self.contentView addSubview:areaLab];
    self.contentView.backgroundColor=[UIColor whiteColor];
    [areaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(0));
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(FIT(33));
        make.width.mas_equalTo(ScreenWidth/2);

    }];

    self.marketArr=@[@"USDT",@"ETH",@"BTC"];
    self.areaArr=@[NSLocalizedString(@"普通交易区", nil),NSLocalizedString(@"大宗交易区", nil)];
    
    
    UITableView* marketTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    marketTableView.delegate = self;
    marketTableView.dataSource = self;
    marketTableView.backgroundColor=UIColorFromRGB(0XF5F6FA);
    marketTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    marketTableView.sectionHeaderHeight=FIT(0);
    marketTableView.sectionFooterHeight=FIT(0);
    marketTableView.rowHeight=SZSelectTradeAreaCellHeight;
    self.marketTableView=marketTableView;
    [marketTableView registerClass:[SZSelectTradeAreaCell class] forCellReuseIdentifier:SZSelectTradeAreaCellReuseIdentifier];
    [self.contentView addSubview:marketTableView];
    [marketTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(areaLab.mas_bottom);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(FIT(0));
        make.width.mas_equalTo(ScreenWidth/2);
    }];

    UITableView* areaTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    areaTableView.delegate = self;
    areaTableView.dataSource = self;
    areaTableView.backgroundColor=UIColorFromRGB(0XEDF0F5);
    areaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    areaTableView.sectionHeaderHeight=FIT(0);
    areaTableView.sectionFooterHeight=FIT(0);
    areaTableView.rowHeight=SZSelectTradeAreaCellHeight;
    self.areaTableView=areaTableView;
    [areaTableView registerClass:[SZSelectTradeAreaCell class] forCellReuseIdentifier:SZSelectTradeAreaCellReuseIdentifier];
    [self.contentView addSubview:areaTableView];
    [areaTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(areaLab.mas_bottom);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(FIT(0));
        make.width.mas_equalTo(ScreenWidth/2);
    }];

    
    

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView==self.marketTableView?self.marketArr.count:self.areaArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    SZSelectTradeAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:SZSelectTradeAreaCellReuseIdentifier forIndexPath:indexPath];
  
    if (tableView == self.marketTableView) {
        cell.titleLab.text=self.marketArr[indexPath.row];
        cell.backgroundColor=UIColorFromRGB(0XF5F6FA);
        cell.titleLab.textColor=(self.tradeMarketType==(SZTradeMarketType)indexPath.row)?MainThemeColor:MainLabelBlackColor;

    }else{
        cell.titleLab.text=self.areaArr[indexPath.row];
        cell.backgroundColor=UIColorFromRGB(0XEDF0F5);
        cell.titleLab.textColor=(self.tradeAreaType==(SZTradeAreaType)indexPath.row)?MainThemeColor:MainLabelBlackColor;

    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SZSelectTradeAreaCell* cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.titleLab.textColor=MainThemeColor;
    if (tableView == self.marketTableView) {
        self.tradeMarketType=(SZTradeMarketType)indexPath.row;
    }else{
        self.tradeAreaType=(SZTradeAreaType)indexPath.row;

    }
    [self disMissView];
 }
-(void)addActions{
    
}

- (void)showInView:(UIView *)view directionType:(SZPopViewFromDirectionType)directionType{
    [super showInView:view directionType:directionType];
    
    [self.marketTableView reloadData];
    [self.areaTableView reloadData];
}
-(void)disMissView{
    [super disMissView];
    [self removeFromSuperview];
    
}
@end
@implementation SZSelectTradeAreaCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
    }
    return self;
}

-(void)setSubView{
    
    UILabel* titleLab=[UILabel new];
    titleLab.textColor=MainLabelBlackColor;
    titleLab.font=[UIFont systemFontOfSize:FIT(16)];
    titleLab.text=@"USDT";
    titleLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.left.mas_equalTo(FIT(16));
        make.top.bottom.mas_equalTo(FIT(0));
    }];
    self.titleLab=titleLab;
    [titleLab addBottomLineView];
    
}
@end


