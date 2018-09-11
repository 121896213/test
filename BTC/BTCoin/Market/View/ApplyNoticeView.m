//
//  ApplyNoticeView.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "ApplyNoticeView.h"

@interface ApplyNoticeView()
@property (nonatomic,strong)UILabel * noticeLabel;
//@property (nonatomic,strong)UITextView * noticeLabel;

@end

@implementation ApplyNoticeView


-(instancetype)init{
    if (self = [super init]) {
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    self.backgroundColor = [UIColor clearColor];
    
    UIView * back = [UIView new];
    back.backgroundColor = UIColorFromRGBWithAlpha(0x111b3a, 0.5);
    [self addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.mas_equalTo(0);
    }];
    
    UIView * white = [UIView new];
    white.backgroundColor = [UIColor whiteColor];
    white.layer.cornerRadius = 5.0f;
    [self addSubview:white];
    [white mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.height.mas_lessThanOrEqualTo(kScreenHeight - 100);
    }];
    
    UILabel * topLabel = [UILabel new];
    topLabel.textColor = UIColorFromRGB(0x000000);
    topLabel.font = [UIFont boldSystemFontOfSize:16];
    topLabel.text = NSLocalizedString(@"温馨提示", nil);
    [white addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.height.mas_equalTo(20);
    }];
    
    UIButton * close = [[UIButton alloc]init];
    [close setImage:kIMAGE_NAMED(@"applyNoticeClose") forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [white addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(topLabel);
        make.trailing.mas_equalTo(-15);
    }];
    
    _noticeLabel = [UILabel new];
    _noticeLabel.textColor = UIColorFromRGB(0x333333);
    _noticeLabel.font = kFontSize(14);
    _noticeLabel.numberOfLines = 0;
    [white addSubview:_noticeLabel];

    [_noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLabel.mas_bottom).offset(25);
        make.leading.mas_equalTo(25);
        make.trailing.mas_equalTo(-25);
    }];
    
    UIButton * ensure = [[UIButton alloc]init];
    ensure.backgroundColor = MainThemeColor;
    ensure.layer.cornerRadius = 5.0f;
    [ensure setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [ensure setTitle:NSLocalizedString(@"确认申购", nil) forState:UIControlStateNormal];
    ensure.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [ensure addTarget:self action:@selector(ensureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [white addSubview:ensure];
    [ensure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(136);
        make.centerX.mas_equalTo(white);
        make.top.mas_equalTo(_noticeLabel.mas_bottom).offset(40);
        make.bottom.mas_equalTo(-30);
    }];
}

-(void)setText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[text dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _noticeLabel.attributedText = attributedString;
    [_noticeLabel sizeToFit];
}

-(void)closeButtonClick{
    [self removeFromSuperview];
}

-(void)ensureButtonClick{
    if (self.goNextBlock) {
        self.goNextBlock();
    }
    [self removeFromSuperview];
}

@end
