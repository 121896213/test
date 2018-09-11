//
//  ZZYScan.h
//  Demo
//
//  Copyright (c) 2015年 zzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"

@class SZAddressSaoCodeViewController;

@protocol SZAddressSaoCodeDelegate

- (void)reader:(SZAddressSaoCodeViewController*)saoCodeViewController didScanResult:(NSString *)result;

@end


@interface SZAddressSaoCodeViewController : CustomViewController

@property (nonatomic,weak) id<SZAddressSaoCodeDelegate> delegate;
@end
