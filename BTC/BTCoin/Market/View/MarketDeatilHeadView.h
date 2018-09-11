//
//  MarketDeatilHeadView.h
//  BTCoin
//
//  Created by zzg on 2018/4/14.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealTimeModel.h"

@interface MarketDeatilHeadView : UIView

@property (nonatomic, strong) UILabel   *twenty_fourPrice;  //24小时量比

-(void)setViewWithModel:(RealTimeModel *)model;
-(void)setEqualRmbPrice:(NSString *)price;

-(void)setIsBlack:(BOOL)isBlack;

@end
