//
//  EntrustSiftView.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/4/29.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EntrustSiftType) {
    EntrustSiftTypeToday=0,//今日委托
    EntrustSiftTypeHistory =1,//历史委托/历史成交记录
    EntrustSiftTypeRecordToday =2//当日成交记录
};

/**委托管理 筛选*/
@interface EntrustSiftView : UIView

@property (nonatomic,assign)EntrustSiftType siftType;
@property (nonatomic,copy)void (^finishSiftBlock)(NSDictionary * dict);
-(instancetype)initWithSiftType:(EntrustSiftType)type;

-(void)setDefaultState;
@end
