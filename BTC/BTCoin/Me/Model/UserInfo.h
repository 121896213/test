//
//  UserInfo.h
//  99SVR
//
//  Created by xia zhonglin  on 12/9/15.
//  Copyright © 2015 xia zhonglin . All rights reserved.
//

#import "BaseModel.h"

@interface UserInfo : BaseModel
DEFINE_SINGLETON_FOR_HEADER(UserInfo)

//登录返回
@property (nonatomic,copy) NSString * sessionId;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,assign)NSInteger idAuthStatus;// 2：未认证、1：待审核、0：已认证 
@property (nonatomic,copy) NSString *loginName;
@property (nonatomic,copy) NSString *nickName;

@property (nonatomic,copy) NSString *appLoginName;
//
@property (nonatomic,assign) NSInteger bindType;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,assign) NSInteger areaCode;

@property (nonatomic,assign) BOOL isBindEmail;
@property (nonatomic,assign) BOOL isBindGoogle;
@property (nonatomic,assign) BOOL isBindTelephone;
@property (nonatomic,assign) BOOL isLoginPassword;
@property (nonatomic,assign) BOOL isTradePassword;

@property (nonatomic,copy) NSString *device_name;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *telNumber;

@property (nonatomic,copy) NSString *frealName;//真实姓名
@property (nonatomic,assign) NSInteger fidentityType;//证件类型
@property (nonatomic,copy) NSString * fIdentityNo;  //证件号码
@property (nonatomic,copy) NSString * fIdentityPath; //正面URL
@property (nonatomic,copy) NSString * fIdentityPath2;//反面URL
@property (nonatomic,copy) NSString * fIdentityPath3;//手持URL
@property (nonatomic,assign) NSInteger fhasRealValidate;
@property (nonatomic,copy) NSString * token;//h5登录token
@property (nonatomic,copy) NSString * redisTokenKey;//h5登录token

@property (nonatomic,copy) NSString *registerTime;

-(NSString *)getIdentityTypeString;
/**
 *  是否登录
 */
@property (nonatomic,assign) BOOL bIsLogin;

- (void)updateUserInfo:(UserInfo *)info;
- (void)updateUserSecurityInfo:(NSDictionary *)dic;
- (NSDictionary *)getHeaderDic;
+ (BOOL)isLogin;
- (BOOL)isIdAuthStatus;
@end

