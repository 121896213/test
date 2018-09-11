//
//  SevenBuyOrSelDataModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketHomeListModel.h"
/**买卖七档的模型*/
@interface SevenBuyOrSelDataModel : NSObject

@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * volume;
@property (nonatomic,copy)NSString * title;

+(NSArray *)getDefaultNodata;
+(NSArray *)dealDataFromSocket:(id)socketMessgae compareModel:(MarketHomeListModel *)ruleModel;
@end
