//
//  SZHTTPSRsqManager.h
//  BTCoin
//
//  Created by Shizi on 2018/5/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  SZHTTPSReqManager [SZHTTPSRsqManager sharedSZHTTPSRsqManager]

typedef void(^SZHTTPSuccessBlock)(id responseObject);
typedef void(^SZHTTPFailureBlock)(NSError* error);
typedef void(^SZPresentLoginVC)(id responseObject);

@interface SZHTTPSRsqManager : NSObject
DEFINE_SINGLETON_FOR_HEADER(SZHTTPSRsqManager);
@property (nonatomic,copy)SZPresentLoginVC presentLoginVC;

-(NSURLSessionDataTask *)SZPostRequestWithUrlString:(NSString*)urlString  appendParameters:(NSDictionary*)appendParameters  bodyParameters:(NSDictionary*)bodyParameters successBlock:(SZHTTPSuccessBlock)successBlock failureBlock:(SZHTTPFailureBlock)failureBlock;

-(NSURLSessionDataTask *)get:(NSString*)urlString  appendParameters:(NSDictionary*)appendParameters successBlock:(SZHTTPSuccessBlock)successBlock failureBlock:(SZHTTPFailureBlock)failureBlock;
-(void)postUploadWithUrl:(NSString *)urlStr image:(UIImage*)imgInfo successBlock:(SZHTTPSuccessBlock)successBlock successBlock:(SZHTTPFailureBlock)failureBlock;

@end
