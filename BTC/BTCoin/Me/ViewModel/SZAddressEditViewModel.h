//
//  SZAddressEditViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/11.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZAddressListCellViewModel.h"
@interface SZAddressEditViewModel : SZRootViewModel

@property (nonatomic,strong) SZAddressListCellViewModel* listCellViewModel;
-(void)addAddressWithParameters:(id)parameters;
-(void)deleteAddressWithParameters:(id)parameters;
@end
