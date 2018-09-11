//
//  TradeCoinMessageView.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketHomeListModel.h"

@interface TradeCoinMessageView : UIView

@property (nonatomic,copy)void (^changeCoinBlock)(void);

-(void)refreshViewWithModel:(MarketHomeListModel *)model;

-(void)disableTapEvent;
@end
