//
//  SZBindEmailViewModel.m
//  BTCoin
//
//  Created by Shizi on 2018/5/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZBindEmailViewModel.h"

@implementation SZBindEmailViewModel


-(void)bindEmailWithParameters:(id)parameters{

    @weakify(self);
    NSString *urlString = [NSString stringWithFormat:@"%@/user/bindingEmail.do",BaseHttpUrl];
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlString appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
        @strongify(self);
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (base.code == 0) {
            [(RACSubject *) self.successSignal sendNext:base.msg];
        }else{
            [(RACSubject *) self.failureSignal sendNext:base.msg];
        }
    } failureBlock:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];
    }];
    
}

-(void)getEmailCodeWithParameters:(id)parameters{
    
    @weakify(self);
    NSString *urlString = [NSString stringWithFormat:@"%@/user/postValidateMail.do?email=%@",BaseHttpUrl,parameters];
    [SZHTTPSReqManager SZPostRequestWithUrlString:urlString appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
        @strongify(self);
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (base.code == 0) {
            [(RACSubject*)self.otherSignal sendNext:@"SecurityCode"];
        }else{
            [(RACSubject *) self.failureSignal sendNext:base.msg];
        }
    } failureBlock:^(NSError *error) {
        [(RACSubject *) self.failureSignal sendNext:error.localizedDescription];

    }];

}
@end
