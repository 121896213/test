//
//  SZPromotionRecordViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZPromotionRecordCellViewModel.h"
#import "SZBaseListModel.h"
@interface SZPromotionRecordViewModel : SZRootViewModel
@property (nonatomic,strong) SZPromotionRecordListModel* baseListModel;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,copy) NSString* coinType;

-(void)getPromotionRecordList:(id)parameters;
- (SZPromotionRecordCellViewModel *)promotionRecordCellViewModellAtIndexPath:(NSIndexPath *)indexPath ;
@end
