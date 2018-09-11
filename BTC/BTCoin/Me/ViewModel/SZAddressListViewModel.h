//
//  SZAddressListViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZAddressListCellViewModel.h"
@interface SZAddressListViewModel : SZRootViewModel
@property (nonatomic,strong) NSMutableArray* addressListArr;
-(void)getAddressList:(id)parameters;
- (SZAddressListCellViewModel *)addressListCellViewModelAtIndexPath:(NSIndexPath *)indexPath ;
@end
