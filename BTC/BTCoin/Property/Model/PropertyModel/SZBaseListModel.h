//
//  SZSCPropertyModel.h
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBaseModel.h"





@interface SZBaseListModel : SZBaseModel

@property (nonatomic,strong) NSMutableArray* dataList;
@property (nonatomic,assign) NSInteger totalPage;
@property (nonatomic,assign) NSInteger totalSize;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* endTime;
@end


