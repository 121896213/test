//
//  SZPropertyRechargeViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/8.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZRechargePropertyModel.h"
#import "SZPropertyCellViewModel.h"
@interface SZPropertyRechargeViewModel : SZRootViewModel

@property (nonatomic,strong) SZRechargePropertyModel* model;
@property (nonatomic,strong) SZPropertyCellViewModel* propertyCellViewModel;


-(void)getPropertyRechargeAddressWithParameters:(id)parameters;
@end
