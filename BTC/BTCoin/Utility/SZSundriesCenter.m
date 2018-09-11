//
//  DDSundriesCenter.m
//  Duoduo
//
//  Created by Hongbin Fan on 2017-4-23.
//  Copyright (c) 2017年 code. All rights reserved.
//

#import "SZSundriesCenter.h"

@implementation SZSundriesCenter
+ (instancetype)instance
{
    static SZSundriesCenter* g_ddSundriesCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_ddSundriesCenter = [[SZSundriesCenter alloc] init];
    });
    return g_ddSundriesCenter;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _serialQueue = dispatch_queue_create("com.lion.SundriesSerial", DISPATCH_QUEUE_SERIAL);
        _parallelQueue = dispatch_queue_create("com.lion.SundriesParallel", NULL);
        
        _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _groupQueue = dispatch_group_create();
        
        
        _downloadQueues=[[NSMutableDictionary alloc]init];
    }
    return self;
}
- (void)delayExecutionInMainThread:(Task)task
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        task();
    });

}
- (void)pushTaskToSerialQueue:(Task)task
{
    dispatch_async(self.serialQueue, ^{
        task();
    });
}

- (void)pushTaskToParallelQueue:(Task)task
{
    dispatch_async(self.parallelQueue, ^{
        task();
    });
}

- (void)pushTaskToSynchronizationSerialQUeue:(Task)task
{
    dispatch_sync(self.serialQueue, ^{
        task();
    });
}
-(void)pushTaskToMainThreadQueue:(Task)task
{
    dispatch_async(dispatch_get_main_queue(), ^{
        task();
    });
    
    
}

-(void)pushTaskToGlobalThreadQueue:(Task)task
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0), ^{
        task();
    });
    
    
}



-(void)pushTaskToBarrierThreadQueue:(Task)task
{
    //dispatch_barrier_sync将自己的任务插入到队列的时候，需要等待自己的任务结束之后才会继续插入被写在它后面的任务，然后执行它们
    //dispatch_barrier_async将自己的任务插入到队列之后，不会等待自己的任务结束，它会继续把后面的任务插入到队列，然后等待自己的任务结束后才执行后面任务
    dispatch_barrier_sync(self.serialQueue, ^{
        task();
    });
    
    
}
-(void)pushTaskToMainSyncThreadQueue:(Task)task
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        task();
    });
}


-(void)pushTaskToGroupQueue:(Task)task{

    dispatch_group_async(_groupQueue, _globalQueue, ^{

        task();
    });

}

-(void)pushGroupNotify:(Task)task{

    dispatch_group_notify(_groupQueue, dispatch_get_main_queue(), ^{
        task();
    });

}
-(void)addFileDownloadQueuesWithValue:(id) value Key:(NSNumber*)key{

    if ([self isInDownloadQueuesForKey:key]) {
        return;
    }else{
        [self.downloadQueues setObject:value forKey:key];
    }
}
-(void)removeFileDownloadQuesForKey:(NSNumber*)key{
   
    [self.downloadQueues removeObjectForKey:key];
}

-(BOOL)isInDownloadQueuesForKey:(NSNumber*)key{
    
    NSArray* allKeys= [self.downloadQueues allKeys];
    __block BOOL isIn=NO;
    [allKeys enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj integerValue] ==  [key integerValue]) {
            isIn=YES;
        }
    }];

    return isIn;
}
-(BOOL)isHaveDownload{

    if ([self.downloadQueues allKeys] > 0) {
        return YES;
    }
    return NO;
}
-(NSNumber*)getDownloadingKey{

    return [[self.downloadQueues allKeys] firstObject];
}



@end
