//
//  SZMineRecommendViewModel.h
//  BTCoin
//
//  Created by sumrain on 2018/6/22.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZMineRecommendCellViewModel.h"
#import "SZMineRecommendModel.h"
@interface SZMineRecommendViewModel : SZRootViewModel
@property (nonatomic,strong) SZMineRecommendListModel* baseListModel;
@property (nonatomic,assign) NSInteger currentPage;
-(void)getMineRecommendList:(id)parameters;
- (SZMineRecommendCellViewModel *)mineRecommendCellViewModellAtIndexPath:(NSIndexPath *)indexPath ;
@end
