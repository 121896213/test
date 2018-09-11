//
//  SZIdentityPhotosViewModel.m
//  BTCoin
//
//  Created by sumrain on 2018/7/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZIdentityPhotosViewModel.h"

@implementation SZIdentityPhotosViewModel
-(void)upLoadIDPhotos:(id)parameters{
    @weakify(self);
    [[[SZHttpsService sharedSZHttpsService] signalRequestUploadIDPhotosWithParameter:parameters]subscribeNext:^(id responseDictionary) {
        @strongify(self);
        NSInteger code=[responseDictionary[@"code"] integerValue];
        if (code == 0) {
            [(RACSubject *) self.successSignal sendNext:nil];
        }else{
            NSString* errorMessage=responseDictionary[@"msg"];
            [(RACSubject *) self.failureSignal sendNext:errorMessage ];
        }
    } error:^(NSError *error) {
        @strongify(self);
        [(RACSubject*)self.failureSignal sendNext:error.localizedDescription];
    }];
    
}
@end
