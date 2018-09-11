//
//  SZAddressDetailViewController.h
//  BTCoin
//
//  Created by Shizi on 2018/5/10.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "CustomViewController.h"
#import "SZAddressDetailViewModel.h"

@class SZAddressDetailViewController;
@protocol SZAddressDetailDelegate

- (void)reader:(SZAddressDetailViewController*)addressDetailViewController didSelectResult:(NSString *)result;

@end

@interface SZAddressDetailViewController : CustomViewController
@property (nonatomic,strong) SZAddressDetailViewModel* viewModel;
@property (nonatomic,assign) id<SZAddressDetailDelegate> delegate;
- (instancetype)initWithCoinCellViewModel:(SZAddressListCellViewModel*)viewModel;

@end
