//
//  SZC2CAdRuleViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/8/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CAdRuleViewController.h"

@interface SZC2CAdRuleViewController ()

@end

@implementation SZC2CAdRuleViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    ;
    [self setTitleText:NSLocalizedString(@"交易规则", nil)];

    UILabel* promptLab=[UILabel new];
    promptLab.text=NSLocalizedString(@"1. 同一地区、同一币种，最多只能发一条同类型广告。\n2. 买家当日连续3笔或累计6笔取消订单，系统会限制当日买入功能。\n3. 卖出广告，广告最大额度不能大于钱包余额。即钱包有多少币才能发多少额度的广告。\n4. 发布的广告可以撤销。下已撤销的广告，不能进行重新上架。暂不支持广告删除。\n5. 交易取消后的订单/正常交易时间内的订单/交易完成的订单，不能进行申诉；超过正常交易时间后未解决的订单，可以发起申诉。\n6. 买家可以在标记付款成功15分钟后发起申诉，若卖家没有响应时，如果买家能够提供有效的付款证明，平台会将托管的货币放行给买家。\n7. 卖家在买家标记付款30分钟未收到付款，提交申诉后，如果买家在发起交易后不响应，平台客服会将托管中的货币解冻给卖家。\n8. 工作日正常申诉处理时间为4-12小时，节假日及特殊纠纷处理时间会根据情况延长。\n9. 发起申诉后，交易中的相关资产已经被平台冻结，系统不会自动释放。\n10. 申诉过程中请随时保持通讯顺畅。因通讯方式等原因联络不上造成损失的，损失由交易方自行承担。\n11. 为了确保交易的及时性，请发布广告时务必确保能在线并及时处理订单；若您无法保证及时处理交易订单，请及时撤销，以免造成不必要的申诉纠纷。过多的申诉纠纷，可能会影响您在本平台的信誉。", nil) ;
    promptLab.font=[UIFont systemFontOfSize:FIT(14.0)];
    promptLab.textColor=MainLabelBlackColor;
    promptLab.numberOfLines=0;
    promptLab.lineBreakMode=NSLineBreakByWordWrapping;//计算结果不准确是因为没有设置这一行
    [promptLab setLabelParagraphStyle];
    [self.view addSubview:promptLab];
    CGFloat height=[promptLab getLabelParagraphStyleHeightWithWidth:(ScreenWidth-FIT(16)*2)]+promptLab.font.lineHeight;
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationStatusBarHeight+FIT(16));
        make.left.mas_equalTo(FIT(16));
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(height);
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
