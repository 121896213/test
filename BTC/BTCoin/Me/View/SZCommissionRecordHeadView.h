//
//  SZCommissionRecordHeadView.h
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCommissRecordModel.h"
@interface SZCommissionRecordHeadView : UIView
@property (nonatomic,strong) SZCommissRecordListModel* listModel;
@property(nonatomic, strong)UIButton* beginDateButton;
@property(nonatomic, strong)UIButton* endDateButton;
@property(nonatomic, strong)UIButton* selectBtn;
@end
