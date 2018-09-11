//
//  SZBaseModel.h
//  BTCoin
//
//  Created by fanhongbin on 2018/6/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZBaseModel : NSObject
@property (nonatomic,assign) NSInteger code;
@property (nonatomic,copy)  NSString * msg;
@property (nonatomic,copy)  NSDictionary* data;

+(SZBaseModel *)modelWithJson:(id)json;
@end
