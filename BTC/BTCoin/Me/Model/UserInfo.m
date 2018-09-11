//
//  UserInfo.m
//  99SVR
//
//  Created by xia zhonglin  on 12/9/15.
//  Copyright © 2015 xia zhonglin . All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
DEFINE_SINGLETON_FOR_CLASS(UserInfo)

- (void)updateUserInfo:(UserInfo *)info {
    self.userId = info.userId;
    self.sessionId = info.sessionId;
    self.appLoginName= info.appLoginName;
    self.loginName= info.loginName;
    //应该存储本地
}
-(NSString *)loginName{
    return [_appLoginName stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}
- (void)updateUserSecurityInfo:(NSDictionary *)dic {
    [self mj_setKeyValues:dic];
}
- (NSDictionary *)getHeaderDic {
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.userId,@"userId",self.sessionId,@"sessionId", nil];
    return dic;
}
-(void)setBIsLogin:(BOOL)bIsLogin
{
    _bIsLogin = bIsLogin;
    if (!_bIsLogin) {
        _idAuthStatus = -1;
    }
}
-(NSString *)getIdentityTypeString{
    switch (_fidentityType) {
        case IdentityTypeIDCard:
            return NSLocalizedString(@"身份证", nil);
            break;
        case IdentityTypePolice:
            return NSLocalizedString(@"军官证", nil);
            break;
        case IdentityTypePassport:
            return NSLocalizedString(@"护照", nil);
            break;
        case IdentityTypeTaiWan:
            return NSLocalizedString(@"台湾居民通行证", nil);
            break;
        case IdentityTypeHongKong:
            return NSLocalizedString(@"港澳居民通行证", nil);
            break;
        default:
            return @"--";
            break;
    }
}
+ (BOOL)isLogin {
    return [UserInfo sharedUserInfo].bIsLogin;
}
//-(BOOL)isIsTradePassword{
//    return NO;
//}
//-(NSInteger)idAuthStatus{
//    return 0;
//}
- (BOOL)isIdAuthStatus{
    if (self.idAuthStatus == 0) {
        return YES;
    }else{
        return NO;
    }
    
}
@end

