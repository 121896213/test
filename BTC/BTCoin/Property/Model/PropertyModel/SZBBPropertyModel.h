//
//  SZBBPropertyModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

//{"fvirtualcointypeName":"EOS","fvirtualcointypeId":62,"ftotal":"0.00000000","frozen":"0.00000000"}
@interface SZBBPropertyModel : NSObject
@property (nonatomic,copy) NSString* ftotal;
@property (nonatomic,copy) NSString* frozen;
@property (nonatomic,copy) NSString* fvirtualcointypeName;
@property (nonatomic,copy) NSString* fvirtualcointypeId;

@end
