//
//  SZScpropertyRecordCellViewModel.h
//  BTCoin
//
//  Created by fanhongbin on 2018/6/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZScPropertyRecordModel.h"
#import "SZC2CPropertyRecordModel.h"

@interface SZScPropertyRecordCellViewModel : SZRootViewModel
@property (nonatomic,strong) SZScPropertyRecordModel* model;
@property (nonatomic,strong) SZC2CPropertyRecordModel* c2cRecordModel;

@end
