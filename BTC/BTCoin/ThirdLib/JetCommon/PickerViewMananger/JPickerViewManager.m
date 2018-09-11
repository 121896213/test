//
//  JPickerViewManager.m
//  BTCoin
//
//  Created by Shizi on 2018/4/24.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "JPickerViewManager.h"

static JPickerViewManager *JPickerManager = nil ;

@implementation JPickerViewManager

+ (JPickerViewManager *)getCurInstance{
    if( JPickerManager == nil ){
        @synchronized(self) {
            JPickerManager =  [[JPickerViewManager alloc] init];
        }
    }
    
    return JPickerManager;
}

- (void)addCommonShowPickerVC:(void (^ )(JPickerViewController *viewController))initParasBlock finishedBlock:(JPickerManagerBlock)finishedBlock{
    
}

@end
