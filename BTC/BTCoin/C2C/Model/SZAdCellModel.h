//
//  SZAdCellModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SZAdCellTypeCommonTextFiled,
    SZAdCellTypeC2cPriceSwitch,
    SZAdCellTypeC2cPremium,
    SZAdCellTypeC2cAmountPart,
    SZAdCellTypeC2cPayType,
} SZAdCellType;

@interface SZAdCellModel : NSObject
//名称
@property (nonatomic, copy)NSString *title;

@property (nonatomic, copy)NSString *content;

//textfiled的placeholder
@property (nonatomic, copy)NSString *placeholder;
//表单对应的字段
@property (nonatomic, copy)NSString *key;
//cell图片
@property (nonatomic,assign)BOOL isRightBtnHidden;
//cell的类型

@property (nonatomic,assign)BOOL isTextFieldEnable;
//cell的类型
@property (nonatomic,assign) SZAdCellType cellType;

@end
