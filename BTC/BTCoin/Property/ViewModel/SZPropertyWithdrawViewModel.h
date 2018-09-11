//
//  SZPropertyWithdrawViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/8.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"
#import "SZPropertyCellViewModel.h"
@interface SZPropertyWithdrawViewModel : SZRootViewModel
@property (nonatomic,strong) SZPropertyCellViewModel* propertyCellViewModel;
@property (nonatomic,copy)   NSString* withdrawFee;


@property (nonatomic,copy)   NSString* currentCoinCount;
@property (nonatomic,copy)   NSString* currentAddress;
@property (nonatomic,copy)   NSString* currentPassword;
@property (nonatomic,copy)   NSString* reachCoinCount;

-(void)signalRequestPropertyDrawRtcWithParameter:(id)parameters;

-(void)commitWithdrawWithParameters:(id)parameters;
@end
