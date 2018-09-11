//
//  SZOrderStateCellModel.h
//  BTCoin
//
//  Created by sumrain on 2018/8/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    SZOrderStateCellTypeOrderId,
    SZOrderStateCellTypePrice,
    SZOrderStateCellTypeCommon,
    SZOrderStateCellTypePayType,
    SZOrderStateCellTypeAppealDesc,
    SZOrderStateCellTypeAppealDemo,
    SZOrderStateCellTypeAppealInfo,
    SZOrderStateCellTypeHandleAction,
    SZOrderStateCellTypePrompt,

} SZOrderStateCellType;

@interface SZOrderStateCellModel : NSObject
//标题
@property (nonatomic, copy)NSString *title;

//内容
@property (nonatomic, copy)NSString *content;

//cell的类型
@property (nonatomic,assign) SZOrderStateCellType cellType;
@end
