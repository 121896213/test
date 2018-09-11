//
//  NSDictionary+Custom.h
//  99Gold
//
//  Created by LionIT on 11/29/16.
//  Copyright © 2016 xia zhonglin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Custom)
- (NSString *)toJson;
- (NSString *)toHttpUrlPara;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**截取浦发银行接口返回dictionary有用的信息，重新包装成NSDictionary*/
- (NSDictionary *)rebuildSPDBankResponse;
@end
