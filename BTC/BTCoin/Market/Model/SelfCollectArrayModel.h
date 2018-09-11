//
//  SelfCollectArrayModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfCollectArrayModel : NSObject

DEFINE_SINGLETON_FOR_HEADER(SelfCollectArrayModel)

/**自选数据集合*/
@property (nonatomic, readonly) NSMutableDictionary *  dataDict;

/**添加自选（币名，市场名）*/
-(BOOL)addCoin:(NSString *)fShortName andMarketType:(NSString *)marketType;

/**检测可以添加自选（币名，市场名），YES为可以*/
-(BOOL)checkCoinCanAddCollect:(NSString *)fShortName andMarketType:(NSString *)marketType;

/**读取已添加的币名组合（市场名）*/
-(NSMutableArray *)getCollectDataByMarketType:(NSString *)marketType;

/**交换币币位置*/
-(void)exChangeSourceIndex:(NSUInteger)sourceIndex toDestinaIndex:(NSUInteger)destinaIndex inMarketType:(NSString *)marketType;

/**置顶*/
-(void)moveSourceIndex:(NSUInteger)sourceIndex toTopInMarketType:(NSString *)marketType;

/**删除*/
-(void)deleteDataSourceIndex:(NSArray *)sourceIndex inMarketType:(NSString *)marketType;

@end
