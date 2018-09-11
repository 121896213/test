//
//  SZPersonCenterHeadView.m
//  BTCoin
//
//  Created by Shizi on 2018/6/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZPersonCenterHeadView.h"
@interface SZPersonCenterHeadView ()
@property(nonatomic, strong)UIButton* headBtn;

@property(nonatomic, strong)UILabel* nickLab;
@property(nonatomic, strong)UILabel* loginNameLab;
@property(nonatomic, strong)UILabel* loginButton;
@property(nonatomic, strong)UILabel* promptLab;
@property(nonatomic, strong)UIButton* promptBtn;
@end

@implementation SZPersonCenterHeadView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
}

-(void)setSubView{
    
 
    UIImageView* backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.image=[UIImage imageNamed:@"mine_header_bg"];
    backgroundImageView.contentMode=UIViewContentModeScaleToFill;
    backgroundImageView.userInteractionEnabled=YES;
    self.backgroundImageView=backgroundImageView;
    [self addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(0));
        make.top.mas_equalTo(FIT(0));
        make.width.mas_equalTo(UIScreenWidth);
        make.height.mas_equalTo(FIT(115)+NavigationStatusBarHeight);
        
    }];
    
    
    UIButton* headerBtn=[UIButton new];
    [headerBtn setImage:[UIImage imageNamed:@"header_icon"] forState:UIControlStateNormal];
    [backgroundImageView addSubview:headerBtn];
    self.headBtn=headerBtn;
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backgroundImageView.mas_centerY).offset(FIT(15));
        make.width.height.mas_equalTo(FIT(61));
        make.left.mas_equalTo(FIT(18));

    }];
    [self.headBtn setEnlargeEdgeWithTop:0 right:FIT3(400)+FIT3(49) bottom:0 left:0];

    UILabel* nickLab=[UILabel new];
    nickLab.textColor=[UIColor whiteColor];
    nickLab.font=[UIFont systemFontOfSize:FIT(20.0f)];
    nickLab.text=NSLocalizedString(@"未命名", nil);
    [nickLab setHidden:YES];
    self.nickLab=nickLab;
    [backgroundImageView addSubview:nickLab];
    [nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBtn.mas_right).offset(FIT(13));
        make.top.equalTo(headerBtn.mas_top);
        make.height.mas_equalTo(FIT(30.5));
        make.width.mas_equalTo(FIT(300));
    }];
    
    
    UILabel* loginNameLab=[UILabel new];
    loginNameLab.textColor=UIColorFromRGB(0x7285B7);
    loginNameLab.font=[UIFont systemFontOfSize:14.0f];
    loginNameLab.text=NSLocalizedString(@"13143468947", nil);
    [loginNameLab setHidden:YES];
    self.loginNameLab=loginNameLab;
    [backgroundImageView addSubview:loginNameLab];
    [loginNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBtn.mas_right).offset(FIT(13));
        make.top.equalTo(nickLab.mas_bottom);
        make.height.mas_equalTo(FIT(30.5));
        make.width.mas_equalTo(FIT(300));
    }];
    
    
    
    

    UIButton* loginBtn=[UIButton new];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [loginBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [loginBtn setTitle:NSLocalizedString(@"请登录/注册", nil) forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setEnlargeEdgeWithTop:FIT3(48) right:FIT3(48) bottom:FIT3(48) left:FIT3(48)];
    loginBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [backgroundImageView addSubview:loginBtn];
    self.loginBtn=loginBtn;
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBtn.mas_right).offset(FIT(13));
        make.top.equalTo(headerBtn.mas_top);
        make.height.mas_equalTo(FIT(30.5));
        make.width.mas_equalTo(FIT(300));

    }];
    
    UILabel* promptLab=[UILabel new];
    promptLab.textColor=UIColorFromRGB(0x7285B7);
    promptLab.font=[UIFont systemFontOfSize:14.0f];
    promptLab.text=NSLocalizedString(@"登录后查看更多信息", nil);
    self.promptLab=promptLab;
    [backgroundImageView addSubview:promptLab];
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBtn.mas_right).offset(FIT(13));
        make.top.equalTo(loginBtn.mas_bottom);
        make.height.mas_equalTo(FIT(30.5));
        make.width.mas_equalTo(FIT(300));
    }];
    

    UIButton* rightBtn=[[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"arrow_right_icon"] forState:UIControlStateNormal];
    self.rightBtn=rightBtn;
    [backgroundImageView addSubview:rightBtn];
    [rightBtn setEnlargeEdgeWithTop:FIT(20.5) right:FIT(20) bottom:FIT(20.5) left:FIT(20)];

    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.centerY.equalTo(headerBtn.mas_centerY);
        make.height.mas_equalTo(FIT(25));
        make.width.mas_equalTo(FIT(25));
    }];
    
    
    UIView* promptView=[UIView new];
    [self addSubview:promptView];
    promptView.backgroundColor=[UIColor whiteColor];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(0));
        make.top.equalTo(backgroundImageView.mas_bottom);
        make.width.mas_equalTo(UIScreenWidth);
        make.height.mas_equalTo(FIT(43));
        
    }];
    
    UIButton* promptBtn=[UIButton new];
    [promptBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(14.0)]];
    [promptBtn setTitle:NSLocalizedString(@"为了您的账户安全，请先身份认证！", nil) forState:UIControlStateNormal];
    [promptBtn setTitleColor:MainLabelBlackColor forState:UIControlStateNormal];
    [promptBtn setImage:[UIImage imageNamed:@"person_prompt"] forState:UIControlStateNormal];
    [promptBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:FIT(5)];
    promptBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    promptBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [promptView addSubview:promptBtn];
    self.promptBtn=promptBtn;
    [promptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(10));
        make.top.mas_equalTo(FIT(0));
        make.height.mas_equalTo(FIT(43));
        make.width.mas_equalTo(FIT(260));
        
    }];
    
    
    UIButton* closeBtn=[UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"person_prompt_close"] forState:UIControlStateNormal];
    closeBtn.contentMode=UIViewContentModeCenter;
    [promptView addSubview:closeBtn];
    [closeBtn setEnlargeEdgeWithTop:FIT(11.5) right:FIT(10) bottom:FIT(11.5) left:FIT(10)];

    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-10));
        make.centerY.equalTo(promptView.mas_centerY);
        make.height.mas_equalTo(FIT(20));
        make.width.mas_equalTo(FIT(20));
        
    }];
    self.closeBtn=closeBtn;
    
    UIButton* handleBtn=[UIButton new];
    [handleBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(12.0)]];
    [handleBtn setTitle:NSLocalizedString(@"立即认证", nil) forState:UIControlStateNormal];
    [handleBtn setBackgroundImage:[UIImage imageWithColor:MainThemeColor] forState:UIControlStateNormal];
    [handleBtn setBackgroundImage:[UIImage imageWithColor:MainThemeHighlightColor] forState:UIControlStateHighlighted];
    [handleBtn setCircleBorderWidth:FIT(1) bordColor:MainThemeColor radius:FIT(3)];
    [handleBtn setEnlargeEdgeWithTop:FIT(9) right:FIT(0) bottom:FIT(9) left:0];
    [promptView addSubview:handleBtn];
    self.handleBtn=handleBtn;

    [handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(promptBtn.mas_right).offset(FIT(13));
        make.centerY.equalTo(promptView.mas_centerY);
        make.height.mas_equalTo(FIT(25));
        make.width.mas_equalTo(FIT(80));
        
    }];
    
    [promptView setHidden:YES];
    self.promptView=promptView;
}

-(void)setInfo:(UserInfo *)info{
    if ([info bIsLogin]) {
        [self.nickLab setHidden:NO];
        self.loginNameLab.text=info.loginName;
        [self.loginNameLab setHidden:NO];
        self.nickLab.text=isEmptyString(info.nickName)?@"未命名":info.nickName;
        [self.loginBtn setHidden:YES];
        [self.loginBtn setUserInteractionEnabled:NO];
        [self.promptLab setHidden:YES];
        [self.rightBtn setHidden:NO];
        
        if (![UserInfo sharedUserInfo].isTradePassword || ![[UserInfo sharedUserInfo] isIdAuthStatus]) {
            
            [self.promptView setHidden:NO];
            [self.promptView setUserInteractionEnabled:YES];
            self.promptBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            if ([UserInfo sharedUserInfo].idAuthStatus ==2) {
                [self.promptBtn setTitle:NSLocalizedString(@"为了您的账户安全，请先身份认证！", nil) forState:UIControlStateNormal];
                [self.handleBtn setTitle:NSLocalizedString(@"立即认证", nil) forState:UIControlStateNormal];
            }else if (![UserInfo sharedUserInfo].isTradePassword) {
                [self.promptBtn setTitle:NSLocalizedString(@"为了您的资金安全，请先设置交易密码!", nil) forState:UIControlStateNormal];
                [self.handleBtn setTitle:NSLocalizedString(@"立即设置", nil) forState:UIControlStateNormal];
                
            }
            
        }
    }else{
      
        [self.nickLab setHidden:YES];
        [self.loginNameLab setHidden:YES];
        [self.loginBtn setHidden:NO];
        [self.promptLab setHidden:NO];
        [self.loginBtn setUserInteractionEnabled:YES];
        [self.rightBtn setHidden:YES];
        [self.promptView setHidden:YES];
        [self.promptView setUserInteractionEnabled:NO];

    }

    _info=info;
}
@end
