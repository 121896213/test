//
//  SelfCollectArrayModel.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SelfCollectArrayModel.h"
#define kSelfCollectArrayLocalSaveKey @"kSelfCollectArrayLocalSaveKey"


@implementation SelfCollectArrayModel

DEFINE_SINGLETON_FOR_CLASS(SelfCollectArrayModel)
-(instancetype)init{
    if (self = [super init]) {
        [self readLocalData];
    }
    return self;
}
-(void)readLocalData{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:kSelfCollectArrayLocalSaveKey]) {
        _dataDict = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:kSelfCollectArrayLocalSaveKey]];
    }else{
        _dataDict = [NSMutableDictionary dictionary];
    }
}

-(BOOL)addCoin:(NSString *)fShortName andMarketType:(NSString *)marketType{
    NSString * key = FormatString(@"MarketType_%@",marketType);
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if ([self.dataDict objectForKey:key]) {
        NSMutableArray * mArr = [NSMutableArray arrayWithArray:[self.dataDict objectForKey:key]];
        if ([mArr containsObject:fShortName]) {
            [UIViewController showPromptHUDWithTitle:NSLocalizedString(@"您已添加自选！", nil)];
            return NO;
        }
        [mArr addObject:fShortName];
        [self.dataDict setObject:mArr forKey:key];
    }else{
        NSMutableArray * mArr = [NSMutableArray arrayWithObject:fShortName];
        [self.dataDict setObject:mArr forKey:key];
    }
    [ud setObject:self.dataDict forKey:kSelfCollectArrayLocalSaveKey];
    [ud synchronize];
    return YES;
}

-(BOOL)checkCoinCanAddCollect:(NSString *)fShortName andMarketType:(NSString *)marketType{
    NSString * key = FormatString(@"MarketType_%@",marketType);
    if ([self.dataDict objectForKey:key]) {
        NSMutableArray * mArr = [NSMutableArray arrayWithArray:[self.dataDict objectForKey:key]];
        if ([mArr containsObject:fShortName]) {
            return NO;
        }
    }
    return YES;
}

-(NSMutableArray *)getCollectDataByMarketType:(NSString *)marketType{
    NSString * key = FormatString(@"MarketType_%@",marketType);
    if ([self.dataDict objectForKey:key]) {
        return [NSMutableArray arrayWithArray:[self.dataDict objectForKey:key]];
    }else{
        return [NSMutableArray array];
    }
}

-(void)exChangeSourceIndex:(NSUInteger)sourceIndex toDestinaIndex:(NSUInteger)destinaIndex inMarketType:(NSString *)marketType{
    NSString * key = FormatString(@"MarketType_%@",marketType);
    if (![self.dataDict objectForKey:key]) {
        return;
    }else{
        NSMutableArray * mArr = [NSMutableArray arrayWithArray:[self.dataDict objectForKey:key]];
        if (mArr.count <= destinaIndex || mArr.count <= sourceIndex) {
            return;
        }else{
            NSString * obj = mArr[sourceIndex];
            [mArr removeObjectAtIndex:sourceIndex];
            [mArr insertObject:obj atIndex:destinaIndex];
            [self.dataDict setObject:mArr forKey:key];
            
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:self.dataDict forKey:kSelfCollectArrayLocalSaveKey];
            [ud synchronize];
        }
    }
}

-(void)moveSourceIndex:(NSUInteger)sourceIndex toTopInMarketType:(NSString *)marketType{
    NSString * key = FormatString(@"MarketType_%@",marketType);
    if (![self.dataDict objectForKey:key]) {
        return;
    }else{
        NSMutableArray * mArr = [NSMutableArray arrayWithArray:[self.dataDict objectForKey:key]];
        if (mArr.count <= sourceIndex) {
            return;
        }else{
            NSString * obj = mArr[sourceIndex];
            [mArr removeObjectAtIndex:sourceIndex];
            [mArr insertObject:obj atIndex:0];
            [self.dataDict setObject:mArr forKey:key];
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:self.dataDict forKey:kSelfCollectArrayLocalSaveKey];
            [ud synchronize];
        }
    }
}

-(void)deleteDataSourceIndex:(NSArray *)sourceIndex inMarketType:(NSString *)marketType{
    if (sourceIndex.count == 0) {
        return;
    }
    NSString * key = FormatString(@"MarketType_%@",marketType);
    if (![self.dataDict objectForKey:key]) {
        return;
    }else{
        NSMutableArray * mArr = [NSMutableArray arrayWithArray:[self.dataDict objectForKey:key]];
        for (int i = 0; i < sourceIndex.count; i++) {
            NSString * string = sourceIndex[i];
            if ([mArr containsObject:string]) {
                [mArr removeObject:string];
//                [mArr removeObjectAtIndex:index];
            }
        }
        [self.dataDict setObject:mArr forKey:key];
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:self.dataDict forKey:kSelfCollectArrayLocalSaveKey];
        [ud synchronize];
    }
}

@end


