//
//  UserService.m
//  BTCoin
//
//  Created by LionIT on 12/03/2018.
//  Copyright © 2018 LionIT. All rights reserved.
//

#import "UserService.h"
#import "UserInfo.h"

@implementation UserService

DEFINE_SINGLETON_FOR_CLASS(UserService)

#pragma mark - 登录
- (void)loginApp:(NSDictionary *)parDict success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock {
    NSString * urlStr = [NSString stringWithFormat:@"%@/user/login/index.do",BaseHttpUrl];
    
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:parDict successBlock:^(id responseObject) {
        successBlock(responseObject);
    } failureBlock:^(NSError *error) {
        failBlock(error);
    }];
}

#pragma mark - 获取短信验证码
- (void)getValidateCode:(NSDictionary *)parDict success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock {
    NSString * urlStr = [NSString stringWithFormat:@"%@/user/sendMsg.do",BaseHttpUrl];

    
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:parDict successBlock:^(id responseObject) {
        successBlock(responseObject);
    } failureBlock:^(NSError *error) {
        failBlock(error);
    }];
}

#pragma mark - 注册
- (void)registerAccount:(NSDictionary *)parDict success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock {
    NSString * urlStr = [NSString stringWithFormat:@"%@/user/reg/index.do",BaseHttpUrl];

    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:parDict successBlock:^(id responseObject) {
        successBlock(responseObject);
    } failureBlock:^(NSError *error) {
        failBlock(error);
    }];
}

#pragma mark - 发邮箱验证码
- (void)getEmailValidateCode:(NSString *)email success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock {
    NSString * urlStr = [NSString stringWithFormat:@"%@/user/sendMailCode.do",BaseHttpUrl];
    
    
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:@{@"email":email,@"type":@"12"} successBlock:^(id responseObject) {
        successBlock(responseObject);
    } failureBlock:^(NSError *error) {
        failBlock(error);
    }];
}

#pragma mark - 上传身份证图片
- (void)uploadIDImage:(UIImage *)image success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock {
    NSString * urlStr = [NSString stringWithFormat:@"%@/common/upload.do",BaseHttpUrl];
    
    [BaseService postUploadWithUrl:urlStr image:image success:^(id responseObject) {
        successBlock(responseObject);
    }fail:^(NSError *error) {
        failBlock(error);

    }];
}

#pragma mark - 身份证照片审核
- (void)validateKyc:(NSDictionary *)parDict success:(successResponseBlock)successBlock fail:(failResponseBlock)failBlock {
    NSString * para = [parDict toHttpUrlPara];
    NSString * urlStr = [NSString stringWithFormat:@"%@/user/validateKyc.do?%@",BaseHttpUrl,para];
    
    [BaseService post:urlStr headerDictionay:[[UserInfo sharedUserInfo] getHeaderDic]  timeout:SERVICETIMEOUT success:^(id responseObject) {
        successBlock(responseObject);
    } fail:^(NSError *error) {
        failBlock(error);
    }];
}




@end
