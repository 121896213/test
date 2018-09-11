//
//  TradeTypeButton.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/16.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "TradeTypeButton.h"
@interface TradeTypeButton ()

@property (nonatomic,strong)UIImageView * leftImage;
@property (nonatomic,strong)UILabel * label;

@property (nonatomic,copy)UIImage * normalImage;
@property (nonatomic,copy)UIImage * selectImage;

@property (nonatomic,copy)UIColor * normalColor;
@property (nonatomic,copy)UIColor * selectColor;
@end

@implementation TradeTypeButton

-(instancetype)init{
    if (self = [super init]) {
        _leftImage = [[UIImageView alloc]init];
        [self addSubview:_leftImage];
        [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(0);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(15);
        }];
        
        _label = [UILabel new];
        _label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
        _label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(22);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(15);
            make.trailing.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    if (state == UIControlStateNormal) {
        _normalImage = image;
        self.leftImage.image = image;
    }else if (state == UIControlStateSelected){
        _selectImage = image;
    }
}

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    if (state == UIControlStateNormal) {
        _normalColor = color;
        self.label.textColor = color;
    }else if (state == UIControlStateSelected){
        _selectColor = color;
    }
}

-(void)setSelected:(BOOL)selected{
//    selected = selected;
    if (selected) {
        self.leftImage.image = _selectImage;
        self.label.textColor = _selectColor;

    }else{
        self.leftImage.image = _normalImage;
        self.label.textColor = _normalColor;
    }
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    self.label.text = title;
}

@end
