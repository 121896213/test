//
//  JMeNetHelper.m
//  BTCoin
//
//  Created by Shizi on 2018/4/20.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "JMeNetHelper.h"

@implementation JMeNetHelper

//国际区域电话代码
+ (void)GetCountryCodeSuccess:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/country/phoneCode.do",BaseHttpUrl];
    
    [BaseService post:urlStr dictionay:nil timeout:SERVICETIMEOUT success:^(id responseObject) {
//        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil removingNulls:YES ignoreArrays:NO];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
            successBlock(responseObject);
        } else {
            
            failBlock(nil);
        }
        
    } fail:^(NSError *error) {
        failBlock(error);
    }];
}

@end








