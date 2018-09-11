//
//  SZPropertyTypeListModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZBBPropertyModel.h"

@interface SZPropertyTypeListModel : NSObject
@property (nonatomic,strong) NSMutableArray* modelTypeList;
@property (nonatomic,copy) NSString* totalCapital;
@property (nonatomic,copy) NSString* totalNet;
@end
