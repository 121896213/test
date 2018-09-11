//
//  NSDictionary+SAPTransformation.m
//  SAP
//
//  Created by SAP360 on 16/10/9.
//  Copyright © 2016年 sap. All rights reserved.
//

#import "NSDictionary+SAPTransformation.h"

@implementation NSDictionary (SAPTransformation)

/*
 向字典添加中key，value
 */
- (NSDictionary *)addParamsWithKeyValue:(id)addKey , ... {
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
    
    if( (dMArray.count % 2) == 0 ){
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:self];
        
        int nums = dMArray.count / 2 ;
        for( int i=0;i<nums;i++ ){
            [mDic setValue:[dMArray objectAtIndex:2*i+1] forKey:[dMArray objectAtIndex:2*i]];
        }
        
        return mDic ;
    }else{
        return self ;
    }
}

@end
