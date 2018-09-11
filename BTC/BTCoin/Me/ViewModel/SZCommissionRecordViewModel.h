//
//  SZCommissionRecordViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZCommissionRecordCellViewModel.h"
#import "SZCommissRecordModel.h"

@interface SZCommissionRecordViewModel : SZRootViewModel
@property (nonatomic,strong) SZCommissRecordListModel* baseListModel;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,copy) NSString* beginDate;
@property (nonatomic,copy) NSString* endDate;

-(void)getCommissRecordList:(id)parameters;
- (SZCommissionRecordCellViewModel *)commissionRecordCellViewModellAtIndexPath:(NSIndexPath *)indexPath ;
@end
