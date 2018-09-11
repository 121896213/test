//
//  JMeNetHelper.h
//  BTCoin
//
//  Created by Shizi on 2018/4/20.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

@interface JMeNetHelper : NSObject

//国际区域电话代码
+ (void)GetCountryCodeSuccess:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock;

@end
