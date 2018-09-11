//
//  NSArray+SAPTransformation.h
//  SAP
//
//  Created by SAP360 on 16/10/9.
//  Copyright © 2016年 sap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SAPTransformation)

/*
 向数组中的字典添加中key，value
 注意，数组中一定是字典，否则会返回原始数据
 */
- (NSArray *)addParamsToObjectWithKeyValue:(id)addKey , ... ;

/*
 向数组中的字典添加字典
 注意，数组中一定是字典，否则会返回原始数据
 */
- (NSArray *)addParamsToObjectWithDic:(NSDictionary *)addDic;

@end
