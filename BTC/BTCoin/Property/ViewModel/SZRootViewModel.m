//
//  SZRootViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRootViewModel.h"

@implementation SZRootViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.successSignal = [[RACSubject subject] setNameWithFormat:@"SZRootViewModelErrorSignal"];
        self.failureSignal = [[RACSubject subject] setNameWithFormat:@"SZRootViewModelUpdatedSignal"];
        self.otherSignal = [[RACSubject subject] setNameWithFormat:@"SZRootViewModelOtherSignal"];
    }
    return self;
}
@end
