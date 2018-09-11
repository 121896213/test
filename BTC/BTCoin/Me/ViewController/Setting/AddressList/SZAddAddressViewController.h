//
//  SZAddAddressViewController.h
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "CustomViewController.h"
#import "SZAddressEditViewModel.h"
#import "SZAddressDetailCellViewModel.h"

@class SZAddAddressViewController;
@protocol SZAddressEditDelegate

- (void)editAddressSuccess:(SZAddAddressViewController*)addAddressVC;

@end

@interface SZAddAddressViewController : CustomViewController
@property (nonatomic,strong) SZAddressEditViewModel* viewModel;
@property (nonatomic,strong) SZAddressDetailCellViewModel* cellViewModel;
@property (nonatomic,weak) id<SZAddressEditDelegate> delegate;
- (instancetype)initWithIsEdit:(BOOL) isEdit;
@end
