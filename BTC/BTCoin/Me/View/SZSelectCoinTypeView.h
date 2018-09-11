//
//  SZSelectCoinTypeView.h
//  BTCoin
//
//  Created by sumrain on 2018/7/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPopView.h"
@class SZSelectCoinTypeView;

@protocol SZSelectCoinTypeDelegate<NSObject>

- (void)selectCoinType:(SZSelectCoinTypeView*)View coinType:(NSString *)coinType;

@end

@interface SZSelectCoinTypeView : SZPopView

@property (nonatomic,strong) NSMutableArray* dataList;

@property (nonatomic,weak) id<SZSelectCoinTypeDelegate> delegate;

@end
