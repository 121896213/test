//
//  NSDictionary+SAPTransformation.h
//  SAP
//
//  Created by SAP360 on 16/10/9.
//  Copyright © 2016年 sap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SAPTransformation)

/*
 向字典添加中key，value
 */
- (NSDictionary *)addParamsWithKeyValue:(id)addKey , ... ;

@end
