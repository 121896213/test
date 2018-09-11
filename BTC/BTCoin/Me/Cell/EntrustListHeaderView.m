//
//  EntrustListHeaderView.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/4/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "EntrustListHeaderView.h"

@interface EntrustListHeaderView()

@end

@implementation EntrustListHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = MainBackgroundColor;

        _titlelabel = [UILabel new];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        _titlelabel.textColor = UIColorFromRGB(0x000000);
        _titlelabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_titlelabel];
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.leading.mas_equalTo(7);
        }];
    }
    return self;
}
//-(void)prepareForReuse{
//    [super prepareForReuse];
//    self.contentView.backgroundColor = [UIColor whiteColor];
//    self.textLabel.center = self.contentView.center;
//    self.textLabel.textAlignment = NSTextAlignmentCenter;
//    self.textLabel.textColor = UIColorFromRGB(0x333333);
//    self.textLabel.font = kFontSize(14);
//}

@end
