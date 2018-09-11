//
//  BigAreaModel.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**大区类*/
@interface BigAreaModel : NSObject

@property (nonatomic,copy)NSString * fid;
@property (nonatomic,copy)NSString * fShortName;
@property (nonatomic,copy)NSString * fName;

@end
/**狮子基础类*/
@interface SZBase :NSObject

DEFINE_SINGLETON_FOR_HEADER(SZBase)

@property (nonatomic,strong)NSMutableArray <BigAreaModel *>* areaModelArr;//大区数组
@property (nonatomic,strong)NSMutableArray * areaNameArr;//大区简称 数组

-(void)dealModelWithArray:(NSArray *)array;

-(NSString *)getAreaNameWithFid:(NSInteger)fid;//根据大区id，查询fshortName



@property (nonatomic,assign)NSInteger selectIndex;//Trade页，当前选中的大区index（侧滑、委托、成交记录，需要根据大区的fid查数据）
-(int)getSelectedFid;//获取选中的大区ID，与‘selectIndex’对应

@end
