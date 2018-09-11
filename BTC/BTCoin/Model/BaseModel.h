//
//  BaseModel.h
//  GoldNewsHC
//
//  Created by xia zhonglin  on 11/2/16.
//  Copyright © 2016 xia zhonglin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface BaseModel : JSONModel
@property (nonatomic,assign) NSInteger code;
@property (nonatomic,copy) NSString * msg;

@property (nonatomic,assign) NSInteger totalPage;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger pagin;
@property (nonatomic,copy)NSString * errorMessage;

+(BaseModel *)modelWithJson:(id)json;
@end
