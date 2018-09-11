//
//  TradeWalletView.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWalletModel.h"

@interface TradeWalletView : UIView


-(void)refreshWalletViewWithModel:(MyWalletModel *)walletModel :(BOOL)isBuy :(MarketHomeListModel *)model;
@end
