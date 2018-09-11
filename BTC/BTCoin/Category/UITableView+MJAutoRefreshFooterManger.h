//
//  UITableView+MJAutoRefreshFooterManger.h
//  BTCoin
//
//  Created by fanhongbin on 2018/6/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>

#import "MJRefresh.h"



typedef NS_ENUM(NSInteger, MJFooterRefreshState) {
    
    MJFooterRefreshStateNormal,
    
    MJFooterRefreshStateLoadMore,
    
    MJFooterRefreshStateNoMore
    
};
@interface UITableView (MJAutoRefreshFooterManger)
@property (nonatomic,assign)MJFooterRefreshState footRefreshState;

@end
