//
//  SZSetPayTypeViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/8/18.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"

typedef enum : NSUInteger {
    SZPayTypeBank,
    SZPayTypeAlipay,
    SZPayTypeWechat,
} SZPayType;

@interface SZSetPayTypeViewModel : SZRootViewModel
@property (nonatomic ,assign) SZPayType payType;
@end
