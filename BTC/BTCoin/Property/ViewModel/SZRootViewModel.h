//
//  SZRootViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZRootViewModel : NSObject
@property (nonatomic, strong) RACSignal *successSignal;
@property (nonatomic, strong) RACSignal *failureSignal;
@property (nonatomic, strong) RACSignal *otherSignal;

@end
