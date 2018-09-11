//
//  SZRecommendRewardModel.h
//  BTCoin
//
//  Created by sumrain on 2018/7/2.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZHttpsService.h"
#import "SZHTTPSRsqManager.h"
@implementation SZHttpsService
DEFINE_SINGLETON_FOR_CLASS(SZHttpsService)

#pragma mark-  短信验证码
-(RACSignal*)signalRequestWithdrawSecurityCodeWithPhone:(NSString*)phone areaCode:(NSString*)areaCode securityCodeType:(NSString*)securityCodeType
{
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr;
        NSDictionary* parameters;
        if ([phone isMobliePhone]) {
            urlStr = [NSString stringWithFormat:@"%@/user/sendMsg.do",BaseHttpUrl];
            parameters=@{@"phone":phone,@"areaCode":areaCode,@"type":securityCodeType};
        }else{
            urlStr = [NSString stringWithFormat:@"%@/user/sendMailCode.do",BaseHttpUrl];
            parameters=@{@"email":phone,@"type":securityCodeType};
        }
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:parameters successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return dataSignal;
}
#pragma mark-  邮箱验证码
-(RACSignal*)signalRequestEmailCodeWithEmail:(NSString*)email securityCodeType:(NSString*)securityCodeType
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/sendMailCode.do",BaseHttpUrl];
        NSDictionary* parameters=@{@"email":email,@"type":securityCodeType};
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:parameters successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
    
}
#pragma mark- 修改密码
-(RACSignal*)signalModifyPasswordWithNewPwd:(NSString*)newPwd  originPwd:(NSString*)originPwd phoneCode:(NSString*)phoneCode pwdType:(NSString*)pwdType reNewPwd:(NSString*)reNewPwd totpCode:(NSString*)totpCode
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/modifyPwd.do",BaseHttpUrl];
        NSDictionary* parameters=@{@"newPwd":newPwd,@"originPwd":originPwd,@"phoneCode":phoneCode,@"pwdType":@([pwdType integerValue]),@"reNewPwd":reNewPwd};
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:parameters successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
}

#pragma mark- 退出登录
-(RACSignal*)signalLoginOut
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/signout.do",BaseHttpUrl];
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
}



#pragma mark-  绑定手机
-(RACSignal*)signalBindPhoneWithAreaCode:(NSString*)areaCode phone:(NSString*)phone newCode:(NSString*)newCode {
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/validatePhone.do?areaCode=%@&phone=%@&newcode=%@",BaseHttpUrl,areaCode,phone,newCode];
        
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
    
}
#pragma mark- 忘记密码验证
-(RACSignal*)signalcheckSecurityCodeWithPhone:(NSString*)phone  msgCode:(NSString*)msgCode
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/resetPhoneValidation.do?phone=%@&msgcode=%@",BaseHttpUrl,phone,msgCode];
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
}

#pragma mark- 忘记邮箱验证
-(RACSignal*)signalcheckSecurityCodeWithEmail:(NSString*)Email  msgCode:(NSString*)msgCode
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/findPwdByEmail.do?email=%@&ecode=%@",BaseHttpUrl,Email,msgCode];
        
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
}

#pragma mark- 修改密码
-(RACSignal*)signalSetLoginPwdWithPhone:(NSString*)phone  newPassword:(NSString*)newPassword msgCode:(NSString*)msgCode
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString* urlString;
        NSDictionary* bodyParameters;
        if ([phone isEmail]) {
            urlString = [NSString stringWithFormat:@"%@/user/resetMailPwd.do?email=%@&newPwd=%@&ecode=%@",BaseHttpUrl,phone,newPassword,msgCode];
            //          bodyParameters=@{@"email":phone,@"newPwd":newPassword,@"ecode":msgCode};
        }else if ([phone isMobliePhone]){
            urlString = [NSString stringWithFormat:@"%@/user/resetPhonePwd.do?phone=%@&newPwd=%@&ecode=%@",BaseHttpUrl,phone,newPassword,msgCode];
            //           bodyParameters=@{@"email":phone,@"newPwd":newPassword,@"ecode":msgCode};
        }
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlString appendParameters:nil bodyParameters:bodyParameters successBlock:^(id responseObject){
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
}
#pragma mark-  获取用户数据信息
-(RACSignal*)signalRequestGetSecurityInfoParameter:(id)parameters{
    
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/security.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
    
}

#pragma mark-上传身份认证图片
-(RACSignal*)signalRequestUploadIDPhotosWithParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/common/upload.do",BaseHttpUrl];
        [SZHTTPSReqManager postUploadWithUrl:urlStr image:parameters successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } successBlock:^(NSError *error) {
            [subscriber sendError:error];
            
        }];
        return nil;
    }];
    return dataSignal;
    
}

#pragma mark- 提交身份认证信息
-(RACSignal*)signalRequestCommitIDInfoWithParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/validateKyc.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];

        return nil;
    }];
    return dataSignal;
    
}

#pragma mark- 获取钱包总额列表 币币 C2C 锁仓
-(RACSignal*)signalRequestWalletTotalParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/financial/assetsTotal.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
    
}
#pragma mark-  获取C2C资产列表
-(RACSignal*)signalRequestGetC2CPropertyListParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/c2c/assets/list.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return dataSignal;
}

#pragma mark-  获取C2C资产账户明细列表
-(RACSignal*)signalRequestGetC2CPropertyDetailParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/c2c/orderRecord/list.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
    
}

#pragma mark- 获取财务列表
-(RACSignal*)signalRequestPropertyListWithParameter:(id)parameters{
    

    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/financial/index.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:@{@"currentPage":@(1)} bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];

        return nil;
    }];
    
    return dataSignal;
 
}

#pragma mark-  获取锁仓币中列表
-(RACSignal*)signalRequestGetScPropertyListParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/lock/accountMngList.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return dataSignal;
}

#pragma mark-  获取锁仓账户明细列表
-(RACSignal*)signalRequestGetScPropertyDetailParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/lock/accountRecordList.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
    
}

#pragma mark-  获取财务记录明细
-(RACSignal*)signalRequestGetPropertyRecordsParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/lock/accountRecordList.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
}
#pragma mark-  币币与C2C资金相互划转
-(RACSignal*)signalRequestC2CBBTransfersParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/c2c/userferCurrencyTrans.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
}

#pragma mark-  获取币种列表
-(RACSignal*)signalRequestBBPropertyListWithParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/financial/list.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
}
#pragma mark-  获取充值地址
-(RACSignal*)signalRequestPropertyAddressWithParameter:(id)parameters{
    
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//       NSString * urlStr = [NSString stringWithFormat:@"%@/account/rechargeBtc.do?currentPage=1&symbol=%@",BaseHttpUrl,parameters];
        NSString * urlStr = [NSString stringWithFormat:@"%@/account/rechargeBtc.do",BaseHttpUrl];

        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:@{@"currentPage":@(1),@"symbol":parameters} bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
    
}


#pragma mark-  手动获取充值地址
-(RACSignal*)signalRequestManualPropertyAddressWithParameter:(id)parameters{
    
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/account/getVirtualAddress.do",BaseHttpUrl];

        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:@{@"symbol":parameters} bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return dataSignal;
}
#pragma mark-  虚拟货币提现
-(RACSignal*)signalRequestPropertyDrawRtcWithParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/account/withdrawBtc.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:@{@"symbol":parameters} bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return dataSignal;
}


#pragma mark-  虚拟货币提现提交
-(RACSignal*)signalRequestCommitWithdrawWithAddress:(NSString*)address withdrawAddr:(NSString*)withdrawAddr withdrawAmount:(NSString*)withdrawAmount tradePwd:(NSString*)tradePwd googleCode:(NSString*)googleCode phoneCode:(NSString*)phoneCode symbol:(NSString*)symbol
{
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/account/withdrawBtcSubmit.do?address=%@&withdrawAddr=%@&withdrawAmount=%@&tradePwd=%@&totpCode=%@&phoneCode=%@&symbol=%@&level=%ld",BaseHttpUrl,address,withdrawAddr,withdrawAmount,tradePwd,googleCode,phoneCode,symbol,[UserInfo sharedUserInfo].level];
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
}



#pragma mark-  获取币种及地址数目列表
-(RACSignal*)signalRequestGetCoinListWithParameter:(id)parameters
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSString * urlStr = [NSString stringWithFormat:@"%@/financial/withdrawcoin.do",BaseHttpUrl];
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:parameters successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
}
#pragma mark-  获取币种详情，地址列表，备注信息等
-(RACSignal*)signalRequestAddressDetailWithSymbol:(NSString*)symbol {
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSString * urlStr = [NSString stringWithFormat:@"%@/financial/accountcoin.do?symbol=%@",BaseHttpUrl,symbol];
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;

}



#pragma mark-  添加提币地址
-(RACSignal*)signalRequestAddAddressWithAddress:(NSString*)withdrawAddr  googleCode:(NSString*)googleCode phoneCode:(NSString*)phoneCode symbol:(NSString*)symbol addressRemark:(NSString*)withdrawRemark
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/modifyWithdrawAddr.do?withdrawAddr=%@&phoneCode=%@&symbol=%@&withdrawRemark=%@",BaseHttpUrl,withdrawAddr,phoneCode,symbol,withdrawRemark];
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
}

#pragma mark-  删除提币地址
-(RACSignal*)signalRequestdeleteAddressWithAddressId:(NSString*)addressId
{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/detelCoinAddress.do?fid=%@",BaseHttpUrl,addressId];
        
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:nil bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return dataSignal;
}







#pragma mark-  推广奖励
-(RACSignal*)signalRequestPromotionRecordsParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/recommend/reward/list.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters  bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
}

#pragma mark-  返佣记录
-(RACSignal*)signalRequestCommissionRecordsParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/recommend/rebates/list.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
}

#pragma mark-  我的推荐
-(RACSignal*)signalRequestMineRecommendRecordsParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString * urlStr = [NSString stringWithFormat:@"%@/recommend/list.do",BaseHttpUrl];
        [SZHTTPSReqManager SZPostRequestWithUrlString:urlStr appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
}


-(RACSignal*)signalRequestC2CH5LoginParameter:(id)parameters{
    
    RACSignal *dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SZHTTPSReqManager SZPostRequestWithUrlString:SZC2CH5LoginUrl appendParameters:parameters bodyParameters:nil successBlock:^(id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failureBlock:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return dataSignal;
    
    
}

@end
