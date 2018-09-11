//
//  SZPopView.h
//  BTCoin
//
//  Created by Shizi on 2018/5/9.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, SZPopViewFromDirectionType) {
    SZPopViewFromDirectionTypeBottom=1,
    SZPopViewFromDirectionTypeCenter=2,
    SZPopViewFromDirectionTypeTop=3,
};


@interface SZPopView : UIView

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,assign) SZPopViewFromDirectionType directionType;

- (void)showInView:(UIView *)view  directionType:(SZPopViewFromDirectionType) directionType;
- (void)disMissView;
@end
