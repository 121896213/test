//
//  NSArray+SAPTransformation.m
//  SAP
//
//  Created by SAP360 on 16/10/9.
//  Copyright © 2016年 sap. All rights reserved.
//

#import "NSArray+SAPTransformation.h"

@implementation NSArray (SAPTransformation)

/*
 向数组中的字典添加中key，value
 注意，数组中一定是字典，否则会返回原始数据
 */
- (NSArray *)addParamsToObjectWithKeyValue:(id)addKey , ... {
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *dMArray = [[NSMutableArray alloc] init];
    
    if (addKey) {
        va_list args;
        va_start(args, addKey);
        for (id arg = addKey; arg != nil; arg = va_arg(args, id ))
        {
            [dMArray addObject:arg];
        }
        va_end(args);
    }
    
    NSUInteger nums = [self count];
    for( int i=0;i<nums;i++ ){
        NSDictionary *dic = [self objectAtIndex:i];
        
        if( [dic isKindOfClass:[NSDictionary class]] ){
            if( (dMArray.count % 2) == 0 ){
                NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                
                int nums = dMArray.count / 2 ;
                for( int i=0;i<nums;i++ ){
                    [mDic setValue:[dMArray objectAtIndex:2*i+1] forKey:[dMArray objectAtIndex:2*i]];
                }
                
                [mArray addObject:mDic];
            }else{
                [mArray addObject:dic];
            }
        }else{
            [mArray addObject:dic];
        }
    }
    
    return mArray ;
}

/*
 向数组中的字典添加字典
 注意，数组中一定是字典，否则会返回原始数据
 */
- (NSArray *)addParamsToObjectWithDic:(NSDictionary *)addDic{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    NSUInteger nums = [self count];
    for( int i=0;i<nums;i++ ){
        NSDictionary *dic = [self objectAtIndex:i];
        
        if( [dic isKindOfClass:[NSDictionary class]] ){
            NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [mDic setValuesForKeysWithDictionary:addDic];
            
            [mArray addObject:mDic];
        }else{
            [mArray addObject:dic];
        }
    }
    
    return mArray ;
}

@end
