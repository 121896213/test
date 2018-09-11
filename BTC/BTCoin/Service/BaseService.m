//
//  BaseService.m
//  college
//
//  Created by xiongchi on 15/8/30.
//  Copyright (c) 2015年 xiongchi. All rights reserved.
//

#import "BaseService.h"
#import <AFHTTPSessionManager.h>
#import "NSDate+convenience.h"

extern NSString * language_sys;

@implementation BaseService

+ (void)get:(NSString *)url dictionay:(id)dict timeout:(int)time success:(void (^)(id responseObject))success
       fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = time;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"ClientType"];
    [manager.requestSerializer setValue:language_sys forHTTPHeaderField:@"Accept-Language"];

    [manager GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil removingNulls:YES ignoreArrays:NO];
        if (success) {
            success(responseDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

/**POST 请求 参数拼接在URL后面，而不是放在body中*/
+ (void)post:(NSString *)url afterUrlDictionay:(id)dict timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail
{
    int i =0;
    NSString * parametersString = @"";
    for (NSString *strKey in [dict allKeys])
    {
        NSString *strVal = [dict objectForKey:strKey];
        
        if (i == 0) {
            parametersString = [NSString stringWithFormat:@"?%@=%@", strKey, strVal];
        } else {
            parametersString = [NSString stringWithFormat:@"%@&%@=%@", parametersString, strKey, strVal];
        }
        i++;
    }
    NSString *urlstr = [NSString stringWithFormat:@"%@%@", url,parametersString];
    urlstr = [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    [self post:urlstr dictionay:nil timeout:time success:success fail:fail];
}

+ (void)post:(NSString *)url dictionay:(id)dict timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = time;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:language_sys forHTTPHeaderField:@"Accept-Language"];

    if (KUserSingleton.bIsLogin) {
        [manager.requestSerializer setValue:KUserSingleton.userId forHTTPHeaderField:@"userId"];
        [manager.requestSerializer setValue:KUserSingleton.sessionId forHTTPHeaderField:@"sessionId"];
    }
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"ClientType"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];// 设置返回格式

    NSLog(@"%@", [NSString stringWithFormat:@"\n<---------------------------------|start Request|--------------------------------->\nURL is :%@ \nBody is:\n %@", url,dict]);
    
    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         if (success)
         {
             NSLog(@"\n\nResponse : %@\n<---------------------------------|End Request|--------------------------------->", [responseObject mj_JSONString]);
             success(responseObject);
         }
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         DLog(@"error:%@",error);
         if (fail)
         {
             fail(error);
         }
     }];
}

+ (void)post:(NSString *)url headerDictionay:(NSDictionary *)dict timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = time;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSArray * headerKeys = [dict allKeys];
    for (NSString * key in headerKeys) {
        NSLog(@"***************%@:%@",key,dict[key]);
        [manager.requestSerializer setValue:dict[key] forHTTPHeaderField:key];
    }
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"ClientType"];
    [manager.requestSerializer setValue:language_sys forHTTPHeaderField:@"Accept-Language"];

    NSLog(@"\nRequest : %@\n|----------------------------------------|start Request|----------------------------------------|", url);
    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         if (success)
         {
             NSLog(@"\nResponse : %@\n|----------------------------------------|End Request|----------------------------------------|", [responseObject mj_JSONString]);

             success(responseObject);
         }
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         DLog(@"error:%@",error);
         if (fail)
         {
             fail(error);
         }
     }];
}


+ (void)post:(NSString *)url headerDictionay:(NSDictionary *)dict  parameters:(NSDictionary*)parameters timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = time;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSArray * headerKeys = [dict allKeys];
    for (NSString * key in headerKeys) {
        [manager.requestSerializer setValue:dict[key] forHTTPHeaderField:key];
        NSLog(@"***************%@:%@",key,dict[key]);

    }
    NSLog(@"\nRequest : %@ parameters:%@\n|----------------------------------------|start Request|----------------------------------------|", url,[parameters mj_JSONString]);
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         if (success)
         {
             NSLog(@"\nResponse : %@\n|----------------------------------------|End Request|----------------------------------------|", [responseObject mj_JSONString]);
             
             success(responseObject);
         }
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         DLog(@"error:%@",error);
         if (fail)
         {
             fail(error);
         }
     }];
}

+ (void)postUploadWithUrl:(NSString *)urlStr image:(UIImage*)imgInfo success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail
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
        fail(error);
        return;
    }
    

    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *uploadData = UIImageJPEGRepresentation(imgInfo,0.5);
        DLog(@"kb:%zi",uploadData.length/1024);
        [formData appendPartWithFileData:uploadData name:@"file"
                                fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        DLog(@"error:%@",error);
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)postUploadWithUrl:(NSString *)urlStr headerDictionay:(NSDictionary *)dict image:(UIImage*)imgInfo success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSArray * headerKeys = [dict allKeys];
    for (NSString * key in headerKeys) {
        [manager.requestSerializer setValue:dict[key] forHTTPHeaderField:key];
    }
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    NSData *uploadData = UIImageJPEGRepresentation(imgInfo,0.5);
    DLog(@"kb:%zi",uploadData.length/1024);
         [formData appendPartWithFileData:uploadData name:@"file"
                                fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        DLog(@"error:%@",error);
        if (fail) {
            fail();
        }  
    }];  
}

+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // formData是遵守了AFMultipartFormData的对象
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 将本地的文件上传至服务器
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
    } progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //
        //        NSLog(@"完成 %@", result);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            fail();
        }  
    }];  
}

+(void)postUploadCustomWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // formData是遵守了AFMultipartFormData的对象
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 将本地的文件上传至服务器
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
    } progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //
        //        NSLog(@"完成 %@", result);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            fail();
        }  
    }];  
}

@end
