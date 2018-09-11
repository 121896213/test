//
//  UserService.h
//  BTCoin
//
//  Created by LionIT on 12/03/2018.
//  Copyright © 2018 LionIT. All rights reserved.
//

#import "BaseService.h"

@interface UserService : BaseService

DEFINE_SINGLETON_FOR_HEADER(UserService)

/**登录*/
- (void)loginApp:(NSDictionary *)parDict success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock;

/**获取短信验证码*/
- (void)getValidateCode:(NSDictionary *)parDict success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock;

/**注册*/
- (void)registerAccount:(NSDictionary *)parDict success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock;

/**发邮箱验证码*/
- (void)getEmailValidateCode:(NSString *)email success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock;


/**上传身份证图片*/
- (void)uploadIDImage:(UIImage *)image success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock;

/**身份证照片审核*/
- (void)validateKyc:(NSDictionary *)parDict success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock;

@end
