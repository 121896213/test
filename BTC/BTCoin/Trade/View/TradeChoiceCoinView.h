//
//  TradeChoiceCoinView.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeChoiceCoinTableViewCell.h"

@interface TradeChoiceCoinView : UIView

@property (nonatomic,copy)void (^finishChoiceBlock)(MarketHomeListModel * model);
@property (nonatomic,copy)void (^removeBlock)(void);

-(void)showInView:(UIView *)superView;
-(void)removeSelf;
@end
