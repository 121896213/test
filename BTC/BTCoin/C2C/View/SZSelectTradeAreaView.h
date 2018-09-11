//
//  SZSelectTradeAreaView.h
//  BTCoin
//
//  Created by sumrain on 2018/7/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPopView.h"

#define SZSelectTradeAreaCellHeight FIT(50)
#define SZSelectTradeAreaCellReuseIdentifier  @"SZSelectTradeAreaCellReuseIdentifier"



typedef enum : NSUInteger {
    SZTradeMarketTypeUSDT,
    SZTradeMarketTypeETH,
    SZTradeMarketTypeBTC,
} SZTradeMarketType;

typedef enum : NSUInteger {
    SZTradeAreaTypeNormalDeal,
    SZTradeAreaTypeBigDeal,
} SZTradeAreaType;

typedef enum : NSUInteger {
    SZTradeTypeBuy,
    SZTradeTypeSell,
} SZTradeType;
@interface SZSelectTradeAreaCell : UITableViewCell
@property (nonatomic, strong) UILabel* titleLab;
@end

typedef void(^SelectAction) (NSInteger marketRow,NSInteger areaRow);

@interface SZSelectTradeAreaView : SZPopView<UITableViewDelegate,UITableViewDataSource>
@property (copy,nonatomic) SelectAction selectionAction;
@property (assign,nonatomic) SZTradeAreaType  tradeAreaType;
@property (assign,nonatomic) SZTradeMarketType tradeMarketType;

@end
