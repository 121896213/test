//
//  SZHTTPSRsqManager.m
//  BTCoin
//
//  Created by Shizi on 2018/5/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZHTTPSRsqManager.h"
#import <AFHTTPSessionManager.h>

extern NSString * language_sys;

@implementation SZHTTPSRsqManager
DEFINE_SINGLETON_FOR_CLASS(SZHTTPSRsqManager);



-(NSURLSessionDataTask *)SZPostRequestWithUrlString:(NSString*)urlString  appendParameters:(NSDictionary*)appendParameters  bodyParameters:(NSDictionary*)bodyParameters successBlock:(SZHTTPSuccessBlock)successBlock failureBlock:(SZHTTPFailureBlock)failureBlock{
    int i =0;
    NSString * parametersString = @"";
    for (NSString *strKey in [appendParameters allKeys])
    {
        NSString *strVal = [appendParameters objectForKey:strKey];
        
        if (i == 0) {
            parametersString = [NSString stringWithFormat:@"?%@=%@", strKey, strVal];
        } else {
            parametersString = [NSString stringWithFormat:@"%@&%@=%@", parametersString, strKey, strVal];
        }
        i++;
    }
    NSString *urlstr = [NSString stringWithFormat:@"%@%@", urlString,parametersString];
    urlstr = [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];// 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = SERVICETIMEOUT;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"ClientType"];
    [manager.requestSerializer setValue:language_sys forHTTPHeaderField:@"Accept-Language"];

    if (KUserSingleton.bIsLogin) {
        [manager.requestSerializer setValue:KUserSingleton.userId forHTTPHeaderField:@"userId"];
        [manager.requestSerializer setValue:KUserSingleton.sessionId forHTTPHeaderField:@"sessionId"];
        NSLog(@"********************userID:%@,sessionID:%@*****************",KUserSingleton.userId,KUserSingleton.sessionId);

    }
    manager.responseSerializer = [AFJSONResponseSerializer serializer];// 设置返回格式

    NSLog(@"%@", [NSString stringWithFormat:@"\n<---------------------------------|start Request|--------------------------------->\nURL is :%@ \nBody is: %@", urlstr,bodyParameters]);
   NSURLSessionDataTask * task = [manager POST:urlstr parameters:bodyParameters progress:nil success:^(NSURLSessionDataTask *operation, id responseObject){
        
        if (successBlock){
            NSLog(@"\n\nResponse : %@\n<---------------------------------|End Request|--------------------------------->", [responseObject mj_JSONString]);
            BaseModel * base = [BaseModel modelWithJson:responseObject];
            if (base.code == 500) {
                if (failureBlock){
                    failureBlock([self errorWithCode:base.code]);
                }
            }else{
                successBlock(responseObject);
                if (base.code == 100 || base.code == 101) {
                    [UserInfo sharedUserInfo].bIsLogin = NO;
                    self.presentLoginVC(responseObject);
                }
                
            }
        }
    }failure:^(NSURLSessionDataTask *operation, NSError *error){
        DLog(@"error:%@",error);
        if (failureBlock){
            failureBlock([self errorWithCode:error.code]);
        }
    }];
    return task;
}

-(NSURLSessionDataTask *)get:(NSString*)urlString  appendParameters:(NSDictionary*)appendParameters successBlock:(SZHTTPSuccessBlock)successBlock failureBlock:(SZHTTPFailureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];// 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = SERVICETIMEOUT;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:language_sys forHTTPHeaderField:@"Accept-Language"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"ClientType"];
    if (KUserSingleton.bIsLogin) {
        [manager.requestSerializer setValue:KUserSingleton.userId forHTTPHeaderField:@"userId"];
        [manager.requestSerializer setValue:KUserSingleton.sessionId forHTTPHeaderField:@"sessionId"];
        NSLog(@"********************userID:%@,sessionID:%@*****************",KUserSingleton.userId,KUserSingleton.sessionId);

    }
    manager.responseSerializer = [AFJSONResponseSerializer serializer];// 设置返回格式
   
    NSLog(@"%@", [NSString stringWithFormat:@"\n<---------------------------------|start Request|--------------------------------->\nURL is :%@ \nParameters is: %@", urlString,appendParameters]);
   NSURLSessionDataTask * task = [manager GET:urlString parameters:appendParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock){
            NSLog(@"\n\nResponse : %@\n<---------------------------------|End Request|--------------------------------->", [responseObject mj_JSONString]);
            successBlock(responseObject);
            NSLog(@"%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error:%@",error);
        if (failureBlock){
            failureBlock([self errorWithCode:error.code]);
        }
    }];
    return task;
}


-(void)postUploadWithUrl:(NSString *)urlStr image:(UIImage*)imgInfo successBlock:(SZHTTPSuccessBlock)successBlock successBlock:(SZHTTPFailureBlock)failureBlock
{
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:[UserInfo sharedUserInfo].userId forHTTPHeaderField:@"userId"];
    [manager.requestSerializer setValue:[UserInfo sharedUserInfo].sessionId forHTTPHeaderField:@"sessionId"];
    NSData *uploadData = UIImageJPEGRepresentation(imgInfo,0.5);
    if (uploadData.length>1024*1024*10) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"您上传的图片过大", NSLocalizedDescriptionKey, @"您上传的图片过大", NSLocalizedFailureReasonErrorKey, @"您上传的图片过大",NSLocalizedRecoverySuggestionErrorKey,nil];
        NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:userInfo];
        failureBlock(error);
        return;
    }
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *uploadData = UIImageJPEGRepresentation(imgInfo,0.5);
        DLog(@"kb:%zi",uploadData.length/1024);
        [formData appendPartWithFileData:uploadData name:@"file"
                                fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        DLog(@"error:%@",error);
        if (failureBlock) {
            failureBlock([self errorWithCode:error.code]);
        }
    }];
}
- (NSError *)errorWithCode:(NSInteger)code {
   
    NSString *message = nil;
    switch (code) {
        case NSURLErrorCancelled:
            message = NSLocalizedString(@"网络请求取消", nil) ;
            break;
        case NSURLErrorNetworkConnectionLost:
            message =  NSLocalizedString(@"网络已断开,请检查您的网络连接", nil);
            break;
        case NSURLErrorNotConnectedToInternet:
            message =  NSLocalizedString(@"似乎已断开与互联网的连接", nil);
            break;
        case NSURLErrorCannotFindHost:
            message =  NSLocalizedString(@"无法连接服务器,请稍后重试", nil);
            break;
        case NSURLErrorTimedOut:
            message =  NSLocalizedString(@"请求超时,请稍后重试", nil);
            break;
        case NSURLErrorCannotConnectToHost:
            message =  NSLocalizedString(@"未能连接到服务器", nil);
            break;
        case NSURLErrorBadServerResponse :
            message =  NSLocalizedString(@"服务器接口出现异常", nil);
            break;
        case 500:
            message =  NSLocalizedString(@"后台接口程序异常", nil);
            break;
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[NSLocalizedDescriptionKey] = message;
    NSError *error = [NSError errorWithDomain:@"Error" code:code userInfo:userInfo];
    
    return error;
}
@end
