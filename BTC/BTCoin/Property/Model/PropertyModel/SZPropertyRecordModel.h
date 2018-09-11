//
//  SZPropertyRecordModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZPropertyRecordModel : BaseModel
@property (nonatomic,copy) NSString* fAmount;
@property (nonatomic,copy) NSString* fStatus;
@property (nonatomic,copy) NSDictionary* fCreateTime;
@property (nonatomic,copy) NSString* tecType;
@property (nonatomic,copy) NSString* fvirtualaddress;
@property (nonatomic,copy) NSString* ffees;
@property (nonatomic,copy) NSString* fType;

@end
