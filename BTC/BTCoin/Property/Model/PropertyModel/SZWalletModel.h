//
//  SZWalletModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"
#import "SZBaseListModel.h"

typedef enum : NSUInteger {
    SZWalletTypeBB=1,
    SZWalletTypeSC,
    SZWalletTypeC2C,
} SZWalletType;

@interface SZWalletListModel : SZBaseListModel

@property (nonatomic,copy) NSString* usdtNum;
@property (nonatomic,copy) NSString* cnyNum;

@end

@interface SZWalletModel : SZBaseModel
@property (nonatomic,copy) NSString* usdtNum;
@property (nonatomic,copy) NSString* cnyNum;
@property (nonatomic,assign) SZWalletType assetsType;
@end
