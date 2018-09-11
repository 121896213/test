//
//  GlobalDefine.h
//  BTCoin
//
//  Created by Shizi on 2018/4/20.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

#define weakify(var) \
try {} @catch (...) {} \
__weak __typeof__(var) var ## _weak = var

#define strongify(var) \
try {} @catch (...) {} \
__strong __typeof__(var) var = var ## _weak

#endif /* GlobalDefine_h */
