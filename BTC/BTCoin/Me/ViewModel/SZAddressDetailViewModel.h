//
//  SZAddressDetailViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZAddressListCellViewModel.h"
#import "SZAddressDetailCellViewModel.h"
@interface SZAddressDetailViewModel : SZRootViewModel
@property (nonatomic,strong) SZAddressListCellViewModel* coinCellViewModel;
@property (nonatomic,strong) NSMutableArray* addressDetailArr;
-(void)getAddressDetail:(id)parameters;
- (SZAddressDetailCellViewModel *)addressDetailCellViewModelAtIndexPath:(NSIndexPath *)indexPath;
@end
