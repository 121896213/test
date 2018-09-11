//
//  BaseService.h
//  college
//
//  Created by xiongchi on 15/8/30.
//  Copyright (c) 2015年 xiongchi. All rights reserved.
//

#import "BaseModel.h"
#import "NSDictionary+Custom.h"

#define successResponseBlock    void (^)(id responseObject)
#define failResponseBlock       void (^)(NSError *error)
#define SERVICETIMEOUT          30
#define SuccessCode             0



@interface BaseService : NSObject


/**POST 请求 参数拼接在URL后面，而不是放在body中*/
+ (void)post:(NSString *)url afterUrlDictionay:(id)dict timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail;
/**
 *  另外封装的post请求，带timeout
 */
+ (void)post:(NSString *)url dictionay:(id)dict timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail;
/**
 *  封装get,带timeout
 */
+ (void)get:(NSString *)url dictionay:(id)dict timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail;

+ (void)post:(NSString *)url headerDictionay:(NSDictionary *)dict timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail;


+ (void)post:(NSString *)url headerDictionay:(NSDictionary *)dict  parameters:(NSDictionary*)parameters timeout:(int)time success:(void (^)(id responseObject))success
        fail:(void (^)(NSError *error))fail;



+ (void)postUploadWithUrl:(NSString *)urlStr headerDictionay:(NSDictionary *)dict image:(UIImage*)imgInfo success:(void (^)(id responseObject))success fail:(void (^)(void))fail;

+ (void)postUploadWithUrl:(NSString *)urlStr image:(UIImage*)imgInfo success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

+(void)postUploadCustomWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)(void))fail;

@end
