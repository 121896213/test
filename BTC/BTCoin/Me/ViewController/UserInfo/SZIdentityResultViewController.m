//
//  SZIdentityResultViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/4/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZIdentityResultViewController.h"

@interface SZIdentityResultViewController ()
@property (nonatomic,strong)UIImageView * stateImageView;
@property (nonatomic,strong)UILabel * tipsLabel;
@property (nonatomic,strong)UILabel * cardTypeLabel;
@property (nonatomic,strong)UILabel * cardMessageLabel;

@end

@implementation SZIdentityResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"身份认证", nil)];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    [self configSubViews];
}
//绘制界面
-(void)configSubViews
{
    BOOL isSuccess = (_result == SZIdentityResultWaiting ? NO :YES);
    _stateImageView = [[UIImageView alloc]init];
    [self.view addSubview:_stateImageView];
    [_stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(150);
        make.centerX.mas_equalTo(self.view);
        if (isSuccess) {
            make.centerY.mas_equalTo(self.view).offset(-FIT(32));
        }else{
            make.centerY.mas_equalTo(self.view).offset(-FIT(48.5));
        }
        make.width.mas_equalTo(150);
        
    }];
    _stateImageView.image = (isSuccess ? kIMAGE_NAMED(@"passShenHe"):kIMAGE_NAMED(@"waitShenHe"));
    _stateImageView.contentMode=UIViewContentModeScaleAspectFill;
    if (isSuccess)
    {
        _cardTypeLabel = [[UILabel alloc]init];
        _cardTypeLabel.font = [UIFont boldSystemFontOfSize:25];
        _cardTypeLabel.text = [[UserInfo sharedUserInfo]getIdentityTypeString];
        _cardTypeLabel.textAlignment = NSTextAlignmentCenter;
        _cardTypeLabel.textColor = UIColorFromRGB(0x333333);
        [self.view addSubview:_cardTypeLabel];
        [_cardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_stateImageView.mas_bottom).offset(32);
            make.centerX.mas_equalTo(self.view);
        }];
        _cardMessageLabel = [[UILabel alloc]init];
        _cardMessageLabel.font = kFontSize(15);
        NSString* indentityNo=KUserSingleton.fIdentityNo;
        if (indentityNo.length >=9) {
            indentityNo= [indentityNo replaceStringWithAsterisk:4 length:indentityNo.length-8];
        }
        _cardMessageLabel.text = [NSString stringWithFormat:@"%@: %@",KUserSingleton.frealName,indentityNo];
        _cardMessageLabel.textAlignment = NSTextAlignmentCenter;
        _cardMessageLabel.textColor = UIColorFromRGB(0x333333);
        [self.view addSubview:_cardMessageLabel];
        [_cardMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_cardTypeLabel.mas_bottom).offset(25);
            make.centerX.mas_equalTo(self.view);
        }];
    }else{
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.font = kFontSize(16);
        _tipsLabel.text = NSLocalizedString(@"您的认证资料已上传\n请耐心等待！",nil);
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = UIColorFromRGB(0x333333);
        _tipsLabel.numberOfLines = 2;
        [self.view addSubview:_tipsLabel];
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_stateImageView.mas_bottom).offset(32);
            make.centerX.mas_equalTo(self.view);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
