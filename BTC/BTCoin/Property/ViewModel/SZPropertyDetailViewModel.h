//
//  SZPropertyDetailViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZPropertyRecordCellViewModel.h"
#import "SZPropertyCellViewModel.h"
#import "SZScPropertyRecordCellViewModel.h"

@interface SZPropertyDetailViewModel : SZRootViewModel
@property (nonatomic,strong)NSMutableArray* recordsArr;
@property (nonatomic,strong)NSMutableArray* scRecordArr;
@property (nonatomic,strong)NSMutableArray* c2cRecordArr;

@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger currentType;
@property (nonatomic,strong) SZPropertyCellViewModel* cellViewModel;
@property (nonatomic,strong) SZScPropertyRecordCellViewModel* scCellViewModel;

-(void)requestPropertyRecords:(id)parameters;
-(NSInteger)getPropertyRecordCellNumber;
- (SZPropertyRecordCellViewModel *)recordCellViewModelAtIndexPath:(NSIndexPath *)indexPath;
- (SZScPropertyRecordCellViewModel *)recordSzCellViewModelAtIndexPath:(NSIndexPath *)indexPath;
@end
