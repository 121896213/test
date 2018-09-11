//
//  BigAreaModel.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/5/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "BigAreaModel.h"

@implementation BigAreaModel

@end


@implementation SZBase
DEFINE_SINGLETON_FOR_CLASS(SZBase)

-(void)dealModelWithArray:(NSArray *)array{
    _areaModelArr = [NSMutableArray array];
    _areaNameArr = [NSMutableArray array];
    if (array.count == 0) {
        return;
    }else{
        for (NSDictionary * dict in array) {
            BigAreaModel * areaModel = [BigAreaModel new];
            [areaModel mj_setKeyValues:dict];
            [_areaModelArr addObject:areaModel];
            [_areaNameArr addObject:areaModel.fShortName];
        }
    }
}
//根据大区id，查询fshortName
-(NSString *)getAreaNameWithFid:(NSInteger)fid
{
    for (BigAreaModel * model  in self.areaModelArr) {
        if ([model.fid integerValue] == fid) {
            return model.fShortName;
        }
    }
    return @"USDT";
}

//获取选中的大区ID，与‘selectIndex’对应
-(int)getSelectedFid{
    @try {
        BigAreaModel * model = self.areaModelArr[_selectIndex];
        return [model.fid intValue];
    }
    @catch (NSException *exception) {
        return 13;
    }
    @finally {
        
    }
    
}



@end
