//
//  BTCDefine.h
//  BTCoin
//
//  Created by LionIT on 18/03/2018.
//  Copyright © 2018 LionIT. All rights reserved.
#ifndef BTCDefine_h
#define BTCDefine_h

//测试环境---NEW
//#define BaseHttpUrl @"http://172.16.1.57:8080/corn-app"
////#define BaseHttpUrl @"http://192.168.1.245:8080/corn-app"
//#define SocketUrlForMarket @"ws://172.16.1.68:9003"//行情socket
//#define SocketUrlForSeven @"ws://172.16.1.68:9001"//买卖七档socket
//#define KLineUrlHead @"http://172.16.1.68:8088"//K线地址
//#define RecommendUrl @"http://172.16.1.112/#/guideRegister?recommendCode="
//#define SZC2CH5LoginUrl @"http://172.16.1.55:8080/corn-web-merchant/front/interface/user/login/indexH5.json"
////#define SZC2CH5Url @"http://172.16.1.112/#/c2c"
//#define SZC2CH5Url @"http://192.168.1.131:8880/#/c2c"
////#define SZC2CH5Url @"http://192.168.1.241:8880/#/c2c"

//阿里环境(预生产)
//#define BaseHttpUrl @"https://uapp.btktrade.com/corn-app"
//#define SocketUrlForMarket @"ws://uumarried.btktrade.com"//行情socket
//#define SocketUrlForSeven @"ws://umarried.btktrade.com"//买卖七档socket
//#define KLineUrlHead @"https://umarket.btktrade.com"//K线地址
//#define RecommendUrl @"https://uh5.btktrade.com/#/guideRegister?recommendCode="
//#define SZC2CH5LoginUrl @"https://umerchant.btktrade.com/corn-web-merchant/front/interface/user/login/indexH5.json"
//#define SZC2CH5Url @"https://uh5.btktrade.com/#/c2c"
////#define SZC2CH5Url @"http://192.168.1.131:8880/#/c2c"


////生产环境
#define BaseHttpUrl @"https://app.btktrade.com/corn-app"
#define SocketUrlForMarket @"wss://pmarried.btktrade.com"//行情socket
#define SocketUrlForSeven @"wss://married.btktrade.com"//买卖七档socket
#define KLineUrlHead @"https://market.btktrade.com"//K线地址
#define RecommendUrl @"https://h5.btktrade.com/#/guideRegister?recommendCode="
#define SZC2CH5LoginUrl @"https://merchant.btktrade.com/corn-web-merchant/front/interface/user/login/indexH5.json"
#define SZC2CH5Url @"https://h5.btktrade.com/#/c2c"

//亚马逊环境
//#define BaseHttpUrl @"https://aapp.btktrade.com/corn-app"
//#define SocketUrlForMarket @"wss://apmarried.btktrade.com"//行情socket
//#define SocketUrlForSeven @"wss://amarried.btktrade.com"//买卖七档socket
//#define KLineUrlHead @"https://amarket.btktrade.com"//K线地址
//#define RecommendUrl @"https://awww.btktrade.com/#/guideRegister?recommendCode="

 

#define SZCoinTypeUSDT 2
#define USDT_MAX_Points 8

typedef NS_ENUM(NSInteger,IdentityType) {
    IdentityTypeNone = -1,
    IdentityTypeIDCard = 0,//身份证
    IdentityTypePolice = 1,//军官
    IdentityTypePassport =2,//护照
    IdentityTypeTaiWan =3,//台湾
    IdentityTypeHongKong =4//港澳
    // (0:身份证,1:军官证,2:护照,3:台湾居民通行证,4:港澳居民通行证)
};
typedef NS_ENUM(NSInteger,TradeVCType) {
    TradeVCTypeBuy = 0,//买入
    TradeVCTypeSel = 1,// 卖出
    TradeVCTypeAll = 2,// 全部
    TradeVCTypeRecord = 3
};

typedef NS_ENUM(NSInteger,TradeState) {
    TradeStateAll = 0,
    TradeStateUnOver = 1,//未完成
    TradeStateSomeOver = 2,// 部分成交
    TradeStateAllOver = 3,// 全部成交
    TradeStateUserCancel= 4//用户撤单
};


typedef NS_ENUM(NSInteger,StorePercent) {
    StorePercentAll = 0,//全仓
    StorePercentHalf,//半仓
    StorePercentOneForThird,//1/3
    StorePercentOneForFive//1/5
};

#define isStringNull(x)       (!x || [x isKindOfClass:[NSNull class]]||x.length == 0||x == nil)
#define isEmptyString(x)      (isStringNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"] || [x isEqual:@"[null]"] || [x isEqual:@"null"] || [x isEqual:@"<null>"])
#define isEmptyObject(object)  [NSObject isNullOrNilWithObject:object]

#endif /* BTCDefine_h */
