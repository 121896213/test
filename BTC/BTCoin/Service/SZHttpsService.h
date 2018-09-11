//
//   SZHttpsService.h
//   BTCoin
//
//   Created by LionIT on 22/03/2018.
//   Copyright © 2018 LionIT. All rights reserved.
//

#import "BaseService.h"

@interface SZHttpsService : BaseService

DEFINE_SINGLETON_FOR_HEADER(SZHttpsService)

#pragma mark - 提币短信验证码
-(RACSignal*)signalRequestWithdrawSecurityCodeWithPhone:(NSString*)phone areaCode:(NSString*)areaCode securityCodeType:(NSString*)securityCodeType;
#pragma mark - 邮箱验证码
-(RACSignal*)signalRequestEmailCodeWithEmail:(NSString*)email securityCodeType:(NSString*)securityCodeType;
#pragma mark - 修改密码
-(RACSignal*)signalModifyPasswordWithNewPwd:(NSString*)newPwd  originPwd:(NSString*)originPwd phoneCode:(NSString*)phoneCode pwdType:(NSString*)pwdType reNewPwd:(NSString*)reNewPwd totpCode:(NSString*)totpCode;
#pragma mark - 退出登录
-(RACSignal*)signalLoginOut;
#pragma mark - 绑定手机
-(RACSignal*)signalBindPhoneWithAreaCode:(NSString*)areaCode phone:(NSString*)phone newCode:(NSString*)newCode ;
#pragma mark - 验证忘记密码
-(RACSignal*)signalcheckSecurityCodeWithPhone:(NSString*)phone  msgCode:(NSString*)msgCode;
#pragma mark - 验证忘记密码，邮箱
-(RACSignal*)signalcheckSecurityCodeWithEmail:(NSString*)Email  msgCode:(NSString*)msgCode;
#pragma mark - 通过手机修改登录密码
-(RACSignal*)signalSetLoginPwdWithPhone:(NSString*)phone  newPassword:(NSString*)newPassword msgCode:(NSString*)msgCode;
#pragma mark - 获取用户基本信息
-(RACSignal*)signalRequestGetSecurityInfoParameter:(id)parameters;
#pragma mark-上传身份认证图片
-(RACSignal*)signalRequestUploadIDPhotosWithParameter:(id)parameters;
#pragma mark- 提交身份认证信息
-(RACSignal*)signalRequestCommitIDInfoWithParameter:(id)parameters;

#pragma mark获取锁仓 币币 C2C账户总金额
-(RACSignal*)signalRequestWalletTotalParameter:(id)parameters;
#pragma mark-  获取C2C资产列表
-(RACSignal*)signalRequestGetC2CPropertyListParameter:(id)parameters;
#pragma mark-  获取C2C资产账户明细列表
-(RACSignal*)signalRequestGetC2CPropertyDetailParameter:(id)parameters;
#pragma mark获取锁仓币中列表
-(RACSignal*)signalRequestGetScPropertyListParameter:(id)parameters;
#pragma mark获取锁仓账户明细列表
-(RACSignal*)signalRequestGetScPropertyDetailParameter:(id)parameters;
#pragma mark - 获取财产列表
-(RACSignal*)signalRequestPropertyListWithParameter:(id)parameters;
#pragma mark - 获取财务记录明细
-(RACSignal*)signalRequestGetPropertyRecordsParameter:(id)parameters;
#pragma mark-  币币与C2C资金相互划转
-(RACSignal*)signalRequestC2CBBTransfersParameter:(id)parameters;
#pragma mark-  获取用户币种余额
-(RACSignal*)signalRequestBBPropertyListWithParameter:(id)parameters;

#pragma mark - 获取虚拟币充值地址
-(RACSignal*)signalRequestPropertyAddressWithParameter:(id)parameters;
#pragma mark - 手动获取虚拟货币充值地址
-(RACSignal*)signalRequestManualPropertyAddressWithParameter:(id)parameters;
#pragma mark - 虚拟货币提现
-(RACSignal*)signalRequestPropertyDrawRtcWithParameter:(id)parameters;
#pragma mark - 虚拟货币提现提交
-(RACSignal*)signalRequestCommitWithdrawWithAddress:(NSString*)address withdrawAddr:(NSString*)withdrawAddr withdrawAmount:(NSString*)withdrawAmount tradePwd:(NSString*)tradePwd googleCode:(NSString*)googleCode phoneCode:(NSString*)phoneCode symbol:(NSString*)symbol;
#pragma mark - 获取币种及地址数目列表
-(RACSignal*)signalRequestGetCoinListWithParameter:(id)parameters;
#pragma mark - 添加提币地址
-(RACSignal*)signalRequestAddAddressWithAddress:(NSString*)withdrawAddr  googleCode:(NSString*)googleCode phoneCode:(NSString*)phoneCode symbol:(NSString*)symbol addressRemark:(NSString*)withdrawRemark;
#pragma mark - 删除提币地址
-(RACSignal*)signalRequestdeleteAddressWithAddressId:(NSString*)addressId;
#pragma mark - 获取提币地址列表
-(RACSignal*)signalRequestAddressDetailWithSymbol:(NSString*)symbol;


#pragma mark - 推广奖励
-(RACSignal*)signalRequestPromotionRecordsParameter:(id)parameters;
#pragma mark - 返佣记录
-(RACSignal*)signalRequestCommissionRecordsParameter:(id)parameters;
#pragma mark - 我的推荐
-(RACSignal*)signalRequestMineRecommendRecordsParameter:(id)parameters;


#pragma mark - H5登录
-(RACSignal*)signalRequestC2CH5LoginParameter:(id)parameters;

@end
