//
//  JCountryModel.h
//  BTCoin
//
//  Created by Shizi on 2018/4/20.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCountryModel : BaseModel

//Code    string(8)    国家代码
@property (nonatomic, copy) NSString *phoneCode;
//Chinese    string (32)    国家代码中文名称
@property (nonatomic, copy) NSString *countrycn;
//English    string (64)    国家代码英文名称
@property (nonatomic, copy) NSString *countryen;
//
@property (nonatomic, copy) NSString *countryenSimple;

- (BOOL)isChina;

@end


@interface JCountryListModel : BaseModel

@property (nonatomic, copy) NSArray<JCountryModel *> *list;

@end
