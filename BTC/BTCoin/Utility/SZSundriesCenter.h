//
//  DDSundriesCenter.h
//  Duoduo
//
//  Created by Hongbin Fan on 2017-4-23.
//  Copyright (c) 2017年 code. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Task)();

@interface SZSundriesCenter : NSObject

@property (nonatomic,readonly)dispatch_queue_t serialQueue;
@property (nonatomic,readonly)dispatch_queue_t parallelQueue;


@property (nonatomic,readonly)dispatch_queue_t globalQueue;
@property (nonatomic,readonly)dispatch_group_t groupQueue;

@property (nonatomic,strong) NSMutableDictionary* downloadQueues;

+ (instancetype)instance;
- (void)delayExecutionInMainThread:(Task)task;
- (void)pushTaskToSerialQueue:(Task)task;
- (void)pushTaskToParallelQueue:(Task)task;
- (void)pushTaskToSynchronizationSerialQUeue:(Task)task;
-(void)pushTaskToMainThreadQueue:(Task)task;

-(void)pushTaskToGlobalThreadQueue:(Task)task;
-(void)pushTaskToBarrierThreadQueue:(Task)task;
-(void)pushTaskToMainSyncThreadQueue:(Task)task;

-(void)pushTaskToGroupQueue:(Task)task;
-(void)pushGroupNotify:(Task)task;


-(void)addFileDownloadQueuesWithValue:(id) value Key:(NSNumber*)key;
-(void)removeFileDownloadQuesForKey:(NSNumber*)key;
-(BOOL)isInDownloadQueuesForKey:(NSNumber*)key;
-(BOOL)isHaveDownload;
-(NSNumber*)getDownloadingKey;
@end
